From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Update] Re: [PATCH v3]PM/Sleep: Timer quiesce in freeze state
Date: Mon, 9 Feb 2015 10:49:26 +0100
Message-ID: <20150209094926.GQ5029@twins.programming.kicks-ass.net>
References: <54866625.8010406@linux.intel.com>
 <20150206161454.GQ21418@twins.programming.kicks-ass.net>
 <20150206182922.GN24151@twins.programming.kicks-ass.net>
 <1684745.qMDN6HIHc8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:51648 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760412AbbBIJtc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Feb 2015 04:49:32 -0500
Content-Disposition: inline
In-Reply-To: <1684745.qMDN6HIHc8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Li, Aubrey" <aubrey.li@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, Alan Cox <alan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Feb 06, 2015 at 11:36:12PM +0100, Rafael J. Wysocki wrote:
> On Friday, February 06, 2015 07:29:22 PM Peter Zijlstra wrote:

> > > So I'm a wee bit confused; if we use an enter_freeze() state that keeps
> > > interrupts disabled; who is going to call the freeze_wake() thing?
> > 
> > Ah, I think I see, so we wake up, keep the interrupt pending, re-enable
> > the tick and time and everybody, then re-enable interrupts, take the
> > interrupt and go around the idle loop to find we need a reschedule etc..
> 
> Exactly.

So x86 mwait can do this; what other archs can 'sleep' and keep
interrupts disabled?

It looks like the ARM WFI thing wakes on pending interrupts and doesn't
actually require interrupts to be enabled, so that too would work.
