From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/3] clk: Hi6220: enable stub clock driver for ARCH_HISI
Date: Mon, 14 Nov 2016 18:40:42 -0800
Message-ID: <20161115024042.GV5177@codeaurora.org>
References: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
 <1472633417-9330-2-git-send-email-leo.yan@linaro.org>
 <20160831224049.GK12510@codeaurora.org>
 <20161112120231.GB23848@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161112120231.GB23848@leoy-linaro>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Michael Turquette <mturquette@baylibre.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Krzysztof Kozlowski <krzk@kernel.org>, Thierry Reding <treding@nvidia.com>, Riku Voipio <riku.voipio@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 11/12, Leo Yan wrote:
> Hi Stephen,
> 
> On Wed, Aug 31, 2016 at 03:40:49PM -0700, Stephen Boyd wrote:
> > On 08/31, Leo Yan wrote:
> > > In current kernel config 'CONFIG_STUB_CLK_HI6220' is disabled by
> > > default, as result stub clock driver has not been registered and
> > > CPUFreq driver cannot work.
> > > 
> > > This patch is to enable stub clock driver in config for ARCH_HISI.
> > > 
> > > Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > 
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> We found this patch is missed mainline kernel. So could you help pick
> it? Or do you need me resend this patch?
> 

Sure I can fish it out and apply it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
