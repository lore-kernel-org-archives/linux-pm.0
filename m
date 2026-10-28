Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793196216;
	b=BiKGa+FfYpvGuGQk/bZIRywcfg44XZ98l0Hef7LsnjSo2LXOpnwg/iX+WHIskSVkMUY6
	 +V7O1pU/AFxBpZwqBmTyFEAcSx/swFbQRd+xw4zOw+jY4hoOFcLbClTXobzX/KKzIcDwM
	 bZ0Owf29ArVbUuYm+xoYEL50ir2QboWdzJlJV69LajcIaVjCSJ2K6cuxDoS4wFfT2Mvkd
	 xA1kMiRWjTFHlG4zfFa8q14jI88FL5uDsbLwaDj7Wk34d2sU6QbcNATrCn75v714BEPBi
	 UIMdPrAPuvWB+SVNu3MSt1aYt5dWzJ5JXc2NF4UDtWRTIxsOCvcc7u7Z1+D3HS35jCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196216;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=7P6hkajrEuuwluLOAZvBDyIw6BeTtytgqv1+hRyvjaw=;
	b=Lz5rt+X9VCn5cGxW14P8cY6ANLWwkb+7yZ6piQWjAlidNn8JhQmGFMXLeCE48+jQsuJ0
	 VMkDbcZEsPQn+i+xFh2wIJkrLQDvj2YTbQvvX1ByPrVRU2zqH7gRmV9xDYSvCuu7XtiMx
	 sglbTgmTxy9ukH5WjdFKks4hZKOBbf0wCVeocQOE2GLpN9tssvvM1mES0UxkAPRUv3p1N
	 3Vd1NFV2uMurrsbBycQw9ZHAx8jk+aVvyt9PNiKZXAXEgHau2hY981D+4xA/qNESm80g5
	 9PHma8/MRvCsh2d+cinBBpWr1EiC0UiTjZh5cHz21yEQpjkqMZMhznVcsUoLM6qutew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=fJk0v+4g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6725606A31D;
	Wed, 28 Oct 2026 14:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6725606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=fJk0v+4g
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 23858202950;
	Wed, 28 Oct 2026 15:03:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793196205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7P6hkajrEuuwluLOAZvBDyIw6BeTtytgqv1+hRyvjaw=;
	b=fJk0v+4ga7M4vRJu7VspWY2EHWe0tBqGwn6UYuEsrU8J7tIqos7QxaaEOtktZt6mmd9oG4
	tToGGLOVQtMyd0VwsAL034DCpZd70a+KOypN3Pw8M25iIz2z6CMTQk8bTB4h6LYHH5LMI/
	GpkYTVdTUUMIMXxksYKapUyLhsCfVFPcblNefrbBVwotYvdq92Ov4Ce/JGQHK1XmCBrR44
	G/eCbiWnv5Tn7DiM61GMwJ00vjgr8Iwk54oCJyGMBOPdXIetaRJ6UHBr6nkfZ2YHYgHkdg
	AmhyKxulPq5GBLQpez5Cjz3Oc7pwXY2FdlL23PY0g3+QMfU+obSKEAeDEeeOdQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793196205; a=rsa-sha256;
	cv=none;
	b=K0EsB2LyhvUVGLcLwWVrAdslwBFmPDFzgFymzsVwxmG8GDel+Q44FM+cyA1YQyjUa70bCr
	zaaw7nep7CYdZapkD/ueEfo/EKWTbn+PQYXxXfUvWZzvvP0Wkbxx4yF2ZCS09XgQTUphvh
	JES9Msf+INOKkobm6Z2No4WAyj7iqFa66rW2RNVqlpzjrvaq3XEBesTgXFcGP0OKF1/YUL
	kgiGY/0s9/fQGt0IZD5Kx3WViRkNRF7DGibpfUPSatdwC00jjKeyVubysf3krFdDEyRwRZ
	yUSZDM/agGViiRKQScZRwUHPtwCFkYbu2ioL6xbeWyvdRS+2sr/kJpB/jrlhQw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793196205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7P6hkajrEuuwluLOAZvBDyIw6BeTtytgqv1+hRyvjaw=;
	b=ZMLvYx3qz7/nxsQJFZRewAGvPfe/6T/mFhonAzwIFBSuRxFtgY87l2CKgxhdMfgYNaZgYv
	Wkj87jgAjvUxznmG2qh+Zg73PuUY6yD0NXNwypWe7qor+bk4PUrOOSvVY2hissGpRXQX7J
	1esXry4x+WKs81rK/YdDQXrqHCXPL8XW2K+xtGjCkV1i7JnHP2WcPSFpHbhOgk2MkUWg3G
	hDqLFIp2A6Anxg6w0z9Sh1/Ybm5t0mtKU+cSezAZHHF6KvlCM3hxit8r1luB1bWEy4aKr1
	p7T3ZdO1soNYx8xZ+tdNtvXfGbw952EUyt6lcmcxeJdmBYUZk+g/9/sQHPi2aw==
