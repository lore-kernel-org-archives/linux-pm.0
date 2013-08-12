From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 21/44] cpufreq: imx6q: Use generic cpufreq routines
Date: Mon, 12 Aug 2013 15:58:43 +0800
Message-ID: <20130812075841.GG25061@S2101-09.ap.freescale.net>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
 <6d7504823a31aea1e4773998f60720494fb0e6b6.1376116345.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [213.199.154.206] ([213.199.154.206]:26610 "EHLO
	am1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752716Ab3HLID2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2013 04:03:28 -0400
Content-Disposition: inline
In-Reply-To: <6d7504823a31aea1e4773998f60720494fb0e6b6.1376116345.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 10, 2013 at 12:14:17PM +0530, Viresh Kumar wrote:
> Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
> and .attr. So its better if we have generic routines for them which can be used
> by cpufreq drivers then.
> 
> This patch uses these generic routines for this driver.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Shawn Guo <shawn.guo@linaro.org>

