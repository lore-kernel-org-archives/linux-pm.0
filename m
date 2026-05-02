Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C5B36DA04
	for <linux-pm@vger.kernel.org>; Sat,  2 May 2026 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777725683; cv=none; b=ek7+Le3a8IuqkirfB6PvQDMOQxca5IQTx22dNFClBu9ic6PL2rbkiYksUr25soJM+LCUmI1uYqDKb1pzSSq8MRTCUrLhnRpNgArtncrasUGpoP+RRjOPff2XiuVxoUkALVvL+VSuRcW4bm89xPuzrDM74H2Ve3cULAZZ2QbnDrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777725683; c=relaxed/simple;
	bh=DVTWhFsaR7cdJl7ch6Cdddtoyk90yR7GTXbx4wT9YRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEhUc5LqFEuC0kAO0mTosjGCnaPuA7+3MQuUR8NyrElSX0NBwkUzUYa0gfcyHiUqeECLXm0O9kLQzVxKAY6vtu9NK2Yi9pBfMK7/GQrfKYxnqkRLXDpibA8o3AkWQIWhVhk2t+nPc2O/ALbIUbCWEKN0tcMqelsYXPT/hwiXCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3ZYKP2b; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3ZYKP2b"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso4385625a12.1
        for <linux-pm@vger.kernel.org>; Sat, 02 May 2026 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777725680; x=1778330480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTudflxyz4B/xZhcbN0oKqXiQZgSfJMlSBvEdhxrgRw=;
        b=c3ZYKP2bLMptjXHZJekhJoNSRrLEPGEosdXSBJlXkQZOGQEzLz4FypSpjJUekXFlLk
         1+g/HwhH5o3EHXgaBemz2h4qdokHcw9qljGI/QejdUOYZffhiy533Bl2fOECBOyn1REN
         I0CkZwRXGryXTjOvhInqNcvZApeL62be0UfbHtWu2TXBsHmgoRDLyZYPlBayF5yMIrjM
         XOURAYTt1jt1QGUPYKoI7XLgb9bXb/ZfOxu3yvAknU3bWkJl3oqgD84gCFdG0yWZSaJk
         DwckgbLPKoARdVWdXDVLHrokUhUlyAJp/uUn0XrrCUxivppB4mTVzovxOj0NqnAomsNX
         UPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777725680; x=1778330480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTudflxyz4B/xZhcbN0oKqXiQZgSfJMlSBvEdhxrgRw=;
        b=m8gVORvEageMKvVmC76cMQN8J22mp2z8tiCgY+irpL3a0VzJla5LVE6RgLjjRiqE1G
         8HAOg7c0aABHauqvBcjG+6TGbVMW1tHZKH+KS+VzgjSqPZd2JnKtmWfjRe9Sc2yoCqRf
         FGdllBF6FK/tP1NhFWHKbSOQNGlIV/w+MnLx0yZJ9WYp7YaHDw/p/kwqhY2ri2APFuex
         efuHfCcoCou7eEHJCHZktkiQzTI8d4/MwldeGbwQgUjhDG0HSmrv4Udpf520KH/DsP4g
         dAU2jxVmQ3LmtZ5M9ppzOzwZPNb2XVL480z/QvkEfdIC+qlvumj9wnp8wTCMo5FE7hMF
         U2jg==
X-Forwarded-Encrypted: i=1; AFNElJ99iTbELsPNVunJFUQ4t9PXxYu2ubQLTm4JxevVR6cd805tyyGCtXKbtac+4YOJYpLX+RZw+WW9Qw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsnne5w9ttVP+iZzy8IYRGL1Ban17BJiXcppw+cC9kTEY5QJw5
	Pw1uOVeE9AiDwaydVInXrnSoRcjgDa1Sjuh64nFU/rer0XQXC3vUsCC/
