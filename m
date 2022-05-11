Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F307C433EF
	for <linux-pm@archiver.kernel.org>; Wed, 11 May 2022 17:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244095AbiEKRTA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 11 May 2022 13:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345413AbiEKRS6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 May 2022 13:18:58 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069C319CB74;
        Wed, 11 May 2022 10:18:57 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2f7ca2ce255so29020937b3.7;
        Wed, 11 May 2022 10:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IznQYPJ44n5aKvSC9fpTkKkn7z/3b/M/dwJg0jZxqw=;
        b=UZoSH7U1ZU4IJswwvMlV2yHvBOtMb9kMDhSMB+fHcNQn+CI+MhkoNRnA1mVdfv9ABk
         DWJKfRHT66asvGVFP1NkJ8+FqF3ng0tOVeH+h8M8oNkSnYlcsaeHDII+F4OL9RAKVDJo
         qlakjP76g26sMmQlh7wi8Qv6yCbpbDbdFZBJN7SAPvotYUmjG4+gEYEpnqelX5e0wXJN
         17pa9Hs5Yz5lMcMDUAF2DBne1MNFijZejntR+sIs7lHzA9paciFlU5qyk+tpvUa27c3+
         qeFW/Dmq8iHMvwokuQ1Tix+Dbr8GFBYk0bRNLLNttZ+EjtUYUbGD6vQ5VNYzIbqPqW4Y
         dpxw==
X-Gm-Message-State: AOAM530LoYBoWSrjpIb5PNCs8dJUWoe94U8qjVscj5VFBI416bAUCcsy
        og9IyPTwJcArPXbtVzjldqrb5oHATdMUaYyx+Sc=
X-Google-Smtp-Source: ABdhPJzUy92OlQ44g7Aet0Kzhsu/S503joAemeA2YFFg0+m09LtO13jWRSTPjhINJs/E1oMPFNJvuhTiv0OPDL2K1Rg=
X-Received: by 2002:a81:2f4e:0:b0:2fb:2c97:d66f with SMTP id
 v75-20020a812f4e000000b002fb2c97d66fmr26882271ywv.196.1652289536285; Wed, 11
 May 2022 10:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220502205052.1257462-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20220502205052.1257462-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 19:18:45 +0200
Message-ID: <CAJZ5v0htY-7yc6dbtabnRLWkegiJy3OGg9jfXCk=LVbsD+LKgw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Support Sapphire Rapids OOB mode
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 2, 2022 at 10:50 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Prevent intel_pstate to load when OOB (Out Of Band) P-states mode is
> enabled in Sapphire Rapids. The OOB identifying bits are same as the
> prior generation CPUs like Ice Lake servers. So, also add Sapphire
> Rapids to intel_pstate_cpu_oob_ids list.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 846bb3a78788..76d59b3f35e4 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2424,6 +2424,7 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
>         X86_MATCH(BROADWELL_X,          core_funcs),
>         X86_MATCH(SKYLAKE_X,            core_funcs),
>         X86_MATCH(ICELAKE_X,            core_funcs),
> +       X86_MATCH(SAPPHIRERAPIDS_X,     core_funcs),
>         {}
>  };
>
> --

Applied as 5.19 material, thanks!
