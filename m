From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / hibernate: take freed pages into account for preallocated memory
Date: Wed, 04 Feb 2015 15:41:23 +0100
Message-ID: <1823602.zH0H2khnNf@vostro.rjw.lan>
References: <1422951720-29020-1-git-send-email-wonhong.kwon@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64136 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932587AbbBDOS2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 09:18:28 -0500
In-Reply-To: <1422951720-29020-1-git-send-email-wonhong.kwon@lge.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wonhong Kwon <wonhongkwon@gmail.com>
Cc: len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, gunho.lee@lge.com, Wonhong Kwon <wonhong.kwon@lge.com>

On Tuesday, February 03, 2015 05:22:00 PM Wonhong Kwon wrote:
> hibernate_preallocate_memory() prints out that how many pages are
> allocated, but it doesn't take into consideration the pages freed by
> free_unnecessary_pages(). Therefore, it always shows the count more
> than actually allocated.
> 
> Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>

Queued up for 3.20, thanks!

> ---
>  kernel/power/snapshot.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 0c40c16..3a47dcd 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1472,9 +1472,9 @@ static inline unsigned long preallocate_highmem_fraction(unsigned long nr_pages,
>  /**
>   * free_unnecessary_pages - Release preallocated pages not needed for the image
>   */
> -static void free_unnecessary_pages(void)
> +static unsigned long free_unnecessary_pages(void)
>  {
> -	unsigned long save, to_free_normal, to_free_highmem;
> +	unsigned long save, to_free_normal, to_free_highmem, free;
>  
>  	save = count_data_pages();
>  	if (alloc_normal >= save) {
> @@ -1495,6 +1495,7 @@ static void free_unnecessary_pages(void)
>  		else
>  			to_free_normal = 0;
>  	}
> +	free = to_free_normal + to_free_highmem;
>  
>  	memory_bm_position_reset(&copy_bm);
>  
> @@ -1518,6 +1519,8 @@ static void free_unnecessary_pages(void)
>  		swsusp_unset_page_free(page);
>  		__free_page(page);
>  	}
> +
> +	return free;
>  }
>  
>  /**
> @@ -1707,7 +1710,7 @@ int hibernate_preallocate_memory(void)
>  	 * pages in memory, but we have allocated more.  Release the excessive
>  	 * ones now.
>  	 */
> -	free_unnecessary_pages();
> +	pages -= free_unnecessary_pages();
>  
>   out:
>  	stop = ktime_get();
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
