From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sat, 5 May 2007 20:49:57 +0200
Message-ID: <200705052049.58353.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705051132310.1976-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705051132310.1976-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: Johannes Berg <johannes@sipsolutions.net>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Saturday, 5 May 2007 17:37, Alan Stern wrote:
> On Sat, 5 May 2007, Rafael J. Wysocki wrote:
> 
> > > Yeah, whatever. You can fix the problem but it's ugly. Let's come up
> > > with a good way to do the 6 callbacks mentioned in some other thread
> > > earlier.
> > 
> > This is the plan, but we need to do some preparations.
> > 
> > For example, I think, we should introduce some consistent terminology, so that
> > we *always* know what we're talking about.
> 
> A proposal:
> 
> For suspend-to-RAM we already have suspend() and resume().  At the 
> possible cost of introducing some confusion, I think it makes sense to 
> keep those method names.

I agree.

> For hibernation we need these:
> 
> 	pre_snapshot()
> 	post_snapshot()
> 	pre_restore()
> 	post_restore()
> 
> In addition we may want to have early/late variations on these (for use 
> after interrupts have been disabled), which would lead to:
> 
> 	pre_snapshot()
> 	pre_snapshot_late()
> 	post_snapshot_early()
> 	post_snapshot()
> 	pre_restore()
> 	pre_restore_late()
> 	post_restore_early()
> 	post_restore()
> 
> Yes, it's a large list...  But it seems to be necessary for providing all 
> the information drivers will need.

I think we may need yet another callback, executed before pre_snapshot()
and before we shrink memory during the hibernation, to be used by drivers
that need a lot of additional memory in pre_snapshot().

Greetings,
Rafael
