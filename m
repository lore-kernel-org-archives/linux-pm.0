From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] PM / Hibernate: Improve comments in
 hibernate_preallocate_memory()
Date: Mon, 4 Oct 2010 19:56:18 +0200
Message-ID: <20101004175618.GF1518__26626.1618504815$1286217306$gmane$org@ucw.cz>
References: <201009150021.45101.rjw@sisk.pl> <201009150022.30031.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009150022.30031.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2010-09-15 00:22:29, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / Hibernate: Improve comments in hibernate_preallocate_memory()
> 
> One comment in hibernate_preallocate_memory() is wrong, so fix it and
> add one more comment to clarify the meaning of the fixed one.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.


> ---
>  kernel/power/snapshot.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/kernel/power/snapshot.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/snapshot.c
> +++ linux-2.6/kernel/power/snapshot.c
> @@ -1318,12 +1318,14 @@ int hibernate_preallocate_memory(void)
>  
>  	/* Compute the maximum number of saveable pages to leave in memory. */
>  	max_size = (count - (size + PAGES_FOR_IO)) / 2 - 2 * SPARE_PAGES;
> +	/* Compute the desired number of image pages specified by image_size. */
>  	size = DIV_ROUND_UP(image_size, PAGE_SIZE);
>  	if (size > max_size)
>  		size = max_size;
>  	/*
> -	 * If the maximum is not less than the current number of saveable pages
> -	 * in memory, allocate page frames for the image and we're done.
> +	 * If the desired number of image pages is at least as large as the
> +	 * current number of saveable pages in memory, allocate page frames for
> +	 * the image and we're done.
>  	 */
>  	if (size >= saveable) {
>  		pages = preallocate_image_highmem(save_highmem);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
