Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795186;
	b=bT1DrtD3rNqpxz/o6lfpSTgAGYjzcDz/9QNBKZ1EEKRsldbNNkp+QcWTQKSHHpgIFheN
	 1mc9HDdT+KHG2IwQGamcBNfH0Mlgx3i1tFcEnTObTMVbdopQo7LEBuVtsRqffhA2dA3ZK
	 0cARFhf1j4PGidqV2P+R4XmAixwT+4UxgZ2rxKElKoxXnY4tizM4fsn0SJwjeeFmFCzjF
	 ljG1IiIbFInu4RmmAHALTdJ/liXs3pQsqI2Jf0CayVT0PhcLLiCGPdYDw3fLiblpQaJMW
	 t/G8A0VIgg5MSlcWd62uwntGPJxW5rA67oBmv02ewP+1uPx9yRJsqvYWXv5kdrP2b4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=thomxBGmhlzEQD85NB4cuQLLeHvP2M634LL7QtV22Rw=;
	b=EFDoEwsNktAUnFaqU21N5k3eZSDck9aGsJ43tMDz0PIMjR1H/HS68VWrVtwhRcg1cg+9
	 L+UreOWRBJEvZg2AYroHUIwZX4aU41hiHOuO/vhaBkK+AMCaxvHEG1q7RjqB7fyYNWa9s
	 MCZutye9cdxBE8gL447YqU0+Cqf3xIXGwXT3d1RjhwU9IByRBorc8L6M19IDKhS6Nno3W
	 +3E3jjZQaL8OI8GDXao4GIndq5P2b0e9s/O8xdXuzQYQe8N7fybeFvCCiN3TDxbF7xRmG
	 t4KCwwFX62g+CHK+3LXnarGvhhcwnUydJ/we6PM/mNXpoUVCP1wo9StVdH3P+KZ3FDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRBcL15j;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14F606A32F
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 12:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD14F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HRBcL15j
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a214af2076so4314765e9.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 04:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793795184; x=1794399984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thomxBGmhlzEQD85NB4cuQLLeHvP2M634LL7QtV22Rw=;
        b=HRBcL15j+yHMy3baKSzZG+feycDT3bLz/2Py0auzYiUnpUrrwKeNmbv2D93vhW+Y6y
         4GFqlUTeaAxVs9Ja5WdO7TxR7CuFlucR8E9ngwCf3jN78C+Iad65or/2zRQV5tOXzDdl
         baL5Y9sPvdHOysZNSsz2mrdqfUY4TPoe8QcRemBMDZAZ9pvOqYezCN3Kt9v01FO2hm7A
         /vACd1WxhJGMCaIb0SheVEM4alHwz/yJNILaKigsl6JE4hdJGYjj7R7Lx/K6B9+e5f6O
         A493Gudgn/Ervo4IDnA9vrDfTX28gDzpeqQwRkVCanlMTpy1m2K9BlzF7fOANqCa8C5r
         ffmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793795184; x=1794399984;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=thomxBGmhlzEQD85NB4cuQLLeHvP2M634LL7QtV22Rw=;
        b=nerKGLlsRuM7HOJSmobuzCJoNGM17UNGcAxMLp/K8GUkA147dm5e2G6eQM1R7iHpWB
         CPzjolf1tDTgMJAG7pvlAkxNiBdCNmj0Io1r9Nt3kn7+jF91Hu6X6yzmXyWAW0kZ1I01
         qbiLrDc3xpu5NcwvQKLnBSfeCgoaPn65t9+AKHHFGmZobYDTXa3qVhmybChONROSrCQ8
         o0ClClfZgK0TEzEruEYtcA5CUnDnyis062VQp3/0wcAarwHLVE/CBNMi0S9mJsq1+cdc
         Wii/lJRjTS77Pm12usr65+VceO+UCdj4M0J+yvoGK31ANYV4R+LT/XO+zPFIEMHdogiR
         BfqA==
