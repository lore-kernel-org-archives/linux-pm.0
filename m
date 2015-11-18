From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / Domains: Allow runtime PM callbacks to be re-used during system PM
Date: Wed, 18 Nov 2015 10:11:05 -0800
Message-ID: <7hvb8zxjnq.fsf@deeprootsystems.com>
References: <1447778561-9767-1-git-send-email-ulf.hansson@linaro.org>
	<7h4mgk1fd5.fsf@deeprootsystems.com>
	<CAPDyKFp-pHoPP4iW2CxC=L9x03fu2VXZ6LUC4i+CeQW_PjN2+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34373 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933229AbbKRSLH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 13:11:07 -0500
Received: by padhx2 with SMTP id hx2so52031514pad.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 10:11:06 -0800 (PST)
In-Reply-To: <CAPDyKFp-pHoPP4iW2CxC=L9x03fu2VXZ6LUC4i+CeQW_PjN2+Q@mail.gmail.com>
	(Ulf Hansson's message of "Wed, 18 Nov 2015 13:28:14 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, Harunaga <nx-truong@jinso.co.jp>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 17 November 2015 at 22:32, Kevin Hilman <khilman@kernel.org> wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>>> Runtime PM centric subsystems/drivers may re-use their runtime PM
>>> callbacks for system PM. Typically that's done via using the runtime PM
>>> helpers, pm_runtime_force_suspend|resume().
>>>
>>> To genpd, this means its runtime PM callbacks may be invoked even when
>>> runtime PM has been disabled for the device. By checking this condition,
>>> it allows genpd to skip latency validation and measurement in the system
>>> PM path. That's needed to enable drivers/subsystems to re-use the runtime
>>> PM callbacks for system PM.
>>>
>>> Fixes: ba2bbfbf6307 ("PM / Domains: Remove intermediate states from the
>>> power off sequence")
>>> Reported-by: Cao Minh Hiep <cm-hiep@jinso.co.jp>
>>> Reported-by: Harunaga <nx-truong@jinso.co.jp>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>
>>> This patch has only been quick tested on ux500, so further tests are
>>> welcome and needed. It was reported [1] to point out a certain commit
>>> causing the regression, but further analyze actually tells that the
>>> problem been there longer.
>>>
>>> So, I decided to point the fixes tag to a commit from where it actually
>>> becomes quite simple to address the problem. Earlier than that, is just
>>> not worth the effort.
>>>
>>> [1]
>>> https://lkml.org/lkml/2015/11/16/748
>>>
>>> ---
>>>  drivers/base/power/domain.c | 20 ++++++++++++++++----
>>>  1 file changed, 16 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index e03b1ad..8f0c2a3 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -390,6 +390,7 @@ static int pm_genpd_runtime_suspend(struct device *dev)
>>>       struct generic_pm_domain *genpd;
>>>       bool (*stop_ok)(struct device *__dev);
>>>       struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
>>> +     bool system_pm = !pm_runtime_enabled(dev);
>>
>> nit: I think this 'system_pm' variable name is confusing, especaly
>> because it just means runtime PM *not* enabled.
>
> Okay! Perhaps "runtime_pm" would be better?
>

Yes, or rpm_disabled (or rpm_enabled), which is what it's actually
checking.

>>
>> Is !pm_runtime_enabled() really sufficient to determine if these are
>> being called in the context of system PM?
>
> I guess pm_runtime_force_suspend() could be used from other places but
> a system PM callback, such as a ->remove() callback for example. So,
> indeed you have point!
>
> Nevertheless, I still think we can rely on the condition from
> pm_runtime_enabled(dev), as it's only relevant to validate/measure dev
> PM QOS latencies when runtime PM is enabled.

Yeah, good point.

Kevin
