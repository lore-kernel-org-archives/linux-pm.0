From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 1/4] clk: Add support for runtime PM
Date: Thu, 30 Mar 2017 18:29:04 +0200
Message-ID: <CAPDyKFpugXy0c0nx7ThsfQ7w7H_ZoA-f=k=a0xfRVHtiY9rNdg@mail.gmail.com>
References: <1490182543-28550-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170322113554eucas1p27471f0de278c55d5dce7fdf120395e09@eucas1p2.samsung.com>
 <1490182543-28550-2-git-send-email-m.szyprowski@samsung.com> <149081897388.31513.7062843004022908296@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <149081897388.31513.7062843004022908296@resonance>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

[...]

>
> Fourth & final question: I'm under the impression that pm runtime calls
> be be nested and re-enter, but I want to make sure (Ulf?). For instance
> it is highly likely that this new feature would cause something like:
>
> pm_runtime_get()              - called by random driver
> -> clk_prepare_enable()       - genpd enables functioal clocks
>    -> pm_runtime_get()        - called by clk_pm_runtime_get in clk core
>       -> clk_prepare_enable() - genpd enables interface or bus clocks
>
> I guess this is safe from the pm_runtime_get/genpd perspective, but want
> to make sure first.

I noticed Marek's reply, which perhaps is sufficient. However, to
clarify also from genpd and runtime PM point of view the re-entrant
issue is safe and it is already quite commonly used.

For example, from a random driver's ->runtime_resume() callback
clk_prepare_enable() is called. When such clock is managed behind a
i2c interface the i2c controller also needs to be runtime resumed,
meaning its driver calls pm_runtime_get_sync(), before it can serve
the request and ungate the clock.

[...]

Kind regards
Uffe
