From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Mon, 7 May 2007 14:46:45 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705071426090.3429-100000@iolanthe.rowland.org>
References: <200705061810.40499.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705061810.40499.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Sun, 6 May 2007, David Brownell wrote:

> On Saturday 05 May 2007, Alan Stern wrote:
> 
> > But who says that hibernate has to use "Non-Volatile Sleep" and normal 
> > shutdown has to use software-controlled "poweroff"?  Why shouldn't the 
> > user be able to do it the other way 'round?
> 
> Well, the definition of NVS matches hibernation, and
> the definition of soft-off matches poweroff.

Okay, I read sections 2.2 and 2.4 of the ACPI 3.0 spec.  Here's the story
in a nutshell:

	G3 = "mechanical off" = no wakeup devices are enabled,
				safe to disassemble
	G2/S5 = "soft off" = wakeup may be enabled, not safe to
				disassemble
	S4 = "non-volatile sleep" = hibernation, memory image is saved
	S5 = "soft off" = almost the same as S4 except there is no
				memory image

The spec does not explicitly associate S4 with either G2 or G3, and in
fact it contains language suggesting very strongly that the system could
be in either one.  The spec also uses the same name for G2 and for S5, no 
doubt leading to extra levels of confusion.

So there's no question that S4 = NVS = hibernation.  But hibernation
can involve either G2 or G3.

And there's no question (in my mind at least) that normal shutdown should
be able to involve either G2/S5 or G3.  So although the spec doesn't put 
things quite this way, we could say:

	hibernation = S4 = G2/S4 or G3/S4,

	shutdown = S5 = G2/S5 or G3/S5.

Thus the choice between S4 vs. S5 is made at the very start, and steps 1-5 
are executed only for S4.  The choice between G2 vs. G3 can be (and should 
be!) deferred until steps 6-7.


> > > That's a different suggestion, yes.  I'm not sure I see any
> > > benefit of that flexibility for "soft off" states though,
> > > especially if it made "off" consume more power.
> > 
> > The benefit is that it allows more devices to function as wakeup sources, 
> > right?
> 
> With downsides of "more power consumed during 'off' states"
> and "invalidating documentation, training, and expectations".

Okay, let's clear up the confusion.  The additional flexibility I'm 
suggesting for "soft off" = G2 states is that we should allow both G2/S4 
and G2/S5.  They would consume the same amount of power since they are 
both G2 states; the difference is that G2/S4 involves saving and restoring 
a memory image and G2/S5 does not.

This does not invalidate any documentation or training so far as I know.  
And as for expectations...  That's a little harder.  What people _expect_ 
of Linux and what Linux actually _does_ don't always jibe well, owing to 
lack of sufficient documentation -- typical of Open Source projects.

Alan Stern
