From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 1/4] ARM: da850: fix infinite loop in clk_set_rate()
Date: Mon, 2 Jan 2017 14:22:06 +0530
Message-ID: <b04c878f-97cf-f0a1-4968-154d96eda8d4@ti.com>
References: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
 <1481124138-27337-2-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:60772 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdABIxb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2017 03:53:31 -0500
In-Reply-To: <1481124138-27337-2-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On Wednesday 07 December 2016 08:52 PM, Bartosz Golaszewski wrote:
> The aemif clock is added twice to the lookup table in da850.c. This
> breaks the children list of pll0_sysclk3 as we're using the same list
> links in struct clk. When calling clk_set_rate(), we get stuck in
> propagate_rate().
> 
> Create a separate clock for nand, inheriting the rate of the aemif
> clock and retrieve it in the davinci_nand module.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Applied to fixes branch. The prefix for mach-davinci patches is "ARM:
davinci: ...". I fixed it up when applying. Please take care for future.

Thanks,
Sekhar
