Return-Path: <SRS0=5pBW=S3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172D9C10F03
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 10:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1D3217FA
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 10:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRyzd+R/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfDYKcj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:32:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34999 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfDYKch (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2019 06:32:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so10902285plp.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2019 03:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PgZEMgyACtouer8ENDXUIK5amDGb32d+qsYYoVzOlWg=;
        b=QRyzd+R/yJ0hnuf79dQP73fJ8BIRliqlJFg2JktL2rIreYSxjZV8s1a9ilhZMWR8hi
         KXf1OVtnLlJq/EXUI/n+q9PsCQtAt0vZ0g++O1LyMKDlAk1EX7rr3Opp9dmksb17+DVk
         EOwzHUdwIFvj39gzrCs+SWYhsvDX6Ni4Bx7VS46pGsOPRUpsR/qhnpnXcZJa4Yx5nRZi
         dmEsXr4kW5utNcQ/eWF/c4od5NmQnaYfTPAkZAyf66ZUyWb0VHaCSml2ys2gb9oCqNGY
         RAmD6IjHuWsHKBF5i+N/8+MRDLpS/68l3/3J+pVn6kf6UIQKuze2LlRbNFdpD+h86BII
         PCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PgZEMgyACtouer8ENDXUIK5amDGb32d+qsYYoVzOlWg=;
        b=WvxY2oQla002VS5liVKIBwvhd9k0nZ2CRI4f1x7g2TnbdykZ0wQ/LkzITSdw/9UIqe
         bbYmkYX+NDS3awZNp0Mf45+SWIuXyajd7TlPnGIpf6sg9egvyGUv0423EhgpKvRwoKsB
         YkhALcZxc2tb2c47S7veHEJOvlIcNpU+omBzfabI6Su1mGI4TGwh/513+Gu38+R+4k68
         /3vcOrmJB9lxEhl9nkIUL7GipTE3Q5h3pXx1jLbwb5I19RSRZoMUI4DSkm3CIpoEq1Pa
         cE62pz/kwWqQw52t3A3/0EzHDWd5+guv/KN5ywv+MdnbmrP/I+hFmHB33ZxIvHlnFP0A
         5bvg==
X-Gm-Message-State: APjAAAV0R481edsINMlymQ1Mi0gJvSCPNmptqMu7cMlwfHCpV2ejjdmK
        IgQcakoymodKPdE20k2YaEltCQ==
X-Google-Smtp-Source: APXvYqzb07ubteAEDmS4LHNpDqoWtb6FvkHGcB03ZkfhYJprDGwHaTKfcIbJYIe63Wh0bTDKxRBfCg==
X-Received: by 2002:a17:902:a582:: with SMTP id az2mr39006605plb.315.1556188356948;
        Thu, 25 Apr 2019 03:32:36 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id 132sm6515024pfw.87.2019.04.25.03.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 03:32:35 -0700 (PDT)
Date:   Thu, 25 Apr 2019 16:02:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RFC] cpufreq: Add imx-cpufreq-dt driver
Message-ID: <20190425103234.4u6dsh4jxhifiux7@vireshk-i7>
References: <83a3ade389239bd492ee646aa4868c5e37e65434.1556187603.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <83a3ade389239bd492ee646aa4868c5e37e65434.1556187603.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190425103234.iFiZMWE9wIBdIXqPILQXzHK4vcL3Lm5NwXse_bjJGks@z>

On 25-04-19, 10:29, Leonard Crestez wrote:
> Right now in upstream imx8m cpufreq support just lists a common subset
> of OPPs because the higher ones should only be attempted after checking
> speed grading in fuses.
> 
> This is not a reasonable limitation and means we must still carry a
> separate cpufreq driver in NXP tree.
> 
> This is a small driver which checks speed grading from nvmem before
> registering cpufreq-dt. Unlike imx6q-cpufreq and various other rejected
> imx7/8 cpufreq drivers it contains no actual frequency switching code,
> just fuse reading through nvmem API.
> 
> Code is inspired by similar cpufreq wrappers from a dozen different
> vendors. Currently for imx8mm but same issue applies to imx8mq and
> others.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> ---
>  drivers/cpufreq/Kconfig.arm          |   5 ++
>  drivers/cpufreq/Makefile             |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>  drivers/cpufreq/imx-cpufreq-dt.c     | 101 +++++++++++++++++++++++++++
>  4 files changed, 109 insertions(+)
>  create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c
> 
> Since nvmem is a module this driver also needs to be turned into a
> proper module, right now it will simply fail if nvmem is unavailable at
> init time. Let me know if you agree with this approach before I turn it
> into a module.
> 
> In vendor tree this is done in soc driver but many other vendors do it
> in drivers/cpufreq so this is where it belongs.
> 
> This is select by default in Kconfig, if anything fails then regular
> cpufreq-dt is not available. This is intentional because higher OPPs are
> potentially unstable.

No objections on this stuff from me. This is how we are doing it for
everyone using cpufreq-dt.

-- 
viresh
