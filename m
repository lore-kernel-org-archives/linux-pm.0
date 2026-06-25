Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D02630146C
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375360; cv=none; b=JmJrk26It/cwSQ3X9bXE70FTXgPaXfLY557dAjp64hlmCFSJRh/ymu12iky8Gk7ZSeE4kqEBcITB9r7VTLdI+g6p75sGiNOPCev+2q7Xny9vQ3D3w1uk7ZErCJgTHINSA1gH5ySl6XTKnPo1WK2qINnwlqyLxYrQ/W6WThzaWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375360; c=relaxed/simple;
	bh=xGd6NGwZIKu6bwxgG9+VFyp81S1AlTved33dLwV5kz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wp7b4dcNj0+c41EHBKKPNVD2WIrSjON9Zd3FfJ9bvGhQ4onGatGpmiBQdEjX7hE2Lgws2OfIq4J0A/kysFiFcal6jMZ6yeAXp1G527Oioyv4ofia6SFXQZGPNVl43fPjoHp0PVY+MSTa4luOGu5X9I66GABjOe+ULsI+entcB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eq+tDkf7; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq+tDkf7"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ad68b30252so2259243e87.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375355; x=1782980155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gg0fXFMFgIBOcyFcTi6Gl524W+rUCg7wosxNG5EPRuE=;
        b=eq+tDkf7DwxeeWNyexOwEP0T0LLDdl9yq/JHQ2+Ua0VhlEDiyvmq69mDVsdWxF+HIv
         EbYVXbVj69vnyzxhYn1d1uiPb1WhoedmHIfkgQSozSxcPx0at8TbO0+2yvQN0HAMLMs8
         Lt1sctrYJIo+xcGsEZ29pDpvCYjs4NvEpJkse87KY6/JMt7DtDyLPuAg95bryY33KJJn
         RszSKd9uh6jULkVyBYOUCmSW8EOPeuiU6Et9itmonW52OFZt1t/EY8efzWY+jf7HpJ7h
         NQIVxiWCAMXLG+hxetu5JuWWoAxLkDNRP/nC8lSN+/28+CvMpKVQP20hE7BqIRqPy+Bg
         CAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375355; x=1782980155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gg0fXFMFgIBOcyFcTi6Gl524W+rUCg7wosxNG5EPRuE=;
        b=qv27bdeTsGyKciRNoYysb9uXUZggZtvbhyh5px+DyXco28iY0sMil4TzCPHmVBQB4N
         CtQsB745BCF2+NGUCodilmv+1no19cfajecMRGkEBZqab2pdp+BlRoB6w/1YKXTxHINf
         l6TX6gH788+6GHVW79GLpXChDARMJEdC8clvbD3SI+gTynnv3uvMkpkcbOq9sFZL+7tB
         eOh8037KNLf0o1EbDKycQCsh1OgJehPDLJ90JjXsTb5GdIGnDeu59X28LD69AMf5YgjT
         ApMSQg/jfja3UwMaFy+ZHIO89pIJGqGQUrMas4uSqQ1YiVIuqzkS1OzJPC+1ERvyVENZ
         HS4A==
X-Forwarded-Encrypted: i=1; AHgh+RrxjvtelJaGwhQDqIA+MjrAw0U1je7EOxY8PU1YK3nUZ79OZ75sgLZtcO3Gi8K7LvVxxloTacXzbA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vly6OFu6jCMNYXvlwa67Zd7JSoaKdrNkRvJABa2rsIZE1pT3
	zeAOz70qeF84ygRs6DHqQvylftvVPJCDWM3bAaaBypibSV/hR2dGOPCr
X-Gm-Gg: AfdE7ckwTugqyOqBNQvfpMI7O2Ul3glW4siYnZXwjEbsgo4a02ELoxgTFNNGdu4if0x
	b/z5euVrYcC160yyvDJvcWCXLMD1FrDCw+W2lv1+BBLJaK5wdYGVzHxfs+x2faNRo/YJAY9DMxp
	3yVzDw6RMoIocRGpw/XSAFf1OWJkZGyFMcHEKu8T4sX7LJq8ny4zpESOsWjRvx8SiM1LbGij/tw
	sfYic3/FQ2cPNSPer5vuY0Xbbuz6CUeWC66P9d7nN55/dESG6we3wWQiinHRNFxEeRuuMrcjsUs
	qNFcZySSc3UrdC0mwOuF/QewR69++5nYX/kNlFFmGfqfJoBLgI81fi9PSOqLcd1/hwuPe1YzIgG
	SL338KMUBMCvsxxapuJYOG3t0Q2+VJWAukWI/zUZq4Q27o3+nitzVskjav9JyYEzjOc7i4rXcso
	rk20Y0a5cLUnLocfZtIL4ZG96nfrKMjB0X8w==
