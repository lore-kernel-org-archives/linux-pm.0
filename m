From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hibernation considerations
Date: Sun, 22 Jul 2007 11:26:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707221116060.15224-100000__32432.0694119253$1185118040$gmane$org@netrider.rowland.org>
References: <200707220816.03838.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707220816.03838.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@suspend2.net
Cc: david@lang.hm, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sun, 22 Jul 2007, Nigel Cunningham wrote:

> Hi.
> 
> On Sunday 22 July 2007 02:13:56 Jeremy Maitin-Shepard wrote:
> > It seems that you could still potentially get a failure to freeze if one
> > FUSE process depends on another, and the one that is frozen second just
> > happens to be waiting on the one that is frozen first when it is frozen.
> > I admit that this situation is unlikely, and perhaps acceptable.
> > 
> > A larger concern is that it seems that freezing FUSE processes at all
> > _will_ generate deadlocks if a non-synchronous or memory-map-supporting
> > filesystem is loopback mounted from a FUSE filesystem.  In that case, if
> > you attempt to sync or free memory once FUSE is frozen, you are sure to
> > get a deadlock.
> 
> Ok. So then (in response to Alan too), how about keeping a tree of mounts, 
> akin to the device tree, and working from the deepest nodes up? (In 
> conjunction with what I already suggested)?

Face it, Nigel, this is a losing battle.  You can try to come up with
ever-more complex schemes to try and force FUSE into the freezer's
framework, but it just won't fit.  Or if it does, the next filesystem
to come along will require an even more baroque type of special-case 
handling.

The general problem is that task A may be in an unfreezable state,
waiting for task B to do something, while task B is already frozen.  
Since there's no reasonable way to determine that A really is waiting
for B, you're just stuck.  (To make matters worse, A may not even
realize which task it is waiting for; it may know only that it's
waiting for somebody to do something!)  A and B could be user tasks, 
kernel threads, or one of each.

The only thing to do is what Rafael has been working on: unfreeze
things, hope the tasks sort themselves out, and try again.

Alan Stern
