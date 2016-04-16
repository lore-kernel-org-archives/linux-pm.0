From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V1 1/7] clk: Loongson1: Update clocks of Loongson1B
Date: Fri, 15 Apr 2016 17:34:30 -0700
Message-ID: <20160416003430.GL26353@codeaurora.org>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
 <1459946095-7637-2-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459946095-7637-2-git-send-email-keguang.zhang@gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 04/06, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> - Rename the file to clk-loongson1.c
> - Add AC97, DMA and NAND clock
> - Update clock names
> - Remove superfluous error messages
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---

I applied it manually to see the differences.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
