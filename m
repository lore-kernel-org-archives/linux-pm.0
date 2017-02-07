From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH 1/2][RFC v3] ACPI throttling: Disable the MSR T-state if
 enabled after resumed
Date: Wed, 8 Feb 2017 00:55:20 +0800
Message-ID: <20170207165520.GA2505@chenyu-MacBookPro>
References: <cover.1486483294.git.yu.c.chen@intel.com>
 <1fd9d91c7cbdd314ebb6e65264f57f430dfb89ca.1486483294.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:7799 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754217AbdBGQzX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Feb 2017 11:55:23 -0500
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
[cut] 
> +
> +static void throttling_msr_reevaluate(int cpu)
> +{
> +	return -1;
Oops, I made a mistake, should not return any value here.
But please help check if this draft is in the right direction? thanks very much.

Yu
