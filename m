Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794180971;
	b=rOsq+epObZ3bL4ZjPIKyOhii35bqhV0V74A4i3leu8QHwQE00CrsaxrOrKjxO+ZifmzS
	 58ejeOxRypvbbuyJOaeNSsQg698G3Iq12IbWM7fG3zswn5Hf1BYdFDZKpIGQzAIpowMB9
	 7qq+38klGtx4Evp8AfRpUQeXj+W8498OLzeMzZ5fxJ44gL5StBjYTIVCgC4mhvapvGK2e
	 i3zCCLjT7mtM7DI7Kdf/C4JLkdmaYuWaYENV8iYZVHfaxXJhDV4a1UUsHG1cAhBmusnXU
	 vs6MpPt1BCs25iZ5OBEwaqUCUcE5nP7+LTUuVX21Nzrd88sa5PQ5D/iJ3D192UKvVGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794180971;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=rzCWbVuBq4j3nQbn9qB9nnBWuWV6AYhMWDHBJ2VGzO0=;
	b=5NTPfvGw+7g5nDyjVXFx9AtV6dN26cSJp3BX2Kzu+QaSF6sedX9l4OLNhj38uvfvP7Mi
	 MbV2NJTs1KJGTSV2ratuedMislM/e6yv7ITZZ0KNgaOpS6AcyRrA5W3Lbor4XBo2oGvXf
	 HiIM9x90/Mr6XbRwwlfypK3zr1L6nybB0nhAN2TAtNryMG3smgX85u4uvdUWfPYCxphXc
	 iGXwbQGGcVgQCZzpPaJQMPcsXvnA+t4aZ22tTvHim+9LhxnsvQhbKX/Wly7YF0k3oxQPv
	 7WqR4pK2n+j4spYkgPWyT6+DZ3XAKbu3ru8dCgMFUjWTX3eCJvbVbmopzQzrUzFbMDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=in0tMNCz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1BC606A31C;
	Sun,  8 Nov 2026 23:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E1BC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=in0tMNCz
ARC-Seal: i=1; a=rsa-sha256; t=1794180963; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JCYazuEbG8u34Ja0jbuY/ajRP4PFqo4nbl2PtFWagZtmlqXsfcAJ+nu3QqI2A7Fv7RmI4uCK6n8gFivHcvruMNd+DLqWsoFP7t4akel2XH8AwuKF4KkWbO8lbj08OqnzEMDW9HKFo+dkuM8mmw3Pfem6+lNN/t+f5g3zBogNdcY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794180963; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rzCWbVuBq4j3nQbn9qB9nnBWuWV6AYhMWDHBJ2VGzO0=; 
	b=IKiczBuVEXhR+WpwkayFG1gP4Vt76Z0mbLzzZR02h15eCDghDxNaS/jT++JacySsfkXgUTzaicq3OWEvsB7jXzOSz2uf/BP211Lbp2N5mCG+Fdx60Mnh0n/XNO4l1dR6CxDrBns7l1FTDQd1Gn7spbMzgERlVe9mV58r6gR519k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=in0tMNCzQwBgPx9EgkASniH97KM8xaaGsR4EMvsODd2Ew1duwFQ6Vl3JGy0XXDN21v0xSumbLgFy0acXiT2bkQXx8RFw2j28VLUHSJgjzyu1TE/TOoVafK54scYhiKyJrqftZBsNoZwk3YdlXlUas6h10bJv5WSF+3z8vZ/iQhE=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=rzCWbVuBq4j3nQbn9qB9nnBWuWV6AYhMWDHBJ2VGzO0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794180960667868.1735836710294;
	Sun, 8 Nov 2026 15:36:00 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 7C75E1808E6; Mon, 09 Nov 2026 00:35:58 +0100 (CET)
Date: Mon, 9 Nov 2026 00:35:58 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: servpol@tuta.io
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 2/2] power: supply: Add GL.iNet GL-E750 MCU battery
 driver
