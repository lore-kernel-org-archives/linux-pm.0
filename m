From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH 1/2][RFC v3] ACPI throttling: Disable the MSR T-state if
 enabled after resumed
Date: Mon, 13 Feb 2017 10:17:55 +0800
Message-ID: <20170213021755.GA22608@yu-desktop-1.sh.intel.com>
References: <cover.1486483294.git.yu.c.chen@intel.com>
 <1fd9d91c7cbdd314ebb6e65264f57f430dfb89ca.1486483294.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:8892 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbdBMCS0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Feb 2017 21:18:26 -0500
Content-Disposition: inline
In-Reply-To: <1fd9d91c7cbdd314ebb6e65264f57f430dfb89ca.1486483294.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: inux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Feb 08, 2017 at 12:23:16AM +0800, Chen Yu wrote:
> Previously a bug was reported that on certain Broadwell
> platform, after resumed from S3, the CPU is running at
> an anomalously low speed, due to the BIOS has enabled the
> MSR throttling across S3. The solution to this was to introduce
> a quirk framework to save/restore tstate MSR register around
> suspend/resume, in Commit 7a9c2dd08ead ("x86/pm:
> Introduce quirk framework to save/restore extra MSR
> registers around suspend/resume").
> 
> There are three problems here:
> 1. More and more reports show that other platforms also
>    encountered the same issue, so the quirk list might
>    be endless.
> 2. Each CPUs should take the save/restore operation into
>    consideration, rather than the nonboot CPU alone.
> 3. Normally ACPI T-state re-evaluation is done on resume,
>    however there is no _TSS on the bogus platform, thus
>    above re-evaluation code does not run on that machine.
> 
> Solution:
> This patch is based on the fact that, we generally should not
> expect the system to come back from resume with throttling
> enabled, but leverage the OS components to deal with it,
> such as thermal event. So we simply clear the MSR T-state
> and print the warning if it is found to be enabled after
> resumed back.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=90041
> Reported-by: Kadir <kadir@colakoglu.nl>
> Suggested-by: Len Brown <lenb@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
Please ignore this patch for now, need to do more test on this.

Thanks,
Yu