X-Received: by 2002:a05:6512:2c86:b0:5ae:a348:1292 with SMTP id 2adb3069b0e04-5aea34815d2mr246101e87.38.1782375355080;
        Thu, 25 Jun 2026 01:15:55 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999afce64dsm39162221fa.14.2026.06.25.01.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:15:54 -0700 (PDT)
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
Subject: [PATCH v9 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Thu, 25 Jun 2026 11:15:22 +0300
Message-ID: <20260625081529.22447-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for embedded controller used in Asus Transformers for
managing power and input functions.

---
Changes in v2:
- converted sysfs debug exports into debugfs
- added kernel-doc comments for exposed functions
- fixed minor typos and inconsistencies

Changes in v3:
- dropped DockRAM commits (both schema and driver)
- integrated DockRAM functionality directly into the controller driver
- EC schema moved to embedded controllers folder
- removed all cell descriptions from the schema
- removed all compatibles from the cell drivers
- adjusted naming conventions to better align with the ASUS Transformers
- defined EC variant sets to provide coverage for all known devices

Changes in v4:
- grouped known programming models of EC chronologically (both schema
  and driver)
- call debugfs init only if CONFIG_DEBUG_FS is enabled

Changes in v5:
- added asus,tf600t-ec-dock compatible to schema
- rebased on top of v7.0
- kzalloc > kzalloc_obj in keys and kbc

Changes in v6:
- removed asus_ec_handle_smi casting
- asus_dockram_access_ctl > asus_ec_get_ctl in control_reg_*
- fixed battery Kconfig description

Changes in v7:
- added status check of devm_kasprintf where missing
- devm_asus_ec_register_notifier dropped, added .remove where it was used
- removed cell_to_ec, asus_dockram_read, asus_dockram_write, asus_ec_* public API
  asus_ec_i2c_command, devm_asus_ec_register_notifier, asus_ec_read, asus_ec_write
- renamed asusec_info > asusec_core
- ec-kbc: added packed size check
	  ret > error
	  improved key remap logic
- ec-keys: improve formatting and comments 
	   ret > error
	   switched to dev_err_probe
- ec-leds: reworked to register both leds via loop
- ec-mfd: adjusted Kconfig description
	  fixed smbus operation sizes
	  fixed saving of EC fw model
	  adjusted IRQ flags
	  converted to use definer for set cell composition
	  added factory mode states enum and handling
	  defined some "magic" values
	  self > client, info > ec, ecreq > ecreq_gpio, priv > ddata
	  asus_ec_chip_data data > asus_ec_chip_info info
	  ec_data > ec_buf, ctl_data > ctl_buf
	  added and improved comments, added structure descriptions
	  asus_ec_magic_debug > asus_ec_susb_on_status
	  removed all dev_dbg and most of dev_info
	  pronts with model, fw behavior, factory and susb state preserved
	  switched to MFD_CELL_* macros
	  removed debugfs
- ec-battery: swithced to BIT macro
	      lock usage moved to asus_ec_battery_get_value
	      in asus_ec_battery_poll_work fixed possible rescheduling fail
	      in asus_ec_battery_poll_work fixed missing not charging
- ec-charger: POWER_SUPPLY_PROP_MODEL_NAME set as the first check

Changes in v8:
- added MODULE_ALIAS
- renamed DOCKRAM_* to ASUSEC_*
- ec-keys: input_handler moved into private structure
- ec-leds: added brightness_get
- ec-mdf:  fixed i2c_smbus_* return checks ()
	   improved model storing
- ec-batt: added status check of devm_kasprintf

Changes in v9:
- fixed i2c_smbus_read_i2c_block_data return check
- blocking_notifier_chain_register moved before serio registration
- adjusted get_unaligned_le16 bounds check
- unsigned long long > u64
- iterator vars made scoped
- removed "magic" values from ec-mfd
- simplified logging, detect split into detect and init
- improved error logs formatting
- adjusted handler in media keys to connect strictly to dock keyboard
---

Michał Mirosław (6):
  mfd: Add driver for ASUS Transformer embedded controller
  input: serio: Add driver for ASUS Transformer dock keyboard and
    touchpad
  input: keyboard: Add driver for ASUS Transformer dock multimedia keys
  leds: Add driver for ASUS Transformer LEDs
  power: supply: Add driver for ASUS Transformer battery
  power: supply: Add charger driver for Asus Transformers

Svyatoslav Ryhel (1):
  dt-bindings: embedded-controller: document ASUS Transformer EC

 .../asus,tf201-ec-pad.yaml                    | 119 ++++
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 .../input/keyboard/asus-transformer-ec-keys.c | 314 ++++++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 168 ++++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-transformer-ec.c       | 125 ++++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-transformer-ec.c             | 549 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 289 +++++++++
 .../supply/asus-transformer-ec-charger.c      | 208 +++++++
 include/linux/mfd/asus-transformer-ec.h       |  92 +++
 18 files changed, 1944 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
 create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c
 create mode 100644 drivers/leds/leds-asus-transformer-ec.c
 create mode 100644 drivers/mfd/asus-transformer-ec.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-battery.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-charger.c
 create mode 100644 include/linux/mfd/asus-transformer-ec.h

-- 
2.53.0

