From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 06/10] clk: sunxi-ng: allow set parent clock (PLL_CPUX)
 for CPUX clock on H3
Date: Tue, 25 Jul 2017 17:36:18 -0700
Message-ID: <20170726003618.GG2146@codeaurora.org>
References: <20170723102749.17323-1-icenowy@aosc.io>
 <20170723102749.17323-7-icenowy@aosc.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170723102749.17323-7-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pm@vger.kernel.org

On 07/23, Icenowy Zheng wrote:
> The CPUX clock, which is the main clock of the ARM core on Allwinner H3,
> can be adjusted by changing the frequency of the PLL_CPUX clock.
> 
> Allowing setting parent clock for the CPUX clock, thus the PLL_CPUX
> clock can be adjusted when adjusting the CPUX clock.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
