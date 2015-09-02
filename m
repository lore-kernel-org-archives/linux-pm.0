From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v2] PM / hibernate: Fix hibernation panic caused by
 inconsistent e820 map
Date: Wed, 2 Sep 2015 08:24:25 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6401CB03D29@SHSMSX101.ccr.corp.intel.com>
References: <1441101816-24567-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21436 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbbIBIYb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 04:24:31 -0400
In-Reply-To: <1441101816-24567-1-git-send-email-yu.c.chen@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "yinghai@kernel.org" <yinghai@kernel.org>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, all,
I'll do some small modifications on this patch and will
send out a v3 version later. Because:
1.some boudary conditions need to be adjusted and 
2.the page frame  validation code will be moved to the
place where  Joey once put in his patch(which would 
look more reasonable)
Please refer to detail below:
Thanks!
:
> -----Original Message-----
> From: Chen, Yu C
> Sent: Tuesday, September 01, 2015 6:04 PM
> To: rjw@rjwysocki.net; Brown, Len; pavel@ucw.cz
> Cc: mingo@redhat.com; yinghai@kernel.org; joeyli.kernel@gmail.com; linux-
> pm@vger.kernel.org; linux-kernel@vger.kernel.org; Chen, Yu C
> Subject: [PATCH] [v2] PM / hibernate: Fix hibernation panic caused by
> inconsistent e820 map
> 
> +static void mark_valid_pages(struct memory_bitmap *bm) {
> +	unsigned long start_pfn, end_pfn;
> +	int i, j;
> +
> +	for (i = 0; i < nr_pfn_mapped; i++) {
> +		start_pfn = pfn_mapped[i].start;
> +		end_pfn = pfn_mapped[i].end;
> +		for (j = start_pfn; j <= end_pfn; j++)

Changed j <= end_pfn to j < end_pfn

> -2427,11 +2526,19 @@ static void *get_buffer(struct memory_bitmap *bm,
> -	if (swsusp_page_is_forbidden(page) &&
> swsusp_page_is_free(page))
> +	if (swsusp_page_is_forbidden(page) &&
> swsusp_page_is_free(page)) {
> -		return page_address(page);
> +		if (is_valid_orig_page(pfn))
Moved to mark_unsafe_pages
> +			return page_address(page);
> +		else
> +			return ERR_PTR(-EFAULT);
> +	}


Best Regards,
Yu