Message-ID: <8d57f0a1dc8a07838bf1320f9b79588196264ff5.camel@pengutronix.de>
Subject: Re: [PATCH 6/9] reset: google: Add CPM reset driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Stephen Boyd
	 <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet
	 <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>, Ulf Hansson
	 <ulfh@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, devicetree@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, =?ISO-8859-1?Q?Andr=E9?= Draszik
 <andre.draszik@linaro.org>, 	linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, 	linux-kernel@vger.kernel.org, Radu Rendec
 <radu@rendec.net>, 	linux-arm-kernel@lists.infradead.org, Mariano Marciello
 <mmarciello@google.com>,  Douglas Anderson <dianders@chromium.org>,
 linux-clk@vger.kernel.org, Jakub =?UTF-8?Q?G=C5=82owacki?=	
 <jglow@google.com>
Date: Wed, 28 Oct 2026 15:03:24 +0100
In-Reply-To: <20261026144346.6.I0b1ad34a718a9b5f667d2481041970ea45989dd3@changeid>
References: <20261026214359.3122870-1-briannorris@chromium.org>
	 <20261026144346.6.I0b1ad34a718a9b5f667d2481041970ea45989dd3@changeid>
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

On Mo, 2026-10-26 at 14:43 -0700, Brian Norris wrote:
> Google Tensor SoCs (used on Pixel phones) manage many resources
> (including resets) using a Central Power Manager (CPM) co-processor. We
> communicate with CPM using mailboxes, abstracted in the
> cpm_request_client(), etc., API.
>=20
> For posterity, I list a summary of changes made relative to the
> downstream Pixel driver:
>=20
> * Switch to auxiliary bus, as a child of a CPM device
>=20
> * Use devm more heavily
>=20
> * Avoid representing each reset as its own Device Tree node. Use a
>   limited per-SoC table to describe any additional per-SoC details
>   instead.
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>=20
>  drivers/reset/Kconfig            |   1 +
>  drivers/reset/Makefile           |   1 +
>  drivers/reset/google/Kconfig     |  11 +
>  drivers/reset/google/Makefile    |   2 +
>  drivers/reset/google/reset-cpm.c | 367 +++++++++++++++++++++++++++++++
>  5 files changed, 382 insertions(+)
>  create mode 100644 drivers/reset/google/Kconfig
>  create mode 100644 drivers/reset/google/Makefile
>  create mode 100644 drivers/reset/google/reset-cpm.c
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index eda9c698a95f..37dbddcd620f 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -451,6 +451,7 @@ config RESET_ZYNQMP
>  	  This enables the reset controller driver for Xilinx ZynqMP SoCs.
> =20
>  source "drivers/reset/amlogic/Kconfig"
> +source "drivers/reset/google/Kconfig"
>  source "drivers/reset/hisilicon/Kconfig"
>  source "drivers/reset/spacemit/Kconfig"
>  source "drivers/reset/starfive/Kconfig"
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 489fafd6bbe3..9754c274766c 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y +=3D core.o
>  obj-y +=3D amlogic/
> +obj-y +=3D google/
>  obj-y +=3D hisilicon/
>  obj-y +=3D spacemit/
>  obj-y +=3D starfive/
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
> index 000000000000..5f144f1ad5f2
> --- /dev/null
> +++ b/drivers/reset/google/reset-cpm.c
> @@ -0,0 +1,367 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Device driver to control Google SoC LPCM resets via CPM.
> + * Copyright 2023-2026 Google LLC
> + */
> +
> +#include <dt-bindings/soc/google,lga-lpcm.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/container_of.h>
> +#include <linux/debugfs.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/reset-controller.h>
> +#include <soc/google/goog_cpm_service_ids.h>
> +#include <soc/google/google-cpm-mba.h>
> +
> +#define MAILBOX_SEND_TIMEOUT_MS		3000
> +#define LPCM_CMD_SET_RST		0x4
> +
> +#define OP_ID_BITFIELD			GENMASK(31, 24)
> +#define RST_ID_BITFIELD			GENMASK(23, 16)
> +#define LPCM_ID_BITFIELD		GENMASK(15, 8)
> +#define REQ_ID_BITFIELD			GENMASK(7, 0)
> +
> +#define ASSERT_OP_ID			0
> +#define DEASSERT_OP_ID			1
> +
> +#define NO_ERROR			0
> +#define ERR_LPCM_NOT_SUPPORTED		(-24)
> +#define ERR_LPCM_INVALID_ARGS		(-8)
> +#define ERR_LPCM_TIMED_OUT		(-13)
> +#define ERR_LPCM_GENERIC		(-1)
> +
> +#define CPM_RST_LPCM_ID_MASK		GENMASK(31, 16)
> +#define CPM_RST_ID_MASK			GENMASK(15, 0)
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
> +struct cpm_reset_data {
> +	u32 lpcm_id;
> +	u32 nr_resets;
> +	const char *name;
> +};
> +
> +struct cpm_reset_soc_data {
> +	const struct cpm_reset_data *resets;
> +	size_t num_resets;
> +};
> +
> +struct goog_cpm_rst_provider {
> +	struct device *dev;
> +	struct reset_controller_dev rcdev;
> +	struct cpm_client *cpm_client;
> +	struct dentry *debugfs_root;
> +	struct goog_cpm_rst_debugfs_entry *dbg_entries;
> +	const struct cpm_reset_soc_data *soc_data;
> +};
> +
> +#define to_provider(rc) container_of(rc, struct goog_cpm_rst_provider, r=
cdev)

