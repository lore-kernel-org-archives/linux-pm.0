From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 0/2] Add imx6q-cpufreq driver support
Date: Sat, 12 Jan 2013 14:34:24 +0100
Message-ID: <1615305.5RaFjClze9@vostro.rjw.lan>
References: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:38770 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921Ab3ALN2i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 12 Jan 2013 08:28:38 -0500
In-Reply-To: <1357806863-6899-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>

On Thursday, January 10, 2013 04:34:21 PM Shawn Guo wrote:
> Changes since v1:
>  - Drop patch "PM / OPP: Export more symbols for module usage", as
>    there is already one "[PATCH 5/6 v9] power: export opp cpufreq
>    functions" from Mark Langsdorf.
>  - Instead of having cpu_dev be the struct device retrieved from
>    get_cpu_device(), have it be &pdev->dev, so that we can use managed
>    functions to simplified the cleanup path.
>  - Use dev_* rather than pr_* for message output
>  - Fix Typos and others commented by Viresh and Sascha. 
> 
> Once the first patch gets accepted, I will apply the second one for
> going through arm-soc tree.
> 
> Shawn Guo (2):
>   cpufreq: add imx6q-cpufreq driver
>   ARM: imx: enable imx6q-cpufreq support

I would prefer these two to go through the arm-soc tree if that's not a problem.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
