From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/23] Hibernation: Split compression support
	out.
Date: Mon, 27 Sep 2010 22:27:42 +0200
Message-ID: <201009272227.42779.rjw__13299.6310866021$1285619346$gmane$org@sisk.pl>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<1285566238-10966-2-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285566238-10966-2-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

On Monday, September 27, 2010, Nigel Cunningham wrote:
> Separate compression support out into its own file, removing in
> the process the duplication of the load_image and save_image
> functions and some #includes from swap.c that are no longer
> needed.
> 
> Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>

If you're at it, I'd like to do something slightly different.  Explained below.

> ---
>  kernel/power/Makefile   |    2 +-
>  kernel/power/compress.c |  210 +++++++++++++++++++++++++++++
>  kernel/power/compress.h |   23 +++
>  kernel/power/swap.c     |  339 +++++------------------------------------------
>  kernel/power/swap.h     |   28 ++++
>  5 files changed, 296 insertions(+), 306 deletions(-)
>  create mode 100644 kernel/power/compress.c
>  create mode 100644 kernel/power/compress.h
>  create mode 100644 kernel/power/swap.h
> 
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> index f9063c6..2eb134d 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_FREEZER)		+= process.o
>  obj-$(CONFIG_SUSPEND)		+= suspend.o
>  obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
>  obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o user.o \
> -				   block_io.o
> +				   block_io.o compress.o
>  obj-$(CONFIG_SUSPEND_NVS)	+= nvs.o
>  
>  obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
> diff --git a/kernel/power/compress.c b/kernel/power/compress.c
> new file mode 100644
> index 0000000..45725ea
> --- /dev/null
> +++ b/kernel/power/compress.c
> @@ -0,0 +1,210 @@
> +/*
> + * linux/kernel/power/compress.c
> + *
> + * This file provides functions for (optionally) compressing an
> + * image as it is being written and decompressing it at resume.
> + *
> + * Copyright (C) 2003-2010 Nigel Cunningham <nigel@tuxonice.net>
> + *
> + * This file is released under the GPLv2.
> + *
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/lzo.h>
> +#include <linux/vmalloc.h>
> +
> +#include "power.h"
> +#include "swap.h"
> +
> +/* We need to remember how much compressed data we need to read. */
> +#define LZO_HEADER	sizeof(size_t)
> +
> +/* Number of pages/bytes we'll compress at one time. */
> +#define LZO_UNC_PAGES	32
> +#define LZO_UNC_SIZE	(LZO_UNC_PAGES * PAGE_SIZE)
> +
> +/* Number of pages/bytes we need for compressed data (worst case). */
> +#define LZO_CMP_PAGES	DIV_ROUND_UP(lzo1x_worst_compress(LZO_UNC_SIZE) + \
> +			             LZO_HEADER, PAGE_SIZE)
> +#define LZO_CMP_SIZE	(LZO_CMP_PAGES * PAGE_SIZE)
> +
> +static size_t off, unc_len, cmp_len;
> +static unsigned char *unc, *cmp, *wrk, *page;
> +
> +void compress_image_cleanup(void)
> +{
> +	if (cmp) {
> +		vfree(cmp);
> +		cmp = NULL;
> +	}
> +
> +	if (unc) {
> +		vfree(unc);
> +		unc = NULL;
> +	}
> +
> +	if (wrk) {
> +		vfree(wrk);
> +		wrk = NULL;
> +	}
> +
> +	if (page) {
> +		free_page((unsigned long)page);
> +		page = NULL;
> +	}
> +}
> +
> +int compress_image_init(void)
> +{
> +	page = (void *)__get_free_page(__GFP_WAIT | __GFP_HIGH);
> +	if (!page) {
> +		printk(KERN_ERR "PM: Failed to allocate LZO page\n");
> +		return -ENOMEM;
> +	}
> +
> +	wrk = vmalloc(LZO1X_1_MEM_COMPRESS);
> +	unc = vmalloc(LZO_UNC_SIZE);
> +	cmp = vmalloc(LZO_CMP_SIZE);
> +
> +	if (!wrk || !unc || !cmp) {
> +		printk(KERN_ERR "PM: Failed to allocate memory for (de)compression.\n");
> +		compress_image_cleanup();
> +		return -ENOMEM;
> +	}
> +
> +	off = 0;
> +
> +	return 0;
> +}
> +
> +static int compress_and_write(struct swap_map_handle *handle, struct bio **bio)
> +{
> +	int ret;
> +
> +	if (!off)
> +		return 0;
> +
> +	unc_len = off;
> +	ret = lzo1x_1_compress(unc, unc_len, cmp + LZO_HEADER, &cmp_len, wrk);
> +
> +	if (ret < 0) {
> +		printk(KERN_ERR "PM: LZO compression failed\n");
> +		return -EIO;
> +	}
> +
> +	if (unlikely(!cmp_len ||
> +	             cmp_len > lzo1x_worst_compress(unc_len))) {
> +		printk(KERN_ERR "PM: Invalid LZO compressed length\n");
> +		return -EIO;
> +	}
> +
> +	*(size_t *)cmp = cmp_len;
> +
> +	/*
> +	 * Given we are writing one page at a time to disk, we copy
> +	 * that much from the buffer, although the last bit will likely
> +	 * be smaller than full page. This is OK - we saved the length
> +	 * of the compressed data, so any garbage at the end will be
> +	 * discarded when we read it.
> +	 */
> +	for (off = 0; off < LZO_HEADER + cmp_len; off += PAGE_SIZE) {
> +		memcpy(page, cmp + off, PAGE_SIZE);
> +
> +		ret = swap_write_page(handle, page, bio);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	off = 0;
> +	return 0;
> +}
> +
> +int compress_write(struct swap_map_handle *handle, char *buf, struct bio **bio,
> +		int flags)
> +{
> +	int ret = 0;
> +
> +	if (flags & SF_NOCOMPRESS_MODE)
> +		return swap_write_page(handle, buf, bio);
> +
> +	if (off == LZO_UNC_SIZE)
> +		ret = compress_and_write(handle, bio);
> +
> +	memcpy(unc + off, buf, PAGE_SIZE);
> +	off += PAGE_SIZE;
> +	return ret;
> +}

This one doesn't really good to me.  What I'd prefer would be to have a
structure of "swap operations" pointers like ->start(), ->write_data(),
->read_data(), and ->finish() that will point to the functions in this file
(if compression is to be used) or to the "old" swap_write_page()/swap_read_page()
otherwise.  That would reduce the number of the
(flags & SF_NOCOMPRESS_MODE) checks quite substantially and will likely result
in code that's easier to follow.

Thanks,
Rafael
