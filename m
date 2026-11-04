Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795193;
	b=cHCjW8OTTnH/u9PsxrxXa/pp8Scx9kiKklqM8lMPAIShmQGgKCAZnT5ni61EpUG6nrm2
	 6faKe4bN6aZc0Yu/82Myk8nhGU+6CEbP7mZu2CdOct8ksKC7VX2H95WJVGqnFZaEay5Zy
	 JIe2xw9cl+43qkw0c8koca3vIsiMqg/eEd8jrkHzVP552tqo46i6CV7G9ZTO4QPfnHLpg
	 aYwJw7xPcEdinwVZOhxgbdZJ+4GzE2jkyhcRDMMm4uOa/mUj/jJ2Jpe9heuNdhv5xri7c
	 oufkEaiAfhz7kCJ+9vFRItfIFYlgAItN6hPPczIBN+GxQmxbe317L1s2xJ1HEvlbbrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ah01QjGgr8WfBtjYH3tsijDXpoatWAgh5NdwXl8Ui5E=;
	b=J+z0MwkHijZBiPDcE9runqRbNiqDj3zXfSmGE2LUvxeNhTHlwe4usx9MX46fps4ExMnP
	 M9RBRqcucoIdgdk8h1gtLDJmBysixtUbeNu4QnceN5SAdKKFI6UcPysRu3BZPrc2qDDxK
	 T/B6oEQfxwBG3JrjYRE2TM66KgUNRfJL1OMFiW9I+/XJelMiWmK/Cers6HuCIkbhP8O7J
	 ZgiG0211A96djcvyNQTWO5CPHFChTBZVn3VKohY3PU18mmkKHqFcPBlgrvWVzVg2TQmB+
	 e9WSSzpOFnb+BnMkkN9B/pdQywXGnZ3bXaqJG5oMKMXA0kdRBAnWlIbOUEc06pKLjvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MBWDylpU;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9A4606D803
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 12:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E9A4606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MBWDylpU
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a214af2076so4315655e9.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 04:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793795191; x=1794399991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ah01QjGgr8WfBtjYH3tsijDXpoatWAgh5NdwXl8Ui5E=;
        b=MBWDylpUMLPpAQauptal2At6SZB/IwIaOH471zVag92+ms4xNz0x1Msy4vBCIAXmr3
         vdzlMxxI/1SQ+fQ0IOwDA5+yMjCUP037RYPIcCZ8Y7FhTKyxjTL6gDUvZC01prOCBf6h
         sjmFvSMMEW6fh2EY2OEMAB4aohwHKu62PrMRYEmHNoiyFW6nbZSUX2jvdqO3BNU4HPAB
         rj1OsVcpb2qoEe0iXdurYcW5bBw8e9XuHdTHOFl6mQpySIYZA6lrJOKaHd5M1Jh3cuSo
         bYBYheF215jg8ly4Ye7+cxv8zh0d6qfQ+K4q1r6FPDntAv6dRi1oHdfCzBf+FeGhSmIK
         jfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793795191; x=1794399991;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ah01QjGgr8WfBtjYH3tsijDXpoatWAgh5NdwXl8Ui5E=;
        b=G9K08qZJfMz0WtLsfdoEOV/lQVDuGdYS4rfAAnHc8s6uLOZ6N1TULrNKNpdh4cvXLQ
         QC5sO1+Blr6TSaO3okJZFBOgPMeJm3h9b4AeRbVORLkYK15NeXXoiFG/XHuJUmgobOUz
         fesTy6Ojx6iFD19UH2ufls9hozARROA/qMRoMkYJDWZEW4+oR0spdk460lcczZM4q9Se
         VZSjd62T4RMq0TLYeacB/xMdIfLUisXNQeHMSrbW1yE4NDSddTJAiqpkLwSEMLYs0pqB
         QeEY09NYXc1yLgHIoMIkQJCIzUjFWSFp6GiLstcIRHL8KtPPaO3WLrXSvkXZEF35YL4q
         xN9Q==
X-Forwarded-Encrypted: i=1; AKwUvBxKlMMyjoxb0Wqzp8O4ZbzMLV80rS0IuxD4HCigdYRxbz4Pna0EtM4gOeQ5007q/jCr4LKCEnqoNQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/gh037JC7ZQFW9XzNrsbpERY2V16xKWSiD4hPOKTk9ES94z+nr
	gp4MfboblcOdrR6w1Vl/8NxWa3yHLa49uljxMTeZ7hSQO+cXGce+y0Yk
