Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57880C10F13
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 21:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256B42173C
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 21:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555450277;
	bh=4Kqhg4YYv2NJnsDlSX1xv2++dRRH2DaJZ0KkyyNEpd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jhZlOk1yiXIJ79HY0D/Vl7tK3k/PN33fOlL7aWLa/HzgxGZK5C7svxBi/sgLMKKw2
	 1FFSQJ2asZhdym6TFyfcMqtg/PrD9sXEdLpKIi/Az++oDEZCSZrc3eup5xgEGvRoti
	 Z/euHHulYaM0pJ/du7xtWJJ0J2lP4u0eMLvRY3Y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfDPVbQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:31:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38306 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbfDPVbP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 17:31:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id e80so1635772ote.5
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2019 14:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=846ELSgOChVPtzBOSATQRwRBkEGWuT0+mailpxsYm+Y=;
        b=B/vN247Jh+XQHSswK1sTqJfsPMnhlY8InKpQ7L1Dk7iPOCY2ACBnv3SsGPrffY/9ur
         BoDP59lGWUdpzEmRqeU/ZBzwwXo4NI/zeNuaxVvuKqfVkpI0i0F6+Zvmdq6kn8BE46mL
         skrin8JvEWQZ39/oEzioSuf0+IIm/9pmdkohkIK1j+5UOe8Q0clbvQbCmEqoLLc/vk0v
         7s0xmzyfBUgBM3zEPJvNS7TXkYBTwh+IQ7oy4K2PVDJRs9ywKtqJpDTPVx/mV05zdTCi
         5Q5RtxCCQogNJMPs7ZeJUGZny3cLrQeXKHZp3oUyVVKjZkkHoGnjUxygz7JBwN2xX3qR
         P/qA==
X-Gm-Message-State: APjAAAXBU/rYr3YaWHQot+5GRW+py7HKk+AeIjWVnRlInCRtRyvcGW2k
        RuUJ677S3EORsdGZ7fCamEVooZMFGQ/Gx91+cd8=
X-Google-Smtp-Source: APXvYqxVUnAFEY38msh6Yrzgjzkob8tCSRbcnBB59/VIxq49mO2PVhvPORBor1zf8lZnK9K0/Ku/k1B9q6TjvggSp20=
X-Received: by 2002:a05:6830:1342:: with SMTP id r2mr54822669otq.105.1555450274993;
 Tue, 16 Apr 2019 14:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <36183132.7cOCK0nhyl@house>
In-Reply-To: <36183132.7cOCK0nhyl@house>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 16 Apr 2019 23:31:03 +0200
Message-ID: <CAJZ5v0j+BtpgMYZ1f-V1sZDz8RZtTB1P6=9KOiQeWBQeDyPr0A@mail.gmail.com>
Subject: Re: [PATCH] x86: Do not override performance EPB MSR value on servers
To:     Thomas Renninger <trenn@suse.de>
Cc:     Rafael Wysocki <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 8, 2019 at 10:46 AM Thomas Renninger <trenn@suse.de> wrote:
>
> It is about this kernel message showing up on quite a lot servers:
> [    0.072652] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.076003] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
>
> With this patch the EPB value is not overridden anymore on systems
> which expose themselves as appliance or enterprise server via ACPI
> perferred profile variable.
>
> Signed-off-by: trenn@suse.de
>
>
> Index: perf_bias_acpi_server_only/arch/x86/kernel/cpu/intel_epb.c
> ===================================================================
> --- perf_bias_acpi_server_only.orig/arch/x86/kernel/cpu/intel_epb.c     2019-04-05 14:43:04.280222577 +0200
> +++ perf_bias_acpi_server_only/arch/x86/kernel/cpu/intel_epb.c  2019-04-08 10:01:26.029278425 +0200
> @@ -19,6 +19,8 @@
>  #include <asm/cpufeature.h>
>  #include <asm/msr.h>
>
> +#include <linux/acpi.h>
> +
>  /**
>   * DOC: overview
>   *
> @@ -89,7 +91,10 @@ static void intel_epb_restore(void)
>                  * ('normal').
>                  */
>                 val = epb & EPB_MASK;
> -               if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
> +               if (acpi_gbl_FADT.preferred_profile == PM_ENTERPRISE_SERVER ||
> +                   acpi_gbl_FADT.preferred_profile == PM_PERFORMANCE_SERVER) {
> +                       /* Keep performance setting on servers */
> +               } else  if (val == ENERGY_PERF_BIAS_PERFORMANCE) {

I would write this as

if (val == ENERGY_PERF_BIAS_PERFORMANCE &&
    acpi_gbl_FADT.preferred_profile != PM_ENTERPRISE_SERVER &&
    acpi_gbl_FADT.preferred_profile != PM_PERFORMANCE_SERVER) {

but overall the approach is not particularly objectionable.

>                         val = ENERGY_PERF_BIAS_NORMAL;
>                         pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
>                 }
>
