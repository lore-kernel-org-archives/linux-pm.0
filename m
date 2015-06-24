From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 6/8] mfd: make mfd_remove_devices() iterate in reverse
 order
Date: Wed, 24 Jun 2015 12:31:44 +0100
Message-ID: <20150624113144.GL15013@x1>
References: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1434362256-239992-7-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:35080 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbbFXLbt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 07:31:49 -0400
Received: by wgbhy7 with SMTP id hy7so33622514wgb.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2015 04:31:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434362256-239992-7-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>

On Mon, 15 Jun 2015, Andy Shevchenko wrote:

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

Applied, thanks.

> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 1aed3b7..79eeaa5 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -300,7 +300,7 @@ void mfd_remove_devices(struct device *parent)
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
