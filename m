From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Fix bad of_node_put() in failure paths of genpd_dev_pm_attach()
Date: Thu, 3 Dec 2015 11:17:27 +0100
Message-ID: <CAPDyKFqj8bXjhyAgC=Qc4YW+Vz3bu0LacJymp11wbbMiuW+VyA@mail.gmail.com>
References: <1448991571-20301-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448991571-20301-1-git-send-email-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 1 December 2015 at 18:39, Eric Anholt <eric@anholt.net> wrote:
> It looks like these meant to be unreffing the
> of_parse_phandle_with_args() node, since the error paths above it
> don't do of_node_put.  That function returns a new ref in pd_args.np,
> though, not a new ref on dev->of_node.  Also, it would have leaked the
> ref in the success case.
>
> Fixes "ERROR: Bad of_node_put()" on bcm2835 when hitting the
> -EPROBE_DEFER case.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Thanks for the fix!

Perhaps we should add a fixes tag, as the problem been there since we
introduced the OF support.

Fixes: aa42240ab254 ("PM / Domains: Add generic OF-based PM domain look-up")

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e03b1ad..167418e 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1775,10 +1775,10 @@ int genpd_dev_pm_attach(struct device *dev)
>         }
>
>         pd = of_genpd_get_from_provider(&pd_args);
> +       of_node_put(pd_args.np);
>         if (IS_ERR(pd)) {
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
> -               of_node_put(dev->of_node);
>                 return -EPROBE_DEFER;
>         }
>
> @@ -1796,7 +1796,6 @@ int genpd_dev_pm_attach(struct device *dev)
>         if (ret < 0) {
>                 dev_err(dev, "failed to add to PM domain %s: %d",
>                         pd->name, ret);
> -               of_node_put(dev->of_node);
>                 goto out;
>         }
>
> --
> 2.6.2
>
