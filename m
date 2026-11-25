Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634138;
	b=jlzHwbhdtEPCurTvmeEviOcs/CXFHOIdt83nfS8PyvCTKywlKa/Cmit4zukhYlNjjtja
	 K9JwLx5hCovYcmaSb4VkPlWC6ej+8Fme4t8qJUNbdtGQ2BClIddCz0tUsCqqn8sIqRlAv
	 Ra7Xm1q5mnQZsRvOkYNImFCHLKM9U6AZa1frbNzVgf394vvvfaNcOeqZQkI6X6OHYdlsP
	 5Mq/JxYhcmZVSFBaZVjYFK0h5HVmmreCLsGlOS0lM5TAZ1XASFuC0rXwf9/hY9PCIfTyS
	 v/7rcEe6A/JoBdGFvkZ8gOs91Tz5pjKHdLCmVRInTx9h0newAGnVnTrNExqyM/H/TQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=w3smB/TOMIsBOIa48IJ7JNzgUykCOEbYDqooopA7Cxs=;
	b=XPAZ8Hg1js2Udc7ISZHGdcMJuf7fEzVvufwZwp4348axayPRhwrDuFnMgu3l+vly88A2
	 nuFdCi7icaVJeAK6IVzF5W5BUla0wBXNb8pK7chulL/+SeDJZtfeu06wy/6JEUb8Q02bw
	 U/PKb4HBWjSnY6NcBgeg91npsTmBhQj53VTZtDupaIv6tVG1VFjCHWG5s5MoTWJ/1iFG0
	 qCEOTi0FQMi0toY5BLHKqdynSTvXe4ajGh87+A0QRNZ/+VDxfF0TLJfbpFiwBlUt12brN
	 EsaeIH+X2yt4dPvCRYJJA2bHInmK6FyxvP70bxf4wS4SKmuX/05B1pPIATdMRSu0cMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="J/cEdMcm";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AC0606A326
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 19:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44AC0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=J/cEdMcm
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso2847104a91.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795634136; x=1796238936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w3smB/TOMIsBOIa48IJ7JNzgUykCOEbYDqooopA7Cxs=;
        b=J/cEdMcmtp+2QBOI+W5wC1ksFSU6UR/Rg0++bRhvnnolmKblQvpUOgNFOfb/3hudX+
         eUkOsJ/am6h4GC4Bn0hOJ8627ql8V9kYo//d0DO+ryj3PTcZs9S+XwuTFOv/o0Wj1Ttl
         E5f2RHDUbpfnFW09dz9qlN42BkCElDHFcMht4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795634136; x=1796238936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3smB/TOMIsBOIa48IJ7JNzgUykCOEbYDqooopA7Cxs=;
        b=cJQj+1Ds6G44uqd2UpsLT7wirfO+ibwRfF0xdGX1FEcPwOJCrOkLiY0OTPeX6UXc21
         ocHK6Wi7w+MD0DtncXgPzN3QoWQjTtQJ+SeWbFkXZSFhNGGt4gYPerllffWPTbjfwdQY
         xbI/ssNrfVThNsGe3fcd/Pa92qeREyAUExWf9QN+1n/q8i9kYBVGIKlG31RFl8deQP3T
         TH2of8qJ5SjNOy2MD2NHJM9DKkYRP/CYEBWmzJwdQUzNup/OrF9prXgjKX4Z1MkoINxJ
         7e6WIUPtuw9vFnXOV8KGSbsZgmXFLzq7fygQ5wBTw9/GJphhzIE/75paeQH9GhNnzxUX
         is4Q==
X-Forwarded-Encrypted: i=1; AL+hErFg0634H4+cPMlwF/1+c3LkQSCBrf2Yp98CHuV7nMlRA00gNTfwy5IDbtfbIorXrYSh+SROALT49A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8qKyCQyCCkNNCv6urdccmEf+2jwDhzM04ZIYBvC+Th/jL8jB+S
	OCBb2JWzWxatmBtAROU20ujYuyv85ySBCpanEs+6EKZ+y/lkhViIk3iMHtL5d2dxLA==
