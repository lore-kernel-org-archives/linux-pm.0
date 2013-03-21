From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/4] cpuidle / omap4 : use CPUIDLE_FLAG_TIMER_STOP flag
Date: Thu, 21 Mar 2013 14:14:04 +0100
Message-ID: <514B079C.8050002@linaro.org>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org> <1363868494-5503-2-git-send-email-daniel.lezcano@linaro.org> <514B04A7.3040707@ti.com> <514B0580.4080408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:61063 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab3CUNOI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 09:14:08 -0400
Received: by mail-ee0-f50.google.com with SMTP id e51so1764755eek.37
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2013 06:14:06 -0700 (PDT)
In-Reply-To: <514B0580.4080408@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, lenb@kernel.org, linus.walleij@linaro.org, rnayak@ti.com, kernel@pengutronix.de, tglx@linutronix.de

On 03/21/2013 02:05 PM, Santosh Shilimkar wrote:
> On Thursday 21 March 2013 06:31 PM, Santosh Shilimkar wrote:
>> $subject
>> s/'cpuidle/omap4' /ARM: CPUidle: OMAP4:
>>
>> On Thursday 21 March 2013 05:51 PM, Daniel Lezcano wrote:
>>> Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
>>> to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
>>> this state.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Len Brown <lenb@kernel.org>
>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Cc: Rajendra Nayak <rnayak@ti.com>
>>> Cc: Sascha Hauer <kernel@pengutronix.de>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>> Otherwise
>> Akced-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
> One more comment for this patch as well as imx and ux500 one.
>=20
> Remove "#include <linux/clockchips.h>" since it is not needed
> anymore.

Actually, it is still needed for:

omap_setup_broadcast_timer
imx6q_setup_broadcast_timer
ux500_setup_broadcast_timer

I am preparing another round of patches to move these initialization to
the cpuidle framework but I have to take into account the multiple
drivers support which could be impacted, this is why it is a separated
patchset.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

