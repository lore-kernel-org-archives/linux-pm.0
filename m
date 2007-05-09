From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Wed, 9 May 2007 23:07:09 +0200
Message-ID: <20070509210709.GC8229@elf.ucw.cz>
References: <200705091235.05613.david-b@pacbell.net>
	<Pine.LNX.4.44L0.0705091556520.8586-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0705091556520.8586-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > 			In fact, it is the state the computer enters 
> > > 	when you first plug it in (or insert the battery).
> > 
> > No; again, you're missing the entire point of G3 "mechanical off".
> > 
> > When you first plug it in, it's going to be in G3.  Then you turn
> > on the power switch.  Then you press the "on/off" button.
> > 
> > From then on you can use only the "on/off" button, but the system
> > is vampiric ... when off/dead, it can choose to come alive, and is
> > always sucking power/blood at a low level.
> > 
> > But the "large red switch" option is available to put the system
> > into G3 ... driving a bloody stake through its heart, so it can't
> > re-activate itself at midnight, and preventing constant power drain.
> 
> Sorry.  What I meant to say was that S5 is the state the computer enters 
> when you first plug it in and turn on the power switch -- before you press 
> the on/off button.

Actually... some machines just power on when you first plug them in,
and some other have it configurable in BIOS.

For server, you want it to power up after power fail.

For home desktop, you definitely want it to stay powered off after
power fail.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
