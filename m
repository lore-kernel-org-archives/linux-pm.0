From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/9] ARM: pxa: define clock registers as __iomem
Date: Fri, 29 Jan 2016 10:31:48 -0800
Message-ID: <20160129183148.GP12841@codeaurora.org>
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
 <1454076396-3563101-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1454076396-3563101-2-git-send-email-arnd@arndb.de>
Sender: linux-clk-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/29, Arnd Bergmann wrote:
> We should not dereference registers as pointers, so use readl/writel
> instead for these registers.
> 
> The clock registers are accessed in multiple files, so we have to
> change them all at once.
> 
> I stumbled over these registers while looking at something unrelated.
> There are in fact other registers with the same problem, but I did
> not try to address those at this point.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