X-Gm-Gg: AZFdTZea4xoD5ohhUn94v9rPvwV26KC430Af8bxt3y1Y4PjmzeTKpuy4XvYEX32ZqZH
	7Udb/zBxUOKcpu3zAbc3jtvJnxGPepqlBVpU1FmJgPtT2WUBCyFrG6UpnVzTM9KP/Hzmh46wEyb
	mi8VgxA2yFH0M0MkyxnUTgctXFcThee9fOYkijQ4GKmXY3UIev9QV5kALeglHcmGqh6h+Bsa+fU
	e0Qgowvq20cc2kkbUvr2XVWHDbj9WRfBML5rjJMD13Xf4UUVCZnQl66Mw2uS8Equgo4rWROwhgu
	BFWBDxvdpXFoLEpyKGD9UvntbqazmbjKbrrWC3SgkIiYRzkTyRKO4KVEx1ZrNrbuhgDA7KROM8j
	qZIZAgdxwArFWeyoBtA+xsN36G9nxHk018RyW4vxusCSxGGQenFA7W2g85C18VGQgG8XsM0sCNt
	amnbWSFgMWlEC65Wk0L2gBDYZzbL8vE4nxqA2KdbfE7B2H1Ds8GDI+r5yAfaYGhMm68s1cKmjTU
	beYR3NIAR/N61sUd5iF9Mndm7UhxeoVD2qx4SUZu65sfd9lBiqlcqT4EJfjr8AJ9G60niODLBmo
	0NjcholxORUVtJHvPqEz/QI20g8aR8dv/Zj3TI5kV03K1kkFZpsTjxgQmCiaWWlDW3A=
X-Received: by 2002:a17:90b:442c:b0:3ac:a203:e0a1 with SMTP id 98e67ed59e1d1-3b41c92a902mr18354355a91.37.1795634136385;
        Wed, 25 Nov 2026 11:15:36 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d0a2:f616:6ba:a1ce])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cde6d05782asm9164989a12.24.2026.11.25.11.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 11:15:35 -0800 (PST)
Date: Wed, 25 Nov 2026 11:15:33 -0800
From: Brian Norris <briannorris@chromium.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	Jakub =?utf-8?B?R8WCb3dhY2tp?= <jglow@google.com>,
	linux-clk@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	Mariano Marciello <mmarciello@google.com>,
	google-soc@lists.linux.dev
Subject: Re: [PATCH v2 5/9] reset: google: Add CPM reset driver
Message-ID: <awcz1aP6xcL6G2t4@google.com>
References: <20261125000349.3385325-1-briannorris@chromium.org>
 <20261124160343.v2.5.I0b1ad34a718a9b5f667d2481041970ea45989dd3@changeid>
 <f89e293688feb3f9bcdce0f1b6fed0ee424e5cd8.camel@pengutronix.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89e293688feb3f9bcdce0f1b6fed0ee424e5cd8.camel@pengutronix.de>

