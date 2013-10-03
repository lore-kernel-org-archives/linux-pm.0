From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: highbank-cpufreq: Enable Midway/ECX-2000
Date: Thu, 3 Oct 2013 10:38:37 +0530
Message-ID: <CAOh2x=mZ__gYkhi6o_goUkw+JB==VY2PSk-T_1G+6QBxDZGFFg@mail.gmail.com>
References: <1380641424-5666-1-git-send-email-mark.langsdorf@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1380641424-5666-1-git-send-email-mark.langsdorf@calxeda.com>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 1, 2013 at 9:00 PM, Mark Langsdorf
<mark.langsdorf@calxeda.com> wrote:
> Calxeda's new ECX-2000 part uses the same cpufreq interface as highbank,
> so add it to the driver's compatibility list.
>
> This is a minor change that can safely be applied to the 3.10 and 3.11
> stable trees.
>
> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> ---
>  drivers/cpufreq/highbank-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
> index 794123f..bf8902a 100644
> --- a/drivers/cpufreq/highbank-cpufreq.c
> +++ b/drivers/cpufreq/highbank-cpufreq.c
> @@ -66,7 +66,8 @@ static int hb_cpufreq_driver_init(void)
>         struct device_node *np;
>         int ret;
>
> -       if (!of_machine_is_compatible("calxeda,highbank"))
> +       if ((!of_machine_is_compatible("calxeda,highbank")) &&
> +               (!of_machine_is_compatible("calxeda,ecx-2000")))
>                 return -ENODEV;
>
>         cpu_dev = get_cpu_device(0);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
