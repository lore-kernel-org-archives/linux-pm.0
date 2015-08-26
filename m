From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] modify pl011 driver to work as wakeup source
Date: Wed, 26 Aug 2015 16:00:55 +0200
Message-ID: <55DDC697.4080107@linaro.org>
References: <1439547886-5093-1-git-send-email-zhaoyang.huang@linaro.org>	<55CDC9D4.3020709@linaro.org> <CAN2waFv+8KM_TCw=iy1BOn-KmYuZRVmr5jKAniJwCaxBjqXvNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34914 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbbHZOA7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2015 10:00:59 -0400
Received: by wicne3 with SMTP id ne3so45929728wic.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2015 07:00:58 -0700 (PDT)
In-Reply-To: <CAN2waFv+8KM_TCw=iy1BOn-KmYuZRVmr5jKAniJwCaxBjqXvNQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>

On 08/26/2015 03:02 PM, Zhaoyang Huang wrote:
> The following functions don't work on pl011 for setting it as wakeup =
irq.
> device_init_wakeup(dev, true);	dev_pm_set_wake_irq(dev, irq);

Hi Zhaoyang,

if I understood correctly, dev_pm_set_wake_irq is the new API to set a=20
wake up device up. You are the first one using it, so perhaps there is=20
something missing.

I recommend you have a look at the slides [1] showed at the LPC2015.

I added Sudeep so he can give more informations about that.

   -- Daniel

[1]=20
https://linuxplumbersconf.org/2015/ocw//system/presentations/3051/origi=
nal/wakeup_config.pdf

>
> On 14 August 2015 at 18:58, Daniel Lezcano <daniel.lezcano@linaro.org
> <mailto:daniel.lezcano@linaro.org>> wrote:
>
>     On 08/14/2015 12:24 PM, Zhaoyang Huang wrote:
>
>         add IRQF_NO_SUSPEND flag when requiring irq line and call
>         the pm_system_wakeup when RX interrupt happens
>
>         Signed-off-by: Zhaoyang Huang <zhaoyang.huang@linaro.org
>         <mailto:zhaoyang.huang@linaro.org>>
>
>
>     Did you look at the 'dev_pm_set_wake_irq' function ?
>
>
>
>     --
>       <http://www.linaro.org/> Linaro.org =E2=94=82 Open source softw=
are for ARM
>     SoCs
>
>     Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>     <http://twitter.com/#!/linaroorg
>     <http://twitter.com/#%21/linaroorg>> Twitter |
>     <http://www.linaro.org/linaro-blog/> Blog
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

