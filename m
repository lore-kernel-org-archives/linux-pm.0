From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: Skip current frequency initialization for ->setpolicy
 drivers
Date: Tue, 18 Mar 2014 17:23:15 +0530
Message-ID: <532833AB.4020407@linux.vnet.ibm.com>
References: <CAA7pwKNmosWaWPR0x3kNzL7eNLk8vdCB=NknU9ayLT9s1fJQYA@mail.gmail.com> <CAA7pwKOgtx8dBSzdu2iBS_f1Xck0MkmHYjQOvsS-8W+HxFkYmg@mail.gmail.com> <CAA7pwKN2Rn2y9TaEYLtwVmJ0_7Syx0kVQHUNga5ga2BwB=q1fQ@mail.gmail.com> <2460637.PSm5Ca8pqs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2460637.PSm5Ca8pqs@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Patrik Lundquist <patrik.lundquist@gmail.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 03/13/2014 05:00 AM, Rafael J. Wysocki wrote:
> On Wednesday, March 12, 2014 03:14:51 PM Patrik Lundquist wrote:
>> On 12 March 2014 12:42, Patrik Lundquist <patrik.lundquist@gmail.com> wrote:
>>> On 12 March 2014 00:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>
>>>> So Patrik, please test this one (resending, so that it gets to linux-pm):
>>>
>>> Will do. Might take a couple of days.
>>
>> Come to think of it, there's not much to test besides verifying that
>> cpufreq_driver->get() isn't called like before (i.e. no need to test
>> on the server).
>>
>> So I inserted pr_err()s and they aren't printed when booting my Intel
>> Xeon CPU E3-1240 V2 while the intel_pstate driver still is used.
>>
>> The patch works for me.
> 
> Awesome, thanks!  Appended again with a proper changelog and tags.
> 
> Dirk, please let me know if you're fine with it.
> 
> Rafael
> 
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: cpufreq: Skip current frequency initialization for ->setpolicy drivers
> 
> After commit da60ce9f2fac (cpufreq: call cpufreq_driver->get() after
> calling ->init()) __cpufreq_add_dev() sometimes fails for CPUs handled
> by intel_pstate, because that driver may return 0 from its ->get()
> callback if it has not run long enough to collect enough samples on the
> given CPU.  That didn't happen before commit da60ce9f2fac which added
> policy->cur initialization to __cpufreq_add_dev() to help reduce code
> duplication in other cpufreq drivers.
> 
> However, the code added by commit da60ce9f2fac need not be executed
> for cpufreq drivers having the ->setpolicy callback defined, because
> the subsequent invocation of cpufreq_set_policy() will use that
> callback to initialize the policy anyway and it doesn't need
> policy->cur to be initialized upfront.  The analogous code in
> cpufreq_update_policy() is also unnecessary for cpufreq drivers
> having ->setpolicy set and may be skipped for them as well.
> 
> Since intel_pstate provides ->setpolicy, skipping the upfront
> policy->cur initialization for cpufreq drivers with that callback
> set will cover intel_pstate and the problem it's been having after
> commit da60ce9f2fac will be addressed.
> 
> Fixes: da60ce9f2fac (cpufreq: call cpufreq_driver->get() after calling ->init())
> References: https://bugzilla.kernel.org/show_bug.cgi?id=71931
> Reported-and-tested-by: Patrik Lundquist <patrik.lundquist@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: 3.13+ <stable@vger.kernel.org> # 3.13+
> ---

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

>  drivers/cpufreq/cpufreq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1129,7 +1129,7 @@ static int __cpufreq_add_dev(struct devi
>  		per_cpu(cpufreq_cpu_data, j) = policy;
>  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> 
> -	if (cpufreq_driver->get) {
> +	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
>  		policy->cur = cpufreq_driver->get(policy->cpu);
>  		if (!policy->cur) {
>  			pr_err("%s: ->get() failed\n", __func__);
> @@ -2143,7 +2143,7 @@ int cpufreq_update_policy(unsigned int c
>  	 * BIOS might change freq behind our back
>  	 * -> ask driver for current freq and notify governors about a change
>  	 */
> -	if (cpufreq_driver->get) {
> +	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
>  		new_policy.cur = cpufreq_driver->get(cpu);
>  		if (!policy->cur) {
>  			pr_debug("Driver did not initialize current freq");
> 

