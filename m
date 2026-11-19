Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114187;
	b=AApn43awcAYoC/KLKJ4ddqAP3+r4gYkXJZs8L81pidgX+0l6k2cT6LrO9v02j8S3IkZd
	 Uxje2l/fCAt8gE7NcmsaQps3wBuFGeTC3LHxXHLidJwdng1sgsA/qmmLLrMta4dfpkHwn
	 UFnZWEJzOQX77gptFhP/bQBd3mVXV+2Nd9Z/U2pUx2/ZcUq5/FXY9wyyeyKoJpXNVaOdU
	 ZWJq/a6rHd/4W5JGGwLOAS9qBrXfGIlzdXdLGktkDsqEeI+xIMsMcp8rtoDkfLc5EystN
	 ZbSzuW2iG0MyIw510e/GqIMVGY3gbI74o8sIFRQxk5xXPEPqi5YdGIVz70sOqh7ynpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114187;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-AI-Review-Draft;
	bh=BFGiQ3bPXd04tCdi5W1EneLTHL/Y5YgyApKsgvojxzo=;
	b=IrYrwdaWktGJrjzuS99BkPUY+w48fESUOoH17/6I95Kp3sWyS+3g/tBkuFWQTprl7NYU
	 0Qxu7NaU2YzYY4JS2u8Rx2jPQLFNmsFoBmHwmofDQLo8NqINiF2J3wmJ5JVMnXUa6m5dT
	 qo938hK/xIp/T9EIjybE9E8fo6WCHNPHdiykAJ2aWUtYYg95zODd5kI01NHHLrOGea6O7
	 cY+rZtHvQI71foBIRiN5cnrlWUgGg9baXBEC7b94L4Z+iaJC7nxKiEe+oXGbPi0AtC3px
	 UGY/DBOwkDALGmv9Tb40Q+5qMHDDgWCRytFj+83+jXSA7xfCtkUSWU39P/KW6KlDUcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQpH+1AV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4B2606A326;
	Thu, 19 Nov 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQpH+1AV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDE21F000C4;
	Thu, 19 Nov 2026 18:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114187;
	bh=BFGiQ3bPXd04tCdi5W1EneLTHL/Y5YgyApKsgvojxzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MQpH+1AV4z5xJ/gafWNosFTQe3/Clx39BBa9OL1e7vIJFWwZXByjbFLYKmg14APc6
	 BHBboIyf1yT5dRciYJBw394Y8swHP7/+5IxP6YBC7oohPNPT+7Ho2IJbtvrliq5+j8
	 7Oq6P1woAYDBl0qEARcGX7NZf7u44+J4tdghIXXsUza2T6eWE6SgxRqTyVFcC9Givu
	 yZJ9Jl+hXkED2qIrF6ZmBOAe/h8bsROODaazcGP7kU68Bd7KdPuNB1KaLrVYG6fI90
	 zz1Z8TY1z2hw5u38dxmze4oTHbqJFTHa5jHdZ0DRGlXmCb10+6fW4nZI8M18Vw4EiU
	 ZQ7oN1K83rAsQ==
Date: Thu, 19 Nov 2026 18:49:40 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?iso-8859-1?Q?Rafal_Milecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, Ulf Hansson <ulfh@kernel.org>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/6] mfd: bcmbca-pmb: Add a shared BCMBCA PMC3 PMB
  transport
Message-ID: <179510274338.63755.13074299296013371295@kernel.org>
References: <20261117-xg6846b-bcmbca-xrdp-reset-v5-0-f584e8b8e696@kernel.org>
 <20261117-xg6846b-bcmbca-xrdp-reset-v5-2-f584e8b8e696@kernel.org>
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
In-Reply-To: <20261117-xg6846b-bcmbca-xrdp-reset-v5-2-f584e8b8e696@kernel.org>
X-AI-Review-Draft: <20261117-xg6846b-bcmbca-xrdp-reset-v5-2-f584e8b8e696@kernel.org>

Hey Linus,

Some inline review comments, but the chewy stuff is at the bottom.

--- checkpatch.pl (2 issues) ---
Line 51: WARNING: please write a help paragraph that fully describes the config symbol with at least 4 lines
Line 374: WARNING: DT compatible string "brcm,bcm6846-pmb" appears un-documented -- check ./Documentation/devicetree/bindings/
----------------------------------

?

