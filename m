From: tyeon <tom.yeon@windriver.com>
Subject: Re: [PATCH] PM / Hiberante : optimize swsusp_free()
Date: Wed, 15 Apr 2015 10:40:49 +0900
Message-ID: <552DC1A1.3070601@windriver.com>
References: <1426753738-26747-1-git-send-email-tom.yeon@windriver.com> <2492546.RHhDx1zacd@vostro.rjw.lan> <D2D54504A8A67848B028EBEA66F47B9AB2A28235@ALA-MBA.corp.ad.wrs.com> <1845757.HKx1NOssGd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:33947 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708AbbDOBlO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2015 21:41:14 -0400
In-Reply-To: <1845757.HKx1NOssGd@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "pavel@ucw.cz" <pavel@ucw.cz>, "jroedel@suse.de" <jroedel@suse.de>, "BROWN, A LEONARD" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Tom(JeHyeon) Yeon" <tomyeon750415lkml@gmail.com>

On Saturday, April 11, 2015 09:20 AM Rafael J. Wysocki worte:
> On Wednesday, March 25, 2015 01:49:36 AM Yeon, JeHyeon wrote:
>>  From 6cb5fffc41911a29212be52d4ce7e481f5077ccf Mon Sep 17 00:00:00 2001
>> From: "Tom(JeHyeon) Yeon" <tom.yeon@windriver.com>
>> Date: Thu, 19 Mar 2015 17:10:45 +0900
>> Subject: [PATCH] PM / Hiberante : optimize swsusp_free()
>>
>> Our team developed the snapshot booting.
>> Fisrt of all, make a snapshot image, compress it and finally save it
>> in the storage(like mmc).
>> When the system is booting next time, bootloader read it from mmc,
>> decompress it and jump to the kernel.
>> In this circumstance, mili seconds is very important.
>> So, I prepared this patch, but not applied because I missed the time
>> to apply it.
>>
>> And, I came across to find commit fdd64ed.
>> It's very similar to the patch I prepared.
>
> So the part of the changelog above this line is not really relevant.
>
> But the below is OK.
Ok, I'll get rid of the upper changelog.
>
>> I think do { ... } while (fb_pfn != fr_pfn) operation is very similar
>> to my patch. but, it takes a little more time to iterate.
>> So suggest to iterate one of two maps and check whether the other map
>> has the same pfn, finally free the page.
>>
>> Signed-off-by: Tom(JeHyeon) Yeon <tom.yeon@windriver.com>
>
> As for the patch itself ->
>
>> ---
>>   kernel/power/snapshot.c |   43 ++++++++++---------------------------------
>>   1 file changed, 10 insertions(+), 33 deletions(-)
>>
>> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
>> index c24d5a2..a1ad801 100644
>> --- a/kernel/power/snapshot.c
>> +++ b/kernel/power/snapshot.c
>> @@ -726,14 +726,6 @@ static void memory_bm_clear_bit(struct memory_bitmap *bm, unsigned long pfn)
>>   	clear_bit(bit, addr);
>>   }
>>
>> -static void memory_bm_clear_current(struct memory_bitmap *bm)
>> -{
>> -	int bit;
>> -
>> -	bit = max(bm->cur.node_bit - 1, 0);
>> -	clear_bit(bit, bm->cur.node->data);
>> -}
>> -
>>   static int memory_bm_test_bit(struct memory_bitmap *bm, unsigned long pfn)
>>   {
>>   	void *addr;
>> @@ -1342,36 +1334,21 @@ static struct memory_bitmap copy_bm;
>>
>>   void swsusp_free(void)
>>   {
>> -	unsigned long fb_pfn, fr_pfn;
>> +	unsigned long pfn;
>>
>>   	if (!forbidden_pages_map || !free_pages_map)
>>   		goto out;
>>
>>   	memory_bm_position_reset(forbidden_pages_map);
>> -	memory_bm_position_reset(free_pages_map);
>> -
>> -loop:
>> -	fr_pfn = memory_bm_next_pfn(free_pages_map);
>> -	fb_pfn = memory_bm_next_pfn(forbidden_pages_map);
>> -
>> -	/*
>> -	 * Find the next bit set in both bitmaps. This is guaranteed to
>> -	 * terminate when fb_pfn == fr_pfn == BM_END_OF_MAP.
>> -	 */
>> -	do {
>> -		if (fb_pfn < fr_pfn)
>> -			fb_pfn = memory_bm_next_pfn(forbidden_pages_map);
>> -		if (fr_pfn < fb_pfn)
>> -			fr_pfn = memory_bm_next_pfn(free_pages_map);
>> -	} while (fb_pfn != fr_pfn);
>> -
>> -	if (fr_pfn != BM_END_OF_MAP && pfn_valid(fr_pfn)) {
>> -		struct page *page = pfn_to_page(fr_pfn);
>> -
>> -		memory_bm_clear_current(forbidden_pages_map);
>> -		memory_bm_clear_current(free_pages_map);
>> -		__free_page(page);
>> -		goto loop;
>> +	for ( ; ; ) {
>> +		pfn  = memory_bm_next_pfn(forbidden_pages_map);
>> +		if (BM_END_OF_MAP == pfn)
>
> -> First, the usual way of writing such things is
>
> 		if (pfn == BM_END_OF_MAP)
>
> (ie. the variable on the left-hand side of the operator).
Is there any rules for this this in kernel?
Sometime, human makes a mistake like "if (pfn = BM_END_OF_MAP)"
that's why I wrote like that even though the compiler may notice about it.
>
> Second, don't you need to do the pfn_valid() check here too?
hmm. I can add pfn_valid() check. but I don't think that pfn_valid() 
should be checked in this stage.
I think forbidden_pages_map & free_pages_map should be always valid.
Is there any possibility those are not valid in this stage?
>
>> +			break;
>> +		if (memory_bm_test_bit(free_pages_map, pfn)) {
>> +			memory_bm_clear_bit(forbidden_pages_map, pfn);
>> +			memory_bm_clear_bit(free_pages_map, pfn);
>> +			__free_page(pfn_to_page(pfn));
>> +		}
>>   	}
>>
>>   out:
>
>

thanks.
