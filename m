From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/6] thermal: spear: remove unnecessary platform_set_drvdata()
Date: Sun, 12 May 2013 20:35:20 +0530
Message-ID: <CAOh2x=n-t+UEe_bW+H_fi2LEAd4RzPPnJU3e+-1gNh3N_oDPZA@mail.gmail.com>
References: <004401ce4a13$0a2e3ec0$1e8abc40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:36719 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135Ab3ELPFV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 May 2013 11:05:21 -0400
Received: by mail-ve0-f175.google.com with SMTP id cz11so2433797veb.6
        for <linux-pm@vger.kernel.org>; Sun, 12 May 2013 08:05:20 -0700 (PDT)
In-Reply-To: <004401ce4a13$0a2e3ec0$1e8abc40$@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, Vincenzo Frascino <vincenzo.frascino@st.com>

On Mon, May 6, 2013 at 10:04 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/thermal/spear_thermal.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
> index 3c5ee56..1a14eaa 100644
> --- a/drivers/thermal/spear_thermal.c
> +++ b/drivers/thermal/spear_thermal.c
> @@ -174,7 +174,6 @@ static int spear_thermal_exit(struct platform_device *pdev)
>         struct spear_thermal_dev *stdev = spear_thermal->devdata;
>
>         thermal_zone_device_unregister(spear_thermal);
> -       platform_set_drvdata(pdev, NULL);
>
>         /* Disable SPEAr Thermal Sensor */
>         actual_mask = readl_relaxed(stdev->thermal_base);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
