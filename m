From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: Add cpufreq driver for Freescale e500mc SoCs
Date: Sat, 30 Mar 2013 19:22:28 +0530
Message-ID: <CAOh2x=k2cchYWnX0AitOjCOfP_mC-=cm2sm4qhrGv0S9ywzP2g@mail.gmail.com>
References: <1364536350-23788-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1364536350-23788-1-git-send-email-Yuantian.Tang@freescale.com>
Sender: cpufreq-owner@vger.kernel.org
To: Yuantian.Tang@freescale.com
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 29, 2013 at 11:22 AM,  <Yuantian.Tang@freescale.com> wrote:
> diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c

> +static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{

> +       for (i = 0; i < count; i++) {
> +               table[i].index = i;

One more thing, you don't need to set index at all as you aren't using it.
And cpufreq core never uses it.

> +               clk = of_clk_get(data->parent, i);
> +               table[i].frequency = clk_get_rate(clk) / 1000;
> +       }
