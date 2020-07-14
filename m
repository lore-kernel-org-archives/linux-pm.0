Return-Path: <SRS0=bP2c=AZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86083C433DF
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jul 2020 16:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF8C22507
	for <linux-pm@archiver.kernel.org>; Tue, 14 Jul 2020 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594742619;
	bh=wPj65wTz6EHBT8HSEM9nVWFsP4zkzd/637aiXjyIM5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nYge+X8IgYdTQCmoBCWfNp3FlMtysvXpoRPSPMXJ0cxrynDIbcAhWzdOrdWWLfRAI
	 GnauB6lQUQzRLlnSO+87DszyfKn74QJXKl690A/UmzoN1Eahx6eSeSpb+x9xNQJPE4
	 bplGW4AZWZa0vc//qL/NR6+1/S8l2TW5EOjDqXYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgGNQDi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:03:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35456 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgGNQDi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 12:03:38 -0400
Received: by mail-oi1-f196.google.com with SMTP id k4so14317685oik.2;
        Tue, 14 Jul 2020 09:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=21mBK5XQlzzwRfuCdL7vWAD93m+c/3b2zPJqq6HFUxA=;
        b=PvOXOKDq+wdg2asbb+6Hl7stp1xyiybimXSQ2a8aVRZ5vsC1FOskgjK6+KOAup8M4l
         wgdlc95MyOJkW5gYXl6X70DfKk9ZkY6JRMY+tXnm65IO3Wt7Qdk4Z/+Yh9ZK/h/h0te5
         a6QDGxiMLHEiw1gIrm8Unj5hfsoFOuPJ4lM/vhrtX+MzVFoFIwv8wH7sFlDOvXHG5kUH
         HAU4G7u8wh+SaruwtvHJaZDCm/hQyiW+DTTXQ3J1zUcUe1yAvaUbgvbqIjTBFgVAm0Mp
         ZkdSCWBX/JRmuHnbmiqc1m6j/V4nZEZJ6+xIv+BzuZMnFwkhyBEuFD8nWFxG3whRrIGZ
         VH+w==
X-Gm-Message-State: AOAM5334Uu0i7L80hcDnCQE+3EBKYcecyVZPs89k4IHiBEvhN33FhcNx
        Hzx/nS7maAStaUv5+TfQB+qDJ78yRd259LOWakU=
X-Google-Smtp-Source: ABdhPJxM6IGeSW+JYTFdjmhtIe+pRkXzZv9tQYgM798fc9BeuFp/Qi/uhONrx4vElhIaJZEtIm7isFXd34t4t9xnj6E=
X-Received: by 2002:a54:4e87:: with SMTP id c7mr4426194oiy.110.1594742617695;
 Tue, 14 Jul 2020 09:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200714145049.2496163-1-lee.jones@linaro.org> <20200714145049.2496163-9-lee.jones@linaro.org>
In-Reply-To: <20200714145049.2496163-9-lee.jones@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 18:03:26 +0200
Message-ID: <CAJZ5v0igiz-VmmDC2qsZ3AhqjGhM54LHMLeLdZ7Dr=h5Dm9Rrg@mail.gmail.com>
Subject: Re: [PATCH 08/13] cpufreq: acpi-cpufreq: Take 'dummy' principle one
 stage further
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Grover <andrew.grover@intel.com>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Dominik Brodowski <linux@brodo.de>,
        Denis Sadykov <denis.m.sadykov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> If we fail to use a variable, even a 'dummy' one, then the compiler
> complains that it is set but not used.  We know this is fine, so we
> set it to its own value here.

Which is kind of ugly in my personal view.  I hope that the compiler
will actually optimize the extra code away ...

> Fixes the following W=1 kernel build warning(s):

Well, "Makes the following ... warning(s) go away:" rather ...

>  drivers/cpufreq/acpi-cpufreq.c: In function ‘cpu_freq_read_intel’:
>  drivers/cpufreq/acpi-cpufreq.c:247:11: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
>  drivers/cpufreq/acpi-cpufreq.c: In function ‘cpu_freq_read_amd’:
>  drivers/cpufreq/acpi-cpufreq.c:265:11: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
>
> Cc: Andy Grover <andrew.grover@intel.com>
> Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
> Cc: Dominik Brodowski <linux@brodo.de>
> Cc: Denis Sadykov <denis.m.sadykov@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 429e5a36c08a9..d38a693b48e03 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -247,6 +247,7 @@ static u32 cpu_freq_read_intel(struct acpi_pct_register *not_used)
>         u32 val, dummy;
>
>         rdmsr(MSR_IA32_PERF_CTL, val, dummy);
> +       dummy &= dummy; /* Silence set but not used warning */
>         return val;
>  }
>
> @@ -264,6 +265,7 @@ static u32 cpu_freq_read_amd(struct acpi_pct_register *not_used)
>         u32 val, dummy;
>
>         rdmsr(MSR_AMD_PERF_CTL, val, dummy);
> +       dummy &= dummy; /* Silence set but not used warning */
>         return val;
>  }
>
> --
> 2.25.1
>
