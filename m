From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 06/10] OPP: Add dev_pm_opp_{set|put}_required_device() helper
Date: Mon, 10 Sep 2018 16:18:53 +0200
Message-ID: <CAPDyKFrM2x9NwSS0JTjoyu-SdtckQdbZHjWeqmH8NF3_Q2tw-w@mail.gmail.com>
References: <cover.1530252803.git.viresh.kumar@linaro.org> <282ac8092650c95595c84213dc87a4bf6b278da8.1530252803.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <282ac8092650c95595c84213dc87a4bf6b278da8.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29 June 2018 at 08:19, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Multiple generic power domains for a device are supported with the help
> of virtual devices, which are created for each device-genpd pair. These

What "device-genpd" pair are you referring to?

> are the device structures which are attached to the power domain and are
> required by the OPP core to set the performance state of the genpd.
>
> The helpers added by this commit are required to be called once for each
> genpd of a device. These are required only if multiple domains are
> present for a device, otherwise the actual device structure will be used
> instead by the OPP core.
>
> This commit also updates the genpd core to automatically call the new
> helper to set the required devices with the OPP layer, whenever the
> virtual devices are created for multiple genpd. The prototype of
> __genpd_dev_pm_attach() is slightly updated for this.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 31 ++++++++++++++---
>  drivers/opp/core.c          | 69 +++++++++++++++++++++++++++++++++++++
>  drivers/opp/of.c            | 12 +++++++
>  drivers/opp/opp.h           |  2 ++
>  include/linux/pm_opp.h      |  8 +++++
>  5 files changed, 118 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index c298de8a8308..e9c85c96580c 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2219,8 +2219,14 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>         genpd_queue_power_off_work(pd);
>
>         /* Unregister the device if it was created by genpd. */
> -       if (dev->bus == &genpd_bus_type)
> +       if (dev->bus == &genpd_bus_type) {
> +               struct opp_table *opp_table = dev_get_drvdata(dev);

This feels wrong, to me. Genpd is not a driver, but rather a
subsystem, hence I think it's a bad idea to "abuse" the driver data
pointer like this.

Instead, in genpd we store device specific data, through the
dev->power.subsys_data.

Seems like a better option is to extend the subsys_data, to also
include data needed to be shared for opp/performance states.

In that way, we might not even need to call into the opp library
(dev_pm_opp_set_required_device()) API, but rather the opp library can
itself check what is in the subsys_data for the device that is being
targeted. Would that work?

[...]

Kind regards
Uffe
