From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cpuidle : handle clockevent notify from the cpuidle
 framework
Date: Wed, 20 Mar 2013 22:21:26 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303202210090.22263@ionos>
References: <1363795033-26445-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53518 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab3CTVVe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Mar 2013 17:21:34 -0400
In-Reply-To: <1363795033-26445-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, lenb@kernel.org, patches@linaro.org, linux-pm@vger.kernel.org

On Wed, 20 Mar 2013, Daniel Lezcano wrote:

> When a cpu enters a deep idle state, the local timers are stopped and
> the time framework falls back to the timer device used as a broadcast
> timer.
> 
> The different cpuidle drivers are calling clockevents_notify ENTER/EXIT
> when the idle state stops the local timer.
> 
> The proposed patch introduces a new flag CPUIDLE_FLAG_TIMER_STOP to let

Please stop using "proposed patch ...." wording in a patch
description. The changelog you submit with your patch should be
applicable w/o rewriting.

> the cpuidle framework to call clockevents_notify instead of duplicating
> again and again these lines in all the cpuidle drivers.

That's a good enough reason, really. So that paragraph should be
something like:

"Add a new flag CPUIDLE_FLAG_TIMER_STOP which can be set by cpuidle
 drivers. If the flag is set the cpuidle core code takes care of the
 notification on behalf of the driver to avoid pointless code
 duplication."

Ideally you would follow up with two or three drivers converted to
that new infrastructure instead of sending that patch standalone. That
way reviewers can really see the benefit in terms of reduced code
duplication.
 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Other than the above rant:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
