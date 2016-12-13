From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 8/9] PM / Domains: Support IRQ safe PM domains
Date: Tue, 13 Dec 2016 13:47:11 +0100
Message-ID: <CAMuHMdVv=QwnaBL85MSuc_DVPb-jNoH4y6DBSKVFFttByGcq0w@mail.gmail.com>
References: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org> <1477347668-41901-9-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1477347668-41901-9-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Lina,

On Tue, Oct 25, 2016 at 12:21 AM, Lina Iyer <lina.iyer@linaro.org> wrote:
> Generic Power Domains currently support turning on/off only in process
> context. This prevents the usage of PM domains for domains that could be
> powered on/off in a context where IRQs are disabled. Many such domains
> exist today and do not get powered off, when the IRQ safe devices in
> that domain are powered off, because of this limitation.
>
> However, not all domains can operate in IRQ safe contexts. Genpd
> therefore, has to support both cases where the domain may or may not
> operate in IRQ safe contexts. Configuring genpd to use an appropriate
> lock for that domain, would allow domains that have IRQ safe devices to
> runtime suspend and resume, in atomic context.
>
> To achieve domain specific locking, set the domain's ->flag to
> GENPD_FLAG_IRQ_SAFE while defining the domain. This indicates that genpd
> should use a spinlock instead of a mutex for locking the domain. Locking
> is abstracted through genpd_lock() and genpd_unlock() functions that use
> the flag to determine the appropriate lock to be used for that domain.
>
> Domains that have lower latency to suspend and resume and can operate
> with IRQs disabled may now be able to save power, when the component
> devices and sub-domains are idle at runtime.
>
> The restriction this imposes on the domain hierarchy is that non-IRQ
> safe domains may not have IRQ-safe subdomains, but IRQ safe domains may
> have IRQ safe and non-IRQ safe subdomains and devices.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 111 ++++++++++++++++++++++++++++++++++++++++----
>  include/linux/pm_domain.h   |  10 +++-
>  2 files changed, 110 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 1ad42f2..07ed835 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -74,11 +74,70 @@ static const struct genpd_lock_ops genpd_mtx_ops = {

> +static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
> +               struct generic_pm_domain *genpd)
> +{
> +       bool ret;
> +
> +       ret = pm_runtime_is_irq_safe(dev) && !genpd_is_irq_safe(genpd);
> +
> +       /* Warn once for each IRQ safe dev in no sleep domain */

This comment is not correct, as dev_warn_once() will print the warning once,
not once per device. Hence users will not be informed if there are multiple
IRQ safe devices.

> +       if (ret)
> +               dev_warn_once(dev, "PM domain %s will not be powered off\n",
> +                               genpd->name);

BTW, I'm seeing messages like:

    sh_cmt ffca0000.timer: PM domain always-on will not be powered off

and

    sh_cmt e6138000.timer: PM domain c5 will not be powered off

on various Renesas SoCs, and wanted to know if there was more than one
IRQ safe device preventing a PM domain power down (answer: there isn't).
Note that the above are OK, as both "always-on" and "c5" are always-on
PM domains.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
