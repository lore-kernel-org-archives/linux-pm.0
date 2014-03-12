From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH] cpufreq: Skip current frequency initialization for ->setpolicy
 drivers
Date: Wed, 12 Mar 2014 16:30:44 -0700
Message-ID: <5320EE24.4030005@gmail.com>
References: <CAA7pwKNmosWaWPR0x3kNzL7eNLk8vdCB=NknU9ayLT9s1fJQYA@mail.gmail.com> <CAA7pwKOgtx8dBSzdu2iBS_f1Xck0MkmHYjQOvsS-8W+HxFkYmg@mail.gmail.com> <CAA7pwKN2Rn2y9TaEYLtwVmJ0_7Syx0kVQHUNga5ga2BwB=q1fQ@mail.gmail.com> <2460637.PSm5Ca8pqs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:63974 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbaCLXiJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Mar 2014 19:38:09 -0400
In-Reply-To: <2460637.PSm5Ca8pqs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Patrik Lundquist <patrik.lundquist@gmail.com>
Cc: dirk.brandewie@gmail.com, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 03/12/2014 04:30 PM, Rafael J. Wysocki wrote:
> Dirk, please let me know if you're fine with it.
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

Acked-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

> Cc: 3.13+ <stable@vger.kernel.org> # 3.13+
> ---
>   drivers/cpufreq/cpufreq.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1129,7 +1129,7 @@ static int __cpufreq_add_dev(struct devi
>   		per_cpu(cpufreq_cpu_data, j) = policy;
>   	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>
> -	if (cpufreq_driver->get) {
> +	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
>   		policy->cur = cpufreq_driver->get(policy->cpu);
>   		if (!policy->cur) {
>   			pr_err("%s: ->get() failed\n", __func__);
> @@ -2143,7 +2143,7 @@ int cpufreq_update_policy(unsigned int c
>   	 * BIOS might change freq behind our back
>   	 * -> ask driver for current freq and notify governors about a change
>   	 */
> -	if (cpufreq_driver->get) {
> +	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
>   		new_policy.cur = cpufreq_driver->get(cpu);
>   		if (!policy->cur) {
>   			pr_debug("Driver did not initialize current freq");
>