> Add an MFD driver for shared access to the Power Management Bus (PMB)
> of the third generation Power Management Controller (PMC3), initially
> for BCM6846.
>
> Expose an uncached regmap to all children, encoding the bus, device and
> word offset in each register address. Keep keyhole semaphore acquisition
> and transaction recovery inside the MFD driver.
>
> A software timeout does not abort a transaction. If the keyhole is still
> busy, retain its hardware lock and reject new callers until delayed work
> observes completion and releases it.
>
> The keyhole register layout differs from older Broadcom PMB controllers.
> Match only BCM6846 for now.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  MAINTAINERS                    |   2 +
>  drivers/mfd/Kconfig            |  11 ++
>  drivers/mfd/Makefile           |   1 +
>  drivers/mfd/bcmbca_pmc3_pmb.c  | 308 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/bcmbca-pmb.h |  11 ++
>  5 files changed, 333 insertions(+)

I can't help but feel this could be implemented in a much nicer way?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 67642e2a4ab3..1857e720ce3a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5448,9 +5448,11 @@ BROADCOM BCMBCA PMC3 PMB DRIVER
>  M:	Linus Walleij <linusw@kernel.org>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml
> +F:	drivers/mfd/bcmbca_pmc3_pmb.c
>  F:	include/dt-bindings/clock/brcm,bcm6846-pmb.h
>  F:	include/dt-bindings/power/brcm,bcm6846-pmb.h
>  F:	include/dt-bindings/reset/brcm,bcm6846-pmb.h
> +F:	include/linux/mfd/bcmbca-pmb.h
>
>  BROADCOM BDC DRIVER
>  M:	Justin Chen <justin.chen@broadcom.com>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 87ed55c155f0..95e93ea155e1 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -173,6 +173,17 @@ config MFD_ATMEL_SMC
>  	bool
>  	select MFD_SYSCON
>
> +config MFD_BCMBCA_PMB
> +	bool "Broadcom BCMBCA Power Management Bus"
> +	depends on ARCH_BCMBCA || COMPILE_TEST
> +	depends on OF
> +	select MFD_CORE
> +	select REGMAP
> +	help
> +	  Provide shared Power Management Bus (PMB) access through the third
> +	  generation Power Management Controller (PMC3), initially on
> +	  BCM6846.
> +
>  config MFD_BCM590XX
>  	tristate "Broadcom BCM590xx PMUs"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f8101d2a9ce9..f00f5caabe04 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
>  obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
>  obj-$(CONFIG_MFD_SM501)		+= sm501.o
>  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
> +obj-$(CONFIG_MFD_BCMBCA_PMB)	+= bcmbca_pmc3_pmb.o
>  obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
>  obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
>  obj-$(CONFIG_MFD_BQ257XX)	+= bq257xx.o
> diff --git a/drivers/mfd/bcmbca_pmc3_pmb.c b/drivers/mfd/bcmbca_pmc3_pmb.c
> new file mode 100644
> index 000000000000..8607429e8b9a
> --- /dev/null
> +++ b/drivers/mfd/bcmbca_pmc3_pmb.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Broadcom BCMBCA Power Management Bus (PMB) transport for the third
> + * generation Power Management Controller (PMC3).
> + *
> + * Children access keyhole 0 through a shared regmap.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/ioport.h>
> +#include <linux/log2.h>
> +#include <linux/mfd/bcmbca-pmb.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/workqueue.h>
> +
> +#define PMB_CONFIG		0x00
> +#define PMB_REGS_PER_DEVICE	GENMASK(29, 20)
> +#define PMB_CONTROL		0x10
> +#define PMB_WRITE_DATA		0x14
> +#define PMB_MUTEX		0x18
> +#define PMB_READ_DATA		0x1c
> +#define PMB_START		BIT(31)
> +#define PMB_TIMEOUT		BIT(30)
> +#define PMB_SLAVE_ERROR		BIT(29)
> +#define PMB_BUSY			BIT(28)
> +#define PMB_WRITE		BIT(24)
> +#define PMB_BUS			GENMASK(21, 20)
> +#define PMB_LOCKED		BIT(0)
> +
> +struct bcmbca_pmb {
> +	struct device *dev;
> +	void __iomem *base;
> +	/* Serializes regmap operations and recovery state. */
> +	struct mutex lock;
> +	struct delayed_work recovery;
> +	u32 regs_per_device;
> +	bool keyhole_acquired;
> +	bool recovering;
> +	bool stopping;

Do we really need to run this as a state machine?

It's not every Linuxy.

> +};
> +
> +static void bcmbca_pmb_recover(struct work_struct *work)
> +{
> +	struct bcmbca_pmb *pmb = container_of(to_delayed_work(work),
> +					   struct bcmbca_pmb, recovery);
> +
> +	guard(mutex)(&pmb->lock);
> +	if (!pmb->stopping) {

Why not return early on the inverse?

> +		if (readl(pmb->base + PMB_CONTROL) & PMB_BUSY) {
> +			queue_delayed_work(system_dfl_wq, &pmb->recovery,
> +					   msecs_to_jiffies(100));

Why 100?

> +		} else {
> +			writel(PMB_LOCKED, pmb->base + PMB_MUTEX);
> +			pmb->recovering = false;
> +		}

I have no idea what any of this is doing.

Comments?

> +	}
> +}
> +
> +static int bcmbca_pmb_acquire(struct bcmbca_pmb *pmb)
> +{
> +	u32 value;
> +	int ret;
> +
> +	lockdep_assert_held(&pmb->lock);
> +	if (pmb->stopping)
> +		return -ENODEV;
> +	if (pmb->recovering)
> +		return -EBUSY;
> +	if (pmb->keyhole_acquired)
> +		return 0;
> +
> +	/* Reading bit 0 acquires the hardware lock; writing 1 releases it. */
> +	ret = readl_poll_timeout(pmb->base + PMB_MUTEX, value,
> +				 value & PMB_LOCKED, 1, 1000);
> +	if (!ret)
> +		pmb->keyhole_acquired = true;
> +	return ret;
> +}
> +
> +static int bcmbca_pmb_op(struct bcmbca_pmb *pmb, u8 bus, u8 device,
> +			 u16 offset, u32 *value, bool write)
> +{
> +	u32 status, command;
> +	int ret;
> +
> +	lockdep_assert_held(&pmb->lock);
> +	if (bus > FIELD_MAX(PMB_BUS) || offset >= pmb->regs_per_device)
> +		return -EINVAL;
> +
> +	ret = readl_poll_timeout(pmb->base + PMB_CONTROL, status,
> +				 !(status & PMB_BUSY), 1, 1000);
> +	if (ret)
> +		return ret;
> +	command = PMB_START | FIELD_PREP(PMB_BUS, bus) |
> +		  (device * pmb->regs_per_device) | offset;
> +	if (write) {
> +		writel(*value, pmb->base + PMB_WRITE_DATA);
> +		command |= PMB_WRITE;
> +	}
> +	writel(command, pmb->base + PMB_CONTROL);
> +	ret = readl_poll_timeout(pmb->base + PMB_CONTROL, status,
> +				 !(status & PMB_BUSY), 1, 1000);
> +	if (ret || status & PMB_TIMEOUT)
> +		return -ETIMEDOUT;
> +	if (status & PMB_SLAVE_ERROR)
> +		return -EIO;
> +	if (!write)
> +		*value = readl(pmb->base + PMB_READ_DATA);
> +	return 0;
> +}
> +
> +static void bcmbca_pmb_regmap_lock(void *arg)
> +{
> +	struct bcmbca_pmb *pmb = arg;
> +
> +	mutex_lock(&pmb->lock);
> +}
> +
> +static void bcmbca_pmb_regmap_unlock(void *arg)
> +{
> +	struct bcmbca_pmb *pmb = arg;
> +
> +	if (pmb->keyhole_acquired) {
> +		if (readl(pmb->base + PMB_CONTROL) & PMB_BUSY) {
> +			pmb->recovering = true;
> +			dev_err(pmb->dev, "PMB keyhole still busy; deferring unlock\n");
> +			queue_delayed_work(system_dfl_wq, &pmb->recovery,
> +					   msecs_to_jiffies(100));
> +		} else {
> +			writel(PMB_LOCKED, pmb->base + PMB_MUTEX);
> +		}
> +		pmb->keyhole_acquired = false;
> +	}
> +	mutex_unlock(&pmb->lock);
> +}
> +
> +/* Acquire lazily so semaphore errors reach the caller of the regmap API. */
> +static int bcmbca_pmb_reg_read(void *context, unsigned int reg, unsigned int *value)
> +{
> +	struct bcmbca_pmb *pmb = context;
> +	int ret;
> +
> +	bcmbca_pmb_regmap_lock(pmb);
> +	ret = bcmbca_pmb_acquire(pmb);
> +	if (!ret)
> +		ret = bcmbca_pmb_op(pmb, reg >> 24, (reg >> 16) & 0xff,
> +				    reg & 0xffff, value, false);
> +	bcmbca_pmb_regmap_unlock(pmb);
> +	return ret;
> +}
> +
> +static int bcmbca_pmb_reg_write(void *context, unsigned int reg, unsigned int value)
> +{
> +	struct bcmbca_pmb *pmb = context;
> +	int ret;
> +
> +	bcmbca_pmb_regmap_lock(pmb);
> +	ret = bcmbca_pmb_acquire(pmb);
> +	if (!ret)
> +		ret = bcmbca_pmb_op(pmb, reg >> 24, (reg >> 16) & 0xff,
> +				    reg & 0xffff, &value, true);
> +	bcmbca_pmb_regmap_unlock(pmb);
> +	return ret;
> +}
> +
> +static int bcmbca_pmb_reg_update_bits(void *context, unsigned int reg,
> +				      unsigned int mask, unsigned int value)
> +{
> +	struct bcmbca_pmb *pmb = context;
> +	unsigned int tmp;
> +	int ret;
> +
> +	bcmbca_pmb_regmap_lock(pmb);
> +	ret = bcmbca_pmb_acquire(pmb);
> +	if (ret)
> +		goto out;
> +
> +	ret = bcmbca_pmb_op(pmb, reg >> 24, (reg >> 16) & 0xff,
> +			    reg & 0xffff, &tmp, false);
> +	if (ret)
> +		goto out;
> +
> +	tmp = (tmp & ~mask) | (value & mask);
> +	ret = bcmbca_pmb_op(pmb, reg >> 24, (reg >> 16) & 0xff,
> +			    reg & 0xffff, &tmp, true);
> +out:
> +	bcmbca_pmb_regmap_unlock(pmb);
> +	return ret;
> +}
> +
> +static struct regmap *bcmbca_pmb_regmap_init(struct bcmbca_pmb *pmb)
> +{
> +	const struct regmap_config config = {
> +		.reg_bits = 32,
> +		.val_bits = 32,
> +		.reg_stride = 1,
> +		.max_register = BCMBCA_PMB_REG(3, 255, 65535),
> +		.cache_type = REGCACHE_NONE,
> +		/* Callbacks serialize I/O; suppress unsafe debugfs probing. */
> +		.disable_locking = true,
> +		.reg_read = bcmbca_pmb_reg_read,
> +		.reg_write = bcmbca_pmb_reg_write,
> +		.reg_update_bits = bcmbca_pmb_reg_update_bits,
> +		.can_sleep = true,
> +	};

We nearly always declare these statically.

> +	return devm_regmap_init(pmb->dev, NULL, pmb, &config);
> +}
> +
> +/* Children are removed before this action, while MMIO is still mapped. */
> +static void bcmbca_pmb_stop(void *data)
> +{
> +	struct bcmbca_pmb *pmb = data;
> +
> +	scoped_guard(mutex, &pmb->lock)
> +		pmb->stopping = true;
> +	cancel_delayed_work_sync(&pmb->recovery);
> +
> +	if (pmb->recovering) {
> +		if (readl(pmb->base + PMB_CONTROL) & PMB_BUSY)
> +			dev_err(pmb->dev, "PMB keyhole remains busy; hardware reset required\n");
> +		else
> +			writel(PMB_LOCKED, pmb->base + PMB_MUTEX);
> +	}
> +}
> +
> +static const struct mfd_cell bcm6846_pmb_cells[] = {
> +	{
> +		.name = "bcm6846-pmb-power",
> +		.of_compatible = "brcm,bcm6846-pmb-power",
> +	},
> +	{
> +		.name = "bcm6846-pmb-clock",
> +		.of_compatible = "brcm,bcm6846-pmb-clock",
> +	},
> +	{
> +		.name = "bcm6846-pmb-reset",
> +		.of_compatible = "brcm,bcm6846-pmb-reset",
> +	},
> +	{
> +		.name = "bcm6846-pmb-pvtmon",
> +		.of_compatible = "brcm,bcm6846-pmb-pvtmon",
> +	},
> +};

