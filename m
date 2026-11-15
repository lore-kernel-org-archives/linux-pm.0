Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794808994;
	b=1WQiUKPtrsmG3O57QJtw6FyySrUHCNPKPbqWTAJpG2RBlyAIzXa72Pzyc2FphnapvLuV
	 mMdREpyYD6iHznHqDuzv0Hbt/KrJ6kp++Bmvm7/l8N1zbI6Hw/kc/Z07VlCBx9/LkEFrn
	 0TR3WjhEEX7ItH8VdqHZoOMzDsg+W8+q6vmHLdA8TXEDgCAkdIwrAOC0tEEUbxDV74yQ1
	 E3MXWjzvXOffsSsxu9rbf9yAIJVL5FJC0T8jFr3DKpxjvFvWjbuSu9CbA99ZrRXE2Sarq
	 SLv26Tx/pPXpGtGFu10b3F3xXasyp9EefRinUauQuASnf5MaTstypRYnrjT+0WFwJKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808994;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=r+/t7/8YlFHnxsyLwpkOiW86h8l2cQmKlSVSUVvhfg4=;
	b=BketS83XozFtT9hWLSxy4mQdrmswK/yR/K7Q4x3f61TTqe95fi498lBsnAl12THiZcPH
	 ickrmMv86DkT0VwDVxLeD8tq2NTS4YVc+orgyZxYemzhdh7qB3Xtah2Kgh1G7sCqvLsP6
	 OOXo+EpQXFijX66yK9QKPReKQ47lZeQeIpgKrGEdXCxorjsB8q879w5A20riEhsKXtOG2
	 LV1Gh7LNItGeeS+BwIfOQ9aKY9yazyN5nCidZiIFCOUS8+iUtoOXpyFK882QOqke0XcMP
	 77ormnOIjmDy16wXyjUa0dqBFQsxLVwAbcny7yVO77MBwgjyQ+a4rIN7a78ZMwI44Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=BPzv4Tnt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF33606A329;
	Mon, 16 Nov 2026 06:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF33606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=BPzv4Tnt
ARC-Seal: i=1; a=rsa-sha256; t=1794808971; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K5TCXXI91b4b+txGC66v91ASkAjS9cetSVj7d/0V4cs2bSj32Q63apZ8Gf4nnDxmUbc3Bfoq7FzjesXhcTh8jLR+v6sMC0aK8G/gkqmYKYRIZmNggTGwBimrrOx+dymBST4SYKYKUWOaBx/PYHTfq4AYhdDjcO0Qou02f7+4wiI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794808971; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r+/t7/8YlFHnxsyLwpkOiW86h8l2cQmKlSVSUVvhfg4=; 
	b=Jnuw0291o9TrCJBgScPHwVi6QuzLkpKFCAq7+BPYTDdbhrtmk1KvlPYPlgmd+0OoWA92zmTsFmW2x8ihNjiqMh+VDnpvtjGERlGD9f6VnUhl3Nd3gmqBH794rBzqHFxGCN7LoQQQopQgaVIh1EC5ChtDPFdrVneSgd73HIK15qg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=BPzv4Tnt3rbd+kB/+LiC0k9cl4wMgaKyeTr0ktragr8t67a9BcCteaOKXt5ASdVoieL/1+C1DS7C8JaPy5I1XCFzAzD7cWhlbMZUIfCL4GWe25Qm4nc7NySHLRZ8GMACYdDzK5XxVtUGt9/n4GjSSup52oBKDSDW1nye/o/dr8o=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=r+/t7/8YlFHnxsyLwpkOiW86h8l2cQmKlSVSUVvhfg4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794808969440383.91187333815697;
	Sun, 15 Nov 2026 22:02:49 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 564A0180311; Mon, 16 Nov 2026 00:08:05 +0100 (CET)
Date: Mon, 16 Nov 2026 00:08:05 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, John Stultz <john.stultz@linaro.org>, 
	Moritz Fischer <moritz.fischer@ettus.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Andy Yan <andyshrk@163.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>, Ulf Hansson <ulf.hansson@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v27 06/10] power: reset: Add psci-reboot-mode driver
Message-ID: <avo65hxiVDxpJRn-@venus>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <20261029-arm-psci-system_reset2-vendor-reboots-v27-6-fa4b3ff1359b@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vbu6xkkak2iqrbaw"
Content-Disposition: inline
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-6-fa4b3ff1359b@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.637.76
X-ZohoMailClient: External


--vbu6xkkak2iqrbaw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v27 06/10] power: reset: Add psci-reboot-mode driver
MIME-Version: 1.0

Hi,

