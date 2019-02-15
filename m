From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] PM / Domains: Mark "name" const in dev_pm_domain_attach_by_name()
Date: Fri, 15 Feb 2019 11:27:50 +0100
Message-ID: <CAPDyKFpXc+0rAHOgKN+QDK0MH-4efUZJ8asuBkAwg+w73huzOw@mail.gmail.com>
References: <20190214181249.2749-1-dianders@chromium.org> <20190214181249.2749-2-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214181249.2749-2-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 14 Feb 2019 at 19:13, Douglas Anderson <dianders@chromium.org> wrote:
>
> As of the patch ("PM / Domains: Mark "name" const in
> genpd_dev_pm_attach_by_name()") it's clear that the name in
> dev_pm_domain_attach_by_name() can be const.  Mark it as so.  This
> allows drivers to pass in a name that was declared "const" in a
> driver.
>
> Fixes: 27dceb81f445 ("PM / Domains: Introduce dev_pm_domain_attach_by_name()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Perhaps fold $subject patch into patch1, they seems highly related.
Anyway, no strong opinion here.

Kind regards
Uffe

> ---
>
>  drivers/base/power/common.c | 2 +-
>  include/linux/pm_domain.h   | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index b413951c6abc..22aedb28aad7 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -160,7 +160,7 @@ EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_id);
>   * For a detailed function description, see dev_pm_domain_attach_by_id().
>   */
>  struct device *dev_pm_domain_attach_by_name(struct device *dev,
> -                                           char *name)
> +                                           const char *name)
>  {
>         if (dev->pm_domain)
>                 return ERR_PTR(-EEXIST);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 203be5082f33..1ed5874bcee0 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -341,7 +341,7 @@ int dev_pm_domain_attach(struct device *dev, bool power_on);
>  struct device *dev_pm_domain_attach_by_id(struct device *dev,
>                                           unsigned int index);
>  struct device *dev_pm_domain_attach_by_name(struct device *dev,
> -                                           char *name);
> +                                           const char *name);
>  void dev_pm_domain_detach(struct device *dev, bool power_off);
>  void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
>  #else
> @@ -355,7 +355,7 @@ static inline struct device *dev_pm_domain_attach_by_id(struct device *dev,
>         return NULL;
>  }
>  static inline struct device *dev_pm_domain_attach_by_name(struct device *dev,
> -                                                         char *name)
> +                                                         const char *name)
>  {
>         return NULL;
>  }
> --
> 2.21.0.rc0.258.g878e2cd30e-goog
>
