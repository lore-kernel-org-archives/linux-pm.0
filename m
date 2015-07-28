From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 6/8] mfd: make mfd_remove_devices() iterate in reverse
 order
Date: Tue, 28 Jul 2015 08:48:17 +0100
Message-ID: <20150728074817.GT21114@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1438009443-55317-7-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438009443-55317-7-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Jul 2015, Andy Shevchenko wrote:

> The newly introduced device_for_each_child_reverse() would be used wh=
en MFD
> core removes the device.
>=20
> After this patch applied the devices will be removed in a reversed or=
der. This
> behaviour is useful when devices have implicit dependency on order, i=
=2Ee.
> consider MFD device with serial bus controller, such as SPI, and DMA =
IP that is
> attached to serial bus controller: before remove the DMA driver we ha=
ve to be
> ensured that no DMA transfers is ongoing and the requested channel ar=
e unused.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/mfd-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.  Pull request to follow.

> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 14fd5cb..c17635d 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -302,7 +302,7 @@ void mfd_remove_devices(struct device *parent)
>  {
>  	atomic_t *cnts =3D NULL;
> =20
> -	device_for_each_child(parent, &cnts, mfd_remove_devices_fn);
> +	device_for_each_child_reverse(parent, &cnts, mfd_remove_devices_fn)=
;
>  	kfree(cnts);
>  }
>  EXPORT_SYMBOL(mfd_remove_devices);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