On Wed, Nov 25, 2026 at 09:48:04AM +0100, Philipp Zabel wrote:
> On Di, 2026-11-24 at 16:03 -0800, Brian Norris wrote:
> > Google Tensor SoCs (used on Pixel phones) manage many resources
> > (including resets) using a Central Power Manager (CPM) co-processor. We
> > communicate with CPM using mailboxes, abstracted in the
> > devm_cpm_get_handle(), etc., API.
> > 
> > For posterity, I list a summary of changes made relative to the
> > downstream Pixel driver:
> > 
> > * Switch to auxiliary bus, as a child of a CPM device
> > 
> > * Use devm more heavily
> > 
> > * Avoid representing each reset as its own Device Tree node.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> > Changes in v2:
> >  * Rename symbols from goog_cpm_rst_* to cpm_reset_*
> >  * Moved shared protocol details to CPM driver
> >  * Remove custom reset debugfs interface and .remove callback.
> >  * Remove per-SoC table; we only need naive translation of firmware IDs
> > 
> >  drivers/reset/Kconfig            |   1 +
> >  drivers/reset/Makefile           |   1 +
> >  drivers/reset/google/Kconfig     |  11 +++
> >  drivers/reset/google/Makefile    |   2 +
> >  drivers/reset/google/reset-cpm.c | 154 +++++++++++++++++++++++++++++++
> >  5 files changed, 169 insertions(+)
> >  create mode 100644 drivers/reset/google/Kconfig
> >  create mode 100644 drivers/reset/google/Makefile
> >  create mode 100644 drivers/reset/google/reset-cpm.c
> > 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 673bca1e594e..64c12b479b2c 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -475,6 +475,7 @@ config RESET_ZYNQMP
> >  	  This enables the reset controller driver for Xilinx ZynqMP SoCs.
> >  
> >  source "drivers/reset/amlogic/Kconfig"
> > +source "drivers/reset/google/Kconfig"
> >  source "drivers/reset/hisilicon/Kconfig"
> >  source "drivers/reset/realtek/Kconfig"
> >  source "drivers/reset/spacemit/Kconfig"
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index 2fe527a7be8e..a151fe63905e 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-y += core.o
> >  obj-y += amlogic/
> > +obj-y += google/
> >  obj-y += hisilicon/
> >  obj-y += realtek/
> >  obj-y += spacemit/
> > diff --git a/drivers/reset/google/Kconfig b/drivers/reset/google/Kconfig
> > new file mode 100644
> > index 000000000000..38431b4f9001
> > --- /dev/null
> > +++ b/drivers/reset/google/Kconfig
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config RESET_CPM
> > +	tristate "Google CPM Reset Controller"
> > +	depends on ARCH_GOOGLE || COMPILE_TEST
> > +	depends on GOOGLE_CPM_MBA
> > +	help
> > +	  Driver support for reset controllers found on Google Tensor SoCs,
> > +	  operating over the CPM mailbox interface. This allows peripheral
> > +	  drivers to assert and deassert resets on LPCM hardware blocks.
> > +
> > +	  If unsure, say N.
> > diff --git a/drivers/reset/google/Makefile b/drivers/reset/google/Makefile
> > new file mode 100644
> > index 000000000000..437c19459464
> > --- /dev/null
> > +++ b/drivers/reset/google/Makefile
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_RESET_CPM) += reset-cpm.o
> > diff --git a/drivers/reset/google/reset-cpm.c b/drivers/reset/google/reset-cpm.c
> > new file mode 100644
> > index 000000000000..ef0863f25cac
> > --- /dev/null
> > +++ b/drivers/reset/google/reset-cpm.c
> > @@ -0,0 +1,154 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Device driver to control Google SoC LPCM resets via CPM.
> > + * Copyright 2023-2026 Google LLC
> > + */
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/container_of.h>
> > +#include <linux/dev_printk.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/gfp_types.h>
> > +#include <linux/limits.h>
> > +#include <linux/mod_devicetable.h>
> 
> Please include the specific <linux/device-id/*.h> that is needed
> instead of all of <linux/mod_devicetable.h>.

Ack.

> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/reset-controller.h>
> > +#include <linux/types.h>
> > +#include <soc/google/google-cpm-mba.h>
> > +
> > +#define ASSERT_OP_ID			0
> > +#define DEASSERT_OP_ID			1
> > +
> > +#define CPM_RST_LPCM_ID_MASK		GENMASK(31, 16)
> > +#define CPM_RST_ID_MASK			GENMASK(15, 0)
> 
> Why are these fields 16 bits wide when one line below it says:

Poor code evolution, as the bindings changed, and the field width became
more explicit here. Sorry I missed this.

I'm thinking I'll shrink the above to 8 bits, and use FIELD_MAX(*_MASK)
for validation instead of CPM_RST_ID_MAX.

> > +/* Object fields are 8 bits */
> > +#define CPM_RST_ID_MAX			U8_MAX
> > +
> > +static inline unsigned long to_rstc_idx(u32 lpcm_id, u32 rst_id)
> > +{
> > +	return FIELD_PREP(CPM_RST_LPCM_ID_MASK, lpcm_id) |
> > +	       FIELD_PREP(CPM_RST_ID_MASK, rst_id);
> > +}
> > +
> > +static inline u32 lpcm_from_idx(unsigned long idx)
> > +{
> > +	return FIELD_GET(CPM_RST_LPCM_ID_MASK, idx);
> > +}
> > +
> > +static inline u32 rst_from_idx(unsigned long idx)
> > +{
> > +	return FIELD_GET(CPM_RST_ID_MASK, idx);
> > +}
> > +
> > +struct cpm_reset_provider {
> > +	struct reset_controller_dev rcdev;
> > +	struct cpm_handle *cpm;
> > +};
> > +
> > +static inline struct cpm_reset_provider *to_provider(struct reset_controller_dev *rcdev)
> > +{
> > +	return container_of(rcdev, struct cpm_reset_provider, rcdev);
> > +}
> > +
> > +static int cpm_reset_send_lpcm(struct reset_controller_dev *rcdev,
> > +			       unsigned long idx, u8 opcode)
> > +{
> > +	struct cpm_reset_provider *provider = to_provider(rcdev);
> > +	const struct cpm_lpcm_message msg = {
> > +		.cmd = LPCM_CMD_SET_RST,
> > +		.opcode = opcode,
> > +		.lpcm_id = lpcm_from_idx(idx),
> > +		.obj_id = rst_from_idx(idx),
> > +	};
> > +
> > +	return cpm_send_lpcm_message(provider->cpm, &msg);
> > +}
> > +
> > +static int cpm_reset_assert(struct reset_controller_dev *rcdev,
> > +			    unsigned long idx)
> > +{
> > +	return cpm_reset_send_lpcm(rcdev, idx, ASSERT_OP_ID);
> > +}
> > +
> > +static int cpm_reset_deassert(struct reset_controller_dev *rcdev,
> > +			      unsigned long idx)
> > +{
> > +	return cpm_reset_send_lpcm(rcdev, idx, DEASSERT_OP_ID);
> > +}
> > +
> > +static const struct reset_control_ops cpm_reset_ops = {
> > +	.assert = cpm_reset_assert,
> > +	.deassert = cpm_reset_deassert,
> > +};
> > +
> > +static int cpm_reset_of_xlate(struct reset_controller_dev *rcdev,
> > +			      const struct of_phandle_args *reset_spec)
> > +{
> > +	u32 lpcm_id, rst_id;
> > +
> > +	if (reset_spec->args_count != 2)
> > +		return -EINVAL;
> > +
> > +	lpcm_id = reset_spec->args[0];
> > +	rst_id = reset_spec->args[1];
> > +
> > +	if (lpcm_id > CPM_RST_ID_MAX)
> 
> This looks a bit weird.
> 
> Maybe add a CPM_LPCM_ID_MAX, directly use U8_MAX here, or rename the
> constant to not include RST_ID?

How about these (with the masks made 8-bit as they should be)?

  FIELD_MAX(CPM_RST_LPCM_ID_MASK))
  FIELD_MAX(CPM_RST_ID_MASK))

