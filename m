From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/6] clk: mediatek: add missing cpu mux causing Mediatek
 cpufreq can't work
Date: Mon, 19 Jun 2017 18:07:37 -0700
Message-ID: <20170620010737.GB4493@codeaurora.org>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
 <1493997974-17699-2-git-send-email-sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbdFTBHl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2017 21:07:41 -0400
Content-Disposition: inline
In-Reply-To: <1493997974-17699-2-git-send-email-sean.wang@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sean.wang@mediatek.com
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Pi-Cheng Chen <pi-cheng.chen@linaro.org>

On 05/05, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> This patch adds CPU multiplexer clocks which are essential for Mediatek
> cpufreq driver. It would use the CPU clock multiplexer to switch to the
> intermediate clock source temporarily and then wait for the primary clock
> changing getting stable.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
