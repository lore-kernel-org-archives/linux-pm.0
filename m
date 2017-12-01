From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 2/3] PM / core: Add IN_BAND_WAKEUP driver flag
Date: Fri, 1 Dec 2017 12:17:09 +0100
Message-ID: <CAKfTPtAyn-SZL6hq3nrUbWhccjKxx3EHdvD7stf1RnqMTQ4-xQ@mail.gmail.com>
References: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org> <1510588003-16650-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510588003-16650-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

you have left some old naming WAKEUP_POWERED in your patch

On 13 November 2017 at 16:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> For some bus types and PM domains, it's not sufficient to only check the
> return value from device_may_wakeup(), to fully understand how to configure
> wakeup settings for the device during system suspend.
>
[snip]

> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 65d3911..4efb16a 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -559,6 +559,7 @@ struct pm_subsys_data {
>   * NEVER_SKIP: Do not skip system suspend/resume callbacks for the device.
>   * SMART_PREPARE: Check the return value of the driver's ->prepare callback.
>   * SMART_SUSPEND: No need to resume the device from runtime suspend.
> + * WAKEUP_POWERED: Keep the device powered if it has wakeup enabled.

it should be IN_BAND_WAKEUP ?

>   *
>   * Setting SMART_PREPARE instructs bus types and PM domains which may want
>   * system suspend/resume callbacks to be skipped for the device to return 0 from
> @@ -572,10 +573,14 @@ struct pm_subsys_data {
>   * necessary from the driver's perspective.  It also may cause them to skip
>   * invocations of the ->suspend_late and ->suspend_noirq callbacks provided by
>   * the driver if they decide to leave the device in runtime suspend.
> + *
> + * Setting WAKEUP_POWERED instructs bus types and PM domains that the device

it should be IN_BAND_WAKEUP ?

> + * needs to remain powered in system suspend, in case wakeup is enabled for it.
>   */
>  #define DPM_FLAG_NEVER_SKIP    BIT(0)
>  #define DPM_FLAG_SMART_PREPARE BIT(1)
>  #define DPM_FLAG_SMART_SUSPEND BIT(2)
> +#define DPM_FLAG_IN_BAND_WAKEUP        BIT(3)
>
>  struct dev_pm_info {
>         pm_message_t            power_state;
> @@ -595,6 +600,7 @@ struct dev_pm_info {
>         struct completion       completion;
>         struct wakeup_source    *wakeup;
>         bool                    wakeup_path:1;
> +       bool                    wakeup_path_in_band:1;
>         bool                    syscore:1;
>         bool                    no_pm_callbacks:1;      /* Owned by the PM core */
>  #else
> --
> 2.7.4
>
