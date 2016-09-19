From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 13/14] power: reset: Add Intel PIIX4 poweroff driver
Date: Tue, 20 Sep 2016 01:42:42 +0200
Message-ID: <20160919234242.23xyy2y3zjvuhate@earth>
References: <20160919212132.28893-1-paul.burton@imgtec.com>
 <20160919212132.28893-14-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ry5ybowm3ceq2u3n"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160919212132.28893-14-paul.burton@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, Chris Brand <chris.brand@broadcom.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Andy Yan <andy.yan@rock-chips.com>, Krzysztof Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, John Stultz <john.stultz@linaro.org>
List-Id: linux-pm@vger.kernel.org


--ry5ybowm3ceq2u3n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 19, 2016 at 10:21:30PM +0100, Paul Burton wrote:
> Add a driver which allows powering off the system via an Intel PIIX4
> southbridge, by entering the PIIX4 SOff state. This is useful on the
> MIPS Malta development board, where it will power down the FPGA based
> board until its ON/NMI button is pressed, or the QEMU implementation of
> the MIPS Malta board where it will cause QEMU to exit.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>=20
> ---
>=20
> Changes in v2:
> - Add MODULE_LICENSE
> - Allow non-MIPS builds with COMPILE_TEST
>=20
>  drivers/power/reset/Kconfig          |  10 ++++
>  drivers/power/reset/Makefile         |   1 +
>  drivers/power/reset/piix4-poweroff.c | 104 +++++++++++++++++++++++++++++=
++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/power/reset/piix4-poweroff.c
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index c74c3f6..abeb772 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -104,6 +104,16 @@ config POWER_RESET_MSM
>  	help
>  	  Power off and restart support for Qualcomm boards.
> =20
> +config POWER_RESET_PIIX4_POWEROFF
> +	tristate "Intel PIIX4 power-off driver"
> +	depends on PCI
> +	depends on MIPS || COMPILE_TEST
> +	help
> +	  This driver supports powering off a system using the Intel PIIX4
> +	  southbridge, for example the MIPS Malta development board. The
> +	  southbridge SOff state is entered in response to a request to
> +	  power off the system.
> +
>  config POWER_RESET_LTC2952
>  	bool "LTC2952 PowerPath power-off driver"
>  	depends on OF_GPIO
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 1be307c..11dae3b 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restar=
t.o
>  obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
>  obj-$(CONFIG_POWER_RESET_IMX) +=3D imx-snvs-poweroff.o
>  obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
> +obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
>  obj-$(CONFIG_POWER_RESET_LTC2952) +=3D ltc2952-poweroff.o
>  obj-$(CONFIG_POWER_RESET_QNAP) +=3D qnap-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RESTART) +=3D restart-poweroff.o
> diff --git a/drivers/power/reset/piix4-poweroff.c b/drivers/power/reset/p=
iix4-poweroff.c
> new file mode 100644
> index 0000000..11f0999
> --- /dev/null
> +++ b/drivers/power/reset/piix4-poweroff.c
> @@ -0,0 +1,104 @@
> +/*
> + * Copyright (C) 2016 Imagination Technologies
> + * Author: Paul Burton <paul.burton@imgtec.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pm.h>
> +
> +static struct pci_dev *pm_dev;
> +static resource_size_t io_offset;
> +
> +enum piix4_pm_io_reg {
> +	PIIX4_FUNC3IO_PMSTS			=3D 0x00,
> +#define PIIX4_FUNC3IO_PMSTS_PWRBTN_STS		BIT(8)
> +	PIIX4_FUNC3IO_PMCNTRL			=3D 0x04,
> +#define PIIX4_FUNC3IO_PMCNTRL_SUS_EN		BIT(13)
> +#define PIIX4_FUNC3IO_PMCNTRL_SUS_TYP_SOFF	(0x0 << 10)
> +};
> +
> +#define PIIX4_SUSPEND_MAGIC			0x00120002
> +
> +static void piix4_poweroff(void)
> +{
> +	int spec_devid;
> +	u16 sts;
> +
> +	/* Ensure the power button status is clear */
> +	while (1) {
> +		sts =3D inw(io_offset + PIIX4_FUNC3IO_PMSTS);
> +		if (!(sts & PIIX4_FUNC3IO_PMSTS_PWRBTN_STS))
> +			break;
> +		outw(sts, io_offset + PIIX4_FUNC3IO_PMSTS);
> +	}
> +
> +	/* Enable entry to suspend */
> +	outw(PIIX4_FUNC3IO_PMCNTRL_SUS_TYP_SOFF | PIIX4_FUNC3IO_PMCNTRL_SUS_EN,
> +	     io_offset + PIIX4_FUNC3IO_PMCNTRL);
> +
> +	/* If the special cycle occurs too soon this doesn't work... */
> +	mdelay(10);
> +
> +	/*
> +	 * The PIIX4 will enter the suspend state only after seeing a special
> +	 * cycle with the correct magic data on the PCI bus. Generate that
> +	 * cycle now.
> +	 */
> +	spec_devid =3D PCI_DEVID(0, PCI_DEVFN(0x1f, 0x7));
> +	pci_bus_write_config_dword(pm_dev->bus, spec_devid, 0,
> +				   PIIX4_SUSPEND_MAGIC);
> +
> +	/* Give the system some time to power down, then error */
> +	mdelay(1000);
> +	pr_emerg("Unable to poweroff system\n");
> +}
> +
> +static int piix4_poweroff_probe(struct pci_dev *dev,
> +				const struct pci_device_id *id)
> +{
> +	int res, io_region =3D PCI_BRIDGE_RESOURCES;

if (pm_dev)
    return -EINVAL;

> +	/* Request access to the PIIX4 PM IO registers */
> +	res =3D pci_request_region(dev, io_region, "PIIX4 PM IO registers");
> +	if (res) {
> +		dev_err(&dev->dev, "failed to request PM IO registers: %d\n",
> +			res);
> +		return res;
> +	}
> +
> +	pm_dev =3D dev;
> +	io_offset =3D pci_resource_start(dev, io_region);
> +	pm_power_off =3D piix4_poweroff;
> +
> +	return 0;
> +}
> +
> +static void piix4_poweroff_remove(struct pci_dev *dev)
> +{
> +	if (pm_power_off =3D=3D piix4_poweroff)
> +		pm_power_off =3D NULL;

pci_release_region()

> +}
> +
> +static const struct pci_device_id piix4_poweroff_ids[] =3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3) },
> +	{ 0 },
> +};
> +
> +static struct pci_driver piix4_poweroff_driver =3D {
> +	.name		=3D "piix4-poweroff",
> +	.id_table	=3D piix4_poweroff_ids,
> +	.probe		=3D piix4_poweroff_probe,
> +	.remove		=3D piix4_poweroff_remove,
> +};
> +
> +module_pci_driver(piix4_poweroff_driver);
> +MODULE_AUTHOR("Paul Burton <paul.burton@imgtec.com>");
> +MODULE_LICENSE("GPL");

