From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Wed, 24 Feb 2010 15:19:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002241509210.1253-100000__19137.5818256804$1267042986$gmane$org@iolanthe.rowland.org>
References: <20100224191213.GH1025@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100224191213.GH1025@kernel.dk>
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

On Wed, 24 Feb 2010, Jens Axboe wrote:

> > How about plugging the request queue instead of freezing the writeback 
> > task?  Would that work?  It should be easy enough for a driver to 
> > unplug the queue before unregistering its device from within a resume 
> > method.
> 
> We have specific methods for either freezing of stopping or starting the
> queue, perhaps those would be appropriate for suspend/resume actions. It
> effectively prevents the queueing function from being called. If there
> are dirty pages for the device, then it would not help though, as you
> would still get stuck waiting for that IO to complete.

If the resume method would restart the queue before unregistering the
device, pending dirty pages wouldn't cause any problems.  They'd get
sent down to the driver and rejected immediately because the device was
dead or done.

The difficulty with this approach is that it requires individual
attention for each block device driver.  Either the driver has to
freeze/stop/plug the queue during suspend (and restart it during
resume) or else the device's writeback task has to be frozen.

Can this be encapsulated by a function in the block layer?  For
example, drivers could call blk_set_hot_unpluggable(bdev) for devices
that might need to be unregistered during resume.  Then they would
become responsible for managing the device's queue.

Alan Stern
