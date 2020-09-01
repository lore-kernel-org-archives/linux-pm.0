Return-Path: <SRS0=Ebod=CK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14825C43461
	for <linux-pm@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8342064B
	for <linux-pm@archiver.kernel.org>; Tue,  1 Sep 2020 15:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIAPsx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:48:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:48835 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732026AbgIAPsr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 11:48:47 -0400
IronPort-SDR: 7QyqeeF9PM8wiY4HvqH2v3fHnxlbiaK3QiGJ2wD/VKSicHCMo6irY3puck9y5Qt/bz7rmogtv6
 WPSjra3DNLDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="154702982"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="154702982"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 08:48:46 -0700
IronPort-SDR: 8FH0UfrrBXWxXyHdkkgUvalC6wpGa30rtJ7PUnZz7KP6UWjgXz/5za2vL7d9j7WQ0Tjo4LFVn/
 epdAqIaO1aRA==
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="477249681"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.229.52])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 08:48:46 -0700
Message-ID: <81b98c58eab0bf075d9ded2154a7a88020628c80.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix intel_pstate_get_hwp_max()
 for turbo disabled cases.
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Francisco Jerez <currojerez@riseup.net>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Caleb Callaway <caleb.callaway@intel.com>
Date:   Tue, 01 Sep 2020 08:48:45 -0700
In-Reply-To: <20200901030250.495928-1-currojerez@riseup.net>
References: <20200901030250.495928-1-currojerez@riseup.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-08-31 at 20:02 -0700, Francisco Jerez wrote:
> This fixes the behavior of the scaling_max_freq and scaling_min_freq
> sysfs files in systems which had turbo disabled by the BIOS.
> 
> Caleb noticed that the HWP is programmed to operate in the wrong
> P-state range on his system when the CPUFREQ policy min/max frequency
> is set via sysfs.  This seems to be because in his system
> intel_pstate_get_hwp_max() is returning the maximum turbo P-state
> even
> though turbo was disabled by the BIOS, which causes intel_pstate to
> scale kHz frequencies incorrectly e.g. setting the maximum turbo
> frequency whenever the maximum guaranteed frequency is requested via
> sysfs.

When  turbo is disabled via MSR_IA32_MISC_ENABLE_TURBO_DISABLE (From
BIOS), then no matter what we write to HWP. max, the hardware will clip
to HWP_GUARANTEED_PERF.

But it looks like this is some issue on properly disabling turbo from
BIOS, since you observe turbo frequencies (via aperf, mperf) not just
sysfs display issue.



> 
> Tested-by: Caleb Callaway <caleb.callaway@intel.com>
> Signed-off-by: Francisco Jerez <currojerez@riseup.net>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index e0220a6fbc69..7eb7b62bd5c4 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -825,7 +825,7 @@ static void intel_pstate_get_hwp_max(unsigned int
> cpu, int *phy_max,
>  
>  	rdmsrl_on_cpu(cpu, MSR_HWP_CAPABILITIES, &cap);
>  	WRITE_ONCE(all_cpu_data[cpu]->hwp_cap_cached, cap);
> -	if (global.no_turbo)
> +	if (global.no_turbo || global.turbo_disabled)
>  		*current_max = HWP_GUARANTEED_PERF(cap);
>  	else
>  		*current_max = HWP_HIGHEST_PERF(cap);

