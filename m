Return-Path: <SRS0=E4ep=C7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB52C4363D
	for <linux-pm@archiver.kernel.org>; Tue, 22 Sep 2020 15:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22A92399A
	for <linux-pm@archiver.kernel.org>; Tue, 22 Sep 2020 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600789718;
	bh=WuKYvrXzJSrFn07ufkE7deWZENOY64aF3aiWnR72Kb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x9zLUIkwWo/MgTHHHbJIX72f+xtIl/s9z94T2n9vWVnJ9iKD9finAVB4pV5k9kiDB
	 qTEhuOmktDR72MLuPu7xRSCymGOzyaw+Ldaxg4e6MqV1hxlXWbiosKTFCI4+C8Ilik
	 +MvgA2TJqx5jMvZ6uIh7R+uv6Sd4146kHtO6W0Hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIVPsi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Sep 2020 11:48:38 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39777 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIVPsi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 11:48:38 -0400
Received: by mail-oi1-f195.google.com with SMTP id c13so21529823oiy.6;
        Tue, 22 Sep 2020 08:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Lkyw6K4mV5Y9N5eOKNLOPXKcrnx+bU2Daos8PJksvo=;
        b=j2u7v2FbnwDflMk6eSaIuNv3FRyqOt2pFUwoOzNvQsKXGojEOwdQ6GEbZhLwFH1C9h
         lsw+jwc4OWDLlrZ4CjfBodLfL26HD4xQ4BHyem8VUQueGMIO+KGdUEm0rcdt6imdK/Hu
         TO/rV6L5OH3jVVArkC96xdGD2fdYCSWeGWL+H3kjSeQ0bfiJJ7AINqkGn2YNBthooXkM
         z5LxEp9uMU1CYRKNfPPCSaXOlSQm4k0NAgD4EwBFfV253AZRejlNYToFxP4LMiiIYC8N
         O3XJ+ZrYrO8X0Ge+Z7FJDQRCqmFJjBez9PfryoVHLs8zt1NJtTSxCoVEw8YqtoUCtGK8
         W8Xw==
X-Gm-Message-State: AOAM533JrJkAVNhy3cjMsRGEGrxADsaUA3Fy58KCheQZvRVOJl4sQaDf
        w4wWCAUjL2J//dDKTeRMphP6tLM/3BIfW8V7GAQ=
X-Google-Smtp-Source: ABdhPJyyb74MqXqM/L4v+TsjroaR502YIu9Saxz+evAEAqRpZ7pN8+e2GMKQNv6/ALjD0JqyAUXKJsdF1IWhtplVmi0=
X-Received: by 2002:aca:df84:: with SMTP id w126mr3170800oig.103.1600789717353;
 Tue, 22 Sep 2020 08:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200817224109.11040-1-kim.phillips@amd.com>
In-Reply-To: <20200817224109.11040-1-kim.phillips@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Sep 2020 17:48:26 +0200
Message-ID: <CAJZ5v0iwuSQ9RadMTVTdcbN8ecRzLT_vmfwsEMh0jZKpE+8v2Q@mail.gmail.com>
Subject: Re: [PATCH] powercap: Add AMD Fam19h RAPL support
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Victor Ding <victording@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 18, 2020 at 12:41 AM Kim Phillips <kim.phillips@amd.com> wrote:
>
> AMD Family 19h's RAPL MSRs are identical to Family 17h's.  Extend
> Family 17h's support to Family 19h.
>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Victor Ding <victording@google.com>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: x86@kernel.org
> ---
> Depends on Victor Ding's "powercap: Enable RAPL for AMD Fam17h"
> series, submitted here:
>
> https://lore.kernel.org/lkml/20200729105206.2991064-1-victording@google.com/

So I'm deferring this one, because the submitter of the above was
requested to resend the series.

>  drivers/powercap/intel_rapl_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 2e311f9c0d85..1bc0e67cd7a4 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1052,6 +1052,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(XEON_PHI_KNM,        &rapl_defaults_hsw_server),
>
>         X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_core),
> +       X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_core),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
> --
> 2.27.0
>
