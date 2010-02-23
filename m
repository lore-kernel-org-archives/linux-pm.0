From: Alan Stern <stern@rowland.harvard.edu>
Subject: Testing for dirty buffers on a block device
Date: Tue, 23 Feb 2010 11:42:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002231137520.1308-100000__6542.4014385373$1266943420$gmane$org@iolanthe.rowland.org>
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
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 23 Feb 2010, Jens Axboe wrote:

> > P.S.: Jens, given a pointer to a struct gendisk or to a struct
> > request_queue, is there a good way to tell whether there any dirty
> > buffers for that device waiting to be written out?  This is for
> > purposes of runtime power management -- in the initial implementation,
> > I want to avoid powering-down a block device if it is open or has any
> > dirty buffers.  In other words, only completely idle devices should be
> > powered down (a good example would be a card reader with no memory card 
> > inserted).
> 
> There's no fool proof way. For most file systems I think you could get
> away with checking the q->bdi dirty lists to see if there's anything
> pending. But that wont work always, if the fs uses a different backing
> dev info than then queue itself.

That's not what I meant.  Dirty buffers on a filesystem make no 
difference because they always get written out when the filesystem is 
unmounted.  The device file remains open as long as the filesystem 
is mounted, which would prevent the device from being powered down.

I was asking about dirty buffers on a block device that isn't holding a 
filesystem -- where the raw device is being used directly for I/O.

Alan Stern
