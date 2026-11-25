Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795596494;
	b=ZalZu94eSFUec8DGUlKW4/ycRxq9RHVrVEurTYJRRnOTZ7x3u/m7rSrPIwOmEswq8nEW
	 nC/Lolm4ms6rFZfP6veiATGuuVgMykvw5Bg97OcUNGSsBXcVuBL/OdKfwyCs7Dr1pTuV7
	 4r4hMfQm58W0Z3pErFvnjGMWNmYVpUHTayBZgWGxyUSeLys+UehsmAu8mI72ZPCbZYTUt
	 knu6a/6qJ5bLTztwUjxrJexqunc/g4Ab/57oTWd0hFBLQroZpUiV87S9E6xubO5mLAtwp
	 H+kLNCdJLIfx7SjZnt4bUGfdv/hIZlYRWesbvY+DjbaGg1cjXlNsIBTTQoGEypkh5BA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596494;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=YkAdyXDhvxMbRBkp6QhLOEe1Q7AO6B3AXM55qEFp9lo=;
	b=kjwd77O7yJ8nG9EwvqDoeJ8ti6K94CW2GLbWn1UlC2FSw2UHt12kVJPv3HrTgGWSzeS0
	 ycF2CzxTy3lMJk3TrA427CDzWoHnnoEdAVxR9e3Y6J7MXDY3xrx9TY4Ne7fJMVvXe6mCS
	 NEyp90Tq3VZtfePGG2TXk8q/bgNVEvCCw3bxv+UR4ZGFnwJ9/xzbGNXstJOTr0QX01okd
	 /kssRJ+17lMzTiBWtFGXPAStAwuXhV6//oz6MJErhc2suUkbbRt0OMEZ9DuZcOFaVV+hF
	 lJ42aXVZq4FLLJbj624/egtYaRjYbWCatLtnMNiBzbgCnNklGM9NOdnfCzUcl6/mFjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VxswUdnZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035B606A331;
	Wed, 25 Nov 2026 08:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E035B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VxswUdnZ
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 07059205A40;
	Wed, 25 Nov 2026 09:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795596485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkAdyXDhvxMbRBkp6QhLOEe1Q7AO6B3AXM55qEFp9lo=;
	b=VxswUdnZ8zZxlG5K8v8LMwwD3+rEe0Ben6LtoW+UoWP0aSf4mODGbC1+uanTjtonl18p3W
	whniGtoYwAF5KzvpUe2gZBJt3ZU44Vu39ddmIeJqI9Y4dIaHyVS+y31QGoDJI/Biuzdwsb
	SDLuthBxcKO1JWAQTYa1ky4KtxZO/baqpcZBOy7ViitMUEN9SZaI08jVxuZ66Zr6knwB9/
	ZR8f3+8TtaSpiWOzi/nIiUXRmkXbYnV0ZPJH/ciIa8QosV9ftqkNRe9oBg1acezhAx0umP
	K9ABwbJMqnEylxGnPo/hb3UkHV4H8I0zSRsF2EsZudhvK5NJ7ZkXbIIANzoNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795596485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YkAdyXDhvxMbRBkp6QhLOEe1Q7AO6B3AXM55qEFp9lo=;
	b=a4BbdNpK5Zw/lp7YDH8eLh8iOa15oE+eZ6QafE1egvprRUdf7/2cieX+gnOZSWxWtCoQKh
	PPibIQa3XuBva4Wp3Fe6zoUt0lUnHKbrTK7TvPyyrsJzQY1Z4Eovu1afqtrwho5jf0k0JT
	D54qs4MgJULawdk4HDj55BJJIGyZ3QmnIjThpzxKJJ2qPBTxNvQWCbXOtw22V2uq3E/Cpk
	vFzFAW6230132pBQ4025UWOClshecdmx6DTJYuP1vggU8V/APbtdM7fc4hD9VVzU+kQNMI
	9BOa1k3FcR3iuTEWonnYr5kzGkIChYAltbk62SWF6GE/nZkLsJY08OH3dimOyg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795596485; a=rsa-sha256;
	cv=none;
	b=DoQnf0dJy5UTJ4fHT2nESiGG6WRMGq5wR6/d479i6cQIHS8voXrBl+HUyJfpRWJdiJuIJK
	WJig4zqFayZpMmRIWSM9ygk7ZFuVV0tQlF+AxlWjUyQ418pit3CEltkHKzhMxNL28Pv3Y+
	PRkur0UQg9WEKJiyckDFQdZBc0rKsYXwrE9yokweU6WZDtNV8UJvcd4R/bOTXHpqFxFCTh
	rMDohYDNKo/LX69L1sbsSwmn7fh6lgRJ1zuK2/UksJvYE9qOUd3UZT1TKgC8JA4z466B0e
	CEWzw8PwfhIGAaqCXCOFYkdQ4luWMNWA+Kv9AKz3S/njkkx25fNg/kGhC9Q+7Q==
