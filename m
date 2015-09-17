From: Pavel Machek <pavel@ucw.cz>
Subject: turn panic into data corruption, dangerous patch was Re: [PATCH]
 [v3] PM / hibernate: Fix hibernation panic caused by inconsistent e820 map
Date: Thu, 17 Sep 2015 07:45:48 +0200
Message-ID: <20150917054548.GD6665@amd>
References: <1441195588-31175-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54687 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbbIQFp4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 01:45:56 -0400
Content-Disposition: inline
In-Reply-To: <1441195588-31175-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, mingo@redhat.com, joeyli.kernel@gmail.com, yinghai@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed 2015-09-02 20:06:28, Chen Yu wrote:
> On some platforms, there is occasional panic triggered when trying to
> resume from hibernation, a typical panic looks like:
> 
> BUG: unable to handle kernel paging request at ffff880085894000
> IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70
> 
> This is because e820 map has been changed by BIOS before/after
> hibernation, and one of the page frames from first kernel
> is right located in second kernel's unmapped region, so panic
> comes out when accessing unmapped kernel address.

> After this patch applied, the panic will be replaced with the warning:

and with data corruption.

> PM: Loading and decompressing image data (96092 pages)...
> PM: Image loading progress:   0%
> PM: Image loading progress:  10%
> PM: Image loading progress:  20%
> PM: Image loading progress:  30%
> PM: Image loading progress:  40%
> PM:  0x849dd000 to restored not in valid memory region
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> 
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

"Just warns of invalid pages". Do you want to say that you "just cause
data corruption"?

If you don't have enough memory, YOU DON'T RESTORE. Disks were synced,
so not restoring is safe. Running with memory corruption is NOT.

> +	if (!swsusp_page_is_valid(pfn_to_page(pfn))) {
> +		pr_err(
> +			"PM:  %#010llx to restored not in valid memory region\n",
> +			(unsigned long long) pfn << PAGE_SHIFT);

And you'd need to fix english here in any case.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
