From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/4] ARM: timer-sp: Set dynamic irq affinity
Date: Wed, 27 Feb 2013 10:26:08 +0530
Message-ID: <512D91E8.6050706@ti.com>
References: <1361917047-29230-1-git-send-email-daniel.lezcano@linaro.org> <1361917047-29230-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36754 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758491Ab3B0EzE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Feb 2013 23:55:04 -0500
In-Reply-To: <1361917047-29230-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: john.stultz@linaro.org, tglx@linutronix.de, viresh.kumar@linaro.org, jacob.jun.pan@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, linus.walleij@stericsson.com

On Wednesday 27 February 2013 03:47 AM, Daniel Lezcano wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
>
> When a cpu goes to a deep idle state where its local timer is shutdown, it
> notifies the time frame work to use the broadcast timer instead.
>
> Unfortunately, the broadcast device could wake up any CPU, including an idle one
> which is not concerned by the wake up at all.
>
Broad-cast device will only open the CPU for which the timer IRQ
affined to. And infact with subject series the affinity also is
updated for the CPU which owns the last timer expiry event.

> This implies, in the worst case, an idle CPU will wake up to send an IPI to
> another idle cpu.
>
> This patch fixes this for ARM platforms using timer-sp, by setting
> CLOCK_EVT_FEAT_DYNIRQ feature.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
What am I missing here ?

Regards,
Santosh

