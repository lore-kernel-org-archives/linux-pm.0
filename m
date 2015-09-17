From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [v4] PM / hibernate: Fix hibernation panic caused by
 inconsistent e820 map
Date: Thu, 17 Sep 2015 08:07:35 +0200
Message-ID: <20150917060735.GF6665@amd>
References: <1442425343-8339-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54978 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbbIQGHk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 02:07:40 -0400
Content-Disposition: inline
In-Reply-To: <1442425343-8339-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zhang@intel.com, jlee@suse.com, joeyli.kernel@gmail.com, yinghai@kernel.org

> v3:
>  - Adjust the logic to exclude the end_pfn boundary in pfn_mapped
>    when invoking mark_valid_pages, because the end_pfn is not
>    a mapped page frame, we should not regard it as a valid page.
> 
>    Move the sanity check of valid pages to a early stage in resuming
>    process(moved to mark_unsafe_pages), in this way, we can avoid
>    unnecessarily accessing these invalid pages in later stage(yes,
>    move to the original position Joey once introduced in:
>    Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820
>    reserved regions")
> 
>    With v3 patch applied, I did 30 cycles on my problematic platform,
>    no panic triggered anymore(50% reproducible before patched, by
>    plugging/unplugging memory peripheral during hibernation), and it
>    just warns of invalid pages.

NAK. Turning panic into data corruption is a bad idea.

> +	if (!swsusp_page_is_valid(pfn_to_page(pfn))) {
> +		pr_err(
> +		"PM: Hibernation failed, address %#010llx to restored not valid!\n",
> +			(unsigned long long) pfn << PAGE_SHIFT);

...and still bad english.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
