From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: Re: [PATCH][RFC] PM / Domains: Add on-off notifiers
Date: Tue, 19 Mar 2013 18:01:15 +0100
Message-ID: <514899DB.60708@stericsson.com>
References: <1363351143-28490-1-git-send-email-rickard.andersson@stericsson.com> <878v5kh65y.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:53035 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932483Ab3CSRBY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Mar 2013 13:01:24 -0400
In-Reply-To: <878v5kh65y.fsf@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Kevin,

On 03/18/2013 08:14 PM, Kevin Hilman wrote:
> Hi Rickard,
>
> Rickard Andersson<rickard.andersson@stericsson.com>  writes:
>
>> Some drivers needs to restore their context directly
>> when a power domain is activated. For example a driver
>> handling system bus settings must be able to restore
>> context before the bus is being used for the first time.
>> Other examples could be clock settings hardware blocks and
>> special debugging hardware blocks which should be restored
>> as early as possible in order to be able to debug direcly
>> from waking up. Typically these notifers are needed in
>> systems with CPU coupled power domains. The notifiers
>> are intended to be trigged by cpuidle driver or the
>> suspend ops hooks.
>>
>> The drivers that needs to use these notifiers are
>> some special cases. Most drivers should not use this
>> method and instead control their context via the
>> pm_runtime interface.
>>
>> Signed-off-by: Rickard Andersson<rickard.andersson@stericsson.com>
> Some general comments.
>
> First, I don't see where the notifiers are actually called in this
> patch, so their intended use is not entirely clear.
I can send a patch of how the notifiers are trigged and used.
> Second, I'm a bit reluctant to see another layer of callbacks added to
> the drivers.  I think using notifiers for this adds another level of
> complexity to drivers that already have a pile of PM related callbacks
> to manage.
>
I understand your point but these callback should only be used when 
really needed. For example one can compare with that drivers today can 
register to cpufreq transition callbacks but most drivers does not need 
to do that.

> IMO, it would be helpful to see an example driver using this feature,
> and how it would interact with the drivers runtime PM callbacks.  For
> example, I suspect that the the notifier callback would bascially be the
> same as the runtime_resume callback, right?
Yes, they will do similar things.
> Stated differently, at first glance, it seems the feature needed is
> "runtime resume immidately after genpd power on".  Is that correct?
Yes, and "runtime suspend just before power off", but only trigged from 
cpuidle or platform suspend ops. But there are differences, for example 
the devices should be able to get the notifier call in the platform 
suspend ops. Normally pm_runtime is disabled during system suspend if I 
understand correct.
> Also, the changelog implies that ordering may be crucial here (e.g bus
> settings restored before bus is accessed), and using notifiers is not
> going to give you that kind of ordering guarantee.
If the drivers are probed in the right order and the drivers registers 
to the notifiers in the probe function then it will work fine.

One can think of my notifiers patch as something similar as 
/kernel/cpu_pm.c but for a genpd CPU coupled domain instead of the CPU 
power domains.
It would probably be possible to call the drivers runtime_resume 
callbacks for specially registered "runtime resume immediately" devices. 
(It is comparable to try to use runtime_resume for restoring context of 
for example the GIC instead of using /kernel/cpu_pm.c). I am unsure 
which solution is best.

BR
Rickard


