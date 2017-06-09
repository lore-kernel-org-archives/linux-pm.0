From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] thermal: int340x: check for sensor when PTYP is missing
Date: Fri, 09 Jun 2017 15:23:14 -0700
Message-ID: <1497046994.26258.9.camel@linux.intel.com>
References: <1496790041-104500-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <CAHp75VfvVNFRiVMnGEe96C84AkxKs=hR29q8dp701Q4OyNO47g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:21662 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751554AbdFIWXP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jun 2017 18:23:15 -0400
In-Reply-To: <CAHp75VfvVNFRiVMnGEe96C84AkxKs=hR29q8dp701Q4OyNO47g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 2017-06-07 at 13:55 +0300, Andy Shevchenko wrote:
> On Wed, Jun 7, 2017 at 2:00 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > For INT3403 sensor PTYP field is mandatory. But some platforms
> > didn't
> > have this field for sensors. This cause load failure for int3403
> > driver.
> > 
> > This change checks for the presence of _TMP method and if present,
> > then
> > treats this device as a sensor.
> > 
> >         status = acpi_evaluate_integer(priv->adev->handle, "PTYP",
> >                                        NULL, &priv->type);
> >         if (ACPI_FAILURE(status)) {
> > -               result = -EINVAL;
> > -               goto err;
> > 
> > +               unsigned long long tmp;
> You may use &priv->type as temporary variable, though I would go
> other
> way around:
> declare tmp for function, then
> 
>     unsigned long long tmp;
> ...
>     status = acpi_evaluate_integer(priv->adev->handle, "PTYP",  NULL,
> &tmp);
>     if (ACPI_FAILURE(status)) {
>         status = acpi_evaluate_integer(priv->adev->handle, "_TMP",
> NULL, &tmp);
>         if (ACPI_FAILURE(status)) {
>             result = -EINVAL;
>             goto err;
>         }
>         tmp = INT3403_TYPE_SENSOR;
>     }
>     priv->type = tmp;
> 
So what are we saving by doing this way?

Thanks,
Srinivas

> > 
> > +               } else {
> This is redundant.
> 
> > 
> > +                       priv->type = INT3403_TYPE_SENSOR;
> > +               }
> >         }