Message-ID: <avEHPVdx0NlX4dhy@venus>
References: <20261021-gl-e750-mcu-v2-0-9bd7e7c2e0e1@tuta.io>
 <20261021-gl-e750-mcu-v2-2-9bd7e7c2e0e1@tuta.io>
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
	protocol="application/pgp-signature"; boundary="cujmmn73vk23w3r4"
Content-Disposition: inline
In-Reply-To: <20261021-gl-e750-mcu-v2-2-9bd7e7c2e0e1@tuta.io>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.158.93
X-ZohoMailClient: External


--cujmmn73vk23w3r4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] power: supply: Add GL.iNet GL-E750 MCU battery
 driver
MIME-Version: 1.0

Hi,

On Wed, Oct 21, 2026 at 07:33:44PM +0000, Serv Pol via B4 Relay wrote:
> From: Serv Pol <servpol@tuta.io>
>=20
> The status MCU of the GL.iNet GL-E750 (Mudi) travel router sits on the
> SoC UART and talks in text lines: the host sends JSON objects whose values
> are all strings, and a request containing "mcu_status": "1" is answered
> with
>=20
>   {OK},<percent>,<temperature>,<charging>,<cycles>
>=20
> Poll that every 30 seconds and expose the result as a power_supply.
>=20
> When the power switch is turned off, the MCU sends {"shut_down": "1"},
> without a line ending, and cuts the power a few seconds later. Shut the
> system down cleanly in that case.
>=20
> The MCU also renders the status screen from JSON fields (SSIDs, clients,
> cellular state...). That vendor-specific content is not handled here.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Serv Pol <servpol@tuta.io>
> ---

The Sashiko analysis looks correct:

https://sashiko.dev/#/patchset/20261005-gl-e750-mcu-v1-0-499d2e31f786%40tut=
a.io

Greetings,

-- Sebastian

>  MAINTAINERS                        |   1 +
>  drivers/power/supply/Kconfig       |  13 ++
>  drivers/power/supply/Makefile      |   1 +
>  drivers/power/supply/gl-e750-mcu.c | 369 +++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 384 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 247432449..505aa205c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11110,6 +11110,7 @@ M:	Serv Pol <servpol@tuta.io>
>  L:	linux-pm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/power/supply/glinet,gl-e750-mcu.yaml
> +F:	drivers/power/supply/gl-e750-mcu.c
> =20
>  GNSS SUBSYSTEM
>  M:	Johan Hovold <johan@kernel.org>
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index ee7dc5f26..e87c76c18 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -1203,4 +1203,17 @@ config MACSMC_POWER
> =20
>  	  Say Y or M here if you have an Apple Silicon based Mac.
> =20
> +config BATTERY_GL_E750_MCU
> +	tristate "GL.iNet GL-E750 status MCU battery driver"
> +	depends on SERIAL_DEV_BUS
> +	depends on OF || COMPILE_TEST
> +	help
> +	  Say Y or M here to enable the battery driver for the status
> +	  microcontroller of the GL.iNet GL-E750 (Mudi) travel router.
> +	  It reports the battery state and shuts the system down when
> +	  the power switch is turned off.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called gl-e750-mcu.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index f3c0d1006..5d405556e 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_CHARGER_TWL4030)	+=3D twl4030_charger.o
>  obj-$(CONFIG_CHARGER_TWL6030)	+=3D twl6030_charger.o
>  obj-$(CONFIG_CHARGER_LP8727)	+=3D lp8727_charger.o
>  obj-$(CONFIG_CHARGER_LP8788)	+=3D lp8788-charger.o
> +obj-$(CONFIG_BATTERY_GL_E750_MCU)	+=3D gl-e750-mcu.o
>  obj-$(CONFIG_CHARGER_GPIO)	+=3D gpio-charger.o
>  obj-$(CONFIG_CHARGER_MANAGER)	+=3D charger-manager.o
>  obj-$(CONFIG_CHARGER_LT3651)	+=3D lt3651-charger.o
> diff --git a/drivers/power/supply/gl-e750-mcu.c b/drivers/power/supply/gl=
-e750-mcu.c
> new file mode 100644
> index 000000000..37541915e
> --- /dev/null
> +++ b/drivers/power/supply/gl-e750-mcu.c
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * GL.iNet GL-E750 (Mudi) status MCU battery driver
> + *
> + * The MCU sits on the SoC UART. It drives the OLED screen, monitors the
> + * battery and watches the power switch. The host sends one JSON object =
per
> + * line, where every value is a string. When a line contains
> + * "mcu_status": "1", the MCU answers with
> + *
> + *	{OK},<percent>,<temperature>,<charging>,<cycles>
> + *
> + * When the power switch is turned off, the MCU sends {"shut_down": "1"}=
 and
