Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48117ECAAD1
	for <linux-pm@archiver.kernel.org>; Wed, 31 Aug 2022 19:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiHaTIC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiHaTIB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2022 15:08:01 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B95CE4AA;
        Wed, 31 Aug 2022 12:07:59 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3413ad0640dso160937147b3.13;
        Wed, 31 Aug 2022 12:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ECApI1mXwTphgXDXF1CXlcGlLXFAydIzvSTDA98xmCw=;
        b=uNRgp6qmaMBw8qrR7HRo/LuFWWwsJnoaIluoyUumNMiztsp6BoikIo0sCRTNbKAZwg
         zZHKdFbDKdgkt7hnOb1LUT6CE7XTr1i1iZRmUPbuEvfm3fIlWAOm1TUqhqA5EGBBn6aP
         2g5ys/rkvCVtXe955ejgmXdw6vg3rcpSj9n1yX1eyOo6a3aBwdaqUxSCcbPK6TGSy9T2
         pE/unVx2zaAAH+ee75NtELkm31+bMWSHKW8dfHnr2cUXPwaEi2YloawbKcti8X9MYL8W
         Y/PsvHfSueG2JwXzCRABOdaBuLUxdgW98NIBXti80H9B3pyYWIbpJrooQnVEM+FuLCOV
         bKsQ==
X-Gm-Message-State: ACgBeo2tyTgbTM2IsPTpWrRwDoXSwLn7jSTQlQHpkiNDK1DIfYwuQaoC
        h6kQg1+wSFg77drsGi1/2cLoI1Gmvj2IIyfncbQ=
X-Google-Smtp-Source: AA6agR67JqE3CxLVd+PFYqgQBQ6xB7RJPopj/VD+bnO12bFvde7dhwCgDJngMFO4xdK2MCydDfG/quFxeHl2XmmXiJM=
X-Received: by 2002:a0d:cdc2:0:b0:335:debd:2b3d with SMTP id
 p185-20020a0dcdc2000000b00335debd2b3dmr18965515ywd.19.1661972879024; Wed, 31
 Aug 2022 12:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220814163548.326686-1-Perry.Yuan@amd.com> <20220814163548.326686-4-Perry.Yuan@amd.com>
In-Reply-To: <20220814163548.326686-4-Perry.Yuan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 31 Aug 2022 21:07:48 +0200
Message-ID: <CAJZ5v0iNr_C_aGHtFZ-t-pT8jrVpcQWuvA1VFyhiw39SJf9WMQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] cpufreq: amd-pstate: fix white-space
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Deepak Sharma <Deepak.Sharma@amd.com>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, Shimmer.Huang@amd.com,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Aug 14, 2022 at 6:49 PM Perry Yuan <Perry.Yuan@amd.com> wrote:
>
> Remove the white space and correct mixed-up indentation
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index b31bb5e6cefc..5cdef6638681 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -115,7 +115,7 @@ struct amd_cpudata {
>         struct amd_aperf_mperf cur;
>         struct amd_aperf_mperf prev;
>
> -       u64 freq;
> +       u64     freq;
>         bool    boost_supported;
>  };
>
> @@ -651,7 +651,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>         .resume         = amd_pstate_cpu_resume,
>         .set_boost      = amd_pstate_set_boost,
>         .name           = "amd-pstate",
> -       .attr           = amd_pstate_attr,
> +       .attr           = amd_pstate_attr,
>  };
>
>  static int __init amd_pstate_init(void)
> --

Applied as 6.1 material along with patches [3-6/7].

The [7/7] was applied earlier and there was a change request for patch [1/7].