Message-ID: <f89e293688feb3f9bcdce0f1b6fed0ee424e5cd8.camel@pengutronix.de>
Subject: Re: [PATCH v2 5/9] reset: google: Add CPM reset driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Stephen Boyd
	 <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet
	 <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>, Ulf Hansson
	 <ulfh@kernel.org>, Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, =?ISO-8859-1?Q?Andr=E9?=
 Draszik <andre.draszik@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, Jakub
 =?UTF-8?Q?G=C5=82owacki?=	 <jglow@google.com>, linux-clk@vger.kernel.org,
 Douglas Anderson	 <dianders@chromium.org>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org,  Mariano Marciello <mmarciello@google.com>,
 google-soc@lists.linux.dev
Date: Wed, 25 Nov 2026 09:48:04 +0100
In-Reply-To: <20261124160343.v2.5.I0b1ad34a718a9b5f667d2481041970ea45989dd3@changeid>
References: <20261125000349.3385325-1-briannorris@chromium.org>
	 <20261124160343.v2.5.I0b1ad34a718a9b5f667d2481041970ea45989dd3@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Di, 2026-11-24 at 16:03 -0800, Brian Norris wrote:
> Google Tensor SoCs (used on Pixel phones) manage many resources
> (including resets) using a Central Power Manager (CPM) co-processor. We
> communicate with CPM using mailboxes, abstracted in the
> devm_cpm_get_handle(), etc., API.
>=20
> For posterity, I list a summary of changes made relative to the
> downstream Pixel driver:
>=20
> * Switch to auxiliary bus, as a child of a CPM device
>=20
> * Use devm more heavily
>=20
> * Avoid representing each reset as its own Device Tree node.
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>=20
> Changes in v2:
>  * Rename symbols from goog_cpm_rst_* to cpm_reset_*
>  * Moved shared protocol details to CPM driver
>  * Remove custom reset debugfs interface and .remove callback.
>  * Remove per-SoC table; we only need naive translation of firmware IDs
>=20
>  drivers/reset/Kconfig            |   1 +
>  drivers/reset/Makefile           |   1 +
>  drivers/reset/google/Kconfig     |  11 +++
>  drivers/reset/google/Makefile    |   2 +
>  drivers/reset/google/reset-cpm.c | 154 +++++++++++++++++++++++++++++++
>  5 files changed, 169 insertions(+)
>  create mode 100644 drivers/reset/google/Kconfig
>  create mode 100644 drivers/reset/google/Makefile
>  create mode 100644 drivers/reset/google/reset-cpm.c
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 673bca1e594e..64c12b479b2c 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -475,6 +475,7 @@ config RESET_ZYNQMP
>  	  This enables the reset controller driver for Xilinx ZynqMP SoCs.
> =20
>  source "drivers/reset/amlogic/Kconfig"
> +source "drivers/reset/google/Kconfig"
>  source "drivers/reset/hisilicon/Kconfig"
>  source "drivers/reset/realtek/Kconfig"
>  source "drivers/reset/spacemit/Kconfig"
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 2fe527a7be8e..a151fe63905e 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y +=3D core.o
>  obj-y +=3D amlogic/
> +obj-y +=3D google/
>  obj-y +=3D hisilicon/
>  obj-y +=3D realtek/
>  obj-y +=3D spacemit/
> diff --git a/drivers/reset/google/Kconfig b/drivers/reset/google/Kconfig
> new file mode 100644
> index 000000000000..38431b4f9001
> --- /dev/null
> +++ b/drivers/reset/google/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config RESET_CPM
> +	tristate "Google CPM Reset Controller"
> +	depends on ARCH_GOOGLE || COMPILE_TEST
> +	depends on GOOGLE_CPM_MBA
> +	help
> +	  Driver support for reset controllers found on Google Tensor SoCs,
> +	  operating over the CPM mailbox interface. This allows peripheral
> +	  drivers to assert and deassert resets on LPCM hardware blocks.
> +
> +	  If unsure, say N.
> diff --git a/drivers/reset/google/Makefile b/drivers/reset/google/Makefil=
e
> new file mode 100644
> index 000000000000..437c19459464
> --- /dev/null
> +++ b/drivers/reset/google/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_RESET_CPM) +=3D reset-cpm.o
> diff --git a/drivers/reset/google/reset-cpm.c b/drivers/reset/google/rese=
t-cpm.c
> new file mode 100644
> index 000000000000..ef0863f25cac
> --- /dev/null
> +++ b/drivers/reset/google/reset-cpm.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Device driver to control Google SoC LPCM resets via CPM.
> + * Copyright 2023-2026 Google LLC
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/container_of.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/gfp_types.h>
> +#include <linux/limits.h>
> +#include <linux/mod_devicetable.h>

