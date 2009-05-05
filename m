From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/5] PM/Hibernate: Do not release
	preallocated memory unnecessarily (rev. 2)
Date: Wed, 6 May 2009 01:07:44 +0200
Message-ID: <200905060107.45345.rjw__18500.5908403129$1241565063$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera>
	<20090505022427.GA10880@localhost>
	<20090505024646.GA14621@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090505024646.GA14621@localhost>
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
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alan-jenkins@tuffmail.co.uk" <alan-jenkins@tuffmail.co.uk>, "jens.axboe@oracle.com" <jens.axboe@oracle.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "kernel-testers@vger.kernel.org" <kernel-testers@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 05 May 2009, Wu Fengguang wrote:
> On Tue, May 05, 2009 at 10:24:27AM +0800, Wu Fengguang wrote:
> > On Mon, May 04, 2009 at 08:22:38AM +0800, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Since the hibernation code is now going to use allocations of memory
> > > to create enough room for the image, it can also use the page frames
> > > allocated at this stage as image page frames.  The low-level
> > > hibernation code needs to be rearranged for this purpose, but it
> > > allows us to avoid freeing a great number of pages and allocating
> > > these same pages once again later, so it generally is worth doing.
> > > 
> > > [rev. 2: Change the strategy of preallocating memory to allocate as
> > >  many pages as needed to get the right image size in one shot (the
> > >  excessive allocated pages are released afterwards).]
> > 
> > Rafael, I tried out your patches and found doubled memory shrink speed!
> > 
> > [  579.641781] PM: Preallocating image memory ... done (allocated 383900 pages, 128000 image pages kept)
> > [  583.087875] PM: Allocated 1535600 kbytes in 3.43 seconds (447.69 MB/s)
>  
> > For you reference, here is the free memory before/after
> > hibernate_preallocate_memory():
> > 
> >         # free
> >                      total       used       free     shared    buffers     cached
> >         Mem:          1933       1917         15          0          0       1845
> >         -/+ buffers/cache:         72       1861
> >         Swap:            0          0          0
> > 
> >         # free
> >                      total       used       free     shared    buffers     cached
> >         Mem:          1933        920       1012          0          0        356
> >         -/+ buffers/cache:        563       1369
> >         Swap:            0          0          0
> > 
> > It seems that the preallocated memory is not freed on -ENOMEM.
> 
> Ah, this was my fault.
> 
> I used to do this debugging trick:
> 
>         @@ -1207,7 +1207,7 @@ int hibernate_preallocate_memory(void)
>                         pages, size);
>                 swsusp_show_speed(&start, &stop, pages, "Allocated");
> 
>         -       return 0;
>         +       return -ENOMEM;
> 
>           err_out:
>                 printk(KERN_CONT "\n");
> 
> That "return -ENOMEM" should be "error = -ENOMEM" :-)
> 
> Here is one more run:
> 
> [  194.016991] PM: Preallocating image memory ... done (allocated 383897 pages, 128000 image pages kept)
> [  196.505999] PM: Allocated 1535588 kbytes in 2.47 seconds (621.69 MB/s)
> 
> Now the free report is back to normal:
> 
> # free
>              total       used       free     shared    buffers     cached
> Mem:          1933         74       1858          0          0         15

Thanks for testing.  The results look encouraging, but I'd also like to get rid
of the regression mentioned in my previous message.

Thanks,
Rafael
