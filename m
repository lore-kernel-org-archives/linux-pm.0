From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Update] Re: [PATCH v3]PM/Sleep: Timer quiesce in freeze state
Date: Mon, 09 Feb 2015 15:50:34 +0100
Message-ID: <2271803.APdKPzvW0D@vostro.rjw.lan>
References: <54866625.8010406@linux.intel.com> <1684745.qMDN6HIHc8@vostro.rjw.lan> <20150209094926.GQ5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60359 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932375AbbBIO1d (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Feb 2015 09:27:33 -0500
In-Reply-To: <20150209094926.GQ5029@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Li, Aubrey" <aubrey.li@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Alan Cox <alan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Monday, February 09, 2015 10:49:26 AM Peter Zijlstra wrote:
> On Fri, Feb 06, 2015 at 11:36:12PM +0100, Rafael J. Wysocki wrote:
> > On Friday, February 06, 2015 07:29:22 PM Peter Zijlstra wrote:
> 
> > > > So I'm a wee bit confused; if we use an enter_freeze() state that keeps
> > > > interrupts disabled; who is going to call the freeze_wake() thing?
> > > 
> > > Ah, I think I see, so we wake up, keep the interrupt pending, re-enable
> > > the tick and time and everybody, then re-enable interrupts, take the
> > > interrupt and go around the idle loop to find we need a reschedule etc..
> > 
> > Exactly.
> 
> So x86 mwait can do this;

Which is a big enough target already as far as I'm concerned. :-)

> what other archs can 'sleep' and keep interrupts disabled?

The IO port based entry method on old(ish) x86 (like my Toshiba test-bed laptop)
keeps interrupts disabled too and that should cover ia64 (if they have ever
cared about anything more than C1 anyway).

There seem to be some entry methods that keep interrupts disabled on Power too.

> It looks like the ARM WFI thing wakes on pending interrupts and doesn't
> actually require interrupts to be enabled, so that too would work.

Yes, it would.  Moreover, for ARM that can do WFI only and nothing more than
that it would be much better than full suspend, because the whole CPU offline
dance we do then is a pure time loss for them.

The newfangled PSCI stuff should work too AFAICS.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
