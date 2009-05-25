From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2 bugs related to suspend to disk
Date: Mon, 25 May 2009 23:29:50 +0200
Message-ID: <200905252329.51274.rjw__32915.4877727435$1243287174$gmane$org@sisk.pl>
References: <4A199A7A.3010705@gmail.com> <200905242158.15093.rjw@sisk.pl>
	<alpine.LFD.2.00.0905251614160.4048@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0905251614160.4048@localhost.localdomain>
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
To: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, Marcin Slusarz <marcin.slusarz@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 25 May 2009, Sebastian Ott wrote:
> hi,
> 
> On Sun, 24 May 2009, Rafael J. Wysocki wrote:
> 
> > On Sunday 24 May 2009, Marcin Slusarz wrote:
> > > 1) echo platform > /sys/power/disk; echo disk > /sys/power/state
> > > 
> > > works but prints:
> > > 
> > > BUG: sleeping function called from invalid context at include/linux/writeback.h:87
> > > in_atomic(): 1, irqs_disabled(): 0, pid: 6509, name: sh
> > > 3 locks held by sh/6509:
> > >  #0:  (&buffer->mutex){+.+.+.}, at: [<>] sysfs_write_file+0x38/0x119
> > >  #1:  (pm_mutex){+.+.+.}, at: [<>] hibernate+0x17/0x169
> > >  #2:  (swap_lock){+.+...}, at: [<>] swap_type_of+0x2e/0xed
> > > Pid: 6509, comm: sh Not tainted 2.6.30-rc7-mod #124
> > > Call Trace:
> > >  ? __debug_show_held_locks
> > >  ? bdev_test
> > >  __might_sleep
> > >  ifind
> > >  ? bdev_test
> > >  iget5_locked
> > >  ? bdev_set
> > >  bdget
> > >  swap_type_of
> > >  swsusp_write
> > >  ? acpi_sleep_tts_switch
> > >  hibernate
> > >  state_store
> > >  kobj_attr_store
> > >  sysfs_write_file
> > >  vfs_write
> > >  sys_write
> > >  system_call_fastpath
> > > 
> > > 2) "s2disk" (from suspend-0.8) suspends, but doesn't resume (and I need to mkswap && swapon -a later)
> > > 
> > > It's not a regression, because I never tried to STD (STR worked).
> > 
> > Both look strange, at least the first one does.
> > 
> > Thanks for the report, I'll do my best to take care of this as soon as I can.
> > 
> 
> i've seen a similar warning, the problem seems to be that swap_type_of 
> calls bdget with the swap_lock held.

Well, it didn't cause any problems in the past.

> with the attached patch i don't see this warning any more - but i'm not 
> sure if this is the correct way to fix this

I'll have a look, thanks for the patch.

> regards, sebastian
> ---
> 
> don't call bdget with swap_lock held
> 
> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> ---
>  mm/swapfile.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.5/mm/swapfile.c
> ===================================================================
> --- linux-2.5.orig/mm/swapfile.c	2009-03-24 13:51:00.000000000 +0100
> +++ linux-2.5/mm/swapfile.c	2009-05-25 15:33:34.000000000 +0200
> @@ -634,10 +634,10 @@ int swap_type_of(dev_t device, sector_t 
>  			continue;
>  
>  		if (!bdev) {
> +			spin_unlock(&swap_lock);
>  			if (bdev_p)
>  				*bdev_p = bdget(sis->bdev->bd_dev);
>  
> -			spin_unlock(&swap_lock);
>  			return i;
>  		}
>  		if (bdev == sis->bdev) {
> @@ -646,10 +646,10 @@ int swap_type_of(dev_t device, sector_t 
>  			se = list_entry(sis->extent_list.next,
>  					struct swap_extent, list);
>  			if (se->start_block == offset) {
> +				spin_unlock(&swap_lock);
>  				if (bdev_p)
>  					*bdev_p = bdget(sis->bdev->bd_dev);
>  
> -				spin_unlock(&swap_lock);
>  				bdput(bdev);
>  				return i;
>  			}
> --

Best,
Rafael
