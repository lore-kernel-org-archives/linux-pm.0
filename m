From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH/TRIVIAL 1/4] cpufreq: cpufreq-dt: Move newline to end of
 error message
Date: Wed, 19 Nov 2014 13:36:51 +0530
Message-ID: <CAOh2x=kB2QMTXbNg7gCdHoo9QWUG-vc_VQ77iGKz-gfqMd1+KQ@mail.gmail.com>
References: <1414057977-4191-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414057977-4191-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Jiri Kosina <trivial@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 23, 2014 at 3:22 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Currently the error message is needlessly splitted across two lines.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 92c162af5045a2da..685f59598137ea03 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -192,7 +192,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>
>         ret = allocate_resources(policy->cpu, &cpu_dev, &cpu_reg, &cpu_clk);
>         if (ret) {
> -               pr_err("%s: Failed to allocate resources\n: %d", __func__, ret);
> +               pr_err("%s: Failed to allocate resources: %d\n", __func__, ret);
>                 return ret;
>         }

Please add me and linux-pm in cc next time.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
