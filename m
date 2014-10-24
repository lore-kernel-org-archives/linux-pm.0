From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/5] cpuidle: idle: menu: Don't reflect when a state
 selection failed
Date: Fri, 24 Oct 2014 15:38:10 +0200
Message-ID: <20141024133810.GK12706@worktop.programming.kicks-ass.net>
References: <1413822343-1972-1-git-send-email-daniel.lezcano@linaro.org>
 <1413822343-1972-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:53350 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504AbaJXNiN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Oct 2014 09:38:13 -0400
Content-Disposition: inline
In-Reply-To: <1413822343-1972-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org

On Mon, Oct 20, 2014 at 06:25:41PM +0200, Daniel Lezcano wrote:
> +++ b/kernel/sched/idle.c
> @@ -162,7 +162,8 @@ use_default:
>  	/*
>  	 * Give the governor an opportunity to reflect on the outcome
>  	 */
> -	cpuidle_reflect(dev, entered_state);
> +	if (entered_state >= 0)
> +		cpuidle_reflect(dev, entered_state);
>  

Given we'll do use_default: when next_state < 0, we actually never get
here unless this is true.
