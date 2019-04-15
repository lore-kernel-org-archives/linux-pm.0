Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9571CC10F13
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 02:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6406C206B6
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 02:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfDOCAd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 14 Apr 2019 22:00:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:43492 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfDOCAd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 14 Apr 2019 22:00:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Apr 2019 19:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,351,1549958400"; 
   d="scan'208";a="135814294"
Received: from spandruv-mobl3.jf.intel.com ([10.251.156.198])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2019 19:00:32 -0700
Message-ID: <d1825fdb9b1c9d759bcfefa7ef80a380cd9ece78.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] x86: intel_pstate: Fix wrong definition of Disable
 Energy Efficiency Optimization bit
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Liran Alon <liran.alon@oracle.com>, linux-pm@vger.kernel.org,
        lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Date:   Sun, 14 Apr 2019 19:00:32 -0700
In-Reply-To: <20190414204831.93705-1-liran.alon@oracle.com>
References: <20190414204831.93705-1-liran.alon@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2019-04-14 at 23:48 +0300, Liran Alon wrote:
> Bit definition can be found in Intel SDM Section 2.16 MSRS IN THE 6TH
> GENERATION, 7TH GENERATION AND 8TH GENERATION
> INTEL® CORE™ PROCESSORS, INTEL® XEON® PROCESSOR SCALABLE
> FAMILY, AND FUTURE INTEL® CORE™ PROCESSORS.
> 
> Definition of all Skylake MSR_POWER_CTL bits can also be found at
> EDK2
> source at UefiCpuPkg/Include/Register/Msr/SkylakeMsr.h union
> MSR_SKYLAKE_POWER_CTL_REGISTER.
> 
> Fixes: 6e978b22efa1 ("cpufreq: intel_pstate: Disable energy
> efficiency optimization")
What are you trying to address? This bit 19 has a special meaning when
system is in HWP mode. So this is correct.

Bit 20 has a different meaning depending on legacy or in HWP mode.

Thanks,
Srinivas




> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index dd66decf2087..3ce39c332c7b 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1200,7 +1200,7 @@ static void intel_pstate_hwp_enable(struct
> cpudata *cpudata)corrrect
>  		cpudata->epp_default = intel_pstate_get_epp(cpudata,
> 0);
>  }
>  
> -#define MSR_IA32_POWER_CTL_BIT_EE	19
> +#define MSR_IA32_POWER_CTL_BIT_EE	20
>  
>  /* Disable energy efficiency optimization */
>  static void intel_pstate_disable_ee(int cpu)

