Return-Path: <SRS0=sttx=DX=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942C3C433DF
	for <linux-pm@archiver.kernel.org>; Fri, 16 Oct 2020 14:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBAA20866
	for <linux-pm@archiver.kernel.org>; Fri, 16 Oct 2020 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602860310;
	bh=7n1rV6DjaAtKKZQE/xdeCojIwGYW+0b3qCLVTAPWODw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K28OVzFNMH7dRw/BVBj+ip5Im0Cqvo0yuKhs0bSkACWyG63nZjSPktEWqoI50deg6
	 zn+fH7Ylat9P0grdZyBU+MkTs7D2BDeuEQ+JGgT5imgpy6qZPScguZwRFbpoQr2yFY
	 ogD7If77BjBwbjaSFlOJXS2pn2q3UXtocQrHzdiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409664AbgJPO63 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 16 Oct 2020 10:58:29 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44997 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406936AbgJPO62 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 10:58:28 -0400
Received: by mail-oi1-f195.google.com with SMTP id x62so2709913oix.11;
        Fri, 16 Oct 2020 07:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52P5CCJjU8JsAThqwGL00Sl+HuNSijfO2WktQIA1FOs=;
        b=IG0K1MpKSGCk/zT4pCMftJ00p4OPEHdkOURfhNc2VgzoxVErFKKBu2feIaOYrET2So
         6wyW9hsW7iOBNDtSG0hZ2aZBcjKT3LF9M23t7tRsFUmdbxBXPQX/cldOoWCBaVygFC/J
         h/eKqIHTNtiC37hJM7gL3pSIxOAOhe0OIzJbZOzDCQS482CRVoLS/v1ch8E+YcahY2Fl
         khh8QvnyCbEfX6Lv0fA2wd3JSpaR4wO3lK+BMnEKkxtfyv91Ab2/O94gtL9nkokmOgFy
         ML6vrbROKRLL9UKamtZ15dSSlihg+++h/18/DUHE2aTim/vVMu0sGh+9Vrmu3FAg6tGq
         DeBA==
X-Gm-Message-State: AOAM531jNubtIXZcrmdHgRuUiDs5w82DbQxRV0+j0GKnXxdTbibLc/gc
        KDeeVWJkPYclxWfRwuMkDbked9xoUSFxvinpY2K8UCad1sw=
X-Google-Smtp-Source: ABdhPJxaMtnROJv3PeilVQTvDW44CTUxxjySJO7c/W2UuOqMb0BR9xN7ZNrPgqHoNZyDhDVDXN4KZHcpyjCfw6DxCaQ=
X-Received: by 2002:aca:724a:: with SMTP id p71mr2747907oic.157.1602860307729;
 Fri, 16 Oct 2020 07:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201007204412.565881-1-wei.huang2@amd.com>
In-Reply-To: <20201007204412.565881-1-wei.huang2@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 16:58:16 +0200
Message-ID: <CAJZ5v0g3fzSHOjKhaF0Nof=81MkX_GF7A6NL8-=5gQgQVtkY+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi-cpufreq: Honor _PSD table setting in CPU
 frequency control
To:     Wei Huang <wei.huang2@amd.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 7, 2020 at 10:44 PM Wei Huang <wei.huang2@amd.com> wrote:
>
> acpi-cpufreq has a old quirk that overrides the _PSD table supplied by
> BIOS on AMD CPUs. However the _PSD table of new AMD CPUs (Family 19h+)
> now accurately reports the P-state dependency of CPU cores. Hence this
> quirk needs to be fixed in order to support new CPUs' frequency control.
>
> Fixes: acd316248205 ("acpi-cpufreq: Add quirk to disable _PSD usage on all AMD CPUs")
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index e4ff681faaaa..1e6e2abde428 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -691,7 +691,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                 cpumask_copy(policy->cpus, topology_core_cpumask(cpu));
>         }
>
> -       if (check_amd_hwpstate_cpu(cpu) && !acpi_pstate_strict) {
> +       if (check_amd_hwpstate_cpu(cpu) && (c->x86 < 0x19) &&

Why don't you use boot_cpu_data instead of *c?

And why don't you do the extra check in check_amd_hwpstate_cpu()?

Also the parens around it are not necessary here and is there any
chance for having a proper symbol instead of the raw 0x19 in that
check?

> +           !acpi_pstate_strict) {
>                 cpumask_clear(policy->cpus);
>                 cpumask_set_cpu(cpu, policy->cpus);
>                 cpumask_copy(data->freqdomain_cpus,
> --
> 2.26.2
>
