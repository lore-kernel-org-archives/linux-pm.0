From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: powernv: Add boost files to export
 ultra-turbo frequencies
Date: Tue, 3 Jan 2017 16:38:59 +0530
Message-ID: <20170103110859.GB14137@vireshk-i7>
References: <1483441560-11957-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35557 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934854AbdACLJD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2017 06:09:03 -0500
Received: by mail-pg0-f48.google.com with SMTP id i5so149119712pgh.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2017 03:09:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1483441560-11957-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, svaidy@linux.vnet.ibm.com

On 03-01-17, 16:36, Shilpasri G Bhat wrote:
> In P8+, Workload Optimized Frequency(WOF) provides the capability to
> boost the cpu frequency based on the utilization of the other cpus
> running in the chip. The On-Chip-Controller(OCC) firmware will control
> the achievability of these frequencies depending on the power headroom
> available in the chip. Currently the ultra-turbo frequencies provided
> by this feature are exported along with the turbo and sub-turbo
> frequencies as scaling_available_frequencies. This patch will export
> the ultra-turbo frequencies separately as scaling_boost_frequencies in
> WOF enabled systems. This patch will add the boost sysfs file which
> can be used to disable/enable ultra-turbo frequencies.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> Changes from v1:
> - Print if WOF is enabled
> - s/clean_notifiers/cleanup_notifiers
> 
>  drivers/cpufreq/powernv-cpufreq.c | 50 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
