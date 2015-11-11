From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFCv2 1/2] power: domain: add pm_genpd_uninit
Date: Wed, 11 Nov 2015 21:29:26 +0100
Message-ID: <CAPDyKFqKExt0CdF6hccnm4Z1Q_r3N3+HoCnAH6rj904ARTzhpQ@mail.gmail.com>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
	<1446590711-18928-2-git-send-email-alex.aring@gmail.com>
	<CAPDyKFrkzMZZjFRM7EbqDqmW8EXzV22O_tp8a45LVGQYSn6b3g@mail.gmail.com>
	<20151105143445.GC599@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:36179 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbbKKU31 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2015 15:29:27 -0500
Received: by ykdr82 with SMTP id r82so68862564ykd.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2015 12:29:26 -0800 (PST)
In-Reply-To: <20151105143445.GC599@omega>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

[...]

>> >
>> > +/**
>> > + * pm_genpd_uninit - Uninitialize a generic I/O PM domain object.
>> > + * @genpd: PM domain object to initialize.
>> > + */
>> > +void pm_genpd_uninit(struct generic_pm_domain *genpd)
>> > +{
>> > +       if (IS_ERR_OR_NULL(genpd))
>> > +               return;
>> > +
>> > +       mutex_lock(&gpd_list_lock);
>> > +       list_del(&genpd->gpd_list_node);
>> > +       mutex_unlock(&gpd_list_lock);
>>
>> This is too fragile. You don't protect from the cases below.
>>
>> 1. The genpd may have devices attached to it.
>> 2. The genpd may have subdomains.
>>
>> To deal with these case, that's when it becomes more complex which I
>> guess is the reason to why nobody really cared until now.
>>
>
> Can we not just undo the things which pm_genpd_init does, then let the
> driver to deal with all other uninitialize of e.g. "subdomains" which might
> the driver has initialize before? We know there are no slaves or something
> else which is empty because pm_genpd_init runs INIT_LIST_HEAD, or not?
>
> To make such handling above I would add some:
>
> "pm_genpd_uninit_recursive" function, which cleanup everything from a
> power domain, e.g. subdomains, etc and other lists.
>
> What do you suggest to me for e.g. the raspberrypi power domain driver,
> also simple ignore such error handling?

No, let's give it try so see if can improve the situation.

>
>
> For my current use-case I can remove the failure between pm_genpd_init by
> simple getting all "power states" (the bool is_off for pm_genpd_init),
> before calling pm_genpd_init. In this case I don't have any failure between
> calling pm_genpd_init when another pm_genpd_init was before.
>
> Looks like this:
>
> 1. get all states from firmware to get parameter "is_off", which can fail.
>    We should get here the states for the power domains which we want to
>    register only.
>
> 2. Then call pm_genpd_init, which cannot be fail between another
>    pm_genpd_init. (There are only void functions in the middle, which cannot
>    fail). If I call pm_genpd_init, I use "is_off" variable from the step
>    of "1.".
>
>
> But then I have still the call of "of_genpd_add_provider_onecell" at the end
> of probing which can fail. So this is also not a valid solution, because
> I need to undo everything before.

Okay, got it.

>
>> Moreover, I think there are some more structures to "uninitialize"
>> besides just unlinking the genpd struct from the gpd list. For example
>> a mutex_destroy() should be done.
>>
>
> yes, of course.
>
> - Alex

Kind regards
Uffe
