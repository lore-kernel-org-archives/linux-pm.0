From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/4] sched / idle: Reduce the number of branches in the
 idle loop
Date: Mon, 4 May 2015 16:25:05 +0200
Message-ID: <20150504142505.GM23123@twins.programming.kicks-ass.net>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:51162 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbEDOZS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 10:25:18 -0400
Content-Disposition: inline
In-Reply-To: <3084951.QaIkFrZ3VU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Mon, May 04, 2015 at 03:54:43PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> The "reflect" variable that had to be added to cpuidle_idle_call() to fix a
> regression during the 4.0 cycle has bothered me a bit since then and guess
> what?  It is not necessary.
> 
> After the last regression fix related to tick_broadcast_exit() I realized
> that it should be possible to eliminate this variable by splitting
> cpuidle_idle_call() into smaller routines and reordering the code in
> question which is done by this patch series.
> 
> It also gets rid of one more redundant check while at it.


Ooh nice! Yes that thing bothered me too.

Once you fix that one weird opening bracket:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
