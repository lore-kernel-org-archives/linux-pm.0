From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Fri, 04 Jun 2010 14:20:16 +0300
Message-ID: <1275650416.3403.5.camel__31646.3012983606$1275650567$gmane$org@maxim-laptop>
References: <20100303215056.GB2579@ucw.cz>
	<Pine.LNX.4.44L0.1003031720530.1380-100000@iolanthe.rowland.org>
	<20100304135337.GC12191@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100304135337.GC12191@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-03-04 at 14:53 +0100, Pavel Machek wrote: 
> Hi!
> 
> > > journalling assumptions broken: commit block is there, but previous
> > > blocks are not intact. Data loss.
> > > 
> > > ...and that was the first I could think about. Lets not do
> > >  this. Barriers were invented for a reason.
> > 
> > Very well.  Then we still need a solution to the original problem:  
> > Devices sometimes need to be unregistered during resume, but
> > del_gendisk() blocks on the writeback thread, which is frozen until
> > after the resume finishes.  How do you suggest this be fixed?
> 
> Avoid unregistering device during resume. Instead, return errors until
> resume is done and you can call del_gendisk? 

This won't help ether. The same driver needs to unregister perfectly
working device on suspend, because the user might replace the card
during suspend and fool the os.
There is a setting, CONFIG_MMC_UNSAFE_RESUME and I use it, but it isn't
default.

Anyway to revive that old thread, how about introducing new
del_gendisk_no_sync?

A less safe version of del_gendisk, but which won't sync the filesystem.
Since driver knows that card is gone, there is no point of syncing it.

(the sync is done by invalidate_partition, so some flag should be
propagated to it).



Best regards,
Maxim Levitsky
