From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PM/hibernate swapfile regression
Date: Tue, 21 Jul 2009 15:41:37 +0200
Message-ID: <200907211541.38694.rjw__17755.078248638$1248183767$gmane$org@sisk.pl>
References: <20090714135453.GA26976@osiris.boeblingen.de.ibm.com>
	<20090720132456.GA29023@osiris.boeblingen.de.ibm.com>
	<4A659D75.3050004@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A659D75.3050004@tuffmail.co.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Jens Axboe <jens.axboe@oracle.com>
Cc: Arnd Schneider <arnd@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Hans-Joachim Picht <hans@linux.vnet.ibm.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 21 July 2009, Alan Jenkins wrote:
> Heiko Carstens wrote:
> > On Fri, Jul 17, 2009 at 02:08:46PM +0100, Alan Jenkins wrote:
> >   
> >> Rafael J. Wysocki wrote:
> >>     
> >>> On Tuesday 14 July 2009, Heiko Carstens wrote:
> >>>   
> >>>       
> >>>> We've seen this bug [...]
> >>>>
> >>>> Looks like this was introduced with git commit a1bb7d61 "PM/hibernate: fix "swap
> >>>> breaks after hibernation failures"".
> >>>> Calling bdget while holding a spinlock doesn't seem to be a good idea...
> >>>>     
> >>>>         
> >>> Agreed, sorry for missing that.
> >>>
> >>> Alan, can you please prepare a fix?
> >>>       
> >> Here's a quick & dirty patch [...]
> >>     
> >
> > Thanks for the patch. Unfortunately Arnd was unable to reproduce the original
> > behaviour. But your patch makes sense anyway.
> > I also tested it and nothing broke. So should this go upstream?  
> 
> I do want to fix it, but I think there's a better way.
> 
> It doesn't really need the sleeping bdget().  All we want is
> atomic_inc(&bdev->bd_inode->i_count).  I think we should call it bdcopy().

Makes sense to me, but IMO that requres an ACK from Jens.

Jens, is the patch below fine with you?

Rafael


> ---------->
> From 643014ec079610a8b01dfd78c6949c1e8727195b Mon Sep 17 00:00:00 2001
> From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Date: Tue, 21 Jul 2009 10:17:30 +0100
> Subject: [PATCH] PM/hibernate: replace bdget call with bdcopy (simple atomic_inc of i_count)
> 
> Create bdcopy().  This function copies an existing reference to a
> block_device.  It is safe to call from any context.
> 
> Hibernation code wishes to copy a reference to the active swap device.
> Right now it calls bdget() under a spinlock, but this is wrong because
> bdget() can sleep.  It doesn't need a full bdget() because we already
> hold a reference to active swap devices (and the spinlock protects
> against swapoff).
> 
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> CC: linux-fsdevel@vger.kernel.org
> ---
>  fs/block_dev.c     |    8 ++++++++
>  include/linux/fs.h |    1 +
>  mm/swapfile.c      |    4 ++--
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 3a6d4fb..0b04974 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -564,6 +564,14 @@ struct block_device *bdget(dev_t dev)
>  
>  EXPORT_SYMBOL(bdget);
>  
> +struct block_device *bdcopy(struct block_device *bdev)
> +{
> +	atomic_inc(&bdev->bd_inode->i_count);
> +	return bdev;
> +}
> +
> +EXPORT_SYMBOL(bdcopy);
> +
>  long nr_blockdev_pages(void)
>  {
>  	struct block_device *bdev;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0872372..eeb1091 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1946,6 +1946,7 @@ extern void putname(const char *name);
>  extern int register_blkdev(unsigned int, const char *);
>  extern void unregister_blkdev(unsigned int, const char *);
>  extern struct block_device *bdget(dev_t);
> +extern struct block_device *bdcopy(struct block_device *bdev);
>  extern void bd_set_size(struct block_device *, loff_t size);
>  extern void bd_forget(struct inode *inode);
>  extern void bdput(struct block_device *);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index d1ade1a..272ea8e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -753,7 +753,7 @@ int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
>  
>  		if (!bdev) {
>  			if (bdev_p)
> -				*bdev_p = bdget(sis->bdev->bd_dev);
> +				*bdev_p = bdcopy(sis->bdev);
>  
>  			spin_unlock(&swap_lock);
>  			return i;
> @@ -765,7 +765,7 @@ int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
>  					struct swap_extent, list);
>  			if (se->start_block == offset) {
>  				if (bdev_p)
> -					*bdev_p = bdget(sis->bdev->bd_dev);
> +					*bdev_p = bdcopy(sis->bdev);
>  
>  				spin_unlock(&swap_lock);
>  				bdput(bdev);
