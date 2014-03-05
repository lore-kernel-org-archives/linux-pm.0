From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v2 01/11] base: power: Add generic OF-based power domain
 look-up
Date: Wed, 05 Mar 2014 12:47:14 +0100
Message-ID: <53170EC2.6090908@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>	<1393862536-9842-2-git-send-email-tomasz.figa@gmail.com> <CAPDyKFqK1JqxeJ_L_bzduixRLGA5m_FFPq_of2r6y0aCpS7z9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:41085 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbaCELra (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Mar 2014 06:47:30 -0500
In-Reply-To: <CAPDyKFqK1JqxeJ_L_bzduixRLGA5m_FFPq_of2r6y0aCpS7z9A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Loren

Hi Ulf,

On 05.03.2014 08:19, Ulf Hansson wrote:
>> @@ -2177,3 +2181,297 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>>          list_add(&genpd->gpd_list_node, &gpd_list);
>>          mutex_unlock(&gpd_list_lock);
>>   }
>> +
>> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>
> Do we need a new config for this? Can't we just use CONFIG_OF?
>

I guess we could, but initially it would have to be CONFIG_OF && 
!CONFIG_ARCH_EXYNOS until patch 03/11 converts Exynos to use the common 
code.

>> +       if (ret < 0) {
>> +               dev_err(dev, "failed to add to power domain %s: %d",
>> +                       pd->name, ret);
>> +               return ret;
>> +       }
>> +
>> +       pm_genpd_dev_need_restore(dev, true);
>
> So this will reflect the device as being inactive, which I think is
> the wrong approach.
>
> Usually we should expect drivers that's being probed successfully to
> leave their devices in active state, right?

It depends on domain power state, but actually it seems to be already 
handled in __pm_genpd_add_device(), so this line might be not needed indeed.

Strangely enough, it seemed to be needed on Exynos for correct 
operation, but maybe in the meantime some fixes in genpd code showed up. 
This will need some extra testing.

Best regards,
Tomasz
