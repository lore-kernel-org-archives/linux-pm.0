From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/7] cpufreq: Loongson1: Update cpufreq of Loongson1B
Date: Mon, 11 Apr 2016 09:22:11 +0530
Message-ID: <20160411035211.GA16238@vireshk-i7>
References: <1460115779-13141-1-git-send-email-keguang.zhang@gmail.com>
 <1460115779-13141-2-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460115779-13141-2-git-send-email-keguang.zhang@gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 08-04-16, 19:42, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> - Rename the file to loongson1-cpufreq.c
> - Use kcalloc() instead of kzalloc()
> - Use devm_kzalloc() instead of global structure
> - Use dev_get_platdata() to access the platform_data field
>   instead of referencing it directly
> - Remove superfluous error messages

Its much better now, in the sense that I can see what you have done.
And see you have done a lot.

That's not how you are supposed to send the patches, sorry.

You need to break this patch into multiple patches, each targeting a
particular fix.

And I have no idea now, what change you have done to make it work for
Loongson1B. Which of the above changes does that?

And please, just send out a separate cpufreq series and don't send
everything in a single patchset that covers DMA, cpufreq, clk, etc..

-- 
viresh
