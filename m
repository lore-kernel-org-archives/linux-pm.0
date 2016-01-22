From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Fri, 22 Jan 2016 11:15:11 +0100
Message-ID: <20160122101511.GP6357@twins.programming.kicks-ass.net>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org>
 <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org>
 <20160120190718.GS6357@twins.programming.kicks-ass.net>
 <alpine.DEB.2.11.1601202050050.3575@nanos>
 <56A0A9E3.2070306@linaro.org>
 <alpine.DEB.2.11.1601211128240.3873@nanos>
 <56A0E8F1.7010409@linaro.org>
 <alpine.DEB.2.11.1601211936260.3886@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56883 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbcAVKPQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2016 05:15:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1601211936260.3886@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Thu, Jan 21, 2016 at 07:56:36PM +0100, Thomas Gleixner wrote:

> We really should ignore that sillyness and if people complain, make them
> complain to their HW vendor. That's the only way this crap will go away.
> 
> If we just keep on supporting this completely pointless nonsense the HW folks
> will just not fix it.
> 
> We've been successful in the past to 'educate' hw people by making features
> not available for mindless designs.
> 
> In this case we still support the feature, but it might be suboptimal. The
> real interesting ports on that platform are MSI anyway, so I really couldn't
> care less.

I'm fine with not supporting shared interrupts, as long as the thing is
consistent.


