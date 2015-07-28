From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 3/8] Driver core: wakeup the parent device before
 trying probe
Date: Tue, 28 Jul 2015 08:47:43 +0100
Message-ID: <20150728074743.GQ21114@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1438009443-55317-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438009443-55317-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Jul 2015, Andy Shevchenko wrote:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> If the parent is still suspended when driver probe is
> attempted, the result may be failure.
>=20
> For example, if the parent is a PCI MFD device that has been
> suspended when we try to probe our device, any register
> reads will return 0xffffffff.
>=20
> To fix the problem, making sure the parent is always awake
> before attempting driver probe.
>=20
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/dd.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Applied, thanks.  Pull request to follow.

> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index a638bbb..2d6df1d 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -399,6 +399,8 @@ EXPORT_SYMBOL_GPL(wait_for_device_probe);
>   *
>   * This function must be called with @dev lock held.  When called fo=
r a
>   * USB interface, @dev->parent lock must be held as well.
> + *
> + * If the device has a parent, runtime-resume the parent before driv=
er probing.
>   */
>  int driver_probe_device(struct device_driver *drv, struct device *de=
v)
>  {
> @@ -410,10 +412,16 @@ int driver_probe_device(struct device_driver *d=
rv, struct device *dev)
>  	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
>  		 drv->bus->name, __func__, dev_name(dev), drv->name);
> =20
> +	if (dev->parent)
> +		pm_runtime_get_sync(dev->parent);
> +
>  	pm_runtime_barrier(dev);
>  	ret =3D really_probe(dev, drv);
>  	pm_request_idle(dev);
> =20
> +	if (dev->parent)
> +		pm_runtime_put(dev->parent);
> +
>  	return ret;
>  }
> =20
> @@ -507,11 +515,17 @@ static void __device_attach_async_helper(void *=
_dev, async_cookie_t cookie)
> =20
>  	device_lock(dev);
> =20
> +	if (dev->parent)
> +		pm_runtime_get_sync(dev->parent);
> +
>  	bus_for_each_drv(dev->bus, NULL, &data, __device_attach_driver);
>  	dev_dbg(dev, "async probe completed\n");
> =20
>  	pm_request_idle(dev);
> =20
> +	if (dev->parent)
> +		pm_runtime_put(dev->parent);
> +
>  	device_unlock(dev);
> =20
>  	put_device(dev);
> @@ -541,6 +555,9 @@ static int __device_attach(struct device *dev, bo=
ol allow_async)
>  			.want_async =3D false,
>  		};
> =20
> +		if (dev->parent)
> +			pm_runtime_get_sync(dev->parent);
> +
>  		ret =3D bus_for_each_drv(dev->bus, NULL, &data,
>  					__device_attach_driver);
>  		if (!ret && allow_async && data.have_async) {
> @@ -557,6 +574,9 @@ static int __device_attach(struct device *dev, bo=
ol allow_async)
>  		} else {
>  			pm_request_idle(dev);
>  		}
> +
> +		if (dev->parent)
> +			pm_runtime_put(dev->parent);
>  	}
>  out_unlock:
>  	device_unlock(dev);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
