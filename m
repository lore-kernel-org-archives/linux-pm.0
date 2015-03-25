From: "Yeon, JeHyeon (Tom)" <Tom.Yeon@windriver.com>
Subject: Re: [PATCH] PM / Hiberante : optimize swsusp_free()
Date: Wed, 25 Mar 2015 01:49:36 +0000
Message-ID: <D2D54504A8A67848B028EBEA66F47B9AB2A28235@ALA-MBA.corp.ad.wrs.com>
References: <1426753738-26747-1-git-send-email-tom.yeon@windriver.com>,<2492546.RHhDx1zacd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:65362 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbbCYBtr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2015 21:49:47 -0400
In-Reply-To: <2492546.RHhDx1zacd@vostro.rjw.lan>
Content-Language: ko-KR
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "pavel@ucw.cz" <pavel@ucw.cz>
Cc: "BROWN, A LEONARD" <len.brown@intel.com>, "jroedel@suse.de" <jroedel@suse.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Tom(JeHyeon) Yeon" <tomyeon750415lkml@gmail.com>

>From 6cb5fffc41911a29212be52d4ce7e481f5077ccf Mon Sep 17 00:00:00 2001
From: "Tom(JeHyeon) Yeon" <tom.yeon@windriver.com>
Date: Thu, 19 Mar 2015 17:10:45 +0900
Subject: [PATCH] PM / Hiberante : optimize swsusp_free()

Our team developed the snapshot booting.
Fisrt of all, make a snapshot image, compress it and finally save it
in the storage(like mmc).
When the system is booting next time, bootloader read it from mmc,
decompress it and jump to the kernel.
In this circumstance, mili seconds is very important.
So, I prepared this patch, but not applied because I missed the time
to apply it.

And, I came across to find commit fdd64ed.
It's very similar to the patch I prepared.

I think do { ... } while (fb_pfn != fr_pfn) operation is very similar
to my patch. but, it takes a little more time to iterate.
So suggest to iterate one of two maps and check whether the other map
has the same pfn, finally free the page.

Signed-off-by: Tom(JeHyeon) Yeon <tom.yeon@windriver.com>
---
 kernel/power/snapshot.c |   43 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c24d5a2..a1ad801 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -726,14 +726,6 @@ static void memory_bm_clear_bit(struct memory_bitmap *bm, unsigned long pfn)
 	clear_bit(bit, addr);
 }
 
