From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / Hiberante : optimize swsusp_free()
Date: Thu, 19 Mar 2015 09:54:48 +0100
Message-ID: <20150319085448.GA18997@amd>
References: <1426753738-26747-1-git-send-email-tom.yeon@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39205 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbbCSIyv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Mar 2015 04:54:51 -0400
Content-Disposition: inline
In-Reply-To: <1426753738-26747-1-git-send-email-tom.yeon@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Tom(JeHyeon) Yeon" <tomyeon750415lkml@gmail.com>
Cc: len.brown@intel.com, jroedel@suse.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Tom(JeHyeon) Yeon" <tom.yeon@windriver.com>

On Thu 2015-03-19 17:28:58, Tom(JeHyeon) Yeon wrote:
> From: "Tom(JeHyeon) Yeon" <tom.yeon@windriver.com>
> 
> I tested the performance of swsusp_free operation.
> The free time took about 58768us before commit fdd64ed, and
> the free time took about 40535us after the commit fdd64ed.
> 
> But, I optimized the function before I saw commit fdd64ed.
> So, I applied the patch in my system.(ARM Coretex A9, Dual Core 1GHz)
> The free time took about 35164us.
> I think that the finding routine for the same pfn is redundant
> 
> Signed-off-by: Tom(JeHyeon) Yeon <tom.yeon@windriver.com>

Well, saving 5msec on operation that takes 30 seconds is not that
much, but new code looks cleaner.

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -726,14 +726,6 @@ static void memory_bm_clear_bit(struct memory_bitmap *bm, unsigned long pfn)
>  	clear_bit(bit, addr);
>  }
>  
> -static void memory_bm_clear_current(struct memory_bitmap *bm)
> -{
> -	int bit;
> -
> -	bit = max(bm->cur.node_bit - 1, 0);
> -	clear_bit(bit, bm->cur.node->data);
> -}
> -
>  static int memory_bm_test_bit(struct memory_bitmap *bm, unsigned long pfn)
>  {
>  	void *addr;
> @@ -1342,36 +1334,21 @@ static struct memory_bitmap copy_bm;
>  
>  void swsusp_free(void)
>  {
> -	unsigned long fb_pfn, fr_pfn;
> +	unsigned long pfn;
>  
>  	if (!forbidden_pages_map || !free_pages_map)
>  		goto out;
>  
>  	memory_bm_position_reset(forbidden_pages_map);
> -	memory_bm_position_reset(free_pages_map);
> -
> -loop:
> -	fr_pfn = memory_bm_next_pfn(free_pages_map);
> -	fb_pfn = memory_bm_next_pfn(forbidden_pages_map);
> -
> -	/*
> -	 * Find the next bit set in both bitmaps. This is guaranteed to
> -	 * terminate when fb_pfn == fr_pfn == BM_END_OF_MAP.
> -	 */
> -	do {
> -		if (fb_pfn < fr_pfn)
> -			fb_pfn = memory_bm_next_pfn(forbidden_pages_map);
> -		if (fr_pfn < fb_pfn)
> -			fr_pfn = memory_bm_next_pfn(free_pages_map);
> -	} while (fb_pfn != fr_pfn);
> -
> -	if (fr_pfn != BM_END_OF_MAP && pfn_valid(fr_pfn)) {
> -		struct page *page = pfn_to_page(fr_pfn);
> -
> -		memory_bm_clear_current(forbidden_pages_map);
> -		memory_bm_clear_current(free_pages_map);
> -		__free_page(page);
> -		goto loop;
> +	for ( ; ; ) {
> +		pfn  = memory_bm_next_pfn(forbidden_pages_map);
> +		if (BM_END_OF_MAP == pfn)
> +			break;
> +		if (memory_bm_test_bit(free_pages_map, pfn)) {
> +			memory_bm_clear_bit(forbidden_pages_map, pfn);
> +			memory_bm_clear_bit(free_pages_map, pfn);
> +			__free_page(pfn_to_page(pfn));
> +		}
>  	}
>  
>  out:

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
