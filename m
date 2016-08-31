From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/3] clk: Hi6220: enable stub clock driver for ARCH_HISI
Date: Wed, 31 Aug 2016 15:40:49 -0700
Message-ID: <20160831224049.GK12510@codeaurora.org>
References: <1472633417-9330-1-git-send-email-leo.yan@linaro.org>
 <1472633417-9330-2-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472633417-9330-2-git-send-email-leo.yan@linaro.org>
Sender: linux-clk-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Michael Turquette <mturquette@baylibre.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Krzysztof Kozlowski <krzk@kernel.org>, Thierry Reding <treding@nvidia.com>, Riku Voipio <riku.voipio@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 08/31, Leo Yan wrote:
> In current kernel config 'CONFIG_STUB_CLK_HI6220' is disabled by
> default, as result stub clock driver has not been registered and
> CPUFreq driver cannot work.
> 
> This patch is to enable stub clock driver in config for ARCH_HISI.
> 
> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
