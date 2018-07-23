From: Ilia Lin <ilia.lin@gmail.com>
Subject: Re: [PATCH] cpufreq: qcom-kryo: add NULL entry to the end
 of_device_id array
Date: Mon, 23 Jul 2018 15:44:17 +0300
Message-ID: <CA+5LGR0VAN-RQvEBNNJ08YEQVgW=NZ-pgBq=DByAfTwXonfiRQ@mail.gmail.com>
References: <20180723123429.20040-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723123429.20040-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuehaibing@huawei.com
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 23, 2018 at 3:38 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Make sure of_device_id tables are NULL terminated
> Found by coccinelle spatch "misc/of_table.cocci"
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-kryo.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
> index 29389ac..efc9a7a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-kryo.c
> +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> @@ -183,6 +183,7 @@ static struct platform_driver qcom_cpufreq_kryo_driver = {
>  static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
>         { .compatible = "qcom,apq8096", },
>         { .compatible = "qcom,msm8996", },
> +       {}
>  };
>
>  /*
> --
> 2.7.0
>
>

Acked-by: Ilia Lin <ilia.lin@kernel.org>
