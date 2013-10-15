From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 1/2] ARM: at91: cpuidle: convert to platform driver
Date: Tue, 15 Oct 2013 08:16:31 +0200
Message-ID: <525CDDBF.3060500@linaro.org>
References: <1381781721-11866-1-git-send-email-daniel.lezcano@linaro.org> <20131014232539.GM11420@ns203013.ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56391 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab3JOGQe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2013 02:16:34 -0400
Received: by mail-wi0-f174.google.com with SMTP id cb5so4495047wib.1
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2013 23:16:33 -0700 (PDT)
In-Reply-To: <20131014232539.GM11420@ns203013.ovh.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, thomas.petazzoni@free-electrons.com, b.zolnierkie@samsung.com

On 10/15/2013 01:25 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 22:15 Mon 14 Oct     , Daniel Lezcano wrote:
>> Using the platform driver model is a good way to separate the cpuidl=
e specific
>> code from the low level pm code. It allows to remove the dependency =
between
>> these two components.
>>
>> The platform_device is located in the pm code and a 'set' function h=
as been
>> added to set the standby function from the AT91_SOC_START initializa=
tion
>> function. Each SoC with a cpuidle driver will set the standby functi=
on in the
>> platform_data field at init time. Then pm code will register the cpu=
idle
>> platform device.
>>
>> The cpuidle driver will register the platform_driver and use the dev=
ice's
>> platform_data as a standby callback in the idle path.
>
> I've an issue while re-reading the pm code
>
> we use the xx_standby for 2 drivers cpuidle and suspend/resume
>
> with all the cpu_is_xxxx
>
> so you need to do one more step in this series
> by cleaning up the PM_SUSPEND_STANDBY to as you put a function pointe=
r with
> the correct one in pm.c

I was plannning to send it as a separate patch.

> otherwise looks good

Cool. Thanks for the review.

   -- Daniel

[ ... ]

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

