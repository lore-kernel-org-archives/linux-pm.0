From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 7/7] PM: submit bio in a sane way in cases without bio_chain
Date: Fri, 30 Jan 2015 01:49:12 +0100
Message-ID: <4984785.46RVPIMUvq@vostro.rjw.lan>
References: <cover.1421052656.git.dongsu.park@profitbricks.com> <962e0fd9683e2d523cadf8036769dfbaf3b21e77.1421052656.git.dongsu.park@profitbricks.com> <be07c413948b5504b78bbfc1e20395905525efd0.1421052656.git.dongsu.park@profitbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54186 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751322AbbA3A0Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 19:26:24 -0500
In-Reply-To: <be07c413948b5504b78bbfc1e20395905525efd0.1421052656.git.dongsu.park@profitbricks.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dongsu Park <dongsu.park@profitbricks.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Kent Overstreet <kmo@daterainc.com>, Jens Axboe <axboe@kernel.dk>, linux-pm@vger.kernel.org

On Monday, January 12, 2015 12:44:04 PM Dongsu Park wrote:
> From: Kent Overstreet <kmo@daterainc.com>
> 
> Make bio submission in kernel/power/block_io.c to properly submit
> bios also when bio_chain is not available. In that case, it's not
> necessary to handle refcount with bio_get(), but it's saner to simply
> call a predefined helper submit_bio_wait(). So call bio_get() only
> when bio_chain is given.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Kent Overstreet <kmo@daterainc.com>
> [dpark: add more description in commit message]
> Signed-off-by: Dongsu Park <dongsu.park@profitbricks.com>

This is fine by me, but I'd like to have an ACK from a block layer
expert here if I'm to apply it.

If you want to push this through the block layer subsystem tree,
please feel free to add my ACK to it.

> ---
>  kernel/power/block_io.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
> index 9a58bc2..7206408 100644
> --- a/kernel/power/block_io.c
> +++ b/kernel/power/block_io.c
> @@ -34,7 +34,6 @@ static int submit(int rw, struct block_device *bdev, sector_t sector,
>  	bio = bio_alloc(__GFP_WAIT | __GFP_HIGH, 1);
>  	bio->bi_iter.bi_sector = sector;
>  	bio->bi_bdev = bdev;
> -	bio->bi_end_io = end_swap_bio_read;
>  
>  	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
>  		printk(KERN_ERR "PM: Adding page to bio failed at %llu\n",
> @@ -44,15 +43,29 @@ static int submit(int rw, struct block_device *bdev, sector_t sector,
>  	}
>  
>  	lock_page(page);
> -	bio_get(bio);
>  
>  	if (bio_chain == NULL) {
> -		submit_bio(bio_rw, bio);
> -		wait_on_page_locked(page);
> +		int err = submit_bio_wait(bio_rw, bio);
> +
> +		if (err) {
> +			SetPageError(page);
> +			ClearPageUptodate(page);
> +			pr_alert("Read-error on swap-device (%u:%u:%llu)\n",
> +				 imajor(bio->bi_bdev->bd_inode),
> +				 iminor(bio->bi_bdev->bd_inode),
> +				 (unsigned long long)bio->bi_iter.bi_sector);
> +		} else {
> +			SetPageUptodate(page);
> +		}
> +
>  		if (rw == READ)
> -			bio_set_pages_dirty(bio);
> +			set_page_dirty_lock(page);
> +		unlock_page(page);
>  		bio_put(bio);
>  	} else {
> +		bio->bi_end_io = end_swap_bio_read;
> +		bio_get(bio);
> +
>  		if (rw == READ)
>  			get_page(page);	/* These pages are freed later */
>  		bio->bi_private = *bio_chain;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
