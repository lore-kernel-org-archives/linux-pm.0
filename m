From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH RESEND] tools: add
	power/x86/x86_energy_perf_policy to program
	MSR_IA32_ENERGY_PERF_BIAS
Date: Wed, 17 Nov 2010 12:35:52 +0100
Message-ID: <8739r0rxlz.fsf__15254.1659925648$1289998185$gmane$org@basil.nowhere.org>
References: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
	<alpine.LFD.2.00.1009281143070.14962@localhost.localdomain>
	<alpine.LFD.2.00.1010230035360.29399@localhost.localdomain>
	<alpine.LFD.2.00.1011151103280.2939@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1011151103280.2939@x980> (Len Brown's message of
	"Mon, 15 Nov 2010 11:07:04 -0500 (EST)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

Len Brown <lenb@kernel.org> writes:
> @@ -0,0 +1,7 @@
> +x86_energy_perf_policy : x86_energy_perf_policy.c
> +
> +clean :
> +	rm -f x86_energy_perf_policy
> +
> +install :
> +	install x86_energy_perf_policy /usr/bin/x86_energy_perf_policy

It's not clear to me how this Makefile ensures it's only
build on x86. 

If someone on another architecture does a full tools build
in the future (I think that is not wired up yet, but should
eventually) such a mechanism would be needed.


> +
> +/*
> + * Usage:

...

This full comment and parts of the following comments describing the
semantics need to be available somewhere to the user who may not have
easy access to the source. Can you make it display in usage or convert
it to a manpage? I would prefer a manpage

> +
> +cmdline(int argc, char **argv) {

No type?

> +	int opt;
> +
> +	progname = argv[0];
> +
> +	while ((opt = getopt(argc, argv, "+rvc:")) != -1) {

Maybe it's me, but I prefer having long options too (getopt_long)
These are easier to memorize.

> +
> +	/*
> +	 * if no -r , then must be one additional optind
> +	 */
> +	if (!read_only) {
> +
> +		if (argc != optind + 1) {
> +			printf("must supply -r or policy param\n");
> +			usage();
> +			exit(-1);

-1 is an unusual exit code. Better use 1.

An obvious improvement would be to put the exit() into usage()

> +			}
> +
> +		if (!strcmp("performance", argv[optind])) {
> +			new_bias = BIAS_PERFORMANCE;
> +		} else if (!strcmp("normal", argv[optind])) {
> +			new_bias = BIAS_BALANCE;
> +		} else if (!strcmp("powersave", argv[optind])) {
> +			new_bias = BIAS_POWERSAVE;
> +		} else {
> +			new_bias = atoll(argv[optind]);

If you used strtoull() you could actually check if the input
is really a number (end == argv[optind])

> +	eax = ebx = ecx = edx = 0;
> +
> +	asm("cpuid" : "=a" (max_level), "=b" (ebx), "=c" (ecx),
> +		"=d" (edx) : "a" (0));

Strictly for 386/early 486 you would need to check if cpuid
is available using pushf too. Perhaps it's safer to use cpuinfo

> +
> +check_dev_msr() {

Return type missing again

> +	struct stat sb;
> +
> +	if (stat("/dev/cpu/0/msr", &sb)) {
> +		printf("no /dev/cpu/0/msr\n");

This will fail if we eventually implement cpu 0 hotplug...
Better readdir or similar.

> +		printf("Try \"# modprobe msr\"\n");
> +		exit(-5);

Again -5 is unusual.


> +	char msr_path[32];
> +	int retval;
> +	int fd;
> +
> +	sprintf(msr_path, "/dev/cpu/%d/msr", cpu);
> +	fd = open(msr_path, O_RDONLY);
> +	if (fd < 0) {
> +		perror(msr_path);
> +		exit(-1);

This should be a soft error because the CPU can go away
any time.


> +/*
> + * run func() on every cpu in /dev/cpu
> + */
> +void for_every_cpu(void (func)(int))
> +{
> +	FILE *fp;
> +	int cpu_count;
> +	int retval;
> +
> +	fp = fopen(proc_stat, "r");

Using /proc/stat to get the number of CPUs is unusual
and you don't handle holes in the cpu numbers which
can happen due to hotplug.

I would just readdir or fnmatch the MSR /dev/cpu/* directories.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
