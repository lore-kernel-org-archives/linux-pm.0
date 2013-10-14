From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM: at91: cpuidle: Move driver to drivers/cpuidle
Date: Mon, 14 Oct 2013 12:53:42 +0200
Message-ID: <525BCD36.5050401@linaro.org>
References: <1381593099-1184-1-git-send-email-daniel.lezcano@linaro.org> <20131013111945.0251a3cc@skate> <525A732D.3080708@linaro.org> <3135182.xhXUMRLLGy@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:48923 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100Ab3JNKxo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 06:53:44 -0400
Received: by mail-we0-f182.google.com with SMTP id t61so6924919wes.13
        for <linux-pm@vger.kernel.org>; Mon, 14 Oct 2013 03:53:43 -0700 (PDT)
In-Reply-To: <3135182.xhXUMRLLGy@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On 10/14/2013 12:20 PM, Bartlomiej Zolnierkiewicz wrote:
>
> Hi Daniel,
>
> On Sunday, October 13, 2013 12:17:17 PM Daniel Lezcano wrote:
>> On 10/13/2013 11:19 AM, Thomas Petazzoni wrote:
>>> Dear Daniel Lezcano,
>>>
>>> On Sat, 12 Oct 2013 17:51:39 +0200, Daniel Lezcano wrote:
>>>
>>>> +config ARM_AT91_CPUIDLE
>>>> +        bool "Cpu Idle Driver for the AT91 processors"
>>>
>>> Nitpick: indentation is done with spaces here, while it should be o=
ne
>>> tab.
>>
>> Ah, right. Fixed for the V2.
>
> Could you also please add 'default y' to preserve the old behavior?
> (the at91 cpuidle support was always built-in for CONFIG_CPU_IDLE=3Dy=
)

Yes, sure.

Thanks for the review.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