X-Gm-Gg: AeBDietXndmLfXIDZ5ilAL4k1mlCWajN8Yq1YbXe2gkUZxzFYl9V799sntBXQTQWmgy
	KTmo/jAEUKPsyo8j9uoAnI6wGfoQzsgPqU5yRbGcCh/vJPl9VGYytkAYHfmpOJfFdbQOVP/dB6b
	QmTYO5UcNRAesl8mP1liHzagKfsY8mnsLKvYLWxRrLu6ZspNjQO2XDUGNdoPmF0/i0dwvexaSTY
	sFQbhP/kjDsrzzIwmYZufto84DTH8m8PHMNcmZtah6RXAMJT86zKsemh9Zx1GxvEt2tkc1KS4Mj
	bfbjpP+q1e+VuoZL7HyHVWvKMx8LPfx7dh6afSsMBHpcjcsIedwc6rdOca92HiLDMy40FqgMt49
	C8I8liW2MJI+cUzQvP7ysIEuBBjJrcW+iJW7Jp1It7OKDV1VHr+fiCm7oFdHTQm80ENj3pNUZ2Q
	g1WWTijNuk4URjUn8NO1blgJo=
X-Received: by 2002:aa7:ce16:0:b0:66e:8ca6:e79f with SMTP id 4fb4d7f45d1cf-67c1aaa6068mr799383a12.13.1777725679600;
        Sat, 02 May 2026 05:41:19 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b85e281cdsm1649649a12.3.2026.05.02.05.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 05:41:18 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 3/7] input: serio: Add driver for ASUS Transformer dock keyboard and touchpad
Date: Sat,  2 May 2026 15:40:51 +0300
Message-ID: <20260502124055.22475-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260502124055.22475-1-clamor95@gmail.com>
References: <20260502124055.22475-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add input driver for ASUS Transformer dock keyboard and touchpad.

Some keys in ASUS Dock report keycodes that don't make sense according to
their position, this patch modifies the incoming data that is sent to
serio to send proper scancodes.

Co-developed-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/serio/Kconfig                   |  15 ++
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 147 ++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 5f15a6462056..fad29b950309 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -84,6 +84,21 @@ config SERIO_RPCKBD
 	  To compile this driver as a module, choose M here: the
 	  module will be called rpckbd.
 
+config SERIO_ASUS_TRANSFORMER_EC
+	tristate "Asus Transformer's Dock keyboard and touchpad controller"
+	depends on MFD_ASUS_TRANSFORMER_EC
+	help
+	  Say Y here if you want to use the keyboard and/or touchpad on
+	  Asus Transformed's Mobile Dock.
+
+	  For keyboard support you also need atkbd driver.
+
+	  For touchpad support you also need psmouse driver with Elantech
+	  touchpad option enabled.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called asus-transformer-ec-kbc.
+
 config SERIO_AMBAKMI
 	tristate "AMBA KMI keyboard controller"
 	depends on ARM_AMBA
diff --git a/drivers/input/serio/Makefile b/drivers/input/serio/Makefile
index 8ab98f4aa28d..fedc37ee102b 100644
--- a/drivers/input/serio/Makefile
+++ b/drivers/input/serio/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SERIO_SERPORT)	+= serport.o
 obj-$(CONFIG_SERIO_RPCKBD)	+= rpckbd.o
 obj-$(CONFIG_SERIO_SA1111)	+= sa1111ps2.o
 obj-$(CONFIG_SERIO_AMBAKMI)	+= ambakmi.o
+obj-$(CONFIG_SERIO_ASUS_TRANSFORMER_EC)	+= asus-transformer-ec-kbc.o
 obj-$(CONFIG_SERIO_Q40KBD)	+= q40kbd.o
 obj-$(CONFIG_SERIO_GSCPS2)	+= gscps2.o
 obj-$(CONFIG_HP_SDC)		+= hp_sdc.o
