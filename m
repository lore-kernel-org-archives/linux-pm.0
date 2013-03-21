From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/4] cpuidle / omap4 : use CPUIDLE_FLAG_TIMER_STOP flag
Date: Thu, 21 Mar 2013 18:31:27 +0530
Message-ID: <514B04A7.3040707@ti.com>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org> <1363868494-5503-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57211 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757173Ab3CUNAC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Mar 2013 09:00:02 -0400
In-Reply-To: <1363868494-5503-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, lenb@kernel.org, linus.walleij@linaro.org, rnayak@ti.com, kernel@pengutronix.de, tglx@linutronix.de

$subject
s/'cpuidle/omap4' /ARM: CPUidle: OMAP4:

On Thursday 21 March 2013 05:51 PM, Daniel Lezcano wrote:
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
> ---
Otherwise
Akced-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

