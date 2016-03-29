From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 3/3] cpufreq: exynos: Use generic platdev driver
Date: Tue, 29 Mar 2016 17:04:26 +0200
Message-ID: <3810049.oQlCXiQ5bk@wuerfel>
References: <cover.1459233524.git.viresh.kumar@linaro.org> <81a8da75a0e7783e2b47f9e04297f167e8134afe.1459233524.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <81a8da75a0e7783e2b47f9e04297f167e8134afe.1459233524.git.viresh.kumar@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, mmcclint@codeaurora.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 29 March 2016 12:09:49 Viresh Kumar wrote:
> -static void __init exynos_cpufreq_init(void)
> -{
> -       struct device_node *root = of_find_node_by_path("/");
> -       const struct of_device_id *match;
> -
> -       match = of_match_node(exynos_cpufreq_matches, root);
> -       if (!match) {
> -               platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
> -               return;
> -       }
> -
> -       platform_device_register_simple(match->data, -1, NULL, 0);
> -}

How is the "exynos-cpufreq" case handled now? Is that no longer used now?
I assume the patch is correct based on Krzysztof's review, but it might be
good to explain this better.

	Arnd