MFD_CELL_OF()?

Why are they all the way down here?

I often think it's nicer to see the children at the top of the file.

> +static int bcmbca_pmb_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct bcmbca_pmb *pmb;
> +	struct regmap *regmap;
> +	struct resource *res;
> +	int ret;
> +
> +	pmb = devm_kzalloc(dev, sizeof(*pmb), GFP_KERNEL);
> +	if (!pmb)
> +		return -ENOMEM;
> +	pmb->dev = dev;
> +	pmb->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(pmb->base))
> +		return PTR_ERR(pmb->base);
> +	if (resource_size(res) < PMB_READ_DATA + sizeof(u32))
> +		return dev_err_probe(dev, -EINVAL, "PMB register range is too small\n");
> +	pmb->regs_per_device = FIELD_GET(PMB_REGS_PER_DEVICE,
> +					 readl(pmb->base + PMB_CONFIG));
> +	if (!is_power_of_2(pmb->regs_per_device))
> +		return dev_err_probe(dev, -EINVAL, "invalid PMB register stride\n");
> +	mutex_init(&pmb->lock);

Does devm_mutex_init() work here?

> +	INIT_DELAYED_WORK(&pmb->recovery, bcmbca_pmb_recover);
> +	ret = devm_add_action_or_reset(dev, bcmbca_pmb_stop, pmb);
> +	if (ret)
> +		return ret;
> +	regmap = bcmbca_pmb_regmap_init(pmb);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "failed to register PMB regmap\n");
> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, bcm6846_pmb_cells,
> +				   ARRAY_SIZE(bcm6846_pmb_cells), NULL, 0, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register PMB functions\n");

