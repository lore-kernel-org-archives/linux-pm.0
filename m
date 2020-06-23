Return-Path: <SRS0=QwoY=AE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D3AC433E0
	for <linux-pm@archiver.kernel.org>; Tue, 23 Jun 2020 16:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868B02073E
	for <linux-pm@archiver.kernel.org>; Tue, 23 Jun 2020 16:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbgFWQfv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:35:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43978 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbgFWQfu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 12:35:50 -0400
Received: from 89-64-86-94.dynamic.chello.pl (89.64.86.94) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id cfb7520a50996e14; Tue, 23 Jun 2020 18:35:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     lenb@kernel.org, viresh.kumar@linaro.org, dsmythies@telus.net,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add additional OOB enabling bit
Date:   Tue, 23 Jun 2020 18:35:48 +0200
Message-ID: <1776411.KcV3dxTrbR@kreacher>
In-Reply-To: <20200612180957.1018235-1-srinivas.pandruvada@linux.intel.com>
References: <20200612180957.1018235-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, June 12, 2020 8:09:57 PM CEST Srinivas Pandruvada wrote:
> Add additional bit for OOB (Out of band) enabling of P-states. In this
> case intel_pstate shouldn't load. Currently, only "BIT(8) == 1" of the
> MSR MSR_MISC_PWR_MGMT is considered as OOB. Also add "BIT(18) == 1" as
> OOB condition.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2
>    - As suggested by Doug add OOB in debug message
>    - Atleast added local definition of OOB mask
> 
>  drivers/cpufreq/intel_pstate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8e23a698ce04..4e9bfd2509b8 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2677,6 +2677,7 @@ static struct acpi_platform_list plat_info[] __initdata = {
>  	{ } /* End */
>  };
>  
> +#define BITMASK_OOB	(BIT(8) | BIT(18))
>  static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
>  {
>  	const struct x86_cpu_id *id;
> @@ -2686,8 +2687,9 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
>  	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
>  	if (id) {
>  		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
> -		if (misc_pwr & (1 << 8)) {
> -			pr_debug("Bit 8 in the MISC_PWR_MGMT MSR set\n");
> +		if (misc_pwr & BITMASK_OOB) {
> +			pr_debug("Bit 8 or 18 in the MISC_PWR_MGMT MSR set\n");
> +			pr_debug("P states are controlled in Out of Band mode by the firmware/hardware\n");
>  			return true;
>  		}
>  	}
> 

Applied as 5.8-rc material with some edits in the subject/changelog, thanks!



