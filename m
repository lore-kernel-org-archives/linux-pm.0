From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] clk: renesas: Use pm_clk_no_clocks() helper i.s.o.
 direct access
Date: Wed, 26 Apr 2017 09:11:21 +0200
Message-ID: <20170426071120.GB25517@verge.net.au>
References: <1493141638-28940-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493141638-28940-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 25, 2017 at 07:33:58PM +0200, Geert Uytterhoeven wrote:
> The pm_subsys_data.clock_list member exists only if CONFIG_PM_CLK=y.
> Hence direct accesses to this field break compile-testing on platforms
> where CONFIG_PM_CLK=n.
> 
> To fix this, use the pm_clk_no_clocks() helper instead, for which a
> dummy version is provided if CONFIG_PM_CLK=n.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <simon.horman@netronome.com>