X-Gm-Gg: AYBFou3H4ycp2U2Y3QDx1zbn3cu8g9mHuIvlDNdpk/X1NJUJYIV5WCgSEoEK6FoB3gm
	EfEpHW9xL0opUyoUlAZ3tPVdyGGQMKg+15gFTFrI1+bPxcCvXHX+GGNI5wSgNsZ7MQItCCAE+DX
	O59LhCVuFpbferWZXH5bTiBaNUDao7OTIkWEceWj1iscIfW+5KMMhDmiTAdaGpICJG2nX9fQFaj
	9v6GuIA/U0jIbdpMC+sJhzpi7okEBfDuZnoVxmEd9y8Zqmo11z2f8m8KLpiRdWJgge4eLnyNFcn
	Z9c/sLfe1LPIqB2U8YUu13cPUdrE9YFTjPmHkBVmEb2FVqMSq+uQ+pf5U0nTjbegn9XamqaX/32
	kAKCBEZhz2Q/tJCsc6GTu0TnltNuFWDEYPqgbwrJAD/3Xb0UFh/Xy613OWQlVSVFT4kC9Ga/MwW
	AJVkbhKcbuVuYFlBHflce9EEjIUM/XfllFBf1G+VnCloCkYJYgjnlWFBiDFj+xgQOm3kKY0CzS7
	rkmkrItuhBEB/9usBvzOAsZ55Oicx1Wjtsi9PvDbu7D4AO1GZBuPosAV22YAL1FJKxJhn7Hr8o7
	ukSKk1snc8dazYAPT2aGa2JVKBjOPGh6N/ImQAxdm2kIX6o7nw==
X-Received: by 2002:a05:600c:1f8d:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4ac177539f6mr352866395e9.17.1793795190436;
        Wed, 04 Nov 2026 04:26:30 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43da9825bsm50492415e9.15.2026.11.04.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:26:29 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v13 3/7] input: serio: Add driver for ASUS Transformer dock keyboard and touchpad
