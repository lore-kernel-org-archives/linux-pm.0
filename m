Return-Path: <SRS0=Ee89=4J=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357D3C35657
	for <linux-pm@archiver.kernel.org>; Fri, 21 Feb 2020 14:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D37C206DB
	for <linux-pm@archiver.kernel.org>; Fri, 21 Feb 2020 14:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBGjfqKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgBUOz2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:55:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37817 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgBUOz1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 09:55:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id w15so2394981wru.4
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 06:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VYFmZABuXC2P3mL+XBtC87Ki2RRj3t8jFY9o3T5ockc=;
        b=qBGjfqKqIhfELazUq1yKbqpD8Qsj8UMuqu+4fmKwHveSJwobSUDrCJSwBVhwu5Bmqb
         zczv4ydTB2cI4GPaZHJ8y+8pyGp8k0mqXRP7gSWa/TpKv6/dz8zHuMx+mTveJg0J6NvZ
         XqCHm1itlNuZUmRMyEhinBjSq5Y0CUI3dEBKdvf0MHRyWF4dr3I0o3A1OC08L3fCke1S
         OyBNtxGpeY9iSG7/x5UiyRaPj+ELuKtOE9bTFgf0QN6YkoBgHUPT1nIMkdIZlvgoRLpr
         MMlc2BfR3jqw9Dal4aEiMhXrLMAY9zFjFqViSfEPFu1/Ps+HN4zZ+kmWloC5ownsmxyR
         pnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VYFmZABuXC2P3mL+XBtC87Ki2RRj3t8jFY9o3T5ockc=;
        b=nQsuxygi7WiQA83tnX02HXc/mMCI6+RiPN/D27NyVfxlc+RGsjUGJHsMoTRn8pjIwk
         WmHWekBtM3C/kX/HVz1nwDPSiZnf+GdaXcqqL4eJ7v4p8awNj4xwTJMqJ85PL1mpob5K
         JVbWfPrVBPf5i8KPJIZrGceK5CNWOLi0cXBkEa4/iTNhRVOsI98/LBWAJJaboRR1jwsu
         HwsIpvkNd/LHM16oRoxUG36a6vahEXTA7kQGfADIMGUCsCFTEdNnJWJ69/3r8Csp/Mri
         b8V3mJAIUYE8qbPt+NoKaZBOBq1xfAQhhidgV4uPTjJtTzxo+gG6lc/1700LLeppyOW1
         vKuA==
X-Gm-Message-State: APjAAAUB1dd4lZe41u6vxkX2Gs8GkeTu1RISABgcpH7VjI6p0QOeRGVP
        LAUZX0oSCZjm41fVPNoOPw4qWA==
X-Google-Smtp-Source: APXvYqxlQBHBtXVdKb8UmXuzt1Ss70Lfj6fxpQ5QfcMhGxHSh56TW6+M7a7t4xCU95n8tS/8m1lw9g==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr47003721wru.235.1582296925319;
        Fri, 21 Feb 2020 06:55:25 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id o9sm4320439wrw.20.2020.02.21.06.55.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 06:55:24 -0800 (PST)
Date:   Fri, 21 Feb 2020 15:55:22 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 09/17] arm: tegra20: cpuidle: Handle case where
 secondary CPU hangs on entering LP2
Message-ID: <20200221145522.GG10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212235134.12638-10-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:26AM +0300, Dmitry Osipenko wrote:
> It is possible that something may go wrong with the secondary CPU, in that
> case it is much nicer to get a dump of the flow-controller state before
> hanging machine.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/arm/mach-tegra/cpuidle-tegra20.c | 47 +++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
> index 9672c619f4bc..bcc158b72e67 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra20.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
> @@ -83,14 +83,57 @@ static inline void tegra20_wake_cpu1_from_reset(void)
>  }
>  #endif
>  
> +static void tegra20_report_cpus_state(void)
> +{
> +	unsigned long cpu, lcpu, csr;
> +
> +	for_each_cpu(lcpu, cpu_possible_mask) {
> +		cpu = cpu_logical_map(lcpu);
> +		csr = flowctrl_read_cpu_csr(cpu);
> +
> +		pr_err("cpu%lu: online=%d flowctrl_csr=0x%08lx\n",
> +		       cpu, cpu_online(lcpu), csr);
> +	}
> +}
> +
> +static int tegra20_wait_for_secondary_cpu_parking(void)
> +{
> +	unsigned int retries = 3;
> +
> +	while (retries--) {
> +		ktime_t timeout = ktime_add_ms(ktime_get(), 500);
> +
> +		/*
> +		 * The primary CPU0 core shall wait for the secondaries
> +		 * shutdown in order to power-off CPU's cluster safely.
> +		 * The timeout value depends on the current CPU frequency,
> +		 * it takes about 40-150us  in average and over 1000us in
> +		 * a worst case scenario.
> +		 */
> +		do {
> +			if (tegra_cpu_rail_off_ready())
> +				return 0;
> +
> +		} while (ktime_before(ktime_get(), timeout));
> +
> +		pr_err("secondary CPU taking too long to park\n");
> +
> +		tegra20_report_cpus_state();
> +	}
> +
> +	pr_err("timed out waiting secondaries to park\n");
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
>  					   struct cpuidle_driver *drv,
>  					   int index)
>  {
>  	bool ret;
>  
> -	while (!tegra_cpu_rail_off_ready())
> -		cpu_relax();
> +	if (tegra20_wait_for_secondary_cpu_parking())
> +		return false;
>  
>  	ret = !tegra_pm_enter_lp2();
>  
> -- 
> 2.24.0
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
