From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v3] ARM: tegra: cpuidle: implement cpuidle_state.enter_freeze()
Date: Thu, 18 Jun 2015 09:09:29 +0200
Message-ID: <CAAObsKCURyo-ujcA7r+UYqSw6ie-aBxKiYEdTKwe-HrL14RkBw@mail.gmail.com>
References: <1432046953-12945-1-git-send-email-tomeu.vizoso@collabora.com> <1773599.T1QStsTFTH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37941 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbbFRHJy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 03:09:54 -0400
In-Reply-To: <1773599.T1QStsTFTH@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Ingo Molnar <mingo@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 21 May 2015 at 03:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, May 19, 2015 04:49:12 PM Tomeu Vizoso wrote:
>> This callback is expected to do the same as enter() but it has to
>> guarantee that interrupts aren't enabled at any point in its execution,
>> as the tick is frozen.
>>
>> It will be called when the system goes to suspend-to-idle and will
>> reduce power usage because CPUs won't be awaken for unnecessary IRQs.
>>
>> By setting the CPUIDLE_FLAG_TIMER_STOP flag, we can reuse the same code
>> for both the enter() and enter_freeze() callbacks.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Makes sense to me, but I suppose it should go in via arm-soc.

Hi Thierry,

what's the plan regarding merging of this patch?

It needs df8d9ee ("cpuidle: Run tick_broadcast_exit() with disabled
interrupts") so it doesn't break boot.

Thanks,

Tomeu
