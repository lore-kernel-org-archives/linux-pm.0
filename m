From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Fri, 4 Jun 2010 10:59:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006041052570.1794-100000__10391.909213695$1275663711$gmane$org@iolanthe.rowland.org>
References: <1275650416.3403.5.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275650416.3403.5.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 Jun 2010, Maxim Levitsky wrote:

> On Thu, 2010-03-04 at 14:53 +0100, Pavel Machek wrote: 
> > Hi!
> > 
> > > > journalling assumptions broken: commit block is there, but previous
> > > > blocks are not intact. Data loss.
> > > > 
> > > > ...and that was the first I could think about. Lets not do
> > > >  this. Barriers were invented for a reason.
> > > 
> > > Very well.  Then we still need a solution to the original problem:  
> > > Devices sometimes need to be unregistered during resume, but
> > > del_gendisk() blocks on the writeback thread, which is frozen until
> > > after the resume finishes.  How do you suggest this be fixed?
> > 
> > Avoid unregistering device during resume. Instead, return errors until
> > resume is done and you can call del_gendisk? 
> 
> This won't help ether. The same driver needs to unregister perfectly
> working device on suspend, because the user might replace the card
> during suspend and fool the os.
> There is a setting, CONFIG_MMC_UNSAFE_RESUME and I use it, but it isn't
> default.

People have generally agreed that the best answer is to have 
del_gendisk always thaw the writeback thread.

> Anyway to revive that old thread, how about introducing new
> del_gendisk_no_sync?
> 
> A less safe version of del_gendisk, but which won't sync the filesystem.
> Since driver knows that card is gone, there is no point of syncing it.
> 
> (the sync is done by invalidate_partition, so some flag should be
> propagated to it).

That might work for mmc, but it wouldn't help other drivers subject to
the same problem.

Besides, it's subject to races.  What if the card _isn't_ gone, but for 
some other reason the driver wants to unregister the device at a time 
when the writeback thread is frozen?

Alan Stern
