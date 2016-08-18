From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] cpufreq: schedutil: set cpu freq to min in idle state
Date: Thu, 18 Aug 2016 13:13:15 +0200
Message-ID: <20160818111315.GA10153@twins.programming.kicks-ass.net>
References: <1471510531-7330-1-git-send-email-pingbo.wen@linaro.org>
 <5157068.Mf44In0Tcp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33146 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047AbcHRLNV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2016 07:13:21 -0400
Content-Disposition: inline
In-Reply-To: <5157068.Mf44In0Tcp@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: WEN Pingbo <pingbo.wen@linaro.org>, linux-pm@vger.kernel.org, steve.muckle@linaro.org

On Thu, Aug 18, 2016 at 01:10:00PM +0200, Rafael J. Wysocki wrote:

> > This patch added a idle_timer, which will re-feed in every util
> > callback. When cpu enter idle state, the idle_timer expires, and will
> > pull down the frequency.
> 
> No timers in this code, please.

Agreed.. teach your cpuidle code to pull down the frequency, maybe based
on the idle time guestimate.
