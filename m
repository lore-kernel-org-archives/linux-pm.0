From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Testing for dirty buffers on a block device
Date: Wed, 24 Feb 2010 20:09:42 +0100
Message-ID: <20100224190942.GG1025__43583.8064099245$1267038826$gmane$org@kernel.dk>
References: <20100223221329.GO1025@kernel.dk>
	<Pine.LNX.4.44L0.1002241039190.2436-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1002241039190.2436-100000@iolanthe.rowland.org>
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

On Wed, Feb 24 2010, Alan Stern wrote:
> On Tue, 23 Feb 2010, Jens Axboe wrote:
> 
> > > That's not what I meant.  Dirty buffers on a filesystem make no 
> > > difference because they always get written out when the filesystem is 
> > > unmounted.  The device file remains open as long as the filesystem 
> > > is mounted, which would prevent the device from being powered down.
> > > 
> > > I was asking about dirty buffers on a block device that isn't holding a 
> > > filesystem -- where the raw device is being used directly for I/O.
> > 
> > OK, so just specifically the page cache of the device. Is that really
> > enough of an issue to warrant special checking? I mean, what normal
> > setup would even use buffer raw device access?
> 
> Doesn't fdisk use it?  There might be other applications too.

It does, but that sound be a very short lived issue (since the dirty
buffers will get flushed).

> > But if you wanted, I guess the only way would be to lookup
> > dirty/writeback pages on the bdev inode mapping. For that you'd need the
> > bdev, not the gendisk or the queue though.
> 
> I can get the bdev from the gendisk by calling bdget_disk() with a 
> partition number of 0, right?  What would the next step be?  Would this 
> check for dirty pages associated with any of the partitions or would it 
> only look at pages associated with the inode for the entire disk?

It would cover the entire bdev.

-- 
Jens Axboe
