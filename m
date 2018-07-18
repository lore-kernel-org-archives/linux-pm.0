From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH] cpufreq: qcom-kryo: Silently error out on EPROBE_DEFER
Date: Wed, 18 Jul 2018 15:51:25 +0530
Message-ID: <CAHLCerMfcjjjEmHZthA23V1WfrS6x05h2a-LZRpQjCKLyZVSzQ@mail.gmail.com>
References: <20180717204821.15987-1-niklas.cassel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717204821.15987-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Ilia Lin <ilia.lin@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 18, 2018 at 2:18 AM, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> If of_nvmem_cell_get() fails due to probe deferal, we shouldn't print an
> error message. Just be silent in this case.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 29389accf3e9..b8d1e6875f16 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -109,8 +109,9 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
>         speedbin_nvmem = of_nvmem_cell_get(np, NULL);
>         of_node_put(np);
>         if (IS_ERR(speedbin_nvmem)) {
> -               dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
> -                       PTR_ERR(speedbin_nvmem));
> +               if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
> +                       dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
> +                               PTR_ERR(speedbin_nvmem));
>                 return PTR_ERR(speedbin_nvmem);
>         }
>
> --
> 2.17.1
>