Please include the specific <linux/device-id/*.h> that is needed
instead of all of <linux/mod_devicetable.h>.

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/reset-controller.h>
> +#include <linux/types.h>
> +#include <soc/google/google-cpm-mba.h>
> +
> +#define ASSERT_OP_ID			0
> +#define DEASSERT_OP_ID			1
> +
> +#define CPM_RST_LPCM_ID_MASK		GENMASK(31, 16)
> +#define CPM_RST_ID_MASK			GENMASK(15, 0)

Why are these fields 16 bits wide when one line below it says:

> +/* Object fields are 8 bits */
> +#define CPM_RST_ID_MAX			U8_MAX
> +
> +static inline unsigned long to_rstc_idx(u32 lpcm_id, u32 rst_id)
> +{
> +	return FIELD_PREP(CPM_RST_LPCM_ID_MASK, lpcm_id) |
> +	       FIELD_PREP(CPM_RST_ID_MASK, rst_id);
> +}
> +
> +static inline u32 lpcm_from_idx(unsigned long idx)
> +{
> +	return FIELD_GET(CPM_RST_LPCM_ID_MASK, idx);
> +}
> +
> +static inline u32 rst_from_idx(unsigned long idx)
> +{
> +	return FIELD_GET(CPM_RST_ID_MASK, idx);
> +}
> +
> +struct cpm_reset_provider {
> +	struct reset_controller_dev rcdev;
> +	struct cpm_handle *cpm;
> +};
> +
> +static inline struct cpm_reset_provider *to_provider(struct reset_contro=
ller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct cpm_reset_provider, rcdev);
> +}
> +
> +static int cpm_reset_send_lpcm(struct reset_controller_dev *rcdev,
> +			       unsigned long idx, u8 opcode)
> +{
> +	struct cpm_reset_provider *provider =3D to_provider(rcdev);
> +	const struct cpm_lpcm_message msg =3D {
> +		.cmd =3D LPCM_CMD_SET_RST,
> +		.opcode =3D opcode,
> +		.lpcm_id =3D lpcm_from_idx(idx),
> +		.obj_id =3D rst_from_idx(idx),
> +	};
> +
> +	return cpm_send_lpcm_message(provider->cpm, &msg);
> +}
> +
> +static int cpm_reset_assert(struct reset_controller_dev *rcdev,
> +			    unsigned long idx)
> +{
> +	return cpm_reset_send_lpcm(rcdev, idx, ASSERT_OP_ID);
> +}
> +
> +static int cpm_reset_deassert(struct reset_controller_dev *rcdev,
> +			      unsigned long idx)
> +{
> +	return cpm_reset_send_lpcm(rcdev, idx, DEASSERT_OP_ID);
> +}
> +
> +static const struct reset_control_ops cpm_reset_ops =3D {
> +	.assert =3D cpm_reset_assert,
> +	.deassert =3D cpm_reset_deassert,
> +};
> +
> +static int cpm_reset_of_xlate(struct reset_controller_dev *rcdev,
> +			      const struct of_phandle_args *reset_spec)
> +{
> +	u32 lpcm_id, rst_id;
> +
> +	if (reset_spec->args_count !=3D 2)
> +		return -EINVAL;
> +
> +	lpcm_id =3D reset_spec->args[0];
> +	rst_id =3D reset_spec->args[1];
> +
> +	if (lpcm_id > CPM_RST_ID_MAX)

This looks a bit weird.

Maybe add a CPM_LPCM_ID_MAX, directly use U8_MAX here, or rename the
constant to not include RST_ID?

> +		return -EINVAL;
> +	if (rst_id > CPM_RST_ID_MAX)
> +		return -EINVAL;
> +
> +	return to_rstc_idx(lpcm_id, rst_id);
> +}
> +
> +static int cpm_reset_probe(struct auxiliary_device *auxdev,
> +			   const struct auxiliary_device_id *id)
> +{
> +	struct device *dev =3D &auxdev->dev;
> +	struct cpm_reset_provider *provider;
> +	int ret;
> +
> +	provider =3D devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);

devm_kzalloc_obj()

> +	if (!provider)
> +		return -ENOMEM;
> +
> +	provider->cpm =3D devm_cpm_get_handle(dev);
> +	if (IS_ERR(provider->cpm))
> +		return dev_err_probe(dev, PTR_ERR(provider->cpm),
> +				     "Failed to get CPM handle\n");
> +
> +	provider->rcdev.dev =3D dev;
> +	provider->rcdev.owner =3D THIS_MODULE;
> +	provider->rcdev.of_node =3D dev->of_node;
> +	provider->rcdev.ops =3D &cpm_reset_ops;
> +	provider->rcdev.of_reset_n_cells =3D 2;
> +	provider->rcdev.of_xlate =3D cpm_reset_of_xlate;
> +
> +	ret =3D devm_reset_controller_register(dev, &provider->rcdev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register reset controller: %d\n", ret);

dev_err_probe()


regards
Philipp