Date: Wed,  4 Nov 2026 14:26:02 +0200
Message-ID: <20261104122606.215629-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104122606.215629-1-clamor95@gmail.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
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
Tested-by: Florian Krischer <florian.krischer@fkr.dev> # ASUS SL101
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 258 ++++++++++++++++++
 3 files changed, 274 insertions(+)
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 087f0203fff99..58d415ca1d540 100644
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
index 7f5137dc02e26..bed2a7a92a13d 100644
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
index 0000000000000..cff18da6d59d7
--- /dev/null
+++ b/drivers/input/serio/asus-transformer-ec-kbc.c
@@ -0,0 +1,258 @@
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
+	struct asusec_core *ec;
+	struct i2c_client *parent;
+	struct serio *sdev[2];
+	bool altgr_delayed;
+	bool altgr_suppressed;
+};
+
+static bool asus_ec_kbc_altgr_active(struct asus_ec_kbc_data *priv)
+{
+	return IS_ENABLED(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC) &&
+		(priv->ec->ext_keys_enabled || priv->altgr_delayed ||
+		 priv->altgr_suppressed);
+}
+
+static void asus_ec_kbc_reset_altgr(struct asus_ec_kbc_data *priv)
+{
+	if (!IS_ENABLED(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC))
+		return;
+
+	priv->ec->right_alt_pressed = false;
+	priv->ec->special_combo_triggered = false;
+	priv->altgr_delayed = false;
+	priv->altgr_suppressed = false;
+}
+
+static void asus_ec_kbc_sync_altgr_combo(struct asus_ec_kbc_data *priv)
+{
+	if (priv->ec->special_combo_triggered) {
+		priv->ec->special_combo_triggered = false;
+		if (priv->altgr_delayed) {
+			priv->altgr_delayed = false;
+			priv->altgr_suppressed = true;
+		}
+	}
+}
+
+static void asus_ec_kbc_flush_altgr(struct asus_ec_kbc_data *priv)
+{
+	if (!asus_ec_kbc_altgr_active(priv))
+		return;
+
+	asus_ec_kbc_sync_altgr_combo(priv);
+
+	if (!priv->altgr_delayed)
+		return;
+
+	serio_interrupt(priv->sdev[0], 0xe0, 0);
+	serio_interrupt(priv->sdev[0], 0x11, 0);
+
+	priv->altgr_delayed = false;
+}
+
+static bool asus_ec_kbc_handle_altgr(struct asus_ec_kbc_data *priv, bool is_release)
+{
+	bool suppressed;
+
+	if (!asus_ec_kbc_altgr_active(priv)) {
+		asus_ec_kbc_reset_altgr(priv);
+		return false;
+	}
+
+	asus_ec_kbc_sync_altgr_combo(priv);
+
+	if (!is_release) {
+		if (!priv->ec->right_alt_pressed) {
+			asus_ec_kbc_reset_altgr(priv);
+			priv->ec->right_alt_pressed = true;
+			priv->altgr_delayed = true;
+			return true;
+		}
+
+		return priv->altgr_delayed || priv->altgr_suppressed;
+	}
+
+	suppressed = priv->altgr_suppressed;
+	if (!suppressed)
+		asus_ec_kbc_flush_altgr(priv);
+
+	asus_ec_kbc_reset_altgr(priv);
+	return suppressed;
+}
+
+static int asus_ec_kbc_notify(struct notifier_block *nb,
+			      unsigned long action, void *data_)
+{
+	struct asus_ec_kbc_data *priv = container_of(nb, struct asus_ec_kbc_data, nb);
+	unsigned int port_idx, n;
+	u8 *data = data_;
+
+	if (action & (ASUSEC_SMI_MASK | ASUSEC_SCI_MASK)) {
+		if (action == ASUSEC_SMI_ACTION(HANDSHAKE) ||
+		    action == ASUSEC_SMI_ACTION(RESET))
+			asus_ec_kbc_reset_altgr(priv);
+		return NOTIFY_DONE;
+	} else if (action & ASUSEC_AUX_MASK) {
+		port_idx = 1;
+	} else if (action & priv->ec->keyboard_mask) {
+		port_idx = 0;
+	} else {
+		return NOTIFY_DONE;
+	}
+
+	/*
+	 * The data[0] is the number of bytes following the count byte: one
+	 * status byte plus the payload. The SL101 EC, for example, reports
+	 * keyboard reset as 03 09 fa aa (status 09, ACK fa, BAT aa). Skip the
+	 * count and status bytes and forward every payload byte to serio.
+	 */
+	if (data[0] < 2 || data[0] > ASUSEC_ENTRY_SIZE)
+		return NOTIFY_BAD;
+
+	n = data[0] - 1;
+	data += 2;
+
+	if (port_idx == 0) {
+		/*
+		 * Remap keyboard key codes to match AT layout:
+		 * ALTGR:  RIGHT-ALT  [E0 11] -> delayed / suppressed
+		 * SEARCH: RIGHT-META [E0 27] -> LEFT-ALT   [11]
+		 * MENU:   COMPOSE    [E0 2F] -> RIGHT-META [E0 27]
+		 */
+		if ((n == 2 || (n == 3 && data[1] == 0xF0)) && data[0] == 0xE0) {
+			u8 *keycode = &data[n - 1];
+
+			switch (*keycode) {
+			case 0x11:
+				if (asus_ec_kbc_handle_altgr(priv, n == 3))
+					return NOTIFY_OK;
+				break;
+			case 0x27:
+				*keycode = 0x11;
+				++data;
+				--n;
+				break;
+			case 0x2F:
+				*keycode = 0x27;
+				break;
+			}
+		}
+
+		/*
+		 * Only flush delayed AltGr on key make events, ignoring
+		 * key break codes and PS/2 command responses (ACK, BAT, etc.).
+		 */
+		if ((n == 2 && data[0] == 0xe0) ||
+		    (n == 1 && data[0] > 0 && data[0] < 0x84) || data[0] == 0xe1)
+			asus_ec_kbc_flush_altgr(priv);
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
+	struct asus_ec_kbc_data *priv = port->port_data;
+
+	return i2c_smbus_write_word_data(priv->parent, ASUSEC_WRITE_BUF,
+					 (data << 8) | port->id.extra);
+}
+
+static void asus_ec_serio_remove(void *port)
+{
+	serio_unregister_port(port);
+}
+
+static int asus_ec_register_serio(struct platform_device *pdev, int idx, const char *name, int cmd)
+{
+	struct asus_ec_kbc_data *priv = platform_get_drvdata(pdev);
+	struct i2c_client *parent = priv->parent;
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
+	port->port_data = (void *)priv;
+	snprintf(port->name, sizeof(port->name), "%s %s", priv->ec->model, name);
+	snprintf(port->phys, sizeof(port->phys), "i2c-%u-%04x/serio%d",
+		 i2c_adapter_id(parent->adapter), parent->addr, idx);
+
+	serio_register_port(port);
+
+	return devm_add_action_or_reset(&pdev->dev, asus_ec_serio_remove, port);
+}
+
+static void asus_ec_notifier_chain_unregister(void *data)
+{
+	struct asus_ec_kbc_data *priv = data;
+	struct asusec_core *ec = priv->ec;
+
+	blocking_notifier_chain_unregister(&ec->notify_list, &priv->nb);
+}
+
+static int asus_ec_kbc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct asusec_core *ec = dev_get_drvdata(dev->parent);
+	struct asus_ec_kbc_data *priv;
+	int error;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->ec = ec;
+	priv->parent = to_i2c_client(dev->parent);
+
+	priv->nb.notifier_call = asus_ec_kbc_notify;
+	error = blocking_notifier_chain_register(&ec->notify_list, &priv->nb);
+	if (error)
+		return dev_err_probe(dev, error, "Failed to register blocking notifier chain");
+
+	error = devm_add_action_or_reset(dev, asus_ec_notifier_chain_unregister, priv);
+	if (error)
+		return error;
+
+	error = asus_ec_register_serio(pdev, 0, "Keyboard", 0);
+	if (error)
+		return error;
+
+	error = asus_ec_register_serio(pdev, 1, "Touchpad", I8042_CMD_AUX_SEND);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static struct platform_driver asus_ec_kbc_driver = {
+	.driver.name = "asus-transformer-ec-kbc",
+	.probe = asus_ec_kbc_probe,
+};
+module_platform_driver(asus_ec_kbc_driver);
+
+MODULE_ALIAS("platform:asus-transformer-ec-kbc");
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_DESCRIPTION("ASUS Transformer's Dock keyboard and touchpad driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

