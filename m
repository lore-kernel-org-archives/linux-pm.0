From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Resend][PATCH] PM / tick: Add tracepoints for suspend-to-idle diagnostics
Date: Fri, 15 May 2015 01:42:55 +0200
Message-ID: <1892508.rYMRoIEMoX@vostro.rjw.lan>
References: <17474563.tpu6u1dKOa@vostro.rjw.lan> <9746445.jijJSAGWOf@vostro.rjw.lan> <alpine.DEB.2.11.1505142342530.4225@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57957 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933101AbbENXRn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 19:17:43 -0400
In-Reply-To: <alpine.DEB.2.11.1505142342530.4225@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thursday, May 14, 2015 11:43:11 PM Thomas Gleixner wrote:
> On Fri, 15 May 2015, Rafael J. Wysocki wrote:
> 
> > On Sunday, May 10, 2015 01:23:35 AM Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Add suspend/resume tracepoints to tick_freeze() and tick_unfreeze()
> > > to catch when timekeeping is suspended and resumed during suspend-to-idle
> > > so as to be able to check whether or not we enter the "frozen" state
> > > and to measure the time spent in it.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Thomas, Peter, any objections here?
> 
> No.
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!