This should be an inline function.

> +struct goog_cpm_rst_debugfs_entry {
> +	struct goog_cpm_rst_provider *provider;
> +	u32 lpcm_id;
> +};
> +
> +static int goog_cpm_rst_mba_check_ret(struct device *dev, int ret)
> +{
> +	switch (ret) {
> +	case NO_ERROR:
> +		return 0;
> +	case ERR_LPCM_NOT_SUPPORTED:
> +		dev_err(dev, "the received request_id is invalid\n");
> +		return -EPROTO;

-EOPNOTSUPP?

> +	case ERR_LPCM_INVALID_ARGS:
> +		dev_err(dev, "invalid lpcm_id or rst_id\n");
> +		return -EINVAL;
> +	case ERR_LPCM_TIMED_OUT:
> +		dev_err(dev, "operation timed out\n");
> +		return -ETIMEDOUT;
> +	case ERR_LPCM_GENERIC:
> +		dev_err(dev, "internal error occurred\n");
> +		return -EREMOTEIO;
> +	default:
> +		dev_err(dev, "unknown error response from CPM\n");
> +		return -EPROTO;
> +	}
> +}

Is this specific to reset functionality, or should this maybe live in
CPM common code? I see that the return values in the power-domain
driver are not translated, but the clock driver contains a near-
identical copy of this function. Or maybe just printing the translated
error with "%pe" is good enough?

