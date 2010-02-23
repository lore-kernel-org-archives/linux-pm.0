From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Is it supposed to be ok to call del_gendisk
	while	userspace is frozen?
Date: Tue, 23 Feb 2010 16:58:03 +0100
Message-ID: <20100223155803.GN1025__14717.5004393377$1266940778$gmane$org@kernel.dk>
References: <20100223123321.GA1025@kernel.dk>
	<Pine.LNX.4.44L0.1002231016500.1507-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1002231016500.1507-100000@iolanthe.rowland.org>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 23 2010, Alan Stern wrote:
> > > This is a matter for Jens.  Is the bdi writeback task freezable?  If it
> > > is, should it be made unfreezable?
> > 
> > I'm not a big expect on what tasks should be freezable or not. As it
> > stands, the writeback tasks will attempt to freeze and thaw with the
> > system. I guess that screws the sync from resume call, since it's not
> > running and the sync will wait for it to retrieve and finish that work
> > item.
> > 
> > To the suspend experts - can we safely mark the writeback tasks as
> > non-freezable?
> 
> The reason for freezing those tasks is to avoid writebacks at random
> times during a system sleep transition, when the underlying device may
> already be suspended, right?

Right, or at least it would seem pointless to have them running while
the device is suspended. But my point was that if it's easier (and
feasible) to just leave them running, perhaps that was easier.

> In principle, a device's writeback task could be unfrozen immediately
> after the device is resumed.  In practice this might not solve the
> problem, since the del_gendisk() call occurs _within_ the device's
> resume routine.  I suppose del_gendisk() could be made responsible for 
> unfreezing the writeback task.

And that's back to the question of whether or not that is a nice thing to
do. It seems a bit dirty, but otoh where else to do it. Perhaps just
using the kblockd to postpone the del_gendisk() to out-of-resume context
would be the best approach.

> The best solution would be to have del_gendisk() avoid waiting for the 
> writeback task in cases where the underlying device has been removed.  
> I don't know if that is feasible, however.

kblockd?

> P.S.: Jens, given a pointer to a struct gendisk or to a struct
> request_queue, is there a good way to tell whether there any dirty
> buffers for that device waiting to be written out?  This is for
> purposes of runtime power management -- in the initial implementation,
> I want to avoid powering-down a block device if it is open or has any
> dirty buffers.  In other words, only completely idle devices should be
> powered down (a good example would be a card reader with no memory card 
> inserted).

There's no fool proof way. For most file systems I think you could get
away with checking the q->bdi dirty lists to see if there's anything
pending. But that wont work always, if the fs uses a different backing
dev info than then queue itself.

-- 
Jens Axboe