diff --git a/drivers/input/serio/asus-transformer-ec-kbc.c b/drivers/input/serio/asus-transformer-ec-kbc.c
new file mode 100644
index 000000000000..47fd6e48c989
--- /dev/null
+++ b/drivers/input/serio/asus-transformer-ec-kbc.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/i8042.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/serio.h>
+
+struct asus_ec_kbc_data {
+	struct notifier_block nb;
+	struct asusec_info *ec;
+	struct serio *sdev[2];
+};
+
+static int asus_ec_kbc_notify(struct notifier_block *nb,
+			      unsigned long action, void *data_)
+{
+	struct asus_ec_kbc_data *priv = container_of(nb, struct asus_ec_kbc_data, nb);
+	unsigned int port_idx, n;
+	u8 *data = data_;
+
+	if (action & (ASUSEC_SMI_MASK | ASUSEC_SCI_MASK))
+		return NOTIFY_DONE;
+	else if (action & ASUSEC_AUX_MASK)
+		port_idx = 1;
+	else if (action & (ASUSEC_KBC_MASK | ASUSEC_KEY_MASK))
+		port_idx = 0;
+	else
+		return NOTIFY_DONE;
+
+	n = data[0] - 1;
+	data += 2;
+
+	/*
+	 * We need to replace these incoming data for keys:
+	 * RIGHT_META Press   0xE0 0x27      -> LEFT_ALT   Press   0x11
+	 * RIGHT_META Release 0xE0 0xF0 0x27 -> LEFT_ALT   Release 0xF0 0x11
+	 * COMPOSE    Press   0xE0 0x2F      -> RIGHT_META Press   0xE0 0x27
+	 * COMPOSE    Release 0xE0 0xF0 0x2F -> RIGHT_META Release 0xE0 0xF0 0x27
+	 */
+
+	if (port_idx == 0 && n >= 2 && data[0] == 0xE0) {
+		if (n == 3 && data[1] == 0xF0) {
+			switch (data[2]) {
+			case 0x27:
+				data[0] = 0xF0;
+				data[1] = 0x11;
+				n = 2;
+				break;
+			case 0x2F:
+				data[2] = 0x27;
+				break;
+			}
+		} else if (n == 2) {
+			switch (data[1]) {
+			case 0x27:
+				data[0] = 0x11;
+				n = 1;
+				break;
+			case 0x2F:
+				data[1] = 0x27;
+				break;
+			}
+		}
+	}
+
+	while (n--)
+		serio_interrupt(priv->sdev[port_idx], *data++, 0);
+
+	return NOTIFY_OK;
+}
+
+static int asus_ec_serio_write(struct serio *port, unsigned char data)
+{
+	const struct asusec_info *ec = port->port_data;
+
+	return asus_ec_i2c_command(ec, (data << 8) | port->id.extra);
+}
+
+static void asus_ec_serio_remove(void *data)
+{
+	serio_unregister_port(data);
+}
+
+static int asus_ec_register_serio(struct platform_device *pdev, int idx,
+				  const char *name, int cmd)
+{
+	struct asus_ec_kbc_data *priv = platform_get_drvdata(pdev);
+	struct i2c_client *parent = to_i2c_client(pdev->dev.parent);
+	struct serio *port = kzalloc_obj(*port);
+
+	if (!port)
+		return -ENOMEM;
+
+	priv->sdev[idx] = port;
+	port->dev.parent = &pdev->dev;
+	port->id.type = SERIO_8042;
+	port->id.extra = cmd & 0xFF;
+	port->write = asus_ec_serio_write;
+	port->port_data = (void *)priv->ec;
+	snprintf(port->name, sizeof(port->name), "%s %s",
+		 priv->ec->model, name);
+	snprintf(port->phys, sizeof(port->phys), "i2c-%u-%04x/serio%d",
+		 i2c_adapter_id(parent->adapter), parent->addr, idx);
+
+	serio_register_port(port);
+
+	return devm_add_action_or_reset(&pdev->dev, asus_ec_serio_remove, port);
+}
+
+static int asus_ec_kbc_probe(struct platform_device *pdev)
+{
+	struct asusec_info *ec = cell_to_ec(pdev);
+	struct asus_ec_kbc_data *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->ec = ec;
+
+	ret = asus_ec_register_serio(pdev, 0, "Keyboard", 0);
+	if (ret < 0)
+		return ret;
+
+	ret = asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_AUX_SEND);
+	if (ret < 0)
+		return ret;
+
+	priv->nb.notifier_call = asus_ec_kbc_notify;
+
+	return devm_asus_ec_register_notifier(pdev, &priv->nb);
+}
+
+static struct platform_driver asus_ec_kbc_driver = {
+	.driver.name = "asus-transformer-ec-kbc",
+	.probe = asus_ec_kbc_probe,
+};
+module_platform_driver(asus_ec_kbc_driver);
+
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer's Dock keyboard and touchpad controller driver");
+MODULE_LICENSE("GPL");
-- 
2.51.0

