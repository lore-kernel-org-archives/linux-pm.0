From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: add synchronous runtime interface for
 interrupt handlers
Date: Sat, 2 Oct 2010 10:12:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010021004150.15874-100000__10518.838876351$1286028875$gmane$org@netrider.rowland.org>
References: <201010012323.47697.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010012323.47697.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 1 Oct 2010, Rafael J. Wysocki wrote:

> > > In my opinion the _irq operations should really be one-shot, without
> > > any looping, waking up parents etc.  I mean, if the parent is not RPM_ACTIVE,
> > > the _irq resume should immediately fail and analogously for the _irq
> > > suspend.  And so on.  As simple as reasonably possible.
> > 
> > But what if the device's own status is currently SUSPENDING or
> > RESUMING?  Do you want to fail when that happens, instead of waiting
> > for the concurrent operation to finish?
> 
> Yes.  IMO an _irq() suspend should only be allowed if the status is RPM_ACTIVE
> and an _irq() resume should fail if the status is not RPM_SUSPENDED.  The
> error code returned should depend on the situation, though.
> 
> > There's no way to prevent this
> > on SMP systems, because a wakeup request can arrive while a
> > software-initiated resume is in progress.
> 
> I know that. :-)

I suspect Kevin will not want to live with this restriction, but I'd
like to hear from him.  Kevin?

> > What you are describing is basically what autosuspend was intended to
> > accomplish (that is, formalizing the difference between "the device
> > just became idle, you should consider when to suspend it" and "the
> > device has been idle for a sufficiently long time, please suspend it
> > now").  Would the r8169 driver be simplified if it used autosuspend?
> 
> At the moment it suspends when the network cable is removed from the device
> and the hack I mentioned is used during the resume after the cable has been
> reinserted (it checks if the cable is still there and schedules suspend if not).

That does seem like a strange hack.  Instead of scheduling a suspend,
why not simply do a suspend as soon as you learn that the cable has
been removed again?  Is there a problem about the connection status
bouncing?

> If we removed the immediate idle notification after a successful resume, it
> might need to be reworked slightly.

My suggestion was that we remove the idle notification after a failed 
suspend, not the notification after a successful resume.

Alan Stern
