From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/5] intel_idle: Add S0ix validation
Date: Thu, 2 Jun 2016 14:23:18 +0100
Message-ID: <20160602142318.2c9d2111@lxorguk.ukuu.org.uk>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
	<1464842009-21789-6-git-send-email-dbasehore@chromium.org>
	<20160602092505.GQ3206@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33054 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbcFBNYI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 09:24:08 -0400
In-Reply-To: <20160602092505.GQ3206@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: dbasehore@chromium.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de

On Thu, 2 Jun 2016 11:25:05 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jun 01, 2016 at 09:33:29PM -0700, dbasehore@chromium.org wrote:
> > +/*
> > + * Default chosen to have <= 1% power increase while allowing fast detection of
> > + * SLP S0 entry errors. Waking up 10 times a second shows ~30% increase in
> > + * system power on Skylake Y. Waking up once every 10 seconds is
> > + * indistinguishable from not waking up at all (as ~0.3% power increase would
> > + * be). Any reasonable power increases above this will not be visible to the
> > + * user.
> > + */
> > +#define DEFAULT_SLP_S0_SECONDS 10  
> 
> So I don't think anybody waits for 10 seconds to see if suspend worked.
> After 10 seconds its in the bag and I'm out the door.
> 
> Then what?
> 
> 
> Why can't you fire a single timer after 0.5 seconds to see if you hit
> C10 and leave it at that? What's the point any further wakeup, if you
> know you hit C10, you're good continue on.

There are plenty of Skylake configurations where at the moment you won't
get s0ix entry because the ISH driver is not yet merged. Spamming those
users with useless messages is not helpful. Likewise on systems with
modular kernels your warning may spuriously trigger during boot until the
ISH, i915 and audio modules and firmware have loaded and are active. I
know Chrome doesn't like modules but the rest of us do !

I'm also a bit at a loss to understand why anyone needs this except
validation engineers for Chrome products and kernel hackers doing
debug. It seems a bit odd to burden the entire world with a pile of
checks they can't use that cost even 0.3% of power (that's 15 minutes on
an 8 hour battery multiplied by every Skylake user!).

Having to have debugfs present to turn it off, but not to use it is also
a bit weird...

IMHO this should be one of the hacking/kernel debug options and not even
compiled into normal kernels.

Alan