> + * cuts the power a few seconds later.
> + *
> + * Copyright (C) 2026 Serv Pol <servpol@tuta.io>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/ctype.h>
> +#include <linux/devm-helpers.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +#include <linux/reboot.h>
> +#include <linux/serdev.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +#include <linux/workqueue.h>
> +
> +#define MCU_BAUDRATE		115200
> +#define MCU_RX_LINE_MAX		128
> +#define MCU_POLL_INTERVAL_MS	30000
> +#define MCU_REPLY_TIMEOUT_MS	1500
> +
> +static const u8 mcu_status_req[] =3D "{ \"mcu_status\": \"1\" }\n";
> +
> +struct gl_e750_mcu {
> +	struct serdev_device *serdev;
> +	struct power_supply *psy;
> +	struct delayed_work poll_work;
> +	struct work_struct poweroff_work;
> +	struct completion reply;
> +
> +	/* receive buffer and battery state, filled from the serdev callback */
> +	spinlock_t lock;
> +	char rx_line[MCU_RX_LINE_MAX];
> +	size_t rx_len;
> +	bool valid;
> +	int capacity;		/* percent */
> +	int temp;		/* tenths of a degree Celsius */
> +	bool charging;
> +	int cycles;
> +};
> +
> +/* "37.4", "40" or "-1.5" -> tenths of a degree */
> +static int mcu_parse_tenths(const char *s, int *out)
> +{
> +	const char *dot =3D strchr(s, '.');
> +	char whole_str[8];
> +	int whole, frac =3D 0;
> +
> +	if (!dot) {
> +		if (kstrtoint(s, 10, &whole))
> +			return -EINVAL;
> +		*out =3D whole * 10;
> +		return 0;
> +	}
> +
> +	if (dot =3D=3D s || dot - s >=3D sizeof(whole_str))
> +		return -EINVAL;
> +	memcpy(whole_str, s, dot - s);
> +	whole_str[dot - s] =3D '\0';
> +	if (kstrtoint(whole_str, 10, &whole))
> +		return -EINVAL;
> +	if (isdigit(dot[1]))
> +		frac =3D dot[1] - '0';
> +	*out =3D whole * 10 + (*s =3D=3D '-' ? -frac : frac);
> +	return 0;
> +}
> +
> +/*
> + * "{OK},<percent>,<temperature>,<charging>,<cycles>", called with the l=
ock
> + * held. Returns true if the line was a valid status reply.
> + */
> +static bool mcu_parse_status(struct gl_e750_mcu *mcu, char *line)
> +{
> +	char *p =3D line + 4, *f[4];
> +	int capacity, temp, charging, cycles, i;
> +	bool changed;
> +
> +	if (*p++ !=3D ',')
> +		return false;
> +	for (i =3D 0; i < ARRAY_SIZE(f); i++) {
> +		f[i] =3D strsep(&p, ",");
> +		if (!f[i] || !*f[i])
> +			return false;
> +	}
> +
> +	if (kstrtoint(f[0], 10, &capacity) || mcu_parse_tenths(f[1], &temp) ||
> +	    kstrtoint(f[2], 10, &charging) || kstrtoint(f[3], 10, &cycles))
> +		return false;
> +	if (capacity < 0 || capacity > 100)
> +		return false;
> +
> +	changed =3D !mcu->valid || mcu->capacity !=3D capacity ||
> +		  mcu->charging !=3D !!charging || mcu->cycles !=3D cycles ||
> +		  abs(mcu->temp - temp) >=3D 10;
> +	mcu->capacity =3D capacity;
> +	mcu->temp =3D temp;
> +	mcu->charging =3D !!charging;
> +	mcu->cycles =3D cycles;
> +	mcu->valid =3D true;
> +
> +	complete(&mcu->reply);
> +	if (changed)
> +		power_supply_changed(mcu->psy);
> +	return true;
> +}
> +
> +/* called with the lock held */
> +static void mcu_handle_line(struct gl_e750_mcu *mcu, char *line)
> +{
> +	if (!strncmp(line, "{OK}", 4))
> +		mcu_parse_status(mcu, line);
> +	else if (strstr(line, "\"shut_down\""))
> +		schedule_work(&mcu->poweroff_work);
> +	else
> +		dev_dbg_ratelimited(&mcu->serdev->dev, "unhandled: %s\n", line);
> +}
> +
> +/* hand the buffered message over, called with the lock held */
> +static void mcu_flush_line(struct gl_e750_mcu *mcu)
> +{
> +	mcu->rx_line[mcu->rx_len] =3D '\0';
> +	mcu_handle_line(mcu, mcu->rx_line);
> +	mcu->rx_len =3D 0;
> +}
> +
> +/* a status reply is waiting in the buffer, called with the lock held */
> +static bool mcu_status_pending(struct gl_e750_mcu *mcu)
> +{
> +	return mcu->rx_len > 4 && !strncmp(mcu->rx_line, "{OK}", 4);
> +}
> +
> +static size_t mcu_receive_buf(struct serdev_device *serdev, const u8 *da=
ta,
> +			      size_t count)
> +{
> +	struct gl_e750_mcu *mcu =3D serdev_device_get_drvdata(serdev);
> +	unsigned long flags;
> +	size_t i;
> +
> +	spin_lock_irqsave(&mcu->lock, flags);
> +	for (i =3D 0; i < count; i++) {
> +		char c =3D data[i];
> +
> +		if (c =3D=3D '\r' || c =3D=3D '\n') {
> +			if (mcu->rx_len)
> +				mcu_flush_line(mcu);
> +			continue;
> +		}
> +
> +		/*
> +		 * Status replies and JSON events may come without a line
> +		 * ending. Every message starts with '{', so a new one ends
> +		 * the previous message, and a JSON event ends with '}'.
> +		 */
> +		if (c =3D=3D '{' && mcu->rx_len)
> +			mcu_flush_line(mcu);
> +		if (mcu->rx_len < MCU_RX_LINE_MAX - 1)
> +			mcu->rx_line[mcu->rx_len++] =3D c;
> +		if (c =3D=3D '}' && mcu->rx_line[0] =3D=3D '{' &&
> +		    strncmp(mcu->rx_line, "{OK}", 4))
> +			mcu_flush_line(mcu);
> +	}
> +	spin_unlock_irqrestore(&mcu->lock, flags);
> +
> +	return count;
> +}
> +
> +static const struct serdev_device_ops mcu_serdev_ops =3D {
> +	.receive_buf =3D mcu_receive_buf,
> +	.write_wakeup =3D serdev_device_write_wakeup,
> +};
> +
> +static void mcu_poll_work(struct work_struct *work)
> +{
> +	struct gl_e750_mcu *mcu =3D container_of(to_delayed_work(work),
> +					       struct gl_e750_mcu, poll_work);
> +	unsigned long timeout =3D msecs_to_jiffies(MCU_REPLY_TIMEOUT_MS);
> +	unsigned long flags;
> +	int ret;
> +
> +	/*
> +	 * Only an earlier status reply is consumed here; a partially received
> +	 * event stays in the buffer.
> +	 */
> +	spin_lock_irqsave(&mcu->lock, flags);
> +	if (mcu_status_pending(mcu))
> +		mcu_flush_line(mcu);
> +	reinit_completion(&mcu->reply);
> +	spin_unlock_irqrestore(&mcu->lock, flags);
> +
> +	ret =3D serdev_device_write(mcu->serdev, mcu_status_req,
> +				  sizeof(mcu_status_req) - 1, timeout);
> +	if (ret < 0) {
> +		dev_warn_ratelimited(&mcu->serdev->dev, "write failed: %d\n", ret);
> +	} else if (!wait_for_completion_timeout(&mcu->reply, timeout)) {
> +		/* the reply may come without a line ending */
> +		spin_lock_irqsave(&mcu->lock, flags);
> +		if (mcu_status_pending(mcu))
> +			mcu_flush_line(mcu);
> +		else
> +			dev_dbg(&mcu->serdev->dev, "no status reply\n");
> +		spin_unlock_irqrestore(&mcu->lock, flags);
> +	}
> +
> +	schedule_delayed_work(&mcu->poll_work,
> +			      msecs_to_jiffies(MCU_POLL_INTERVAL_MS));
> +}
> +
> +static void mcu_poweroff_work(struct work_struct *work)
> +{
> +	struct gl_e750_mcu *mcu =3D container_of(work, struct gl_e750_mcu,
> +					       poweroff_work);
> +
> +	/* the MCU cuts the power a few seconds after reporting the switch */
> +	dev_info(&mcu->serdev->dev, "power switch turned off, shutting down\n");
> +	orderly_poweroff(true);
> +}
> +
> +static const enum power_supply_property mcu_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +};
> +
> +static int mcu_battery_get_property(struct power_supply *psy,
> +				    enum power_supply_property psp,
> +				    union power_supply_propval *val)
> +{
> +	struct gl_e750_mcu *mcu =3D power_supply_get_drvdata(psy);
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&mcu->lock, flags);
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D 1;
> +		break;
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (!mcu->valid)
> +			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +		else if (mcu->charging)
> +			val->intval =3D mcu->capacity >=3D 100 ?
> +				      POWER_SUPPLY_STATUS_FULL :
> +				      POWER_SUPPLY_STATUS_CHARGING;
> +		else
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		if (mcu->valid)
> +			val->intval =3D mcu->capacity;
> +		else
> +			ret =3D -ENODATA;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		if (mcu->valid)
> +			val->intval =3D mcu->temp;
> +		else
> +			ret =3D -ENODATA;
> +		break;
> +	case POWER_SUPPLY_PROP_CYCLE_COUNT:
> +		if (mcu->valid)
> +			val->intval =3D mcu->cycles;
> +		else
> +			ret =3D -ENODATA;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +	spin_unlock_irqrestore(&mcu->lock, flags);
> +
> +	return ret;
> +}
> +
> +static const struct power_supply_desc mcu_battery_desc =3D {
> +	.name =3D "gl-e750-battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D mcu_battery_props,
> +	.num_properties =3D ARRAY_SIZE(mcu_battery_props),
> +	.get_property =3D mcu_battery_get_property,
> +};
> +
> +static int gl_e750_mcu_probe(struct serdev_device *serdev)
> +{
> +	struct device *dev =3D &serdev->dev;
> +	struct power_supply_config psy_cfg =3D {};
> +	struct gl_e750_mcu *mcu;
> +	int ret;
> +
> +	mcu =3D devm_kzalloc(dev, sizeof(*mcu), GFP_KERNEL);
> +	if (!mcu)
> +		return -ENOMEM;
> +
> +	mcu->serdev =3D serdev;
> +	spin_lock_init(&mcu->lock);
> +	init_completion(&mcu->reply);
> +	serdev_device_set_drvdata(serdev, mcu);
> +	serdev_device_set_client_ops(serdev, &mcu_serdev_ops);
> +
> +	/*
> +	 * devm teardown runs in reverse: the poll work is cancelled before the
> +	 * port is closed, the power-off work (queued from the receive path)
> +	 * and the battery only after it.
> +	 */
> +	psy_cfg.drv_data =3D mcu;
> +	psy_cfg.fwnode =3D dev_fwnode(dev);
> +	mcu->psy =3D devm_power_supply_register(dev, &mcu_battery_desc, &psy_cf=
g);
> +	if (IS_ERR(mcu->psy))
> +		return dev_err_probe(dev, PTR_ERR(mcu->psy),
> +				     "failed to register battery\n");
> +
> +	ret =3D devm_work_autocancel(dev, &mcu->poweroff_work, mcu_poweroff_wor=
k);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_serdev_device_open(dev, serdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to open serdev\n");
> +
> +	serdev_device_set_baudrate(serdev, MCU_BAUDRATE);
> +	serdev_device_set_flow_control(serdev, false);
> +	ret =3D serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to set parity\n");
> +
> +	ret =3D devm_delayed_work_autocancel(dev, &mcu->poll_work, mcu_poll_wor=
k);
> +	if (ret)
> +		return ret;
> +
> +	schedule_delayed_work(&mcu->poll_work, 0);
> +	return 0;
> +}
> +
> +static const struct of_device_id gl_e750_mcu_of_match[] =3D {
> +	{ .compatible =3D "glinet,gl-e750-mcu" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gl_e750_mcu_of_match);
> +
> +static struct serdev_device_driver gl_e750_mcu_driver =3D {
> +	.probe =3D gl_e750_mcu_probe,
> +	.driver =3D {
> +		.name =3D "gl-e750-mcu",
> +		.of_match_table =3D gl_e750_mcu_of_match,
> +	},
> +};
> +module_serdev_device_driver(gl_e750_mcu_driver);
> +
> +MODULE_AUTHOR("Serv Pol <servpol@tuta.io>");
> +MODULE_DESCRIPTION("GL.iNet GL-E750 status MCU battery driver");
> +MODULE_LICENSE("GPL");
>=20
> --=20
> 2.47.3
>=20
>=20

--cujmmn73vk23w3r4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrxB1oACgkQ2O7X88g7
+pouoQ//WSRwx391K55NU+UejsUfSYt1PrbKjsTAUB20+HIjDmVjJVYgjch9nrpH
xeyhsh8x9pXoLFQCDfySusglqvrdWuD3uWY/+dDS2eeOh0GWJi7GGwpHsPbDY8re
XxBFQDYMrt89JLyxCQ31bEvoYBfcIfr+HPx4efmoIHE/WoF0nPnwTBh8UL2pG0E/
gA6mwWd0S7YmRgEfangk6lyZdBOKbqgE4BcA2C6l1LmJ8UzJ1mY8IlAlfB3QFqvq
BcAKbremD8+4VULLm2392xp/dPOWy+R8QEbGqPAoecGlut1B9Auim7XJxL+w9s5O
eRByX1k5CfqyxgK6j2CZ6duoj0+DYpoGmc8Zob4zQ/pj+jtORbBX6P2Dmjg+iPxw
oK9UXp3Zj5lVwM54DMynnsdsouF+Z7T005/krMKAQtjVIEJnXoZCNiJ/2CQzkJB3
JNgdm/eQIFYmX/XCoA5WtSMEA7lE58x+dqkoihgpsxw7CfcFgditXOiW77rIexXg
VMM7j/bH2bxyBOGg6fYjRG+clJIs/Ao0f3lzbZX1vgIcwT1ER8vhDLQtd60WoKrk
GXT++I0pEC6rvw+fP/yYKLmMatHUFAmufYRxBt3OBJEplM6WiKc8FJ9YdJwZufAZ
c8nco2wq5uNiJMBRri4yiMSzaYqVZb8mnJOfwq7DHNe3Uf16oW4=
=Uy5S
-----END PGP SIGNATURE-----

--cujmmn73vk23w3r4--
