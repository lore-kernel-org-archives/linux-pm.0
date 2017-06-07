From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] thermal: int340x: check for sensor when PTYP is missing
Date: Wed, 7 Jun 2017 13:55:39 +0300
Message-ID: <CAHp75VfvVNFRiVMnGEe96C84AkxKs=hR29q8dp701Q4OyNO47g@mail.gmail.com>
References: <1496790041-104500-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35575 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbdFGKzk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jun 2017 06:55:40 -0400
In-Reply-To: <1496790041-104500-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jun 7, 2017 at 2:00 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> For INT3403 sensor PTYP field is mandatory. But some platforms didn't
> have this field for sensors. This cause load failure for int3403 driver.
>
> This change checks for the presence of _TMP method and if present, then
> treats this device as a sensor.

>         status = acpi_evaluate_integer(priv->adev->handle, "PTYP",
>                                        NULL, &priv->type);
>         if (ACPI_FAILURE(status)) {
> -               result = -EINVAL;
> -               goto err;

> +               unsigned long long tmp;

You may use &priv->type as temporary variable, though I would go other
way around:
declare tmp for function, then

    unsigned long long tmp;
...
    status = acpi_evaluate_integer(priv->adev->handle, "PTYP",  NULL, &tmp);
    if (ACPI_FAILURE(status)) {
        status = acpi_evaluate_integer(priv->adev->handle, "_TMP", NULL, &tmp);
        if (ACPI_FAILURE(status)) {
            result = -EINVAL;
            goto err;
        }
        tmp = INT3403_TYPE_SENSOR;
    }
    priv->type = tmp;

> +               } else {

This is redundant.

> +                       priv->type = INT3403_TYPE_SENSOR;
> +               }
>         }

-- 
With Best Regards,
Andy Shevchenko
