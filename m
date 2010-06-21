From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Mon, 21 Jun 2010 23:58:05 +0200
Message-ID: <201006212358.05755.rjw__2942.30851945958$1277157634$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006202154260.29532-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006202154260.29532-100000@netrider.rowland.org>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, June 21, 2010, Alan Stern wrote:
> On Sun, 20 Jun 2010, Rafael J. Wysocki wrote:
> 
> > > > Generally, there are two problems in that area.  First, if a wakeup event
> > > > occurs exactly at the same time when /sys/power/state is being written to,
> > > > the even may be delivered to user space right before the freezing of it,
> > > > in which case the user space consumer of the event may not be able to process
> > > > it before the system is suspended.
> > > 
> > > Indeed, the same problem arises if the event isn't delivered to
> > > userspace until after userspace is frozen.
> > 
> > In that case the kernel should abort the suspend so that the event can be
> > delivered to the user space.
> 
> Yes.
> 
> > > Of course, the underlying issue here is that the kernel has no direct way
> > > to know when userspace has finished processing an event.  Userspace would
> > > have to tell it, which generally would mean rewriting some large number of user
> > > programs.
> > 
> > I'm not sure of that.  If the kernel doesn't initiate suspend, it doesn't
> > really need to know whether or not user space has already consumed the event.
> 
> That's true.  But it only shifts the onus: When a userspace program has 
> finished processing an event, it has to tell the power-manager process.  
> Clearly this sort of thing is unavoidable, one way or another.

That's correct, but there already are multiple ways to communicate things
between user space processes, while we would need new interfaces to
pass that information between user space and the kernel.  That makes quite
some difference.

> > > > The following patch illustrates my idea of how these two problems may be
> > > > addressed.  It introduces a new global sysfs attribute,
> > > > /sys/power/wakeup_count, associated with a running counter of wakeup events
> > > > and a helper function, pm_wakeup_event(), that may be used by kernel subsystems
> > > > to increment the wakeup events counter.
> > > 
> > > In what way is this better than suspend blockers?
> > 
> > It doesn't add any new framework and it doesn't require the users of
> > pm_wakeup_event() to "unblock" suspend, so it is simpler.  It also doesn't add
> > the user space interface that caused so much opposition to appear.
> 
> Okay.  A quick comparison shows that in your proposal:
> 
> 	There's no need to register and unregister suspend blockers.
> 	But instead you create the equivalent of a suspend blocker
> 	inside every struct device.

Not really.  That thing is for statistics purposes only and it's not essential
from the functionality POV.  But you know that. :-)

> 	Drivers (or subsystems) don't have to activate suspend 
> 	blockers.  But instead they have to call pm_wakeup_event().
>
> 	Drivers don't have to deactivate suspend blockers.  You don't
> 	have anything equivalent, and as a result your scheme is 
> 	subject to the race described below.

The original one without user space variant of suspend blockers is subject to
it as well, because the kernel doesn't know when the user space consumer is
going to finish processing the event.

Rafael