> +static int goog_cpm_rst_mba_resp_hdl(struct device *dev, const struct cp=
m_request *cpm_req)
> +{
> +	int dst =3D cpm_req->dst_id;
> +	int ret =3D cpm_req->resp_msg->payload[0];
> +
> +	dev_dbg(dev, "got resp from %u, data %d.\n", dst, ret);
> +
> +	return goog_cpm_rst_mba_check_ret(dev, ret);
> +}
> +
> +static int goog_cpm_rst_send_mba_mail(struct goog_cpm_rst_provider *prov=
ider,
> +				      u32 lpcm_id, unsigned long rst_id, int op_id)
> +{
> +	struct device *dev =3D provider->dev;
> +	struct cpm_payload resp_msg;
> +	struct cpm_payload req_msg =3D {};
> +	struct cpm_request cpm_req =3D {
> +		.msg_type =3D REQUEST_MSG,
> +		.req_msg =3D &req_msg,
> +		.resp_msg =3D &resp_msg,
> +		.dst_id =3D CPM_COMMON_LPCM_SERVICE,
> +		.tout_ms =3D MAILBOX_SEND_TIMEOUT_MS,
> +	};
> +	int ret;
> +
> +	req_msg.payload[0] =3D FIELD_PREP(REQ_ID_BITFIELD, LPCM_CMD_SET_RST) |
> +			     FIELD_PREP(LPCM_ID_BITFIELD, lpcm_id) |
> +			     FIELD_PREP(RST_ID_BITFIELD, rst_id) |
> +			     FIELD_PREP(OP_ID_BITFIELD, op_id);
> +
> +	dev_dbg(dev, "lpcm_id %d, rst_id %lu: send mba mail: [%u, %u, %u]\n",
> +		lpcm_id, rst_id, req_msg.payload[0], req_msg.payload[1],
> +		req_msg.payload[2]);
> +
> +	ret =3D cpm_send_message(provider->cpm_client, &cpm_req);
> +	if (ret < 0) {
> +		dev_err(dev,
> +			"lpcm_id %d, rst_id %lu: failed to send request to CPM, ret=3D%d\n",
> +			lpcm_id, rst_id, ret);
> +		return ret;
> +	}
> +
> +	return goog_cpm_rst_mba_resp_hdl(dev, &cpm_req);
> +}
> +
> +static int goog_cpm_rst_assert(struct reset_controller_dev *rcdev,
> +			       unsigned long idx)
> +{
> +	struct goog_cpm_rst_provider *provider =3D to_provider(rcdev);
> +	u32 lpcm_id =3D lpcm_from_idx(idx);
> +	u32 rst_id =3D rst_from_idx(idx);
> +
> +	dev_dbg(rcdev->dev, "assert reset id=3D%u of lpcm %u\n", rst_id, lpcm_i=
d);
> +	return goog_cpm_rst_send_mba_mail(provider, lpcm_id, rst_id, ASSERT_OP_=
ID);
> +}
> +
> +static int goog_cpm_rst_deassert(struct reset_controller_dev *rcdev,
> +				 unsigned long idx)
> +{
> +	struct goog_cpm_rst_provider *provider =3D to_provider(rcdev);
> +	u32 lpcm_id =3D lpcm_from_idx(idx);
> +	u32 rst_id =3D rst_from_idx(idx);
> +
> +	dev_dbg(rcdev->dev, "deassert reset id=3D%u of lpcm %u\n", rst_id, lpcm=
_id);

This all could be deduplicated by moving it into the _send_mba_mail()
function, using str_assert_deassert(op_id =3D=3D ASSERT_OP_ID).

> +	return goog_cpm_rst_send_mba_mail(provider, lpcm_id, rst_id, DEASSERT_O=
P_ID);
> +}
> +
> +static const struct reset_control_ops goog_cpm_rst_ops =3D {
> +	.assert =3D goog_cpm_rst_assert,
> +	.deassert =3D goog_cpm_rst_deassert,
> +};
> +
> +static int goog_cpm_rst_debugfs_assert_set(void *data, u64 rst_id)
> +{
> +	struct goog_cpm_rst_debugfs_entry *entry =3D data;
> +	unsigned long idx =3D to_rstc_idx(entry->lpcm_id, rst_id);
> +
> +	return goog_cpm_rst_assert(&entry->provider->rcdev, idx);

Calling into reset_control_ops like this bypasses all reference
counting in the core and breaks reset controller API promises.

> +}
> +
> +static int goog_cpm_rst_debugfs_deassert_set(void *data, u64 rst_id)
> +{
> +	struct goog_cpm_rst_debugfs_entry *entry =3D data;
> +	unsigned long idx =3D to_rstc_idx(entry->lpcm_id, rst_id);
> +
> +	return goog_cpm_rst_deassert(&entry->provider->rcdev, idx);
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(goog_cpm_rst_assert_debugfs_fops, NULL,
> +			 goog_cpm_rst_debugfs_assert_set, "%llu\n");
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(goog_cpm_rst_deassert_debugfs_fops, NULL,
> +			 goog_cpm_rst_debugfs_deassert_set, "%llu\n");
> +
> +static void goog_cpm_rst_add_debugfs(struct goog_cpm_rst_debugfs_entry *=
entry,
> +				     struct dentry *debugfs_root,
> +				     const char *name)
> +{
> +	struct dentry *d =3D debugfs_create_dir(name, debugfs_root);
> +
> +	debugfs_create_file("assert", 0220, d, entry,
> +			    &goog_cpm_rst_assert_debugfs_fops);
> +	debugfs_create_file("deassert", 0220, d, entry,
> +			    &goog_cpm_rst_deassert_debugfs_fops);
> +}

Please drop the debugfs functionality or explain what it is needed for.

> +static int goog_cpm_rst_get_nr_resets(const struct cpm_reset_soc_data *s=
oc_data, u32 lpcm_id)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < soc_data->num_resets; i++)
> +		if (soc_data->resets[i].lpcm_id =3D=3D lpcm_id)
> +			return soc_data->resets[i].nr_resets;
> +
> +	return -EINVAL;
> +}
> +
> +static int goog_cpm_rst_of_xlate(struct reset_controller_dev *rcdev,
> +				 const struct of_phandle_args *reset_spec)
> +{
> +	struct goog_cpm_rst_provider *provider =3D to_provider(rcdev);
> +	u32 lpcm_id, rst_id;
> +	int max_resets;
> +
> +	if (reset_spec->args_count !=3D 2)
> +		return -EINVAL;
> +
> +	lpcm_id =3D reset_spec->args[0];
> +	rst_id =3D reset_spec->args[1];
> +
> +	max_resets =3D goog_cpm_rst_get_nr_resets(provider->soc_data, lpcm_id);
> +	if (max_resets < 0)
> +		return max_resets;
> +
> +	if (rst_id >=3D max_resets)
> +		return -EINVAL;
> +
> +	return to_rstc_idx(lpcm_id, rst_id);
> +}
> +
> +static const struct cpm_reset_data cpm_resets_lga_entries[] =3D {
> +	{
> +		.lpcm_id =3D LGA_LPCM_HSIO_N,
> +		.nr_resets =3D 16,
> +		.name =3D "hsio-n",
> +	},
> +	{
> +		.lpcm_id =3D LGA_LPCM_HSIO_S,
> +		.nr_resets =3D 5,
> +		.name =3D "hsio-s",
> +	},
> +	{
> +		.lpcm_id =3D LGA_LPCM_LSIO_S,
> +		.nr_resets =3D 45,
> +		.name =3D "lsio-s",
> +	},
> +	{
> +		.lpcm_id =3D LGA_LPCM_LSIO_N,
> +		.nr_resets =3D 43,
> +		.name =3D "lsio-n",
> +	},
> +	{
> +		.lpcm_id =3D LGA_LPCM_LSIO_E,
> +		.nr_resets =3D 50,
> +		.name =3D "lsio-e",
> +	},
> +};
> +
> +static const struct cpm_reset_soc_data cpm_resets_lga =3D {
> +	.resets =3D cpm_resets_lga_entries,
> +	.num_resets =3D ARRAY_SIZE(cpm_resets_lga_entries),
> +};
> +
> +static const struct of_device_id cpm_rst_of_match[] =3D {
> +	{ .compatible =3D "google,lga-cpm", .data =3D &cpm_resets_lga },
> +	{ /* sentinel */ }

Please choose one style (align with goog_cpm_rst_id_table).

> +};
> +
> +static int goog_cpm_rst_probe(struct auxiliary_device *auxdev,
> +			      const struct auxiliary_device_id *id)
> +{
> +	struct device *dev =3D &auxdev->dev;
> +	struct goog_cpm_rst_provider *provider;
> +	const struct of_device_id *match;
> +	int i, ret;
> +
> +	match =3D of_match_node(cpm_rst_of_match, dev->of_node);
> +	if (!match) {
> +		dev_err(dev, "no matching SoC data found\n");

This should never happen, does it warrant an error message?

> +		return -ENODEV;
> +	}
> +
> +	provider =3D devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
> +	if (!provider)
> +		return -ENOMEM;
> +
> +	provider->dev =3D dev;

This is not needed, you can just use provider->rcdev.dev.

> +	provider->soc_data =3D match->data;
> +
> +	provider->cpm_client =3D devm_cpm_request_client(dev, 0, NULL, NULL);
> +	if (IS_ERR(provider->cpm_client))
> +		return dev_err_probe(dev, PTR_ERR(provider->cpm_client),
> +				     "Failed to request cpm client\n");
> +	auxiliary_set_drvdata(auxdev, provider);
> +
> +	provider->rcdev.dev =3D dev;
> +	provider->rcdev.owner =3D THIS_MODULE;
> +	provider->rcdev.of_node =3D dev->of_node;
> +	provider->rcdev.ops =3D &goog_cpm_rst_ops;
> +	provider->rcdev.of_reset_n_cells =3D 2;
> +	provider->rcdev.of_xlate =3D goog_cpm_rst_of_xlate;
> +
> +	ret =3D devm_reset_controller_register(dev, &provider->rcdev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register reset controller: %d\n", ret);
> +		return ret;
> +	}
> +
> +	provider->debugfs_root =3D debugfs_create_dir(dev_name(dev), NULL);
> +	if (!IS_ERR(provider->debugfs_root)) {
> +		provider->dbg_entries =3D devm_kcalloc(dev, provider->soc_data->num_re=
sets,
> +						     sizeof(*provider->dbg_entries), GFP_KERNEL);
> +		if (!provider->dbg_entries) {
> +			debugfs_remove_recursive(provider->debugfs_root);
> +			return -ENOMEM;
> +		}
> +
> +		for (i =3D 0; i < provider->soc_data->num_resets; i++) {
> +			provider->dbg_entries[i].provider =3D provider;
> +			provider->dbg_entries[i].lpcm_id =3D provider->soc_data->resets[i].lp=
cm_id;
> +			goog_cpm_rst_add_debugfs(&provider->dbg_entries[i],
> +						 provider->debugfs_root,
> +						 provider->soc_data->resets[i].name);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void goog_cpm_rst_remove(struct auxiliary_device *auxdev)
> +{
> +	struct goog_cpm_rst_provider *provider =3D auxiliary_get_drvdata(auxdev=
);
> +
> +	debugfs_remove_recursive(provider->debugfs_root);
> +}
> +
> +static const struct auxiliary_device_id goog_cpm_rst_id_table[] =3D {
> +	{ .name =3D "google_cpm_mba.reset" },
> +	{},

Please choose one style (align with cpm_rst_of_match).

> +};
> +MODULE_DEVICE_TABLE(auxiliary, goog_cpm_rst_id_table);
> +
> +static struct auxiliary_driver goog_cpm_rst_driver =3D {
> +	.probe =3D goog_cpm_rst_probe,
> +	.remove =3D goog_cpm_rst_remove,
> +	.name =3D "google-reset-cpm",
> +	.id_table =3D goog_cpm_rst_id_table,
> +};
> +
> +module_auxiliary_driver(goog_cpm_rst_driver);
> +
> +MODULE_DESCRIPTION("Google CPM Reset Driver");
> +MODULE_LICENSE("GPL");

regards
Philipp
