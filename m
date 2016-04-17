From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH V1 6/7] MIPS: Loongson1B: Some updates/fixes for LS1B
Date: Sun, 17 Apr 2016 11:47:19 -0700
Message-ID: <20160417184719.GD391@tuxbot>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
 <1459946095-7637-7-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459946095-7637-7-git-send-email-keguang.zhang@gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed 06 Apr 05:34 PDT 2016, Keguang Zhang wrote:

> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> - Add DMA device
> - Add NAND device
> - Add GPIO device
> - Add LED device
> - Update the defconfig and rename it to loongson1b_defconfig
> - Fix ioremap size
> - Other minor fixes

You should split this into a series of patches, at least to get all the
non-functional (renames and BIT usage) into a separate patch. That
way it's much easier to review your functional changes and to later
debug any issues introduced.

Regards,
Bjorn
