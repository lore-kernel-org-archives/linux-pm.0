From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sat, 5 May 2007 11:49:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705051139580.1976-100000@netrider.rowland.org>
References: <200705041500.33849.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705041500.33849.david-b@pacbell.net>
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

On Fri, 4 May 2007, David Brownell wrote:

> > You are describing the difference between ACPI S4 and S5, but I was 
> > talking about the difference between "normal" poweroff and "hibernate" 
> > poweroff.  There doesn't seem to be any reason why we must always have
> > 
> > 	hibernate = S4    and     normal = S5.
> 
> What the ACPI spec describes for the "Non-Volatile Sleep" is
> that either S4 or S5 could match "hibernate" ... but for
> a software-controlled "poweroff", only S5 is appropriate.
> 
> That's a reason.  Another:  pretty much all end-user docs
> on this stuff match what ACPI says.
> 
> Lacking compelling reasons to violate specs (like them
> being clearly broken), I avoid breaking them.

Again you misunderstand.  I concede that either S4 or S5 is appropriate
for "Non-Volatile Sleep" whereas only S5 is appropriate for
software-controlled "poweroff".

But who says that hibernate has to use "Non-Volatile Sleep" and normal 
shutdown has to use software-controlled "poweroff"?  Why shouldn't the 
user be able to do it the other way 'round?


> > > Non-ACPI systems can make the same natural distinctions.
> > 
> > On such systems there seems to be even less reason for those equalities 
> > (or rather, their analogs).
> 
> This is one of those "less is more" things, right?  :)
> 
> People doing embedded designs _like_ their flexibility.
> 
> It's common to have multiple power levels.  If you mean
> that they _could_ give up that flexibility and only use
> one of those state analogues, yes they could ... but if
> you mean they'd see that as a Good Thing, I doubt it.

No, no!  That's not what I mean.  I'm proposing that we offer the user
_more_ flexibility by giving a choice of power levels.  The user should be
able to choose whether the system uses "Non-Volatile Sleep" vs.
software-controlled "poweroff"; the choice shouldn't be dictated by
whether or not the system is entering hibernation.

> I guess I don't see why you want to throw away all the
> work the hardware (and/or software) designers did to
> ensure that some key devices use a "retention" mode
> in their S4-analogue state.
> 
> Me, I always thought that leveraging those retention
> states was a great way to shrink wakeup times and get
> more functionality.

I can't imagine why you think I proposed anything along those lines.


> > > You're suggesting Linux not use the S5 state, essentially.
> > 
> > No, I'm suggesting that the user should be able to control whether Linux 
> > uses S4 vs. S5 at poweroff time.  If the user selected always to use S4 
> > then wakeup devices would function in both hibernation and normal 
> > shutdown.  If the user selected always to use S5 then wakeup devices would 
> > not function in either hibernation or normal shutdown.
> 
> That's a different suggestion, yes.  I'm not sure I see any
> benefit of that flexibility for "soft off" states though,
> especially if it made "off" consume more power.

The benefit is that it allows more devices to function as wakeup sources, 
right?

Alan Stern
