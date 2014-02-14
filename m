From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: fix current freq check on policy update
Date: Fri, 14 Feb 2014 17:14:34 +0530
Message-ID: <52FE01A2.9030905@linux.vnet.ibm.com>
References: <20140214072623.3dd67851@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:55537 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbaBNLuC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2014 06:50:02 -0500
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 14 Feb 2014 17:19:59 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 81ED0394004E
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2014 17:19:57 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s1EBnvRd5177698
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2014 17:19:57 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s1EBnsZm032134
	for <linux-pm@vger.kernel.org>; Fri, 14 Feb 2014 17:19:55 +0530
In-Reply-To: <20140214072623.3dd67851@mjolnir.ossman.eu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pierre Ossman <pierre-list@ossman.eu>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM mailing list <linux-pm@vger.kernel.org>

On 02/14/2014 11:56 AM, Pierre Ossman wrote:
> From de497de3fcd81e8340498cd0b34b3388fe75cc19 Mon Sep 17 00:00:00 2001
> From: Pierre Ossman <pierre@ossman.eu>
> Date: Fri, 14 Feb 2014 07:17:02 +0100
> Subject: [PATCH] cpufreq: fix current freq check on policy update
> 
> There was some variable confusion in cpufreq_update_policy()
> when we tried to get a current reading of the CPU frequency.
> If it failed to get the frequency, a current frequency of
> 0 kHz would be stored which in turn screwed up other parts
> of the kernel.
> 

You know what's interesting? I went through the powernow-k8 cpufreq
driver code (based on your system data in the bugzilla), and found
that (if I read it correctly), ->get() can simply never return 0 !

.get is mapped to powernowk8_get

powernowk8_get() in turn calls smp_call_function_single() on that cpu
and fetches the data into data->currfid.

Then we have this statement:
	khz = find_khz_freq_from_fid(data->currfid);

which is:

  66 /* Return a frequency in MHz, given an input fid */
  67 static u32 find_freq_from_fid(u32 fid)
  68 {
  69         return 800 + (fid * 100);
  70 }
  71 
  72 /* Return a frequency in KHz, given an input fid */
  73 static u32 find_khz_freq_from_fid(u32 fid)
  74 {
  75         return 1000 * find_freq_from_fid(fid);
  76 }


So with that, I don't see how the KHz value can turn out to be zero!

Regards,
Srivatsa S. Bhat

> In particular it somehow disoriented the r8169 driver and
> this entire issue was handled on this bug:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=70311
> 
> Signed-off-by: Pierre Ossman <pierre@ossman.eu>
> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 08ca8c9..1b61310 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2151,9 +2151,9 @@ int cpufreq_update_policy(unsigned int cpu)
>  	 */
>  	if (cpufreq_driver->get) {
>  		new_policy.cur = cpufreq_driver->get(cpu);
> -		if (!policy->cur) {
> +		if (!new_policy.cur) {
>  			pr_debug("Driver did not initialize current freq");
> -			policy->cur = new_policy.cur;
> +			new_policy.cur = policy->cur;
>  		} else {
>  			if (policy->cur != new_policy.cur && has_target())
>  				cpufreq_out_of_sync(cpu, policy->cur,
> -- 1.8.5.3

