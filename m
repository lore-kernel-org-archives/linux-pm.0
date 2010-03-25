From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 05/15] PM / Hibernate: group swap ops
Date: Thu, 25 Mar 2010 22:28:25 +0100
Message-ID: <201003252228.25665.rjw__41927.0797785886$1269552611$gmane$org@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-5-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1269361063-3341-5-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, jirislaby@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 March 2010, Jiri Slaby wrote:
> Move all the swap processing into one function. It will make swap
> calls from a non-swap code easier.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Nigel Cunningham <ncunningham@crca.org.au>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>

Looks good.

Rafael


> ---
>  kernel/power/swap.c |  117 ++++++++++++++++++++++++++++++++-------------------
>  1 files changed, 74 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index a1cff28..2edf742 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -207,9 +207,10 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
>  /**
>   *	swsusp_swap_check - check if the resume device is a swap device
>   *	and get its index (if so)
> + *
> + *	This is called before saving image
>   */
> -
> -static int swsusp_swap_check(void) /* This is called before saving image */
> +static int swsusp_swap_check(void)
>  {
>  	int res;
>  
> @@ -268,17 +269,33 @@ static void release_swap_writer(struct swap_map_handle *handle)
>  
>  static int get_swap_writer(struct swap_map_handle *handle)
>  {
> +	int ret;
> +
> +	ret = swsusp_swap_check();
> +	if (ret) {
> +		if (ret != -ENOSPC)
> +			printk(KERN_ERR "PM: Cannot find swap device, try "
> +					"swapon -a.\n");
> +		return ret;
> +	}
>  	handle->cur = (struct swap_map_page *)get_zeroed_page(GFP_KERNEL);
> -	if (!handle->cur)
> -		return -ENOMEM;
> +	if (!handle->cur) {
> +		ret = -ENOMEM;
> +		goto err_close;
> +	}
>  	handle->cur_swap = alloc_swapdev_block(root_swap);
>  	if (!handle->cur_swap) {
> -		release_swap_writer(handle);
> -		return -ENOSPC;
> +		ret = -ENOSPC;
> +		goto err_rel;
>  	}
>  	handle->k = 0;
>  	handle->first_sector = handle->cur_swap;
>  	return 0;
> +err_rel:
> +	release_swap_writer(handle);
> +err_close:
> +	swsusp_close(FMODE_WRITE);
> +	return ret;
>  }
>  
>  static int swap_write_page(struct swap_map_handle *handle, void *buf,
> @@ -321,6 +338,24 @@ static int flush_swap_writer(struct swap_map_handle *handle)
>  		return -EINVAL;
>  }
>  
> +static int put_swap_writer(struct swap_map_handle *handle,
> +		unsigned int flags, int error)
> +{
> +	if (!error) {
> +		flush_swap_writer(handle);
> +		printk(KERN_INFO "PM: S");
> +		error = mark_swapfiles(handle, flags);
> +		printk("|\n");
> +	}
> +
> +	if (error)
> +		free_all_swap_pages(root_swap);
> +	release_swap_writer(handle);
> +	swsusp_close(FMODE_WRITE);
> +
> +	return error;
> +}
> +
>  /**
>   *	save_image - save the suspend image data
>   */
> @@ -398,48 +433,34 @@ int swsusp_write(unsigned int flags)
>  	struct swap_map_handle handle;
>  	struct snapshot_handle snapshot;
>  	struct swsusp_info *header;
> +	unsigned long pages;
>  	int error;
>  
> -	error = swsusp_swap_check();
> +	pages = snapshot_get_image_size();
> +	error = get_swap_writer(&handle);
>  	if (error) {
> -		printk(KERN_ERR "PM: Cannot find swap device, try "
> -				"swapon -a.\n");
> +		printk(KERN_ERR "PM: Cannot get swap writer\n");
>  		return error;
>  	}
> +	if (!enough_swap(pages)) {
> +		printk(KERN_ERR "PM: Not enough free swap\n");
> +		error = -ENOSPC;
> +		goto out_finish;
> +	}
>  	memset(&snapshot, 0, sizeof(struct snapshot_handle));
>  	error = snapshot_read_next(&snapshot);
>  	if (error < PAGE_SIZE) {
>  		if (error >= 0)
>  			error = -EFAULT;
>  
> -		goto out;
> +		goto out_finish;
>  	}
>  	header = (struct swsusp_info *)data_of(snapshot);
> -	if (!enough_swap(header->pages)) {
> -		printk(KERN_ERR "PM: Not enough free swap\n");
> -		error = -ENOSPC;
> -		goto out;
> -	}
> -	error = get_swap_writer(&handle);
> -	if (!error) {
> -		error = swap_write_page(&handle, header, NULL);
> -		if (!error)
> -			error = save_image(&handle, &snapshot,
> -					header->pages - 1);
> -
> -		if (!error) {
> -			flush_swap_writer(&handle);
> -			printk(KERN_INFO "PM: S");
> -			error = mark_swapfiles(&handle, flags);
> -			printk("|\n");
> -		}
> -	}
> -	if (error)
> -		free_all_swap_pages(root_swap);
> -
> -	release_swap_writer(&handle);
> - out:
> -	swsusp_close(FMODE_WRITE);
> +	error = swap_write_page(&handle, header, NULL);
> +	if (!error)
> +		error = save_image(&handle, &snapshot, pages - 1);
> +out_finish:
> +	error = put_swap_writer(&handle, flags, error);
>  	return error;
>  }
>  
> @@ -455,18 +476,21 @@ static void release_swap_reader(struct swap_map_handle *handle)
>  	handle->cur = NULL;
>  }
>  
> -static int get_swap_reader(struct swap_map_handle *handle, sector_t start)
> +static int get_swap_reader(struct swap_map_handle *handle,
> +		unsigned int *flags_p)
>  {
>  	int error;
>  
> -	if (!start)
> +	*flags_p = swsusp_header->flags;
> +
> +	if (!swsusp_header->image) /* how can this happen? */
>  		return -EINVAL;
>  
>  	handle->cur = (struct swap_map_page *)get_zeroed_page(__GFP_WAIT | __GFP_HIGH);
>  	if (!handle->cur)
>  		return -ENOMEM;
>  
> -	error = sws_bio_read_page(start, handle->cur, NULL);
> +	error = sws_bio_read_page(swsusp_header->image, handle->cur, NULL);
>  	if (error) {
>  		release_swap_reader(handle);
>  		return error;
> @@ -501,6 +525,13 @@ static int swap_read_page(struct swap_map_handle *handle, void *buf,
>  	return error;
>  }
>  
> +static int put_swap_reader(struct swap_map_handle *handle)
> +{
> +	release_swap_reader(handle);
> +
> +	return 0;
> +}
> +
>  /**
>   *	load_image - load the image using the swap map handle
>   *	@handle and the snapshot handle @snapshot
> @@ -570,20 +601,20 @@ int swsusp_read(unsigned int *flags_p)
>  	struct snapshot_handle snapshot;
>  	struct swsusp_info *header;
>  
> -	*flags_p = swsusp_header->flags;
> -
>  	memset(&snapshot, 0, sizeof(struct snapshot_handle));
>  	error = snapshot_write_next(&snapshot);
>  	if (error < PAGE_SIZE)
>  		return error < 0 ? error : -EFAULT;
>  	header = (struct swsusp_info *)data_of(snapshot);
> -	error = get_swap_reader(&handle, swsusp_header->image);
> +	error = get_swap_reader(&handle, flags_p);
> +	if (error)
> +		goto end;
>  	if (!error)
>  		error = swap_read_page(&handle, header, NULL);
>  	if (!error)
>  		error = load_image(&handle, &snapshot, header->pages - 1);
> -	release_swap_reader(&handle);
> -
> +	put_swap_reader(&handle);
> +end:
>  	if (!error)
>  		pr_debug("PM: Image successfully loaded\n");
>  	else
> 
