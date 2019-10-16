Return-Path: <SRS0=MfD0=YJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B51AC4360C
	for <linux-pm@archiver.kernel.org>; Wed, 16 Oct 2019 03:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBF221835
	for <linux-pm@archiver.kernel.org>; Wed, 16 Oct 2019 03:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyDL16WH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfJPDiQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:38:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44850 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbfJPDiN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 23:38:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so9416748pgd.11
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xDw1E+VxBs/5UND1mf/klt16slydi9JotBXF01e+CRk=;
        b=kyDL16WHaN2o9selPh6MHGPHfV+X7wEq0FllVlq4/AMM/N0LVOftGKRuCwqzhga1Hd
         cdN+t0MyQmeFRJ5bf/XbDXmItS0ZWVX7UiLiUci5QgPuJ0pmI/mAIAOhsVOExjXSLXDk
         WCFFMMunb9/gDv9fzRuwcEBPTAfrgn2BIMd7bsPFc9ZEvqcn3DgN99CzDKWE1tGebs5x
         6vF/R0l5IS2cpf/QJz71tCyEslIqkHo+nXy2rjOCY8UdaKI5fPfbIO9owHZ/WIva3dDB
         ++BCPIgmNCv0Mm2uFmWjsB7CWPUdt7AcPg514jBVxgt4Lt/OWXlHaApJAdDUsRfJPF9d
         J/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xDw1E+VxBs/5UND1mf/klt16slydi9JotBXF01e+CRk=;
        b=IPR+wa/LOEhD4tHtipbLHB9L5Xmf1SkO71W/0NkpoB70krORIvZ2/jCPDddQ7fJXNy
         1SFYldYMyl3pLXGxJkaw5I/NKCxd5THBek3IqTQs+m3hXXox5JZ76miGBGAYQyPGk78m
         3pVl5Px0Oru3cjBGiLzaF3kuey5HtQg/q1tishZNp+NRIAGmDtEizKyS0/8frfQPbGZR
         TWlYYhsWtXIgoxvsiHS4cxHE2X6ihPTwwpul9h7909blC6Yp0Bctqvv6QsZIVcT3x5bv
         1o6/NzrxOhdAcJXXnxmEOnzj9i9PyRK1ZqjncK+aW6vimrSfjXwV/LvG0773pJFzkKJO
         Cqjw==
X-Gm-Message-State: APjAAAXRDrRuw60AweWDB0BMxLC2jLunRU6bw3zrNrvTstm7uouY06Z8
        KEMg7hOq63JuXq7Kej7FbmPegw==
X-Google-Smtp-Source: APXvYqxIMFWNe/yMHUCIaIMu64JgM3ECcEsbE/RT/QAxjCKzVVSrI8MfKrdZOI2NiD63SyqLmhqvNQ==
X-Received: by 2002:aa7:9ed2:: with SMTP id r18mr41382466pfq.1.1571197092543;
        Tue, 15 Oct 2019 20:38:12 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id y17sm32299937pfo.171.2019.10.15.20.38.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 20:38:10 -0700 (PDT)
Date:   Wed, 16 Oct 2019 09:08:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] ACPI: processor: Avoid NULL pointer dereferences at init
 time
Message-ID: <20191016033808.uqgc4ss6xcg4ta5v@vireshk-i7>
References: <9765491.cFa8AugBjT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9765491.cFa8AugBjT@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-10-19, 19:35, Rafael J. Wysocki wrote:
> rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If there are neither processor objects nor processor device objects
> in the ACPI tables, the per-CPU processors table will not be
> initialized and attempting to dereference pointers from there will
> cause the kernel to crash.  This happens in acpi_processor_ppc_init()
> and acpi_thermal_cpufreq_init() after commit d15ce412737a ("ACPI:
> cpufreq: Switch to QoS requests instead of cpufreq notifier")
> which didn't add the requisite NULL pointer checks in there.
> 
> Add the NULL pointer checks to acpi_processor_ppc_init() and
> acpi_thermal_cpufreq_init(), and to the corresponding "exit"
> routines.
> 
> While at it, drop redundant return instructions from
> acpi_processor_ppc_init() and acpi_thermal_cpufreq_init().
> 
> Fixes: d15ce412737a ("ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier")
> Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/processor_perflib.c |   10 ++++++----
>  drivers/acpi/processor_thermal.c |   10 ++++++----
>  2 files changed, 12 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