Or else maybe just U8_MAX.

> > +		return -EINVAL;
> > +	if (rst_id > CPM_RST_ID_MAX)
> > +		return -EINVAL;
> > +
> > +	return to_rstc_idx(lpcm_id, rst_id);
> > +}
> > +
> > +static int cpm_reset_probe(struct auxiliary_device *auxdev,
> > +			   const struct auxiliary_device_id *id)
> > +{
> > +	struct device *dev = &auxdev->dev;
> > +	struct cpm_reset_provider *provider;
> > +	int ret;
> > +
> > +	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
> 
> devm_kzalloc_obj()

Ack.

> > +	if (!provider)
> > +		return -ENOMEM;
> > +
> > +	provider->cpm = devm_cpm_get_handle(dev);
> > +	if (IS_ERR(provider->cpm))
> > +		return dev_err_probe(dev, PTR_ERR(provider->cpm),
> > +				     "Failed to get CPM handle\n");
> > +
> > +	provider->rcdev.dev = dev;
> > +	provider->rcdev.owner = THIS_MODULE;
> > +	provider->rcdev.of_node = dev->of_node;
> > +	provider->rcdev.ops = &cpm_reset_ops;
> > +	provider->rcdev.of_reset_n_cells = 2;
> > +	provider->rcdev.of_xlate = cpm_reset_of_xlate;
> > +
> > +	ret = devm_reset_controller_register(dev, &provider->rcdev);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to register reset controller: %d\n", ret);
> 
> dev_err_probe()

Ack.

Regards,
Brian
