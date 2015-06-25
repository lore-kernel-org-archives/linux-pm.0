From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v2 7/9] ARM: multi_v7_defconfig: Enable support for PWM Regulators
Date: Thu, 25 Jun 2015 18:29:52 +0200
Message-ID: <CABxcv==dWX_J_+zhqjn61QXGtxCKmK62_HEj4R7wsMAWcC=H=Q@mail.gmail.com>
References: <1435154348-28840-1-git-send-email-lee.jones@linaro.org>
	<1435154348-28840-8-git-send-email-lee.jones@linaro.org>
	<CABxcv==J2hi0y+=s3nK_U=-jkjTW3L9jCC2JfebnWwRfpDGLAQ@mail.gmail.com>
	<20150625084204.GW15013@x1>
	<CABxcv==_YZ7BCCzfbLXYxwUL_kKLtBxOVTCvcUnvGVnrD4bVpg@mail.gmail.com>
	<20150625150255.GE23990@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34516 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbbFYQ3x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2015 12:29:53 -0400
Received: by ykfy125 with SMTP id y125so43396973ykf.1
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2015 09:29:52 -0700 (PDT)
In-Reply-To: <20150625150255.GE23990@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ajit Pal Singh <ajitpal.singh@st.com>

Hello Lee,

On Thu, Jun 25, 2015 at 5:02 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 25 Jun 2015, Javier Martinez Canillas wrote:
>> On Thu, Jun 25, 2015 at 10:42 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Wed, 24 Jun 2015, Javier Martinez Canillas wrote:
>>
>> [...]
>>
>> >> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> >> > index f632af0..6666973 100644
>> >> > --- a/arch/arm/configs/multi_v7_defconfig
>> >> > +++ b/arch/arm/configs/multi_v7_defconfig
>> >> > @@ -365,6 +365,7 @@ CONFIG_REGULATOR_MAX8907=y
>> >> >  CONFIG_REGULATOR_MAX8973=y
>> >> >  CONFIG_REGULATOR_MAX77686=y
>> >> >  CONFIG_REGULATOR_PALMAS=y
>> >> > +CONFIG_REGULATOR_PWM=y
>> >>
>> >> The current policy is to build as much as possible as a module in
>> >> multi_v7_defconfig. Since this is a tristate Kconfig symbol, could you
>> >> please change it to =m ?
>> >
>> > I would prefer that it stays built-in.
>> >
>>
>> Ok, I've no strong opinion on this. I was just mentioning what arm-soc
>> maintainers prefer nowadays.
>>
>> May I ask what's the rationale for leaving this option built-in?
>
> My view is that multi_v7 is used for prototyping, testing and to
> ensure all of the vendors are playing nice together.  Hopefully
> vendors aren't actually releasing kernels built with this defconfig!

Agreed and same for the per SoC family defconfigs, vendors should ship
kernels with a customized defconfig.

> During testing/prototyping time; installing and messing around with
> modules is an over-head I can do without.
>

Right but my question wasn't whether multi_v7 should have the options
as built-in or as modules. That has already been decided by the
arm-soc maintainers who want to have as much as possible as modules.
In fact, there have been patches posted recently to change the current
multi_v7 options from built-in to modules.

Instead my question was what makes this driver special to not follow
the current convention.

I agree that there is a trade off between having options as built-in
or modules and I believe that is why most SoC specific defconfigs have
the opposite policy,  that is to enable everything as built-in so one
doesn't have to mess with modules as you said.

But again, I don't have a strong opinion on this. What I think though
is that this should be documented somewhere so the options are enabled
following a documented rule instead of just whatever fits in someone
workflow.

Best regards,
Javier
