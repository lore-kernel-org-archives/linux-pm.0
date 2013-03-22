From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 1/4][resend] cpuidle : handle clockevent notify from the cpuidle framework
Date: Fri, 22 Mar 2013 10:04:24 -0700
Message-ID: <87hak3e57r.fsf@linaro.org>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:62575 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161016Ab3CVRE1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 13:04:27 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so3188501pbc.26
        for <linux-pm@vger.kernel.org>; Fri, 22 Mar 2013 10:04:27 -0700 (PDT)
In-Reply-To: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Thu, 21 Mar 2013 13:21:31 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, lenb@kernel.org, linus.walleij@linaro.org, santosh.shilimkar@ti.com, rnayak@ti.com, kernel@pengutronix.de, tglx@linutronix.de

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> When a cpu enters a deep idle state, the local timers are stopped and
> the time framework falls back to the timer device used as a broadcast
> timer.
>
> The different cpuidle drivers are calling clockevents_notify ENTER/EXIT
> when the idle state stops the local timer.
>
> Add a new flag CPUIDLE_FLAG_TIMER_STOP which can be set by the cpuidle
> drivers. If the flag is set, the cpuidle core code takes care of the
> notification on behalf of the driver to avoid pointless code duplication.

Nice cleanup.

Reviewed-by: Kevin Hilman <khilman@linaro.org>

