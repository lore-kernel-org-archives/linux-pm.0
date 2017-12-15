From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] PM / Domains: Take WAKEUP_PATH driver flag into
 account in genpd
Date: Fri, 15 Dec 2017 17:02:45 +0100
Message-ID: <CAPDyKFqoUT6cYoCVyXGj7wsjunKmfUYPLyZ7=9S4LaGEP-F36w@mail.gmail.com>
References: <1513353391-30806-1-git-send-email-ulf.hansson@linaro.org> <1513353391-30806-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513353391-30806-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 15 December 2017 at 16:56, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> In case the WAKEUP_PATH flag has been set in a later phase than from the
> ->suspend() callback, the PM core want set the ->power.wakeup_path status

/s/want/don't

If another version is needed I fix, else perhaps you can just amend the patch!?

Kind regards
Uffe

> flag for the device. Therefore, let's be safe and check it explicitly.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index f9dcc98..32b4ba7 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1038,7 +1038,9 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
>         if (IS_ERR(genpd))
>                 return -EINVAL;
>
> -       if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
> +       if ((dev->power.wakeup_path ||
> +           dev_pm_test_driver_flags(dev, DPM_FLAG_WAKEUP_PATH)) &&
> +           genpd_is_active_wakeup(genpd))
>                 return 0;
>
>         if (poweroff)
> @@ -1093,7 +1095,9 @@ static int genpd_resume_noirq(struct device *dev)
>         if (IS_ERR(genpd))
>                 return -EINVAL;
>
> -       if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
> +       if ((dev->power.wakeup_path ||
> +           dev_pm_test_driver_flags(dev, DPM_FLAG_WAKEUP_PATH)) &&
> +           genpd_is_active_wakeup(genpd))
>                 return 0;
>
>         genpd_lock(genpd);
> --
> 2.7.4
>
