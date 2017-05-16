From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: pdd->dev can't be NULL in genpd_dev_pm_qos_notifier()
Date: Tue, 16 May 2017 08:46:06 +0200
Message-ID: <CAPDyKFobbmoSZFmEhN+pCsZWGQx0Tn0eU-_c4gO5Ppcwgs=d1w@mail.gmail.com>
References: <201976beb620010271d6f842abbc40a93f55bd73.1494912124.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201976beb620010271d6f842abbc40a93f55bd73.1494912124.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 16 May 2017 at 07:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The pm_domain_data (pdd) pointer is set from genpd_alloc_dev_data() and
> pdd->dev is guaranteed to be valid. There is no need to check pdd and
> pdd->dev in rest of the code as pdd->dev will always be valid for a non
> NULL pdd pointer.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index da49a8383dc3..71c95ad808d5 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -443,7 +443,7 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
>
>                 pdd = dev->power.subsys_data ?
>                                 dev->power.subsys_data->domain_data : NULL;
> -               if (pdd && pdd->dev) {
> +               if (pdd) {
>                         to_gpd_data(pdd)->td.constraint_changed = true;
>                         genpd = dev_to_genpd(dev);
>                 } else {
> --
> 2.13.0.303.g4ebf3021692d
>
