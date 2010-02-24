From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Testing for dirty buffers on a block device
Date: Wed, 24 Feb 2010 15:09:16 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1002241503300.1253-100000__5345.91090768135$1267042228$gmane$org@iolanthe.rowland.org>
References: <20100224190942.GG1025@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100224190942.GG1025@kernel.dk>
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

On Wed, 24 Feb 2010, Jens Axboe wrote:

> > > But if you wanted, I guess the only way would be to lookup
> > > dirty/writeback pages on the bdev inode mapping. For that you'd need the
> > > bdev, not the gendisk or the queue though.
> > 
> > I can get the bdev from the gendisk by calling bdget_disk() with a 
> > partition number of 0, right?  What would the next step be?  Would this 
> > check for dirty pages associated with any of the partitions or would it 
> > only look at pages associated with the inode for the entire disk?
> 
> It would cover the entire bdev.

Okay, so once I've got the bdev, how do I look up the dirty/writeback 
pages on the inode mapping?

Alan Stern
