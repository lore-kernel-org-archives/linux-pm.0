From: Arto Jantunen <viiru@iki.fi>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Tue, 01 Mar 2016 09:06:10 +0200
Message-ID: <87twkqllst.fsf@kirika.int.wmdata.fi>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>
	<87a8mv9ujm.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
	<87egc6zc2q.fsf@iki.fi>
	<36DF59CE26D8EE47B0655C516E9CE640286C6319@shsmsx102.ccr.corp.intel.com>
	<56CA17D4.8080802@linux.intel.com> <87lh6du7lu.fsf@iki.fi>
	<20160222061637.GF28226@vireshk-i7> <871t84vgvq.fsf@iki.fi>
	<20160222164114.GU28226@vireshk-i7> <87egbwn8lp.fsf@iki.fi>
	<20160229201946.0bdcc48e@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from viiru.iki.fi ([185.19.28.114]:33771 "EHLO viiru.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802AbcCAHGO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Mar 2016 02:06:14 -0500
In-Reply-To: <20160229201946.0bdcc48e@annuminas.surriel.com> (Rik van Riel's
	message of "Mon, 29 Feb 2016 20:19:46 -0500")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Rik van Riel <riel@redhat.com> writes:

> On Sun, 28 Feb 2016 17:43:46 +0200
> Arto Jantunen <viiru@iki.fi> wrote:
>
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>> 
>> > On 22-02-16, 18:39, Arto Jantunen wrote:
>> >> Viresh Kumar <viresh.kumar@linaro.org> writes:
>> >> 
>> >> > On 21-02-16, 22:33, Arto Jantunen wrote:
>> >> >> I have tested both available governors, and see the same behavior either
>> >> >> way. The kernel I have defaults to performance, I think I'll try
>> >> >> building another one which defaults to powersave to see if that changes
>> >> >> anything (perhaps both governors actually work but it isn't possible to
>> >> >> switch between them at runtime?). The Debian userspace defaults to
>> >> >> ondemand, which doesn't exist for intel_pstate.
>> >> >
>> >> > I took a close look at git log between 4.4 and 4.5-rc1 for intel-pstate and it
>> >> > had only three patches:
>> >> >
>> >> > 157386b6fc14 cpufreq: intel_pstate: Configurable algorithm to get target pstate
>> >> > e70eed2b6454 cpufreq: intel_pstate: Account for non C0 time
>> >> > 63d1d656a523 cpufreq: intel_pstate: Account for IO wait time
>> >> >
>> >> > The first one creates special routines based on the CPU model you have, yours is
>> >> > 94, i.e. 5e, which means we are going to use: core_params in your case. And so
>> >> > you will be using get_target_pstate_use_performance() for .get_target_pstate().
>
> What exactly is the problem you are seeing, and on what CPUs?

Quoting from the first mail in this thread:

When using kernel 4.5-rc4 my Skylake machine runs very warm since all
cpu cores are always kept at 3.10Ghz (with maximum without turboboost
being 2.6Ghz), completely regardless of load. Swapping between the
governors (performance and powersave) doesn't change the result in any
way, frequency remains at a constant 3.10Ghz.

I can force the frequency down manually with cpufreq-set, so the problem
doesn't seem to be with the actual frequency changing.

Cpuinfo (taken from 4.4 which doesn't have the problem):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 94
model name	: Intel(R) Core(TM) i7-6700HQ CPU @ 2.60GHz
stepping	: 3
microcode	: 0x33
cpu MHz		: 1067.929
cache size	: 6144 KB
physical id	: 0
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 22
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 \
clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm \
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf \
eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16 xtpr \
pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c \
rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm hwp hwp_notify \
hwp_act_window hwp_epp intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase \
tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx rdseed adx smap clflushopt \
xsaveopt xsavec xgetbv1 bugs		:
bogomips	: 5183.96
clflush size	: 64
cache_alignment	: 64
address sizes	: 39 bits physical, 48 bits virtual
power management:

> What does the cpufreq table for that CPU look like?
>
> Does HLT (or its equivalent) have a really, really high
> exit or residency latency?

I don't know the answer to either of these questions. How do I find out?

>> commit a9ceb78bc75ca47972096372ff3d48648b16317a
>> Author: Rik van Riel <riel@redhat.com>
>> Date:   Tue Nov 3 17:34:18 2015 -0500
>> 
>>     cpuidle,menu: use interactivity_req to disable polling
>
> I could see that patch being a little aggressive on some CPUs,
> due to interactivity_req being corrected by the load on the
> CPU.  Does using data->predicted_us help?

I'll test this tonight and get back to you.

> ---8<---
>
> Subject: cpuidle: use predicted_us not interactivity_req to consider polling
>
> The interactivity_req variable is the expected sleep time, divided
> by the CPU load. This can be too aggressive a factor in deciding
> whether or not to consider polling in the cpuidle state selection.
>
> Use the (not corrected for load) predicted_us instead.
>
> Signed-off-by: Rik van Riel <riel@redhat.com>
> ---
>  drivers/cpuidle/governors/menu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index 0742b3296673..97022ae01d2e 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -330,7 +330,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  		 * We want to default to C1 (hlt), not to busy polling
>  		 * unless the timer is happening really really soon.
>  		 */
> -		if (interactivity_req > 20 &&
> +		if (data->predicted_us > 20 &&
>  		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
>  			dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
>  			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
>
-- 
Arto Jantunen
