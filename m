From: joeyli <jlee@suse.com>
Subject: Re: [RFC PATCH] PM / hibernate: make sure each resuming page is in
 current memory zones
Date: Thu, 2 Jul 2015 14:19:35 +0800
Message-ID: <20150702061935.GA19010@linux-rxt1.site>
References: <1435679668-13806-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:40394 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbbGBGTz (ORCPT
	<rfc822;groupwise-linux-pm@vger.kernel.org:0:0>);
	Thu, 2 Jul 2015 02:19:55 -0400
Content-Disposition: inline
In-Reply-To: <1435679668-13806-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rui.zhang@intel.com, len.brown@intel.com, aaron.lu@intel.com

Hi Chen Yu, 

On Tue, Jun 30, 2015 at 11:54:28PM +0800, Chen Yu wrote:
> Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820 reserved
> regions") was reverted, because this patch makes resume from hibernation
> on Lenovo x230 unreliable. But reverting may bring back the kernel
> exception firstly reported in former patch. In general, there are three
> problems in current code when resuming from hibernation:
> 
> 1.Resuming page may also be in second kernel's e820 reserved region.
> BIOS-e820: [mem 0x0000000069d4f000-0x0000000069e12fff] reserved
> this causes kernel exception described in Commit 84c91b7ae07c
> ("PM / hibernate: avoid unsafe pages in e820 reserved regions")
> 
> 2.If Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820
> reserved regions") is applied to fix problem 1, and if E820_RESERVED_KERN
> regions causes some regions at e820 table not page aligned,
> e820_mark_nosave_regions will misjudgment the non-page aligned space to
> be "hole" space and add to nosave regions, this causes resuming failed.
> Refer to https://bugzilla.kernel.org/show_bug.cgi?id=96111 for detail.
> 

Sorry for I am not fully understand why checking pfn_valid could avoid
the above 2. issue?

Per my understood should waiting Yinghai Lu's patches for killing
E820_RESERVED_KERN to avoid the aligned problem.


Thanks a lot!
Joey Lee
