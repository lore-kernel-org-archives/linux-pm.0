From: Philippe Longepe <philippe.longepe@linux.intel.com>
Subject: Re: intel_pstate oopses and lockdep report with Linux
 v4.5-1822-g63e30271b04c
Date: Thu, 17 Mar 2016 15:34:14 +0100
Message-ID: <56EAC066.4080203@linux.intel.com>
References: <CA+5PVA5=CJ=yf0EAZqNJX0XMc+ofDDJ-CHBrwuaANQwdhh2XbA@mail.gmail.com>
 <1704778.QLUl50G1uZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58700 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932568AbcCQOdH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Mar 2016 10:33:07 -0400
In-Reply-To: <1704778.QLUl50G1uZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Josh Boyer <jwboyer@fedoraproject.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

Hi,

The wmsrl is supposed to write on the MSR corresponding to the cpu that 
is executing it.

However, it seems that the following commit done by Joe Konno already 
fixed this bug on BYT.

0dd23f94251f49da99a6cbfb22418b2d757d77d6

Now, we need to figure out why the wmsrl is not executed on the current cpu!

Regards,

Philippe


On 17/03/2016 15:07, Rafael J. Wysocki wrote:
> On Thursday, March 17, 2016 09:02:29 AM Josh Boyer wrote:
>> Hello,
> Hi,
>
>> I have an Intel Atom based NUC that is producing the following
>> backtraces on boot of Linus' tree as of last evening.  This does not
>> happen with a tree with top level commit 271ecc5253e2, but does happen
>> when using the tree mentioned in the subject with top level commit
>> 63e30271b04c.
>>
>> The first backtrace appears to be a warning because the intel_pstate
>> driver is calling wrmsrl_on_cpu when interrupts are disabled?  Not
>> sure on that one.
>>
>> The second backtrace is a lockdep report.  Both are from the same boot.
> OK, thanks for the report.
>
> Can you please try the patch below?
>
> I'm actually unsure if we can do that safely in general for Atom because
> of the initialization, but that's what Core does anyway.
>
> Srinivas, Philippe, why exactly do we need the wrmsrl_on_cpu() in
> atom_set_pstate()?  core_set_pstate() uses wrmsrl() and seems to be doing fine.
>
> ---
>   drivers/cpufreq/intel_pstate.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -587,7 +587,7 @@ static void atom_set_pstate(struct cpuda
>   
>   	val |= vid;
>   
> -	wrmsrl_on_cpu(cpudata->cpu, MSR_IA32_PERF_CTL, val);
> +	wrmsrl(MSR_IA32_PERF_CTL, val);
>   }
>   
>   static int silvermont_get_scaling(void)
>

