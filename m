From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq-dt: defer probing if OPP table is not ready
Date: Wed, 17 Dec 2014 10:07:00 +0530
Message-ID: <CAKohpokj=u-VhNsW1ZoRsjjPEioMO6FqzVEL3y-7vDCt07cjKw@mail.gmail.com>
References: <1418771379-24369-1-git-send-email-dtor@chromium.org>
	<1418771379-24369-5-git-send-email-dtor@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418771379-24369-5-git-send-email-dtor@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Stefan Wahren <stefan.wahren@i2se.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Nishanth Menon <nm@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 17 December 2014 at 04:39, Dmitry Torokhov <dtor@chromium.org> wrote:
> cpufreq-dt driver supports mode when OPP table is provided by platform
> code and not device tree. However on certain platforms code that fills
> OPP table may run after cpufreq driver tries to initialize, so let's
> report -EPROBE_DEFER if we do not find any entires in OPP table for the
> CPU.
>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index f56147a..fde97d6 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -211,6 +211,17 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>         /* OPPs might be populated at runtime, don't check for error here */
>         of_init_opp_table(cpu_dev);
>
> +       /*
> +        * But we need OPP table to function so if it is not there let's
> +        * give platform code chance to provide it for us.
> +        */
> +       ret = dev_pm_opp_get_opp_count(cpu_dev);
> +       if (ret <= 0) {
> +               pr_debug("OPP table is not ready, deferring probe\n");
> +               ret = -EPROBE_DEFER;
> +               goto out_free_opp;
> +       }
> +
>         priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>         if (!priv) {
>                 ret = -ENOMEM;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
