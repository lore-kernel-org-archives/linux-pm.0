From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] clk: Provide notifier stubs when !COMMON_CLK
Date: Tue, 28 Jun 2016 17:14:49 -0700
Message-ID: <20160629001449.GI1521@codeaurora.org>
References: <1467113104-8650-1-git-send-email-k.kozlowski@samsung.com>
 <20160628172653.GB1521@codeaurora.org>
 <20160628190100.GA11586@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160628190100.GA11586@kozik-lap>
Sender: linux-clk-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 06/28, Krzysztof Kozlowski wrote:
> On Tue, Jun 28, 2016 at 10:26:53AM -0700, Stephen Boyd wrote:
> > On 06/28, Krzysztof Kozlowski wrote:
> > > The clk notifier symbols are hidden by COMMON_CLK.  However on some
> > > platforms HAVE_CLK might be set while COMMON_CLK not which leads to
> > > compile test build errors like:
> > > 
> > > $ make.cross ARCH=sh
> > >    drivers/devfreq/tegra-devfreq.c: In function 'tegra_actmon_rate_notify_cb':
> > > >> drivers/devfreq/tegra-devfreq.c:391:16: error: 'POST_RATE_CHANGE' undeclared (first use in this function)
> > >      if (action != POST_RATE_CHANGE)
> > >                    ^
> > >    drivers/devfreq/tegra-devfreq.c: In function 'tegra_devfreq_probe':
> > > >> drivers/devfreq/tegra-devfreq.c:654:8: error: implicit declaration of function 'clk_notifier_register' [-Werror=implicit-function-declaration]
> > >      err = clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
> > >            ^
> > > 
> > > Export the macros and data type declarations outside of COMMON_CLK ifdef
> > > and provide stubs to fix the compile testing.
> > > 
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > 
> > > ---
> > > 
> > 
> > Ok. Did you want some stable branch to pull this in and base your
> > use case on?
> 
> It is only one patch but indeed without the branch my patches would have
> to wait for next release. If you would be so kind, could you prepare
> the stable branch? I hope MyungJoo Ham will use it.
> 
> Anyway I encountered more linkage errors for clk API (like clk_get_rate()).
> They happen for various compile-tested drivers in case of MIPS (and
> maybe others like SH). I will investigate it more but I think it is not
> related strictly to this issue.

Sure. That's probably because some clk APIs are optional and not
implemented, leading to link errors.

I've applied this patch to a branch called clk-notify and merged
it into clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
