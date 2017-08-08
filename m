From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v7 1/4] clk: Add support for runtime PM
Date: Tue, 8 Aug 2017 17:37:12 +0200
Message-ID: <20170808153712.GA2646@kozik-book>
References: <1501839294-478-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170804093515eucas1p2226e597c155e5c4ca4ffea95c9e00392@eucas1p2.samsung.com>
 <1501839294-478-2-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37734 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752102AbdHHPhl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2017 11:37:41 -0400
Content-Disposition: inline
In-Reply-To: <1501839294-478-2-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Fri, Aug 04, 2017 at 11:34:51AM +0200, Marek Szyprowski wrote:
> Registers for some clocks might be located in the SOC area, which are under the
> power domain. To enable access to those registers respective domain has to be
> turned on. Additionally, registers for such clocks will usually loose its
> contents when power domain is turned off, so additional saving and restoring of
> them might be needed in the clock controller driver.
> 
> This patch adds basic infrastructure in the clocks core to allow implementing
> driver for such clocks under power domains. Clock provider can supply a
> struct device pointer, which is the used by clock core for tracking and managing
> clock's controller runtime pm state. Each clk_prepare() operation
> will first call pm_runtime_get_sync() on the supplied device, while
> clk_unprepare() will do pm_runtime_put_sync() at the end.
> 
> Additional calls to pm_runtime_get/put functions are required to ensure that any
> register access (like calculating/changing clock rates and unpreparing/disabling
> unused clocks on boot) will be done with clock controller in runtime resumend
> state.
> 
> When one wants to register clock controller, which make use of this feature, he
> has to:
> 1. Provide a struct device to the core when registering the provider.
> 2. Ensure to enable runtime PM for that device before registering clocks.
> 3. Make sure that the runtime PM status of the controller device reflects
>    the HW state.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/clk/clk.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 114 insertions(+), 15 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
