Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238FB24A06A;
	Thu,  2 Apr 2026 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775166755; cv=pass; b=E+0zVeprIVGOB0E0dPGQpdJyGlaE4gy1PKEdSxlnduKJltdrDeEIoz2sdsePja1NiWSzVmwYXixZ9+peiqfAG4s0rlxJCz2p45/VrjwQ6CvJz8kXQ+c8M0v/kW8gJB29gaJPt/oIfSE9fnx//DrztL+HbOGiQ+YnYAe3HgmhtgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775166755; c=relaxed/simple;
	bh=Hd64mnTQC54j4sK7QP5ykQ2oWewTj3xchF+/GPlTM6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aktrhm4ug4HmYL4B3NCJcnF9J6FJXFvUjUgM1LX72MsQD9Wl1d9Xu/ghzVVrfUgWugbtWfP8tpUsKinNvY/UeJvmcYjaF3WEqPlMFwGOwB4az5nXhZ6FJGD9tTi+JFAGYRlL4xpnF+Z4NflZOzaLSGxu92d3KzK1AouHYWohp78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=dxQsmrJy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="dxQsmrJy"
ARC-Seal: i=1; a=rsa-sha256; t=1775166741; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TSOJVVincdKiqkFQg4TZ6Hxj0Mk/jBhd7xCxhcjrM0Hpd7JPzMC5ZA5xUppNAZz2ZTDD7Yp1ocBzkHPipa3k87zCYx+EYk/vL21vmHG6K9SzAccNdgUnQSYRvjNrc9TjUBmWiLGauh/sVdkSri8antZmbLzQNNLwYXyKAETVbBQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775166741; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hNntrYgwhE2yuKEwu9jxpH/EM0IQsdWohxXsHIWzN9o=; 
	b=TZqv3n1He+SB6dwkmNi6vZF4HZG16FOtnBgWt1oG3JXKi22wkm+NRZNMJYVQ6C1HPuny3krbZwxsUoHEB42q+XqYlAAqu1rbhK5GBZG8F6DoYs6n4mtKUUdaRQi8yt7GMskrHilmAzoLL0jaxvWqHB+0NQz0jO8Qd77TWt11SFQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775166741;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=hNntrYgwhE2yuKEwu9jxpH/EM0IQsdWohxXsHIWzN9o=;
	b=dxQsmrJyLRW0ZNd0d6UAGzLxxY+JMlp7KqYBa9TYW48c+UB5pQsY+d+WRv8uqBR+
	ulDMcxBrtGVJ0Jdy02Ov15NX7KSv2xilzktULFeEEt9e3ZAR2dGDJ/dE5dwk9X6bnO1
	r2mpDozsDiBihkAgcwLTblVA/ICb9/3iSJLgN+Dc=
Received: by mx.zohomail.com with SMTPS id 1775166738733728.6517643282676;
	Thu, 2 Apr 2026 14:52:18 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 286321812B2; Thu, 02 Apr 2026 23:52:15 +0200 (CEST)
Date: Thu, 2 Apr 2026 23:52:14 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: geert@linux-m68k.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
	daniel@0x0f.com, laurent@vivier.eu, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] power: reset: Add QEMU virt-ctrl driver
Message-ID: <ac7kP64nbhZzwbJV@venus>
References: <20260222173225.1105572-1-visitorckw@gmail.com>
 <20260222173225.1105572-2-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ffgufuw4dmg3s7ce"
Content-Disposition: inline
In-Reply-To: <20260222173225.1105572-2-visitorckw@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/275.160.75
X-ZohoMailClient: External


--ffgufuw4dmg3s7ce
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/2] power: reset: Add QEMU virt-ctrl driver
MIME-Version: 1.0

Hi,

On Sun, Feb 22, 2026 at 05:32:24PM +0000, Kuan-Wei Chiu wrote:
> Add a new driver for the 'virt-ctrl' device found on QEMU virt machines
> (e.g. m68k). This device provides a simple interface for system reset
> and power off [1].
>=20
> This driver utilizes the modern system-off API to register callbacks
> for both system restart and power off. It also registers a reboot
> notifier to catch SYS_HALT events, ensuring that LINUX_REBOOT_CMD_HALT
> is properly handled. It is designed to be generic and can be reused by
> other architectures utilizing this QEMU device.
>=20
> Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ct=
rl.c [1]
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---

