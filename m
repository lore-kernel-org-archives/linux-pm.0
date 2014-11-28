From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv2 1/1] thermal: cpu_cooling: check for the readiness of
 cpufreq layer
Date: Fri, 28 Nov 2014 13:35:49 +0530
Message-ID: <CAKohponu_PRrqsuMdCJDznhiO_-=iCaYPhCCad8F4WS3rNxo5A@mail.gmail.com>
References: <1417097577-3548-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1417097577-3548-1-git-send-email-edubezval@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, LKML <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On 27 November 2014 at 19:42, Eduardo Valentin <edubezval@gmail.com> wrote:
> (I'm sorry VireshK, I am still using my normal practice) :-)

That's fine :)

> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 1ab0018..bed3fa2 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -440,6 +440,11 @@ __cpufreq_cooling_register(struct device_node *np,
>         int ret = 0, i;
>         struct cpufreq_policy policy;
>
> +       if (!cpufreq_frequency_get_table(0)) {
> +               pr_err("cpu_cooling: cpufreq layer not ready! Deferring.\n");

Throwing an error here doesn't look to be the right thing. Ultimately
we will register the cooling dev when probed again after some time.

So, a pr_debug() suits more here.

Also, this breaks existing exynos thermal drivers as they don't handle
-EPROBE_DEFER well right now.

I reached here, because one of my patches had something similar to what
you wrote. Just for this file though, haven't updated any other drivers though.

Will be sending you my small patchset by end of day today, please see if
they make any sense at all..
