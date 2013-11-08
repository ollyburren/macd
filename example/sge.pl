use lib '../lib/';
use Macd;

## site specific conf file
my $grid_cnf = './ini/example.cnf';
## where STDOUT/STDERR from command will end up
my $log_dir = './log/example/';

$DRIVER = Macd::GRIDDriverFactory->instantiate('SGE',inifile => $grid_cnf);


## create a 'step'
## note that we can pass environment settings if we wish

my $step = Macd::Step->new(
	logdir=> $log_dir,
	driver=>$DRIVER,
	#env_settings=>"ENV_SETTING=$ENV{ENV_SETTING}"
);


## next we create a list of jobs to run on the queue.
## and add them to our step

for(my $i=1;$i<=100;$i++){
	my $cmd="echo \"job number $i\"";
	my $job = Macd::Step::Job->new(command=>$cmd);
	$step->add_job($job);
}

## run the step

if($step->execute()){
	print "Step submitted successfuly\n";
	## we can hold up prog execution as follows
	## in case we have a step below that requires the output
	$step->wait_on_complete();
	print "Step completed successfully\n";
}else{
	print "Error submitting step\n";
}
