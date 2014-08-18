From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos: free memory immediately on unknown SoC
Date: Mon, 18 Aug 2014 13:29:53 +0530
Message-ID: <CAKohpoke=3vGOoQ9s0snYKZxA_5xMuPtGfAS9uJp1xLJnBwuEA@mail.gmail.com>
References: <1408248374-1638-1-git-send-email-arjun024@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1408248374-1638-1-git-send-email-arjun024@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arjun Sreedharan <arjun024@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene.kim@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 17 August 2014 09:36, Arjun Sreedharan <arjun024@gmail.com> wrote:
> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 1e0ec57..e47d165 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -178,6 +178,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
>                 ret = exynos5250_cpufreq_init(exynos_info);
>         } else {
>                 pr_err("%s: Unknown SoC type\n", __func__);
> +               kfree(exynos_info);
>                 return -ENODEV;
>         }

Apart from the fact that we could have added some logs and improved
$subject a bit,
it looks fine.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