-static void memory_bm_clear_current(struct memory_bitmap *bm)
-{
-	int bit;
-
-	bit = max(bm->cur.node_bit - 1, 0);
-	clear_bit(bit, bm->cur.node->data);
-}
-
 static int memory_bm_test_bit(struct memory_bitmap *bm, unsigned long pfn)
 {
 	void *addr;
@@ -1342,36 +1334,21 @@ static struct memory_bitmap copy_bm;
 
 void swsusp_free(void)
 {
-	unsigned long fb_pfn, fr_pfn;
+	unsigned long pfn;
 
 	if (!forbidden_pages_map || !free_pages_map)
 		goto out;
 
 	memory_bm_position_reset(forbidden_pages_map);
-	memory_bm_position_reset(free_pages_map);
-
-loop:
-	fr_pfn = memory_bm_next_pfn(free_pages_map);
-	fb_pfn = memory_bm_next_pfn(forbidden_pages_map);
-
-	/*
-	 * Find the next bit set in both bitmaps. This is guaranteed to
-	 * terminate when fb_pfn == fr_pfn == BM_END_OF_MAP.
-	 */
-	do {
-		if (fb_pfn < fr_pfn)
-			fb_pfn = memory_bm_next_pfn(forbidden_pages_map);
-		if (fr_pfn < fb_pfn)
-			fr_pfn = memory_bm_next_pfn(free_pages_map);
-	} while (fb_pfn != fr_pfn);
-
-	if (fr_pfn != BM_END_OF_MAP && pfn_valid(fr_pfn)) {
-		struct page *page = pfn_to_page(fr_pfn);
-
-		memory_bm_clear_current(forbidden_pages_map);
-		memory_bm_clear_current(free_pages_map);
-		__free_page(page);
-		goto loop;
+	for ( ; ; ) {
+		pfn  = memory_bm_next_pfn(forbidden_pages_map);
+		if (BM_END_OF_MAP == pfn)
+			break;
+		if (memory_bm_test_bit(free_pages_map, pfn)) {
+			memory_bm_clear_bit(forbidden_pages_map, pfn);
+			memory_bm_clear_bit(free_pages_map, pfn);
+			__free_page(pfn_to_page(pfn));
+		}
 	}
 
 out:
-- 
1.7.9.5

describe it in details.
As pavel said, 5ms is not important in the normal booting system.
but mili seconds is important in the hibernation or snapshot system.
Just suggestion.

Thank you.

------------------
On Thursday, March 19, 2015 05:28:58 PM Tom Yeon wrote:
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

This changelog in total pants, sorry.

Please write what the patch is doing and why instead of describing
your testing experience.  The numbers are useful too, but only to
show what the gain is, and you need to explain what is changing and
why.

> Signed-off-by: Tom(JeHyeon) Yeon <tom.yeon@windriver.com>
> ---
>  kernel/power/snapshot.c |   43 ++++++++++---------------------------------
>  1 file changed, 10 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index c24d5a2..a1ad801 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -726,14 +726,6 @@ static void memory_bm_clear_bit(struct memory_bitmap *bm, unsigned long pfn)
>       clear_bit(bit, addr);
>  }
>
> -static void memory_bm_clear_current(struct memory_bitmap *bm)
> -{
> -     int bit;
> -
> -     bit = max(bm->cur.node_bit - 1, 0);
> -     clear_bit(bit, bm->cur.node->data);
> -}
> -
>  static int memory_bm_test_bit(struct memory_bitmap *bm, unsigned long pfn)
>  {
>       void *addr;
> @@ -1342,36 +1334,21 @@ static struct memory_bitmap copy_bm;
>
>  void swsusp_free(void)
>  {
> -     unsigned long fb_pfn, fr_pfn;
> +     unsigned long pfn;
>
>       if (!forbidden_pages_map || !free_pages_map)
>               goto out;
>
>       memory_bm_position_reset(forbidden_pages_map);
> -     memory_bm_position_reset(free_pages_map);
> -
> -loop:
> -     fr_pfn = memory_bm_next_pfn(free_pages_map);
> -     fb_pfn = memory_bm_next_pfn(forbidden_pages_map);
> -
> -     /*
> -      * Find the next bit set in both bitmaps. This is guaranteed to
> -      * terminate when fb_pfn == fr_pfn == BM_END_OF_MAP.
> -      */
> -     do {
> -             if (fb_pfn < fr_pfn)
> -                     fb_pfn = memory_bm_next_pfn(forbidden_pages_map);
> -             if (fr_pfn < fb_pfn)
> -                     fr_pfn = memory_bm_next_pfn(free_pages_map);
> -     } while (fb_pfn != fr_pfn);
> -
> -     if (fr_pfn != BM_END_OF_MAP && pfn_valid(fr_pfn)) {
> -             struct page *page = pfn_to_page(fr_pfn);
> -
> -             memory_bm_clear_current(forbidden_pages_map);
> -             memory_bm_clear_current(free_pages_map);
> -             __free_page(page);
> -             goto loop;
> +     for ( ; ; ) {
> +             pfn  = memory_bm_next_pfn(forbidden_pages_map);
> +             if (BM_END_OF_MAP == pfn)
> +                     break;
> +             if (memory_bm_test_bit(free_pages_map, pfn)) {

So why exactly isn't it necessary to look at memory_bm_next_pfn(forbidden_pages_map)?

> +                     memory_bm_clear_bit(forbidden_pages_map, pfn);
> +                     memory_bm_clear_bit(free_pages_map, pfn);
> +                     __free_page(pfn_to_page(pfn));
> +             }
>       }
>
>  out:
>

--
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