X-Forwarded-Encrypted: i=1; AKwUvBwf9QFNpb/vTaISbTlg+NnqTSZJXIShQo50mylTfzpxIPtZdV9Ae5fkT165n3yp28ctBYukBkkjjw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/oFDXeNJU1N9JMcJfPaO6/tkxWRTD+7+fC2sV/7Va6eGf6oxZe
	AEKh3JYJufnoo0rib6NsqNy1ozHDNycEANcPdRcvoMNdaJw2x91J6t0n
X-Gm-Gg: AYBFou3BZx+2IhrgRAhAtXBzkvnhBM/5/ZSBhVD+ai+DjIKHAGzJb6ybbiZ2WbbTdgw
	0vptF2zh5Gh882dHgncYbF12Rpr6QLqJkcpYJs2UQx3RquvS/UyINJ80pTceEwjCt27KABmESgb
	pHzUP1htG8vItvl9OOcKgmlUFeDA1DCesO5QgKafzmLLeuCBDK/IdH+FAMcmLbM0VY2GzdACRHV
	tJ95PBfUmq0tJ512/do81ykZGDiE8Pk3L/+aFr2NYK9b491Lca9DJOrebZ/D2+VpJu12EXSTYSr
	FTJ/Uh7J1SvoctVhExIw9NSNAfDi5Jortg9/B8tfkVITUG5HjY5avnJZf2R1stAIOkZByTc0HQM
	UccUttO71bId0oI6t/n3dsRQ2LDtuTVnKZbi6W6loUYbFjuE1bfEF+LgeqWRyt0MQxiWqOjn2B0
	S16EQmRvfj9PrzJIb4NDto31QochdziwXnzJ3mf68+ANqAcmYGyTQZWNrb5WGfSnQsB0+BZpoWZ
	jmY8fwsOSmr0JX7VcJSPHQbUheBHJH3CA5/ISiDEcpv6iwcueQQR/LMiLOT8bDv0opE8TXM8gPA
	mrWRRe78wBr1XRXI6a6hQJs4AhIpT/VZLZvt2+R/npNmP9q43Q==
X-Received: by 2002:a05:600c:a30a:b0:4ac:b0b2:fa12 with SMTP id 5b1f17b1804b1-4acb0b2fac0mr259956635e9.1.1793795183945;
        Wed, 04 Nov 2026 04:26:23 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43da9825bsm50492415e9.15.2026.11.04.04.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:26:23 -0800 (PST)
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
Subject: [PATCH v13 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Wed,  4 Nov 2026 14:25:59 +0200
Message-ID: <20261104122606.215629-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Changes in v10:
- ec-kbc: fixed possible out of buffer reads
- ec-kbc: set notifier_call before blocking_notifier_chain_register
- ec-keys: dropped input_unregister_device which should be handled by devm_input_allocate_device

Changes in v11:
- applied changes from Florian Krischer (read_size parameterized and fix keyboard response framing)
- ec-kbc: switch notifier and serio register calls
- ec-keys: used WRITE_ONCE()/READ_ONCE() for priv->special_key_pressed

Changes in v12:
- removed unused includes
- fixed kernel-doc warns
- added check if dockram client and data are not NULL
- replaced handler in media keys with Dmitry's implementation
- calculate battery time props with unsigned value

Changes in v13:
- switch to PLATFORM_DEVID_AUTO
- move notifier registration into input device open()/close()
- remove code check in asus_ec_keys_setup_keymap()
- register notifier before serio ports
- wrap mfd and leds at 100 chars
- moved retry in asus_ec_reset() into loop scope
- removed asus_ec_leds_data from leds
- removed platform_set_drvdata form leds probe
- iterator remains i becuase name led is already taken by struct asus_ec_led pointer
- unfolded driver struct fill in led platform_driver
- minor formatting changes in serio and keyboard drivers
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
 .../input/keyboard/asus-transformer-ec-keys.c | 216 +++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 258 ++++++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-transformer-ec.c       | 114 ++++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-transformer-ec.c             | 551 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 289 +++++++++
 .../supply/asus-transformer-ec-charger.c      | 208 +++++++
 include/linux/mfd/asus-transformer-ec.h       | 100 ++++
 18 files changed, 1935 insertions(+)
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

