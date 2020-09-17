Return-Path: <SRS0=qROV=C2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE42C433E2
	for <linux-pm@archiver.kernel.org>; Thu, 17 Sep 2020 08:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D88821973
	for <linux-pm@archiver.kernel.org>; Thu, 17 Sep 2020 08:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FBQFyK3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIQIxh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:53:37 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6209 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQIxh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 04:53:37 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6320570002>; Thu, 17 Sep 2020 01:37:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 01:38:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 17 Sep 2020 01:38:27 -0700
Received: from [10.26.74.242] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 08:38:24 +0000
Subject: Re: [Patch 2/2] cpufreq: tegra194: Fix unlisted boot freq warning
To:     Sumit Gupta <sumitg@nvidia.com>, <viresh.kumar@linaro.org>,
        <rjw@rjwysocki.net>, <thierry.reding@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <bbasu@nvidia.com>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
 <1600276277-7290-3-git-send-email-sumitg@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <53d4513d-0232-0287-9610-3e9ed8888273@nvidia.com>
Date:   Thu, 17 Sep 2020 09:38:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1600276277-7290-3-git-send-email-sumitg@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600331863; bh=MA+kzDOpgaIasV/XTrUbK7Y5E/jn4WxvrvnA0rc5sJY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FBQFyK3BmMYcCS+AMC+d6rzOHscx6Cx871gJjyu9gktzGPEPSHBN1E0NPmUV+xws9
         JSsI34zBL1Zmcm6ouTAxhmm09wIiTwC6/beMhPgu2LMg/kz4/POeY10s91TozWXHq5
         R3gqmP2BWPtNSSY7YV0hTih6RsbIHeyQgTSdeDAnTRG9naAzgOwzjeFY3SmihwL6nw
         T/jtEReI2WHmixMSfuQXyuCDTpYh4zYZNN/GUOAFRU6geHQCJJ8mm9C/FqTH+XQvmv
         blS7uo2czX2lh4LIeA8ARFN8+P/bLBO6sKHRgt0iokxCFOh2D9X4zWASTFnkTVOBMv
         V/Jm7tkOWJ6NQ==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 16/09/2020 18:11, Sumit Gupta wrote:
> Warning coming during boot because the boot freq set by bootloader
> gets filtered out due to big freq steps while creating freq_table.
> Fixing this by setting closest ndiv value from freq_table.
> Warning:
>   cpufreq: cpufreq_online: CPU0: Running at unlisted freq
>   cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed
> 
> Also, added change in init to wait till current frequency becomes
> equal or near to the previously requested frequency. This is done
> because it takes some time to restore the previous frequency while
> turning-on non-boot cores during exit from SC7(Suspend-to-RAM).

Same here ...

Fixes: df320f89359c ("cpufreq: Add Tegra194 cpufreq driver")

> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Viresh, this is also needed for v5.9.

Thanks
Jon

-- 
nvpublic
