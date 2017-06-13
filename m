From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFT v2 2/8] PM / Domains: Handle safely genpd_syscore_switch()
 call on non-genpd device
Date: Tue, 13 Jun 2017 12:38:01 +0200
Message-ID: <CAPDyKFqYySVe3KC8vT6XW52mjnxZZFu5VVKJ373DA2B8Z8GiGg@mail.gmail.com>
References: <20170612151748.7380-1-krzk@kernel.org> <20170612151748.7380-3-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33610 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbdFMKiD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jun 2017 06:38:03 -0400
Received: by mail-qt0-f179.google.com with SMTP id u12so165140750qth.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Jun 2017 03:38:02 -0700 (PDT)
In-Reply-To: <20170612151748.7380-3-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12 June 2017 at 17:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> genpd_syscore_switch() had two problems:
> 1. It silently assumed that device, it is being called for, belongs to
>    generic power domain and used container_of() on its power domain
>    pointer.  Such assumption might not be true always.
>
> 2. It iterated over list of generic power domains without holding
>    gpd_list_lock mutex thus list could have been modified in the same
>    time.
>
> Usage of genpd_lookup_dev() solves both problems as it is safe a call
> for non-generic power domains and uses mutex when iterating.
>
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Not tested on real hardware.

When tested you may add my:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2e8d0f423507..983f086ab235 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1098,8 +1098,8 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
>  {
>         struct generic_pm_domain *genpd;
>
> -       genpd = dev_to_genpd(dev);
> -       if (!pm_genpd_present(genpd))
> +       genpd = genpd_lookup_dev(dev);
> +       if (!genpd)
>                 return;
>
>         if (suspend) {
> --
> 2.9.3
>
