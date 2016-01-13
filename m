From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Wed, 13 Jan 2016 10:17:27 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601131017000.3575@nanos>
References: <1452093774-17831-1-git-send-email-daniel.lezcano@linaro.org> <1452093774-17831-3-git-send-email-daniel.lezcano@linaro.org> <alpine.DEB.2.11.1601081631380.3575@nanos> <5694F490.3040300@linaro.org> <alpine.DEB.2.11.1601121441330.3575@nanos>
 <56950ACC.4090001@linaro.org> <alpine.DEB.2.11.1601121523070.3575@nanos> <5695133A.8090301@linaro.org> <alpine.DEB.2.11.1601121609460.3575@nanos> <56952414.2000800@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47140 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbcAMJS2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 04:18:28 -0500
In-Reply-To: <56952414.2000800@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Tue, 12 Jan 2016, Daniel Lezcano wrote:
> On 01/12/2016 04:12 PM, Thomas Gleixner wrote:
> > This looks really wrong. Why on earth don't you implement a proper governor
> > and just get rid of this extra hackery?
> 
> That is part of the ongoing work where we are integrating the different PM
> subsystems with the scheduler in order have them collaborating together as
> asked by Ingo [1].
> 
> The idea is to get rid of the governors and let the scheduler to tell the
> Cpuidle framework : "I expect to sleep <x> nsec and I have a <y>
> nsec latency requirement" as stated by Peter Zijlstra [2].
> 
> The code above could be not nice but I think it begins to do what is expecting
> Peter. It is an embryonic code and in order to prevent too much different
> topics for a single series, I posted the two first patches which provide the
> next event API as the foundations for the next changes. How we integrate the
> 'next event' is a question I wanted to postpone in a different series of RFC
> patches.

Fair enough.
