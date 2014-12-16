From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: add some lockdep annotations
Date: Tue, 16 Dec 2014 11:01:12 +0530
Message-ID: <CAKohpo=EcaewdcOtdsa8urPOZtB86XDs1NP2xaLy4Lt=aOjPDA@mail.gmail.com>
References: <20141216004204.GA30467@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:44588 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbaLPFbM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 00:31:12 -0500
Received: by mail-ob0-f173.google.com with SMTP id uy5so21407658obc.4
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2014 21:31:12 -0800 (PST)
In-Reply-To: <20141216004204.GA30467@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 16 December 2014 at 06:12, Dmitry Torokhov <dtor@chromium.org> wrote:
> Certain OPP APIs need to be called under RCU lock; let's add a few
> rcu_lockdep_assert() calls to warn about potential misuse.

Very nice..

> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
> ---
>  drivers/base/power/opp.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index d24dd614a..852eebf 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -218,6 +218,11 @@ int dev_pm_opp_get_opp_count(struct device *dev)
>         struct dev_pm_opp *temp_opp;
>         int count = 0;
>
> +       rcu_lockdep_assert(rcu_read_lock_held() ||
> +                               lockdep_is_held(&dev_opp_list_lock),
> +                          "dev_pm_opp_get_opp_count() needs rcu_read_lock() "
> +                          "or dev_opp_list_lock protection");
> +
>         dev_opp = find_device_opp(dev);
>         if (IS_ERR(dev_opp)) {
>                 int r = PTR_ERR(dev_opp);
> @@ -267,6 +272,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>         struct device_opp *dev_opp;
>         struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
>
> +       rcu_lockdep_assert(rcu_read_lock_held() ||
> +                               lockdep_is_held(&dev_opp_list_lock),
> +                          "dev_pm_opp_find_freq_exact() needs rcu_read_lock() "
> +                          "or dev_opp_list_lock protection");
> +
>         dev_opp = find_device_opp(dev);
>         if (IS_ERR(dev_opp)) {
>                 int r = PTR_ERR(dev_opp);
> @@ -313,6 +323,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
>         struct device_opp *dev_opp;
>         struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
>
> +       rcu_lockdep_assert(rcu_read_lock_held() ||
> +                               lockdep_is_held(&dev_opp_list_lock),
> +                          "dev_pm_opp_find_freq_ceil() needs rcu_read_lock() "
> +                          "or dev_opp_list_lock protection");
> +
>         if (!dev || !freq) {
>                 dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
>                 return ERR_PTR(-EINVAL);
> @@ -361,6 +376,11 @@ struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
>         struct device_opp *dev_opp;
>         struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
>
> +       rcu_lockdep_assert(rcu_read_lock_held() ||
> +                               lockdep_is_held(&dev_opp_list_lock),
> +                          "dev_pm_opp_find_freq_floor() needs rcu_read_lock() "
> +                          "or dev_opp_list_lock protection");
> +

To get rid of the redundancy a bit, what about something like:

#define opp_rcu_lockdep_assert()        \
        rcu_lockdep_assert(rcu_read_lock_held() || \
                                        lockdep_is_held(&dev_opp_list_lock), \
                                        "Missing rcu_read_lock() or
dev_opp_list_lock protection");
