From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V3 2/6] PM / OPP: Rename opp init/free table routines
Date: Sun, 6 Sep 2015 20:26:06 +0800
Message-ID: <20150906122606.GT30746@tiger>
References: <cover.1441354424.git.viresh.kumar@linaro.org>
 <6bdbc2c69b18528648d5a752da0d6176825bd870.1441354424.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6bdbc2c69b18528648d5a752da0d6176825bd870.1441354424.git.viresh.kumar@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com, Pavel Machek <pavel@ucw.cz>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Len Brown <len.brown@intel.com>, "moderated list:ARM SUB-ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 04, 2015 at 01:47:23PM +0530, Viresh Kumar wrote:
> free-table routines are opposite of init-table ones, and must be named
> to make that clear. Opposite of 'init' is 'exit', but those doesn't suit
> really well.
> 
> Replace 'init' with 'add' and 'free' with 'remove'.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-imx/mach-imx6q.c       |  2 +-
...
>  drivers/cpufreq/imx6q-cpufreq.c      |  6 +++---

Acked-by: Shawn Guo <shawnguo@kernel.org>
