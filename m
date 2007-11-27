From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 5/6] Hibernation: Use common prefix in
	messages
Date: Tue, 27 Nov 2007 01:20:34 +0100
Message-ID: <20071127002034.GC9759__31615.0364037187$1196122962$gmane$org@elf.ucw.cz>
References: <200711270025.08128.rjw@sisk.pl> <200711270032.07724.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711270032.07724.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/disk.c     |   38 ++++++++++++++++++++------------------
>  kernel/power/snapshot.c |   24 +++++++++++++-----------
>  kernel/power/swap.c     |   43 +++++++++++++++++++++++--------------------
>  kernel/power/swsusp.c   |   10 +++++-----
>  4 files changed, 61 insertions(+), 54 deletions(-)
> 
> Index: linux-2.6/kernel/power/disk.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/disk.c
> +++ linux-2.6/kernel/power/disk.c
> @@ -191,7 +191,7 @@ int create_image(int platform_mode)
>  	 */
>  	error = device_power_down(PMSG_FREEZE);
>  	if (error) {
> -		printk(KERN_ERR "Some devices failed to power down, "
> +		printk(KERN_ERR PREFIX "Some devices failed to power down, "
>  			KERN_ERR "aborting suspend\n");

This one is actually wrong. (But you did not introduce it). KERN_ERR
will be in the middle of line

> @@ -289,7 +290,7 @@ static int resume_target_kernel(void)
>  	local_irq_disable();
>  	error = device_power_down(PMSG_PRETHAW);
>  	if (error) {
> -		printk(KERN_ERR "Some devices failed to power down, "
> +		printk(KERN_ERR PREFIX "Some devices failed to power down, "
>  			KERN_ERR "aborting resume\n");
>  		goto Enable_irqs;
>  	}

Same here.

> @@ -482,9 +483,9 @@ int hibernate(void)
>  	if (error)
>  		goto Exit;
>  
> -	printk("Syncing filesystems ... ");
> +	printk(KERN_INFO PREFIX "Syncing filesystems ... ");
>  	sys_sync();
> -	printk("done.\n");
> +	printk(KERN_INFO "done.\n");

No. KERN_INFO would end up in the middle of the line.

> @@ -340,7 +342,7 @@ static int save_image(struct swap_map_ha
>  			if (error)
>  				break;
>  			if (!(nr_pages % m))
> -				printk("\b\b\b\b%3d%%", nr_pages / m);
> +				printk(KERN_INFO "\b\b\b\b%3d%%", nr_pages / m);
>  			nr_pages++;
>  		}
>  	} while (ret > 0);

This one is wrong.

> @@ -349,7 +351,7 @@ static int save_image(struct swap_map_ha
>  	if (!error)
>  		error = err2;
>  	if (!error)
> -		printk("\b\b\b\bdone\n");
> +		printk(KERN_INFO "\b\b\b\bdone\n");
>  	swsusp_show_speed(&start, &stop, nr_to_write, "Wrote");
>  	return error;
>  }

As is this. We do some pretty printing with backspaces, and <9> will
break it.

> @@ -388,8 +390,8 @@ int swsusp_write(unsigned int flags)
>  
>  	error = swsusp_swap_check();
>  	if (error) {
> -		printk(KERN_ERR "swsusp: Cannot find swap device, try "
> -				"swapon -a.\n");
> +		printk(KERN_ERR PREFIX "Cannot find swap device, try "
> +			KERN_ERR "swapon -a.\n");
>  		return error;

Same here.

> @@ -417,9 +419,9 @@ int swsusp_write(unsigned int flags)
>  
>  		if (!error) {
>  			flush_swap_writer(&handle);
> -			printk("S");
> +			printk(KERN_INFO PREFIX "S");
>  			error = mark_swapfiles(start, flags);
> -			printk("|\n");
> +			printk(KERN_INFO "|\n");
>  		}
>  	}
>  	if (error)

And here.

> @@ -526,7 +529,7 @@ static int load_image(struct swap_map_ha
>  		if (error)
>  			break;
>  		if (!(nr_pages % m))
> -			printk("\b\b\b\b%3d%%", nr_pages / m);
> +			printk(KERN_INFO "\b\b\b\b%3d%%", nr_pages / m);
>  		nr_pages++;
>  	}
>  	err2 = wait_on_bio_chain(&bio);

And here.

> @@ -534,7 +537,7 @@ static int load_image(struct swap_map_ha
>  	if (!error)
>  		error = err2;
>  	if (!error) {
> -		printk("\b\b\b\bdone\n");
> +		printk(KERN_INFO "\b\b\b\bdone\n");
>  		snapshot_write_finalize(snapshot);
>  		if (!snapshot_image_loaded(snapshot))
>  			error = -ENODATA;

...and here.

> @@ -253,10 +253,10 @@ int swsusp_shrink_memory(void)
>  			tmp = __shrink_memory(size - (image_size / PAGE_SIZE));
>  			pages += tmp;
>  		}
> -		printk("\b%c", p[i++%4]);
> +		printk(KERN_INFO "\b%c", p[i++%4]);
>  	} while (tmp > 0);
>  	do_gettimeofday(&stop);
> -	printk("\bdone (%lu pages freed)\n", pages);
> +	printk(KERN_INFO "\bdone (%lu pages freed)\n", pages);
>  	swsusp_show_speed(&start, &stop, pages, "Freed");

And here.

All in all, I do not think I like the "PREFIX" idea. 

printk(PREFIX "foo");

is longer than

printk("pm: foo");

... and the extra indirection will make greping slightly harder. (I
bet I would do 

grep "pm: foo" *.c

if I saw such message).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
