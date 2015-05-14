From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Resend][PATCH] PM / tick: Add tracepoints for suspend-to-idle
 diagnostics
Date: Thu, 14 May 2015 23:43:11 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505142342530.4225@nanos>
References: <17474563.tpu6u1dKOa@vostro.rjw.lan> <1543314.9EN5CRZp0f@vostro.rjw.lan> <9746445.jijJSAGWOf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:39327 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422795AbbENVnA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 17:43:00 -0400
In-Reply-To: <9746445.jijJSAGWOf@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, 15 May 2015, Rafael J. Wysocki wrote:

> On Sunday, May 10, 2015 01:23:35 AM Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Add suspend/resume tracepoints to tick_freeze() and tick_unfreeze()
> > to catch when timekeeping is suspended and resumed during suspend-to-idle
> > so as to be able to check whether or not we enter the "frozen" state
> > and to measure the time spent in it.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Thomas, Peter, any objections here?

No.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
