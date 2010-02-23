From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Testing for dirty buffers on a block device
Date: Tue, 23 Feb 2010 23:13:30 +0100
Message-ID: <20100223221329.GO1025__7362.03138153559$1266963288$gmane$org@kernel.dk>
References: <20100223155803.GN1025@kernel.dk>
	<Pine.LNX.4.44L0.1002231137520.1308-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1002231137520.1308-100000@iolanthe.rowland.org>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 23 2010, Alan Stern wrote:
> On Tue, 23 Feb 2010, Jens Axboe wrote:
> 
> > > P.S.: Jens, given a pointer to a struct gendisk or to a struct
> > > request_queue, is there a good way to tell whether there any dirty
> > > buffers for that device waiting to be written out?  This is for
> > > purposes of runtime power management -- in the initial implementation,
> > > I want to avoid powering-down a block device if it is open or has any
> > > dirty buffers.  In other words, only completely idle devices should be
> > > powered down (a good example would be a card reader with no memory card 
> > > inserted).
> > 
> > There's no fool proof way. For most file systems I think you could get
> > away with checking the q->bdi dirty lists to see if there's anything
> > pending. But that wont work always, if the fs uses a different backing
> > dev info than then queue itself.
> 
> That's not what I meant.  Dirty buffers on a filesystem make no 
> difference because they always get written out when the filesystem is 
> unmounted.  The device file remains open as long as the filesystem 
> is mounted, which would prevent the device from being powered down.
> 
> I was asking about dirty buffers on a block device that isn't holding a 
> filesystem -- where the raw device is being used directly for I/O.

OK, so just specifically the page cache of the device. Is that really
enough of an issue to warrant special checking? I mean, what normal
setup would even use buffer raw device access?

But if you wanted, I guess the only way would be to lookup
dirty/writeback pages on the bdev inode mapping. For that you'd need the
bdev, not the gendisk or the queue though.

-- 
Jens Axboe
