From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 5/8] driver core: implement
 device_for_each_child_reverse()
Date: Tue, 28 Jul 2015 08:48:06 +0100
Message-ID: <20150728074806.GS21114@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1438009443-55317-6-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34439 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbbG1HsL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 03:48:11 -0400
Received: by wibud3 with SMTP id ud3so168933125wib.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 00:48:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1438009443-55317-6-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org

On Mon, 27 Jul 2015, Andy Shevchenko wrote:

> The new function device_for_each_child_reverse() is helpful to traver=
se the
> registered devices in a reversed order, e.g. in the case when an oper=
ation on
> each device should be done first on the last added device, then on on=
e before
> last and so on.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++=
+++
>  include/linux/device.h |  2 ++
>  2 files changed, 45 insertions(+)

Applied, thanks.  Pull request to follow.

> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index dafae6d..7d62795 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1252,6 +1252,19 @@ void device_unregister(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(device_unregister);
> =20
> +static struct device *prev_device(struct klist_iter *i)
> +{
> +	struct klist_node *n =3D klist_prev(i);
> +	struct device *dev =3D NULL;
> +	struct device_private *p;
> +
> +	if (n) {
> +		p =3D to_device_private_parent(n);
> +		dev =3D p->device;
> +	}
> +	return dev;
> +}
> +
>  static struct device *next_device(struct klist_iter *i)
>  {
>  	struct klist_node *n =3D klist_next(i);
> @@ -1341,6 +1354,36 @@ int device_for_each_child(struct device *paren=
t, void *data,
>  EXPORT_SYMBOL_GPL(device_for_each_child);
> =20
>  /**
> + * device_for_each_child_reverse - device child iterator in reversed=
 order.
> + * @parent: parent struct device.
> + * @fn: function to be called for each device.
> + * @data: data for the callback.
> + *
> + * Iterate over @parent's child devices, and call @fn for each,
> + * passing it @data.
> + *
> + * We check the return of @fn each time. If it returns anything
> + * other than 0, we break out and return that value.
> + */
> +int device_for_each_child_reverse(struct device *parent, void *data,
> +				  int (*fn)(struct device *dev, void *data))
> +{
> +	struct klist_iter i;
> +	struct device *child;
> +	int error =3D 0;
> +
> +	if (!parent->p)
> +		return 0;
> +
> +	klist_iter_init(&parent->p->klist_children, &i);
> +	while ((child =3D prev_device(&i)) && !error)
> +		error =3D fn(child, data);
> +	klist_iter_exit(&i);
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
> +
> +/**
>   * device_find_child - device iterator for locating a particular dev=
ice.
>   * @parent: parent struct device
>   * @match: Callback function to check device
> diff --git a/include/linux/device.h b/include/linux/device.h
> index a2b4ea7..9d212fe 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -959,6 +959,8 @@ extern int __must_check device_add(struct device =
*dev);
>  extern void device_del(struct device *dev);
>  extern int device_for_each_child(struct device *dev, void *data,
>  		     int (*fn)(struct device *dev, void *data));
> +extern int device_for_each_child_reverse(struct device *dev, void *d=
ata,
> +		     int (*fn)(struct device *dev, void *data));
>  extern struct device *device_find_child(struct device *dev, void *da=
ta,
>  				int (*match)(struct device *dev, void *data));
>  extern int device_rename(struct device *dev, const char *new_name);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
