From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Tue, 23 Feb 2010 11:33:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002231115510.1308-100000__33523.3609345325$1266942888$gmane$org@iolanthe.rowland.org>
References: <20100223155803.GN1025@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100223155803.GN1025@kernel.dk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Feb 2010, Jens Axboe wrote:

> On Tue, Feb 23 2010, Alan Stern wrote:
> > > > This is a matter for Jens.  Is the bdi writeback task freezable?  If it
> > > > is, should it be made unfreezable?
> > > 
> > > I'm not a big expect on what tasks should be freezable or not. As it
> > > stands, the writeback tasks will attempt to freeze and thaw with the
> > > system. I guess that screws the sync from resume call, since it's not
> > > running and the sync will wait for it to retrieve and finish that work
> > > item.
> > > 
> > > To the suspend experts - can we safely mark the writeback tasks as
> > > non-freezable?
> > 
> > The reason for freezing those tasks is to avoid writebacks at random
> > times during a system sleep transition, when the underlying device may
> > already be suspended, right?
> 
> Right, or at least it would seem pointless to have them running while
> the device is suspended. But my point was that if it's easier (and
> feasible) to just leave them running, perhaps that was easier.

I don't have a clear picture of how the block layer operates.  For 
example, what is the reason for this comment in the definition of 
struct genhd?

	struct device *driverfs_dev;  // FIXME: remove

Isn't that crucial for making a disk show up in sysfs?  Is the comment 
out of date?

A possible approach is to add suspend and resume methods for this 
driverfs_dev, and make them be responsible for stopping and restarting 
the writeback task instead of relying on the freezer.  Then 
del_gendisk() could cleanly restart the task when necessary.

> > In principle, a device's writeback task could be unfrozen immediately
> > after the device is resumed.  In practice this might not solve the
> > problem, since the del_gendisk() call occurs _within_ the device's
> > resume routine.  I suppose del_gendisk() could be made responsible for 
> > unfreezing the writeback task.
> 
> And that's back to the question of whether or not that is a nice thing to
> do. It seems a bit dirty, but otoh where else to do it. Perhaps just
> using the kblockd to postpone the del_gendisk() to out-of-resume context
> would be the best approach.

That would involve a layering violation, wouldn't it?  Either the 
driver would have to interface with kblockd directly, or else 
del_gendisk() would need to know whether the writeback task was frozen.

On the whole, I think it's best for the block layer to retain full
control over its own tasks and requirements.

Alan Stern
