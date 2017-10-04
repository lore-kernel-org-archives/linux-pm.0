From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 7/7] cpufreq: dt: Remove support for Exynos4212 SoCs
Date: Wed, 4 Oct 2017 10:17:04 +0200
Message-ID: <CAJKOXPdOitz4P+v9emjtEFi7D4HZgoTjWyX5k8HQ8MdDXz7uWA@mail.gmail.com>
References: <CGME20171004063837eucas1p2a2c9dbc268fbb37da5253c329a0a8683@eucas1p2.samsung.com>
 <20171004063828.22068-1-m.szyprowski@samsung.com> <20171004063828.22068-8-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20171004063828.22068-8-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 4, 2017 at 8:38 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Support for Exynos4212 SoCs has been removed by commit bca9085e0ae9 ("ARM:
> dts: exynos: remove Exynos4212 support (dead code)"), so there is no need
> to keep remaining dead code related to this SoC version.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 -
>  1 file changed, 1 deletion(-)
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
