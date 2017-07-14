From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] PM / Domains: defer dev_pm_domain_set() until
 genpd->attach_dev succeeds if present
Date: Fri, 14 Jul 2017 11:31:16 +0100
Message-ID: <0a29eebd-5e52-2cf2-b264-0f8187c590f9@arm.com>
References: <1498759251-11709-1-git-send-email-sudeep.holla@arm.com>
 <CAPDyKFrTSwiUFLbWp7BV4NJiuvoedEX=f4pA6wZzsrhDh4TctA@mail.gmail.com>
 <e6f02160-4153-5e44-8153-bc919808db0e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753808AbdGNKbU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jul 2017 06:31:20 -0400
In-Reply-To: <e6f02160-4153-5e44-8153-bc919808db0e@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>



On 12/07/17 17:36, Sudeep Holla wrote:
> 
> 
> On 12/07/17 14:59, Ulf Hansson wrote:
>> On 29 June 2017 at 20:00, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> If the genpd->attach_dev or genpd->power_on fails, genpd_dev_pm_attach
>>> may return -EPROBE_DEFER initially. However genpd_alloc_dev_data sets
>>> the PM domain for the device unconditionally.
>>>
>>> When subsequent attempts are made to call genpd_dev_pm_attach, it may
>>> return -EEXISTS checking dev->pm_domain without re-attempting to call
>>> attach_dev or power_on.
>>>
>>> platform_drv_probe then attempts to call drv->probe as the return value
>>> -EEXIST != -EPROBE_DEFER, which may end up in a situation where the
>>> device is accessed without it's power domain switched on.
>>
>> Right, this makes sense.
>>
> 
> Thanks
> 
>>>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Kevin Hilman <khilman@kernel.org>
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>
>> Could we perhaps work out which commit it fixes, or perhaps the
>> problem been there long time ago and we should just add a stable tag?
>>
> 
> OK I will dig that out.
> 

It looks like commit 989561de9b51 ("PM / Domains: add setter for
dev.pm_domain") added the helper. I then follow it to commit
f104e1e5ef57 ("PM / Domains: Re-order initialization of
generic_pm_domain_data"). The code in the original commit 6ff7bb0d02f8
("PM / Domains: Cache device stop and domain power off governor results,
v3") looks OK to me.

So What should I do ? Add
Fixes: f104e1e5ef57 ("PM / Domains: Re-order initialization of
generic_pm_domain_data")

tag in the mainline. And when Greg or others fix up before v4.4, I need
to work out the fix for that stable version ?

-- 
Regards,
Sudeep
