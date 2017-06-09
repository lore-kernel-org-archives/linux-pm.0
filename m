From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V7 1/2] PM / Domains: Add support to select
 performance-state of domains
Date: Fri, 9 Jun 2017 13:00:04 +0200
Message-ID: <CAPDyKFrBnAzz6wYvmk7xtdeFUH+sEVLCE2WhMFtwipby-Xj8_w@mail.gmail.com>
References: <cover.1495003720.git.viresh.kumar@linaro.org> <4cc55fce0fd4199941f1d7b785e677255ff792d5.1495003720.git.viresh.kumar@linaro.org>
 <CAPDyKFoWXPJx9pahzv6CkXosncODHSThYA9MoMVdruRtzHRyZg@mail.gmail.com>
 <20170608070505.GB4634@vireshk-i7> <CAPDyKFo1-BN2PqXZgKUCGee_QH1zevXFLFSO2+TaCpkWxd5r-g@mail.gmail.com>
 <20170608094251.GC4634@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608094251.GC4634@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On 8 June 2017 at 11:42, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-06-17, 09:48, Ulf Hansson wrote:
>> It's not a nightmare, just a tricky thing to solve. :-)
>
> I may have just solved it actually :)

That was quick. :-)

>
> So the real locking problem was the case where a subdomain have multiple parent
> domains and how do we access its performance_state field from all the paths that
> originate from the parent's update and from the subdomains own path. And a
> single performance_state field isn't going to help in that as multiple locks are
> involved here. I have added another per parent-domain field and that will help
> get the locking quite simple. Here is the new patch (compile tested):

Obviously you didn't think about this long enough. Please spare me
from having to review something of this complexity just being compile
tested. I don't have unlimited bandwidth. :-)

I recommend at least some functional tests run together with lockdep tests.

>
> ---
>  drivers/base/power/domain.c | 193 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  22 +++++
>  2 files changed, 215 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 71c95ad808d5..40815974287f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -466,6 +466,187 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
>         return NOTIFY_DONE;
>  }
>
> +/*
> + * Returns true if anyone in genpd's parent hierarchy has
> + * set_performance_state() set.
> + */
> +static bool genpd_has_set_performance_state(struct generic_pm_domain *genpd)
> +{
> +       struct gpd_link *link;
> +
> +       if (genpd->set_performance_state)
> +               return true;
> +
> +       list_for_each_entry(link, &genpd->slave_links, slave_node) {
> +               if (genpd_has_set_performance_state(link->master))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +/**
> + * pm_genpd_has_performance_state - Checks if power domain does performance
> + * state management.
> + *
> + * @dev: Device whose power domain is getting inquired.
> + */
> +bool pm_genpd_has_performance_state(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd = dev_to_genpd(dev);
> +
> +       /* The parent domain must have set get_performance_state() */
> +       if (!IS_ERR(genpd) && genpd->get_performance_state)
> +               return true;
> +
> +       return false;
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_has_performance_state);

I think you didn't read my earlier comments well enough.

Who is going to call this? What prevents the genpd object from being
removed in the middle of when you are operating on the genpd pointer?
How can you even be sure the pm_domain pointer is a valid genpd
object?

[...]

Kind regards
Uffe
