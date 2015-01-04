From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [PATCH] power: avs: smartreflex: Remove unused function
Date: Sun, 4 Jan 2015 17:06:12 +0100
Message-ID: <CAKXHbyPiWcVxPwVicz15hQ0GWETkZUPW6n5b9zCJnH+cFrAhaw@mail.gmail.com>
References: <1420300731-8910-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
	<20150103175346.GB20341@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:46140 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbbADQGN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jan 2015 11:06:13 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so17896690iec.25
        for <linux-pm@vger.kernel.org>; Sun, 04 Jan 2015 08:06:13 -0800 (PST)
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com. [209.85.223.180])
        by mx.google.com with ESMTPSA id qa8sm2362718igb.13.2015.01.04.08.06.12
        for <linux-pm@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 04 Jan 2015 08:06:12 -0800 (PST)
Received: by mail-ie0-f180.google.com with SMTP id rp18so18649857iec.11
        for <linux-pm@vger.kernel.org>; Sun, 04 Jan 2015 08:06:12 -0800 (PST)
In-Reply-To: <20150103175346.GB20341@kahuna>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2015-01-03 18:53 GMT+01:00 Nishanth Menon <nm@ti.com>:
> On 16:58-20150103, Rickard Strandqvist wrote:
>> Remove the function sr_configure_minmax() that is not used anywhere.
>>
>> This was partially found by using a static code analysis program called cppcheck.
>>
>> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
>> ---
>>  drivers/power/avs/smartreflex.c   |   86 -------------------------------------
>>  include/linux/power/smartreflex.h |    1 -
>>  2 files changed, 87 deletions(-)
>>
>> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
>> index db9973b..62b8351 100644
>> --- a/drivers/power/avs/smartreflex.c
>> +++ b/drivers/power/avs/smartreflex.c
>> @@ -460,92 +460,6 @@ int sr_disable_errgen(struct omap_sr *sr)
>>  }
>>
>>  /**
>> - * sr_configure_minmax() - Configures the SmartReflex to perform AVS using the
>> - *                    minmaxavg module.
>> - * @sr:                      SR module to be configured.
>> - *
>> - * This API is to be called from the smartreflex class driver to
>> - * configure the minmaxavg module inside the smartreflex module.
>> - * SR settings if using the ERROR module inside Smartreflex.
>> - * SR CLASS 3 by default uses only the ERROR module where as
>> - * SR CLASS 2 can choose between ERROR module and MINMAXAVG
>> - * module. Returns 0 on success and error value in case of failure.
>> - */
>> -int sr_configure_minmax(struct omap_sr *sr)
>> -{
>> -     u32 sr_config, sr_avgwt;
>> -     u32 senp_en = 0, senn_en = 0;
>> -     u8 senp_shift, senn_shift;
>> -
>> -     if (!sr) {
>> -             pr_warn("%s: NULL omap_sr from %pF\n", __func__,
>> -                     (void *)_RET_IP_);
>> -             return -EINVAL;
>> -     }
>> -
>> -     if (!sr->clk_length)
>> -             sr_set_clk_length(sr);
>> -
>> -     senp_en = sr->senp_mod;
>> -     senn_en = sr->senn_mod;
>> -
>> -     sr_config = (sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
>> -             SRCONFIG_SENENABLE |
>> -             (sr->accum_data << SRCONFIG_ACCUMDATA_SHIFT);
>> -
>> -     switch (sr->ip_type) {
>> -     case SR_TYPE_V1:
>> -             sr_config |= SRCONFIG_DELAYCTRL;
>> -             senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
>> -             senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
>> -             break;
>> -     case SR_TYPE_V2:
>> -             senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
>> -             senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
>> -             break;
>> -     default:
>> -             dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
>> -                     "module without specifying the ip\n", __func__);
>> -             return -EINVAL;
>> -     }
>> -
>> -     sr_config |= ((senn_en << senn_shift) | (senp_en << senp_shift));
>> -     sr_write_reg(sr, SRCONFIG, sr_config);
>> -     sr_avgwt = (sr->senp_avgweight << AVGWEIGHT_SENPAVGWEIGHT_SHIFT) |
>> -             (sr->senn_avgweight << AVGWEIGHT_SENNAVGWEIGHT_SHIFT);
>> -     sr_write_reg(sr, AVGWEIGHT, sr_avgwt);
>> -
>> -     /*
>> -      * Enabling the interrupts if MINMAXAVG module is used.
>> -      * TODO: check if all the interrupts are mandatory
>> -      */
>> -     switch (sr->ip_type) {
>> -     case SR_TYPE_V1:
>> -             sr_modify_reg(sr, ERRCONFIG_V1,
>> -                     (ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
>> -                     ERRCONFIG_MCUBOUNDINTEN),
>> -                     (ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
>> -                      ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
>> -                      ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
>> -             break;
>> -     case SR_TYPE_V2:
>> -             sr_write_reg(sr, IRQSTATUS,
>> -                     IRQSTATUS_MCUACCUMINT | IRQSTATUS_MCVALIDINT |
>> -                     IRQSTATUS_MCBOUNDSINT | IRQSTATUS_MCUDISABLEACKINT);
>> -             sr_write_reg(sr, IRQENABLE_SET,
>> -                     IRQENABLE_MCUACCUMINT | IRQENABLE_MCUVALIDINT |
>> -                     IRQENABLE_MCUBOUNDSINT | IRQENABLE_MCUDISABLEACKINT);
>> -             break;
>> -     default:
>> -             dev_err(&sr->pdev->dev, "%s: Trying to Configure smartreflex"
>> -                     "module without specifying the ip\n", __func__);
>> -             return -EINVAL;
>> -     }
>> -
>> -     return 0;
>> -}
>> -
>> -/**
>>   * sr_enable() - Enables the smartreflex module.
>>   * @sr:              pointer to which the SR module to be configured belongs to.
>>   * @volt:    The voltage at which the Voltage domain associated with
>> diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
>> index d8b187c3..ffd31af 100644
>> --- a/include/linux/power/smartreflex.h
>> +++ b/include/linux/power/smartreflex.h
>> @@ -303,7 +303,6 @@ int sr_enable(struct omap_sr *sr, unsigned long volt);
>>  void sr_disable(struct omap_sr *sr);
>>  int sr_configure_errgen(struct omap_sr *sr);
>>  int sr_disable_errgen(struct omap_sr *sr);
>> -int sr_configure_minmax(struct omap_sr *sr);
>>
>>  /* API to register the smartreflex class driver with the smartreflex driver */
>>  int sr_register_class(struct omap_sr_class_data *class_data);
>> --
>> 1.7.10.4
>>
>
> This is potentially used by downstream drivers which are pending cleanup
> of remaining OMAP infrastructure since the transition from hwmod to
> devicetree has multiple impact including the conversion of vc/vp back
> into devicetree supported world (proper regulator framework). while we
> can throw away code by looking at a specific snapshot, it might just
> confuse the future transition.
>
> --
> Regards,
> Nishanth Menon


Hi

Quite ok, I'm just trying to draw attention to the I discover, then
it's up to you if it is something that should be addressed.


Kind regards
Rickard Strandqvist