The 30 lines above are a mess.

Why are they all scrunched up like this?

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bcmbca_pmb_match[] = {
> +	{ .compatible = "brcm,bcm6846-pmb" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bcmbca_pmb_match);
> +
> +static struct platform_driver bcmbca_pmb_driver = {
> +	.probe = bcmbca_pmb_probe,
> +	.driver = {
> +		.name = "bcmbca-pmb",
> +		.of_match_table = bcmbca_pmb_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver(bcmbca_pmb_driver);
> +
> +MODULE_DESCRIPTION("Broadcom BCMBCA Power Management Bus transport for PMC3");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/bcmbca-pmb.h b/include/linux/mfd/bcmbca-pmb.h
> new file mode 100644
> index 000000000000..36e2b42bf053
> --- /dev/null
> +++ b/include/linux/mfd/bcmbca-pmb.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __LINUX_MFD_BCMBCA_PMB_H
> +#define __LINUX_MFD_BCMBCA_PMB_H
> +
> +#include <linux/types.h>
> +
> +/* Logical regmap addresses: 8-bit bus, 8-bit device, 16-bit word offset. */
> +#define BCMBCA_PMB_REG(bus, device, offset) \
> +	(((u32)(bus) << 24) | ((u32)(device) << 16) | (offset))
> +#endif

Dear Gemini,

Can you keep me honest here - give me it straight.

Am I being unreasonable?  This all seems rather fiddly.

    You are not being unreasonable at all - your instincts are spot on, and the
    recovery state machine is actually dead code.
    
    Look at bcmbca_pmb_op(): 1. It waits for PMB_BUSY to clear via
    readl_poll_timeout() (1ms). 2. It writes PMB_START to PMB_CONTROL to kick off
    the hardware transaction.  3. It immediately waits for PMB_BUSY to clear again
    via readl_poll_timeout() (1ms).
    
    The only way bcmbca_pmb_regmap_unlock() ever observes PMB_BUSY still set is if
    that second 1ms poll in bcmbca_pmb_op() timed out (meaning a single 32-bit
    register transaction hung on the bus for >1ms).  Furthermore, the hardware
    appears to have its own built-in timeout bit (PMB_TIMEOUT in PMB_CONTROL), which
    terminates wedged transactions in hardware anyway.
    
    If you drop the delayed-work recovery state machine and just release PMB_MUTEX
    synchronously (perhaps after a final bounded poll or if !PMB_BUSY), you can
    delete: - 'struct delayed_work recovery' - 'keyhole_acquired', 'recovering', and
    'stopping' booleans - bcmbca_pmb_recover() - bcmbca_pmb_stop() and the
    devm_add_action_or_reset() dance - '#include <linux/workqueue.h>'
    
    On top of that, why does this disable regmap's own locking (.disable_locking =
    true) only to manually call bcmbca_pmb_regmap_lock() and
    bcmbca_pmb_regmap_unlock() around every callback?  If it just used a normal
    mutex inside .reg_read / .reg_write / .reg_update_bits with
    guard(mutex)(&pmb->lock) and a small helper that acquires and releases PMB_MUTEX
    around the transaction, the driver would shrink by ~100 lines and be vastly
    easier to read.

-- 
Lee Jones