I think this should be merged with the second patch via the m68k
tree:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

> Changes in v3:
> - Add a reboot notifier to handle SYS_HALT.
> - Implement virt_ctrl_write32() to handle native endianness.
>=20
> I noticed devm_register_sys_off_handler() currently lacks a
> SYS_OFF_MODE_HALT. Therefore, I registered a standard reboot notifier
> for SYS_HALT, while keeping restart and power-off on the sys-off API.
>=20
>  MAINTAINERS                          |   6 ++
>  drivers/power/reset/Kconfig          |  10 +++
>  drivers/power/reset/Makefile         |   1 +
>  drivers/power/reset/qemu-virt-ctrl.c | 122 +++++++++++++++++++++++++++
>  4 files changed, 139 insertions(+)
>  create mode 100644 drivers/power/reset/qemu-virt-ctrl.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55af015174a5..aa9eb8540637 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21441,6 +21441,12 @@ S:	Maintained
>  F:	drivers/firmware/qemu_fw_cfg.c
>  F:	include/uapi/linux/qemu_fw_cfg.h
> =20
> +QEMU VIRT MACHINE SYSTEM CONTROLLER DRIVER
> +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/power/reset/qemu-virt-ctrl.c
> +
>  QLOGIC QL41xxx FCOE DRIVER
>  M:	Saurav Kashyap <skashyap@marvell.com>
>  M:	Javed Hasan <jhasan@marvell.com>
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index f6c1bcbb57de..99e3334726a5 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -354,4 +354,14 @@ config POWER_MLXBF
>  	help
>  	  This driver supports reset or low power mode handling for Mellanox Bl=
ueField.
> =20
> +config POWER_RESET_QEMU_VIRT_CTRL
> +	tristate "QEMU Virt Machine System Controller"
> +	depends on HAS_IOMEM
> +	help
> +	  This driver supports the system reset and power off functionality
> +	  provided by the QEMU 'virt-ctrl' device.
> +
> +	  Say Y here if you are running Linux on a QEMU virtual machine that
> +	  provides this controller, such as the m68k virt machine.
> +
>  endif
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 0e4ae6f6b5c5..d7ae97241a83 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -41,3 +41,4 @@ obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mod=
e.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
>  obj-$(CONFIG_NVMEM_REBOOT_MODE) +=3D nvmem-reboot-mode.o
>  obj-$(CONFIG_POWER_MLXBF) +=3D pwr-mlxbf.o
> +obj-$(CONFIG_POWER_RESET_QEMU_VIRT_CTRL) +=3D qemu-virt-ctrl.o
> diff --git a/drivers/power/reset/qemu-virt-ctrl.c b/drivers/power/reset/q=
emu-virt-ctrl.c
> new file mode 100644
> index 000000000000..f40d04afd4e3
> --- /dev/null
> +++ b/drivers/power/reset/qemu-virt-ctrl.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * QEMU Virt Machine System Controller Driver
> + *
> + * Copyright (C) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +
> +/* Registers */
> +#define VIRT_CTRL_REG_FEATURES	0x00
> +#define VIRT_CTRL_REG_CMD	0x04
> +
> +/* Commands */
> +#define CMD_NOOP	0
> +#define CMD_RESET	1
> +#define CMD_HALT	2
> +#define CMD_PANIC	3
> +
> +struct qemu_virt_ctrl {
> +	void __iomem *base;
> +	struct notifier_block reboot_nb;
> +};
> +
> +static inline void virt_ctrl_write32(u32 val, void __iomem *addr)
> +{
> +	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +		iowrite32be(val, addr);
> +	else
> +		iowrite32(val, addr);
> +}
> +
> +static int qemu_virt_ctrl_power_off(struct sys_off_data *data)
> +{
> +	void __iomem *base =3D data->cb_data;
> +
> +	virt_ctrl_write32(CMD_HALT, base + VIRT_CTRL_REG_CMD);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int qemu_virt_ctrl_restart(struct sys_off_data *data)
> +{
> +	void __iomem *base =3D data->cb_data;
> +
> +	virt_ctrl_write32(CMD_RESET, base + VIRT_CTRL_REG_CMD);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int qemu_virt_ctrl_reboot_notify(struct notifier_block *nb,
> +					unsigned long action, void *data)
> +{
> +	struct qemu_virt_ctrl *ctrl =3D container_of(nb, struct qemu_virt_ctrl,=
 reboot_nb);
> +
> +	if (action =3D=3D SYS_HALT)
> +		virt_ctrl_write32(CMD_HALT, ctrl->base + VIRT_CTRL_REG_CMD);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int qemu_virt_ctrl_probe(struct platform_device *pdev)
> +{
> +	struct qemu_virt_ctrl *ctrl;
> +	int ret;
> +
> +	ctrl =3D devm_kzalloc(&pdev->dev, sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return -ENOMEM;
> +
> +	ctrl->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ctrl->base))
> +		return PTR_ERR(ctrl->base);
> +
> +	ret =3D devm_register_sys_off_handler(&pdev->dev,
> +					    SYS_OFF_MODE_RESTART,
> +					    SYS_OFF_PRIO_DEFAULT,
> +					    qemu_virt_ctrl_restart,
> +					    ctrl->base);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot register restart handler\n");
> +
> +	ret =3D devm_register_sys_off_handler(&pdev->dev,
> +					    SYS_OFF_MODE_POWER_OFF,
> +					    SYS_OFF_PRIO_DEFAULT,
> +					    qemu_virt_ctrl_power_off,
> +					    ctrl->base);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot register power-off handler\n");
> +
> +	ctrl->reboot_nb.notifier_call =3D qemu_virt_ctrl_reboot_notify;
> +	ret =3D devm_register_reboot_notifier(&pdev->dev, &ctrl->reboot_nb);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "cannot register reboot notifier=
\n");
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id qemu_virt_ctrl_id[] =3D {
> +	{ "qemu-virt-ctrl", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, qemu_virt_ctrl_id);
> +
> +static struct platform_driver qemu_virt_ctrl_driver =3D {
> +	.probe =3D qemu_virt_ctrl_probe,
> +	.driver =3D {
> +		.name =3D "qemu-virt-ctrl",
> +	},
> +	.id_table =3D qemu_virt_ctrl_id,
> +};
> +module_platform_driver(qemu_virt_ctrl_driver);
> +
> +MODULE_AUTHOR("Kuan-Wei Chiu <visitorckw@gmail.com>");
> +MODULE_DESCRIPTION("QEMU Virt Machine System Controller Driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.53.0.345.g96ddfc5eaa-goog
>=20

--ffgufuw4dmg3s7ce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmnO5QcACgkQ2O7X88g7
+pq62xAAgx6BpLHcu/yz35xgJEamyr/x9F/FpYwJ8ZrrGT6w5zFfbBB6OU9Nbq5R
NKObno/58BHIJ2rqCNe+GcaXkMWXDufxGcOgjB15Inu3DGN4mbt6X65shHToQg9q
1rSVD9NEMg9RcGXyDkbHw2rlPzohQIL3IDJsUwb+ncKyNW+tu7ZXKHPMiKdR8l3G
Wcn+2DxEQS3ZN/1JjfRt3fl2W5t2JcddvLWShzdxNqlygRjUyJkT+jpDNAVO/0Tm
BpBCiL15VDFXWcHxuUTCMOS0o5+JY038w0l+Fvaj8gnZ+zOuJDrFCWOrRv2JeVA2
Wr0hHy86xBdNyj+MI63fUeAS1ShUWH4baRF+xSjwwG9HYGFDxjP6WM6fO6VxXOqm
mew/LWvj6UtQhNmfHfw3LyOOkjsv31ifRqQkX8o+pIwiFj6FwZbaY+szpNOPhLA7
nb+Lg5+362F6iXW2akco+W370HK1I4OKd/c+eG22j+Tg6BtSaqZNP4U3+AEb3CKP
6tbnNw9aev5rPUmsVZBAKOq2EL8kinO/8I/R6BYOXpWRRrtzGXHzlNcGiWCxXW19
bTTvS6dIzwvlwO2vaTwO6sBix8KG1Svsla8CKZQUW11UfoVN6YaDJLFzdsY213B1
CEhcQ+b+7KScnZZ9TH40RKk7qipemmtJ/z7Ua0SLx9k+dpviric=
=nTBP
-----END PGP SIGNATURE-----

--ffgufuw4dmg3s7ce--
