From: Mike Galbraith <bitbucket@online.de>
Subject: Re: 50 Watt idle power regression bisected to Linux-3.10
Date: Wed, 11 Dec 2013 14:10:35 +0100
Message-ID: <1386767435.12005.66.camel@marge.simpson.net>
References: <CAJvTdKn_2mihtMLiQVNCOp_zokx8CsSr2c5NhbkbfJ-qvma-8Q@mail.gmail.com>
	 <1386559014.4875.16.camel@marge.simpson.net>
	 <1386652637.5374.72.camel@marge.simpson.net>
	 <alpine.DEB.2.02.1312101458040.28330@ionos.tec.linutronix.de>
	 <alpine.DEB.2.02.1312110030330.28330@ionos.tec.linutronix.de>
	 <1386732093.5964.6.camel@marge.simpson.net>
	 <alpine.DEB.2.02.1312111206200.28330@ionos.tec.linutronix.de>
	 <20131211113839.GF21683@pd.tnic>
	 <20131211115239.GA21999@twins.programming.kicks-ass.net>
	 <1386764955.12005.60.camel@marge.simpson.net>
	 <20131211124352.GB21999@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63339 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab3LKNLe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2013 08:11:34 -0500
In-Reply-To: <20131211124352.GB21999@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeremy Eder <jeder@redhat.com>, x86@kernel.org

On Wed, 2013-12-11 at 13:43 +0100, Peter Zijlstra wrote: 
> On Wed, Dec 11, 2013 at 01:29:15PM +0100, Mike Galbraith wrote:
> > On Wed, 2013-12-11 at 12:52 +0100, Peter Zijlstra wrote: 
> > > On Wed, Dec 11, 2013 at 12:38:39PM +0100, Borislav Petkov wrote:
> > > > Right, if it turns out that this is really the case and that this
> > > > erratum hasn't been fixed for models later than 29 - we'd need the
> > > > additional model numbers to set X86_FEATURE_CLFLUSH_MONITOR correctly.
> > > 
> > > You also need: https://lkml.org/lkml/2013/11/19/143
> > > 
> > > Because obviously not all mwait idle loops check that cpu bit.
> > 
> > I had tried that patch, to see if it would magically make the thing
> > start working, nope.  I had also tried...
> 
> > +		if (this_cpu_has(X86_FEATURE_CLFLUSH_MONITOR))
> > +			clflush((void *)&current_thread_info()->flags);
> 
> Yeah, you need a bit extra to enable that feature bit for your CPU as
> bpetkov said.

Works for me, one more for the stable bucket.

So as soon as Len resurrects mwait_idle for Q6600 (and other core2 when
booted max_cstates=1 so tsc clocksource is used instead of pos hpet),
all the (known) idle regressions should be history.

-Mike

