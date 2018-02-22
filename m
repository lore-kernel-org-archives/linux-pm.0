From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: scpi: invoke frequency-invariance setter function
Date: Thu, 22 Feb 2018 23:27:45 +0100
Message-ID: <CAJZ5v0hB+Uk8SNVqUH3fr1y0SXbY1Rd26b84P-8PPV8FiPbnWw@mail.gmail.com>
References: <20180220111057.14756-1-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180220111057.14756-1-dietmar.eggemann@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 20, 2018 at 12:10 PM, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
> Commit 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> changed the cpufreq driver on juno from arm_big_little to scpi.
>
> The scpi set_target function does not call the frequency-invariance
> setter function arch_set_freq_scale() like the arm_big_little set_target
> function does. As a result the task scheduler load and utilization
> signals are not frequency-invariant on this platform anymore.
>
> Fix this by adding a call to arch_set_freq_scale() into
> scpi_cpufreq_set_target().
>
> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

This is really minor, but I would reorder this slightly.

> ---
>  drivers/cpufreq/scpi-cpufreq.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
> index c32a833e1b00..3101d4e9c2de 100644
> --- a/drivers/cpufreq/scpi-cpufreq.c
> +++ b/drivers/cpufreq/scpi-cpufreq.c
> @@ -51,13 +51,19 @@ static unsigned int scpi_cpufreq_get_rate(unsigned int cpu)
>  static int
>  scpi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>  {
> +       unsigned long freq = policy->freq_table[index].frequency;
>         struct scpi_data *priv = policy->driver_data;
> -       u64 rate = policy->freq_table[index].frequency * 1000;
> +       u64 rate = freq * 1000;
>         int ret;
>
>         ret = clk_set_rate(priv->clk, rate);
> -       if (!ret && (clk_get_rate(priv->clk) != rate))
> -               ret = -EIO;
> +       if (!ret) {

I would do:

if (ret)
        return ret;

arch_set_freq_scale(policy->related_cpus, freq, policy->cpuinfo.max_freq);

if (clk_get_rate(priv->clk) != rate)
        return -EIO;

return 0;

That's somewhat easier to follow for me.

> +               if (clk_get_rate(priv->clk) != rate)
> +                       ret = -EIO;
> +
> +               arch_set_freq_scale(policy->related_cpus, freq,
> +                                   policy->cpuinfo.max_freq);
> +       }
>
>         return ret;
>  }
> --

I also am not sure why you want to call arch_set_freq_scale() even if
the new clock rate didn't stick.
