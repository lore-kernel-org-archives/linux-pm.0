From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] driver core: Silence device links sphinx warning
Date: Mon, 5 Dec 2016 23:21:21 +0100
Message-ID: <CAJZ5v0gVyQYm3YEjyhC5FeSV-qnj9UMG=-7uO4Ni6PhwqmrO_w@mail.gmail.com>
References: <cover.1480849144.git.lukas@wunner.de> <a1c7a93ee8ef057fb70aa3abeed38daf989444fc.1480849144.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <a1c7a93ee8ef057fb70aa3abeed38daf989444fc.1480849144.git.lukas@wunner.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Silvio Fricke <silvio.fricke@gmail.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Inki Dae <inki.dae@samsung.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 4, 2016 at 1:10 PM, Lukas Wunner <lukas@wunner.de> wrote:
> Silence this warning emitted by sphinx:
> include/linux/device.h:938: warning: No description found for parameter 'links'
>
> While at it, fix typos in comments of device links code.
>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Silvio Fricke <silvio.fricke@gmail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and thanks for fixing these!

[Adds note to self to spellcheck patches next time.]

> ---
>  drivers/base/core.c    | 4 ++--
>  include/linux/device.h | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d0c9df5..8c25e68 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -172,7 +172,7 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>   *
>   * The supplier device is required to be registered when this function is called
>   * and NULL will be returned if that is not the case.  The consumer device need
> - * not be registerd, however.
> + * not be registered, however.
>   */
>  struct device_link *device_link_add(struct device *consumer,
>                                     struct device *supplier, u32 flags)
> @@ -225,7 +225,7 @@ struct device_link *device_link_add(struct device *consumer,
>         INIT_LIST_HEAD(&link->c_node);
>         link->flags = flags;
>
> -       /* Deterine the initial link state. */
> +       /* Determine the initial link state. */
>         if (flags & DL_FLAG_STATELESS) {
>                 link->status = DL_STATE_NONE;
>         } else {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 3896af4..87edfdf 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -813,6 +813,7 @@ struct dev_links_info {
>   *             on.  This shrinks the "Board Support Packages" (BSPs) and
>   *             minimizes board-specific #ifdefs in drivers.
>   * @driver_data: Private pointer for driver specific info.
> + * @links:     Links to suppliers and consumers of this device.
>   * @power:     For device power management.
>   *             See Documentation/power/admin-guide/devices.rst for details.
>   * @pm_domain: Provide callbacks that are executed during system suspend,
> --
> 2.10.2
>
