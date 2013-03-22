From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 2/4] cpuidle / omap4 : use CPUIDLE_FLAG_TIMER_STOP flag
Date: Fri, 22 Mar 2013 10:05:38 -0700
Message-ID: <87a9pve55p.fsf@linaro.org>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
	<1363868494-5503-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:60499 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161016Ab3CVRFm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 13:05:42 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so3233771pbb.4
        for <linux-pm@vger.kernel.org>; Fri, 22 Mar 2013 10:05:41 -0700 (PDT)
In-Reply-To: <1363868494-5503-2-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Thu, 21 Mar 2013 13:21:32 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, lenb@kernel.org, linus.walleij@linaro.org, santosh.shilimkar@ti.com, rnayak@ti.com, kernel@pengutronix.de, tglx@linutronix.de

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
> to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
> this state.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>

OMAP changes look good.

Reviewed-by: Kevin Hilman <khilman@linaro.org>
