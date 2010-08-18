From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Thu, 19 Aug 2010 01:02:04 +0200
Message-ID: <201008190102.04474.rjw@sisk.pl>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1281407348.2618.52.camel@shrek.rexursive.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bojan Smojver <bojan@rexursive.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 10, 2010, Bojan Smojver wrote:
> Please queue for merge in 2.6.36.
> ---------------------
> 
> Compress hibernation image with LZO in order to save on I/O and
> therefore time to hibernate/thaw.
> 
> Signed-off-by: Bojan Smojver <bojan@rexursive.com>
> ---
> 
>  kernel/power/Kconfig |    2 +
>  kernel/power/swap.c  |  205 ++++++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 183 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index ca6066a..cb57eb9 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -137,6 +137,8 @@ config SUSPEND_FREEZER
>  config HIBERNATION
>  	bool "Hibernation (aka 'suspend to disk')"
>  	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
> +	select LZO_COMPRESS
> +	select LZO_DECOMPRESS

I'm not a big fan of select in Kconfig.  It ususally causes one to be surprised
with the final choice of options in .config.

Does that work at all if CRYPTO_ALGAPI is not set?

>  	select SUSPEND_NVS if HAS_IOMEM
>  	---help---
>  	  Enable the suspend to disk (STD) functionality, which is usually
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index b0bb217..512eb3a 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -24,6 +24,7 @@
>  #include <linux/swapops.h>
>  #include <linux/pm.h>
>  #include <linux/slab.h>
> +#include <linux/lzo.h>
>  
>  #include "power.h"
>  
> @@ -357,6 +358,18 @@ static int swap_writer_finish(struct swap_map_handle *handle,
>  	return error;
>  }
>  
> +/* We need to remember how much compressed data we need to read. */
> +#define LZO_HEADER	sizeof(size_t)
> +
> +/* Number of pages/bytes we'll compress at one time. */
> +#define LZO_UNC_PAGES	32
> +#define LZO_UNC_SIZE	(LZO_UNC_PAGES * PAGE_SIZE)

These numbers seem to be totally arbitrary.  Any justification, please?

> +/* Number of pages/bytes we need for compressed data (worst case). */
> +#define LZO_CMP_PAGES	DIV_ROUND_UP(lzo1x_worst_compress(LZO_UNC_SIZE) + \
> +			             LZO_HEADER, PAGE_SIZE)
> +#define LZO_CMP_SIZE	(LZO_CMP_PAGES * PAGE_SIZE)
> +
>  /**
>   *	save_image - save the suspend image data
>   */
> @@ -372,6 +385,38 @@ static int save_image(struct swap_map_handle *handle,
>  	struct bio *bio;
>  	struct timeval start;
>  	struct timeval stop;
> +	size_t i, unc_len, cmp_len;
> +	unsigned char *unc, *cmp, *wrk, *page;
> +
> +	page = (void *)__get_free_page(__GFP_WAIT | __GFP_HIGH);
> +	if (!page) {
> +		printk(KERN_ERR "PM: Failed to allocate LZO page\n");
> +		return -ENOMEM;
> +	}
> +
> +	wrk = vmalloc(LZO1X_1_MEM_COMPRESS);
> +	if (!wrk) {
> +		printk(KERN_ERR "PM: Failed to allocate LZO workspace\n");
> +		free_page((unsigned long)page);
> +		return -ENOMEM;
> +	}
> +
> +	unc = vmalloc(LZO_UNC_SIZE);
> +	if (!unc) {
> +		printk(KERN_ERR "PM: Failed to allocate LZO uncompressed\n");
> +		vfree(wrk);
> +		free_page((unsigned long)page);
> +		return -ENOMEM;
> +	}
> +
> +	cmp = vmalloc(LZO_CMP_SIZE);
> +	if (!cmp) {
> +		printk(KERN_ERR "PM: Failed to allocate LZO compressed\n");
> +		vfree(unc);
> +		vfree(wrk);
> +		free_page((unsigned long)page);
> +		return -ENOMEM;
> +	}

I'd rather wouldn't like the above to be unconditional.  If not for anything
else, I think it would be nice to be able to switch the compression off for
debugging purposes (like when we're not sure why the image is corrupted or
similar).  A kernel command line switch would suffice for that IMO.

>  	printk(KERN_INFO "PM: Saving image data pages (%u pages) ...     ",
>  		nr_to_write);
> @@ -382,16 +427,57 @@ static int save_image(struct swap_map_handle *handle,
>  	bio = NULL;
>  	do_gettimeofday(&start);
>  	while (1) {
> -		ret = snapshot_read_next(snapshot);
> -		if (ret <= 0)
> +		for (i = 0; i < LZO_UNC_SIZE; i += PAGE_SIZE) {
> +			ret = snapshot_read_next(snapshot);
> +			if (ret < 0)
> +				goto out_finish;
> +
> +			if (!ret)
> +				break;
> +
> +			memcpy(unc + i, data_of(*snapshot), PAGE_SIZE);
> +
> +			if (!(nr_pages % m))
> +				printk(KERN_CONT "\b\b\b\b%3d%%", nr_pages / m);
> +			nr_pages++;
> +		}
> +
> +		if (!i)
>  			break;

This statement is profoundly hard to decode.  Perhaps there's a better name for 'i'?
Like 'size' or similar?

Also please make it possible to switch the compression off here too.

The comments above seem to apply to the remaining code too.

Thanks,
Rafael
