From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/8] PM / Domains: Add lockdep asserts for domains list mutex
Date: Mon, 12 Jun 2017 21:09:59 +0200
Message-ID: <CAPDyKFr=-Ty9ZQ276nmkAPnJjwc3PmuKSdJrOqeEYcxbgfypYA@mail.gmail.com>
References: <20170612151748.7380-1-krzk@kernel.org> <20170612151748.7380-4-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35835 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbdFLTKA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 15:10:00 -0400
Received: by mail-qt0-f180.google.com with SMTP id w1so138336334qtg.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2017 12:10:00 -0700 (PDT)
In-Reply-To: <20170612151748.7380-4-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12 June 2017 at 17:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Add lockdep checks for holding mutex protecting the list of domains.
> This might expose misuse even though only file-scope functions use it
> for now.

I think it seems a bit silly to use these lockdep checks as these
functions are as you state above, static functions. Moreover there are
called from a quite limited amount of places.

Do you really think this add some value?

Kind regards
Uffe

>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/base/power/domain.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 983f086ab235..9d3d3c2a5979 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -726,6 +726,8 @@ static bool pm_genpd_present(const struct generic_pm_domain *genpd)
>  {
>         const struct generic_pm_domain *gpd;
>
> +       lockdep_assert_held(&gpd_list_lock);
> +
>         if (IS_ERR_OR_NULL(genpd))
>                 return false;
>
> @@ -1321,6 +1323,8 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>         struct gpd_link *link, *itr;
>         int ret = 0;
>
> +       lockdep_assert_held(&gpd_list_lock);
> +
>         if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain)
>             || genpd == subdomain)
>                 return -EINVAL;
> @@ -1528,6 +1532,8 @@ static int genpd_remove(struct generic_pm_domain *genpd)
>  {
>         struct gpd_link *l, *link;
>
> +       lockdep_assert_held(&gpd_list_lock);
> +
>         if (IS_ERR_OR_NULL(genpd))
>                 return -EINVAL;
>
> --
> 2.9.3
>
