From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/6] PM / sleep: Re-implement suspend-to-idle handling
Date: Thu, 12 Feb 2015 17:18 +0100
Message-ID: <2207863.Kc1JySZNG4@vostro.rjw.lan>
References: <8292243.ibkmfVtXac@vostro.rjw.lan> <5802443.EAllF0NTnO@vostro.rjw.lan> <20150212131420.GW23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57950 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753412AbbBLPy4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 10:54:56 -0500
In-Reply-To: <20150212131420.GW23123@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>

On Thursday, February 12, 2015 02:14:20 PM Peter Zijlstra wrote:
> On Wed, Feb 11, 2015 at 05:01:09AM +0100, Rafael J. Wysocki wrote:
> > +/* Suspend-to-idle state machnine. */
> > +enum freeze_state {
> > +	FREEZE_STATE_NONE,      /* Not suspended/suspending. */
> > +	FREEZE_STATE_ENTER,     /* Enter suspend-to-idle. */
> > +	FREEZE_STATE_WAKE,      /* Wake up from suspend-to-idle. */
> > +};
> > +
> > +static enum freeze_state __read_mostly suspend_freeze_state;
> > +static DEFINE_SPINLOCK(suspend_freeze_lock);
> > +
> > +bool idle_should_freeze(void)
> > +{
> > +	return unlikely(suspend_freeze_state == FREEZE_STATE_ENTER);
> > +}
> 
> I don't see how a compiler can propagate the unlikely through an actual
> function call. AFAICT that needs to be an inline function for that to
> work.

Oh.

That was silly, I'll send an update later today.

> It would mean exposing suspend_freeze_state and the enum; is there a
> reason not to want to do that?

Not really.

