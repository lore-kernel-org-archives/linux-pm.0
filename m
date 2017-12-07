From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Fix handling of suppliers with disabled
 runtime PM
Date: Thu, 7 Dec 2017 20:48:52 +0100
Message-ID: <CAPDyKFpUsgO1H93QLttTZ65LnXUOBxoKzLxnt5B50+UidWFJ5Q@mail.gmail.com>
References: <1532136.s6buYvDjaS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532136.s6buYvDjaS@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Lukas Wunner <lukas@wunner.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On 1 December 2017 at 14:58, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Prevent rpm_get_suppliers() from returning an error code if runtime
> PM is disabled for one or more of the supplier devices it wants to
> runtime-resume, so as to make runtime PM work for devices with links
> to suppliers that don't use runtime PM (such links may be created
> during device enumeration even before it is known whether or not
> runtime PM will be enabled for the devices in question, for example).
>
> Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 21d5c57b3726 (PM / runtime: Use device links)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/runtime.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -276,7 +276,8 @@ static int rpm_get_suppliers(struct devi
>                         continue;
>
>                 retval = pm_runtime_get_sync(link->supplier);
> -               if (retval < 0) {
> +               /* Ignore suppliers with disabled runtime PM. */
> +               if (retval < 0 && retval != -EACCES) {
>                         pm_runtime_put_noidle(link->supplier);
>                         return retval;
>                 }
>