-- Sebastian

--ry5ybowm3ceq2u3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX4HfvAAoJENju1/PIO/qaAM8P/04ODRhU4jJQO230SgkMBaYg
X0NfnwFSsTlypQnklahBNuypGZmDaRetCAlXamlEGkr/IHxKbaJcCmLmFIJLDth8
gpPuhDyR6yU82moUjwB3mlkJSGA3ye8g5vGK8s6Eki3hxL8FLLUcfDHjU5qVn9gj
xZPxxJuEwMIJFa6bYIpOduiR0vL1BOoXZ2o62IobRDzqv6sa3XCK0Vf6ao+NKh+6
KeE/QGnOs4DJS2123mP0p06POBg3Emg+wdxg0AbbOvbKe7gjEAN8OjdQ9kZLLyGw
xyyBy8Q7t3I/M8eGR6z7TH8JkY0k7NZfReFvBdAQCE2u900F2HongLmTVOBtcQtW
Vkv0Wv3CB5qmSl5QF+FPe649XUfndywTIoWyJN4rk5wt+yjn3Hi36pSr7+PZUICK
NFNh//VAK8VcKDyMjG0MlY+CWav8hUIzdzP/PYBI5VPDoJ2cpPYbPBLD5tX+AHF3
eFvOxTOxzWlOKyaalG7pUMtpSGJCDi54MaOnPx15jSD+aXyQVBI/X+L8hvL0A+Bp
AEo59RO7T82X+qc+yMfWIP7Jx7uLU0MDCnQoHTf1k42sfyCsJMQ8wAZArqwLsFQ0
VImdSEiyaGasgi0px8iWvB0Zj8pSPQb+4MPvrsbnDIi+XNZgbzWemzgkCKz6mLdO
3wwOECxo+H0y5n+CKxif
=sozD
-----END PGP SIGNATURE-----

--ry5ybowm3ceq2u3n--