On Thu, Oct 29, 2026 at 02:31:00PM +0530, Shivendra Pratap wrote:
> PSCI supports different types of resets like SYSTEM_RESET, SYSTEM_RESET2
> ARCH WARM reset and SYSTEM_RESET2 vendor-specific resets. Currently
> there is no common driver that handles all supported psci resets at one
> place. Additionally, there is no common mechanism to issue the supported
> psci resets from userspace.
>=20
> Add psci-reboot-mode as an auxiliary device created by the psci-devices
> driver. Define two types of PSCI resets, predefined-resets and
> vendor-specific resets. Predefined-resets are defined by psci driver
> and vendor-specific resets are defined by SoC vendors, under the
> psci:reboot-mode node of SoC device tree.
>=20
> Register the driver with the reboot-mode framework to interface these
> resets to userspace. When userspace initiates a supported command, pass
> the reset arguments to the PSCI driver to enable command-based reset.
>=20
> This change allows userspace to issue supported PSCI reset commands
> using the standard reboot system calls while enabling SoC vendors to
> define their specific resets for PSCI.
>=20
> Suggested-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> Suggested-by: Lee Jones <lee@kernel.org>
> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  MAINTAINERS                            |   1 +
>  drivers/firmware/psci/psci-devices.c   |   4 ++
>  drivers/power/reset/Kconfig            |  11 ++++
>  drivers/power/reset/Makefile           |   1 +
>  drivers/power/reset/psci-reboot-mode.c | 101 +++++++++++++++++++++++++++=
++++++
>  5 files changed, 118 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4ca41cdd872..0e03826eec48 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22292,6 +22292,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderate=
d for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/arm/psci.yaml
>  F:	drivers/firmware/psci/
> +F:	drivers/power/reset/psci-reboot-mode.c
>  F:	include/linux/psci.h
>  F:	include/uapi/linux/psci.h
> =20
> diff --git a/drivers/firmware/psci/psci-devices.c b/drivers/firmware/psci=
/psci-devices.c
> index d23befc490ed..04f24b8d9943 100644
> --- a/drivers/firmware/psci/psci-devices.c
> +++ b/drivers/firmware/psci/psci-devices.c
> @@ -20,6 +20,10 @@ static const struct arm_psci_device_info arm_psci_devi=
ces[] =3D {
>  	{
>  		.name =3D "psci-cpuidle-domain",
>  	},
> +	{
> +		.name =3D "psci-reboot-mode",
> +		.of_node_name =3D "reboot-mode",
> +	},
>  };
> =20
>  static void arm_psci_auxiliary_device_release(struct device *dev)
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index bce996bbef28..f165a41d40ed 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -360,6 +360,17 @@ config NVMEM_REBOOT_MODE
>  	  then the bootloader can read it and take different
>  	  action according to the mode.
> =20
> +config PSCI_REBOOT_MODE
> +	bool "PSCI reboot mode driver"
> +	depends on ARM_PSCI_DEVICES
> +	select AUXILIARY_BUS
> +	select REBOOT_MODE
> +	help
> +	  Say y here to enable the PSCI reboot mode driver. The driver
> +	  registers with the reboot-mode framework to configure PSCI
> +	  reset commands, which are executed by the PSCI driver during
> +	  psci_sys_reset().
> +
>  config POWER_MLXBF
>  	tristate "Mellanox BlueField power handling driver"
>  	depends on (GPIO_MLXBF2 || GPIO_MLXBF3) && ACPI
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index e31cab4ba78e..45d8aaaffaa1 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -41,5 +41,6 @@ obj-$(CONFIG_REBOOT_MODE) +=3D reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mode.o
>  obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
>  obj-$(CONFIG_NVMEM_REBOOT_MODE) +=3D nvmem-reboot-mode.o
> +obj-$(CONFIG_PSCI_REBOOT_MODE) +=3D psci-reboot-mode.o
>  obj-$(CONFIG_POWER_MLXBF) +=3D pwr-mlxbf.o
>  obj-$(CONFIG_POWER_RESET_QEMU_VIRT_CTRL) +=3D qemu-virt-ctrl.o
> diff --git a/drivers/power/reset/psci-reboot-mode.c b/drivers/power/reset=
/psci-reboot-mode.c
> new file mode 100644
> index 000000000000..c5dcfc40392a
> --- /dev/null
> +++ b/drivers/power/reset/psci-reboot-mode.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/psci.h>
> +#include <linux/reboot-mode.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +/*
> + * Predefined modes use two arguments. arg1/magic[0] is always zero and
> + * arg2/magic[1] is one of the values defined by enum psci_standard_rese=
ts.
> + */
> +static const struct reboot_mode_entry psci_resets[] =3D {
> +	{
> +		.name  =3D "psci-system-reset",
> +		.magic =3D { 0, PSCI_SYSTEM_RESET_COLD_RESET },
> +		.count =3D 2,
> +	},
> +	{
> +		.name  =3D "psci-system-reset2-arch-warm-reset",
> +		.magic =3D { 0, PSCI_SYSTEM_RESET2_ARCH_WARM_RESET },
> +		.count =3D 2,
> +	},
> +};
> +
> +static u64 psci_reboot_mode_get_cookie(const u32 *magic, int count)
> +{
> +	u64 cookie =3D 0;
> +	int i;
> +
> +	/*
> +	 * For a 3-cell magic, arg2 is the high 32 bits and arg3 is the low 32 =
bits.
> +	 * For a 2-cell magic, arg2 is the low 32 bits.
> +	 */
> +	for (i =3D 1; i < count; i++)
> +		cookie =3D (cookie << 32) | magic[i];
> +
> +	return cookie;
> +}
> +
> +static int psci_reboot_mode_write(struct reboot_mode_driver *reboot,
> +				  const u32 *magic, u32 count)
> +{
> +	if (count < 2 || count > 3)
> +		return -EINVAL;
> +
> +	/* Unexpected value at magic[1]/arg2 on a 32-bit system. */
> +	if (!IS_ENABLED(CONFIG_64BIT) && count =3D=3D 3 && magic[1])
> +		return -EINVAL;
> +
> +	return psci_set_reset_cmd(magic[0],
> +				  psci_reboot_mode_get_cookie(magic, count));
> +}
> +
> +static int psci_reboot_mode_probe(struct auxiliary_device *auxdev,
> +				  const struct auxiliary_device_id *id)
> +{
> +	struct reboot_mode_driver *reboot;
> +	struct device *dev =3D &auxdev->dev;
> +	size_t count;
> +	int ret;
> +
> +	reboot =3D devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
> +	if (!reboot)
> +		return -ENOMEM;

reboot =3D devm_kzalloc_obj(dev, *reboot);

Otherwise:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> +	/* Skip PSCI SYSTEM_RESET2 modes if unsupported. */
> +	count =3D psci_has_system_reset2_support() ? ARRAY_SIZE(psci_resets) : =
1;
> +
> +	ret =3D reboot_mode_driver_init(reboot, dev, NULL,
> +				      psci_reboot_mode_write, psci_resets,
> +				      count);
> +	if (ret)
> +		return ret;
> +
> +	return devm_reboot_mode_register(dev, reboot);
> +}
> +
> +static const struct auxiliary_device_id psci_reboot_mode_id_table[] =3D {
> +	{ .name =3D "arm-psci.psci-reboot-mode" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(auxiliary, psci_reboot_mode_id_table);
> +
> +static struct auxiliary_driver psci_reboot_mode_driver =3D {
> +	.probe =3D psci_reboot_mode_probe,
> +	.id_table =3D psci_reboot_mode_id_table,
> +};
> +
> +static int __init psci_reboot_mode_init(void)
> +{
> +	return __auxiliary_driver_register(&psci_reboot_mode_driver, THIS_MODUL=
E,
> +					   "psci-reboot-mode");
> +}
> +subsys_initcall(psci_reboot_mode_init);
>=20
> --=20
> 2.34.1
>=20
>=20

--vbu6xkkak2iqrbaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr6O1EACgkQ2O7X88g7
+prhkxAAkQuin46I3uFGGGhE7nFR3h670j7HVzveY3wJZBIbqbghMQNnj4IJF+LD
ApLl3NuqeBFiGAs52wuZzF3gdLrVQx8xqJHQQ2OYzLligrbYL1kAD4mrouWSKWjN
+af+VTAieHX9dg29j7BlapvuCWSgZwHGkVjErtZ5s3pxrc5x+NMpkAJX4aU5Br5I
M6rt/lkj2/tXvKejS/P/VISj+XaO6Vw+dKZTAwlvAE5XZ7RUcb5XH0cBIB4QVlZC
81FnfMbZXQWddCg0pcUNBuxAsxRH7cKppI7wOygCqWhsghpUQnUPBPC+gg193Ioy
t4D6KbEqMIpGktUf1TNS6HYKrSrH/nh6kv/QN+8/dyTNO+xCOOBeSZZ4rY+trdku
3/HrKiqUtQh3kDKKTZb214ckMObSp+dzMsX87CGUDFnei3zqYU3cIkFhtKCfjqKX
1GA6ckI710xIt/Bdg4p8jZ5cnr9ZnMUBcD4vskv6WvCi6TeZ1uheN0tEZYIfzc4k
/gT7yi0SRLgF7qmmbxti0AgRyUacBdmLruWUrzRluI9uvU9oPcvRpw+xn1w/oc0o
Vfa/EzBEyFa3jCo9Qd0KtSwa/dcN+x0M9ZOKl4txc9ifWGZxOZrr1dhtTEepCMZT
4wJLnPGNFe7VNYM1DCvF8PgurVJn8UcAUqvPZw/vqvnU4bfjREg=
=0rLe
-----END PGP SIGNATURE-----

--vbu6xkkak2iqrbaw--
