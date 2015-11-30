From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/6] cpufreq: governor: replace per-cpu delayed work with
 timers
Date: Mon, 30 Nov 2015 19:05:26 +0530
Message-ID: <20151130133526.GD4899@ubuntu>
References: <cover.1446121217.git.viresh.kumar@linaro.org>
 <e83291bcb6fcb69280f265194801510cf2e02c41.1446121217.git.viresh.kumar@linaro.org>
 <1448885103.8275.31.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33827 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbbK3Nfa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 08:35:30 -0500
Received: by padhx2 with SMTP id hx2so185376347pad.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2015 05:35:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448885103.8275.31.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>

On 30-11-15, 13:05, Lucas Stach wrote:
> I don't want to block this patch on that, but maybe as a thought for
> further consideration: Wouldn't it make sense to use a single unbound
> deferrable work item for this? There was some work to make this possible
> already: "timer: make deferrable cpu unbound timers really not bound to
> a cpu"

Yes, it would be sensible but that work has gone nowhere since April.
Once that is merged, we can think about it.

-- 
viresh
