From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / hibernate: Avoid overflow in hibernate_preallocate_memory
Date: Tue, 05 Nov 2013 15:22:11 +0100
Message-ID: <1974778.1p97Y6DIEX@vostro.rjw.lan>
References: <52789B31.70005@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60597 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754536Ab3KEOJy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2013 09:09:54 -0500
In-Reply-To: <52789B31.70005@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Linux-pm mailing list <linux-pm@vger.kernel.org>, Leon Drugi <eyak@wp.pl>

On Tuesday, November 05, 2013 03:16:01 PM Aaron Lu wrote:
> When system has a lot of highmem(e.g. 16GiB using a 32 bits kernel), the
> code to calculate how much memory we need to preallocate in normal zone
> may cause overflow. As Leon has analysed:
> "
> It looks that during computing 'alloc' variable there is overflow:
> alloc = (3943404 - 1970542) - 1978280 = -5418 (signed)
> And this function goes to err_out.
> "
> Fix this by avoiding that overflow.
> 
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=60817
> Reported-and-tested-by: Leon Drugi <eyak@wp.pl>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  kernel/power/snapshot.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 98c3b34a4cff..91aa616a1f4e 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1402,7 +1402,8 @@ int hibernate_preallocate_memory(void)
>  	 * highmem and non-highmem zones separately.
>  	 */
>  	pages_highmem = preallocate_image_highmem(highmem / 2);
> -	alloc = (count - max_size) - pages_highmem;
> +	alloc = (count - max_size) > pages_highmem ?
> +		(count - max_size - pages_highmem) : 0;

Well, what about

	alloc = count - max_size;
	if (alloc > pages_highmem)
		alloc -= pages_highmem;
	else
		alloc = 0;

>  	pages = preallocate_image_memory(alloc, avail_normal);
>  	if (pages < alloc) {
>  		/* We have exhausted non-highmem pages, try highmem. */
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
