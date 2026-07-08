Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B213F6C5A
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547308; cv=none; b=od+/M7pf25jKrKqTfHWUDC4V8Ye1xlkfUsOBzjiwG4Un8V+SOHI1OK6ulJSKgKKNK6xnrN2aOctb4YboVD2cczWLS+KUw8Mj4GSFOS+3XVreIc73sO+16cWWo3X64u75hYn5+OFKgRo9XkZvyul8h6RZLnhGScoXAvhmH7HvPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547308; c=relaxed/simple;
	bh=7KJXJzo+UE0xE9qAQMsWzVrOorS//UfnfERkBCDL37I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZkiysacffbNT+sZrdDjVILGCaGSM0F1whTuGr8CcbKNISL9Le39u6qi/pqJYcZyHiJYo96AOUIUVFMQ61yY6ssAqenl1kSXb47NSQM6WG3EwR+M+3JiGy85dFz47FoayCxFimYsabXe+B8V5gMMdxa8Bbtqlgy6QL2jV41NPghk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbUi5dYO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbUi5dYO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cae1a3a744so9290435ad.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 14:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783547306; x=1784152106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ws9RhF/v+RDUhCzwrIsuIgwDdl54OneaRZCtnhDgCNo=;
        b=dbUi5dYOv74sX1ph2QjqwrH2P1X6X+GyipaScdiG0ElDNBVvZxmbO1qtkb07nDvSVe
         SRxWkQaUqOcF3+wBYpIeVoSIz7nNpQXsHPfBo82MP6zmqeFc4CWHM+TwSJkozKhQ40qP
         /KKxm57d7pJiZgJiZjY7kmmDUhFMP+vJTQLyVeOW8AnPgCIZ8INQWyVUOlp8DFSt7BeT
         YwU7p90uTGLNybComwoe7OcG+652A7bRxLJy2G3Q8QiT4fEuE4BkDdDZ6bKDOr1SHqkc
         r2Zr/O/T31zZltLZVxnDH2Z+iN9UAbmUmywYAjpJtr812j3ES0bwCoTIynwmj+cJQSu4
         ErPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783547306; x=1784152106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ws9RhF/v+RDUhCzwrIsuIgwDdl54OneaRZCtnhDgCNo=;
        b=gC2xuPN5YWVvdeOgflTrTpR41RtmPFrOMzX//JOMZJ4Zrpyw1zx5yDlG3HbM/bLwji
         2BZSpFVJdbWLA9ZghmzmkgRAwpVB7fr/GSp7/mXL2aAMX/1LCgGQI/c2mrVkaV4A9c6e
         Kg9LlZyW2WE6tb8CIWSWXxGieaayToi1lSopTTtWy33plIY3UCvvVRXd604OdjQ177KB
         KGrKMDf13+J4sHFl9TGlQdfVufQDsEtkyMORcsZexUnVArWY0WfwG9UsSoixM/7n/Tnm
         eygeU3Do2IsDDYUJtP4+tin3iFr5VSEfQ1Zefh86Z4pEG/QOK0xahYbkn80UMGNiwTgb
         Wasg==
X-Forwarded-Encrypted: i=1; AHgh+Rrq1R3tcX10jsdIjyQfzkjSLo8cAPXtEsLA2wVJFf4D5S/uWFKj5jIhhCe6vEsHIYXwHDyWBEje7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNdU3YssKOM71o+ovG67+O+0ucUpVTvMCKIq3phtH0CT41V35
	VT2bypWYJd8mywXnxStPSTfYi/8OIU8pZwGJd5W4eFXA2ktjJDSSGBgQUmdzEQaS
X-Gm-Gg: AfdE7cmw680O+jzFdnxgS17WyHx7BD9NSTf6IHPdb7K0erch5L6+NM1n3sfXAco4Gzt
	Y1I9UKYHICw5YXYajfOq46voTzOHnkIb43ggtHfQIeKcmL22CbsQUd7EQPmUuOCcGmbsVOJ/5n8
	MH5+90raHTDOEYBFvUkC21K50dI4aDMVuvsrT1XKJQhZpATzfIBkCqht4KtdK5oz6bvBKX6XrRf
	RuPu7qJQlBsH6fdFWtsZBWSNZHSZTzAIqFx0pMsXslGBs6906KdGz/f0d4lzch21QYFs87CmkD9
	QRrKWrTHZmbItqhgIB2GYhJUbTuAUKxu5eyUVRJvImteVapo1S0LLFIeVgszQEvSfVyU4L0Pvqt
	gnT5gLXssC9UZeNRJiBSqngqx0qUzuFtSXXr3itHjlyFpmFsWbUTgzYYL/Y6+sz12l/6zmefSnP
	PQhofeiQ1lv+3eFnHNB3PCVpMf2h6jG8sZeJww+gwcd7yqLtA/95I7pCdKqjTDnGicha7CZvPjo
	W5HCRiOcKO8v9sw4wqbrSvm963I8aSAPFlpK3E1NY1YQPUJ3/3P3d6xN3i+ynsiRzyt6JxIie+3
	4LM32bBGQ/WVEl7P14jtO0mERvILUZCDKbAzXhXmglWi1I2foGxsMnMvqtzFbxg6mM8jGPvF
X-Received: by 2002:a17:903:987:b0:2c7:f2c6:89e0 with SMTP id d9443c01a7336-2ccea35ad78mr48716195ad.4.1783547306454;
        Wed, 08 Jul 2026 14:48:26 -0700 (PDT)
Received: from ip-172-31-21-198.us-west-2.compute.internal (ec2-35-85-29-74.us-west-2.compute.amazonaws.com. [35.85.29.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d946sm33733855ad.66.2026.07.08.14.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 14:48:25 -0700 (PDT)
From: Bruce Robertson <brucer42@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Gary Guo <gary@garyguo.net>,
	Tamir Duberstein <tamird@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Boqun Feng <boqun@kernel.org>,
	Bruce Robertson <brucer42@gmail.com>
Subject: [RFC PATCH 0/3] rust: power_supply class abstraction and SMB347 charger driver
Date: Wed,  8 Jul 2026 21:47:35 +0000
Message-ID: <20260708214738.25008-1-brucer42@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a Rust abstraction for the power supply class -- which
does not currently exist in mainline or rust-next -- together with the
SMBus helpers needed to drive an I2C charger from Rust, and a Rust port
of the Summit SMB347 battery charger as the first consumer.

Motivation
----------
Rust drivers for power supply hardware are currently blocked: there is
no safe Rust interface to the power supply class, and the I2cClient
abstraction exposes no register I/O. This series provides a minimal,
self-contained path from binding an I2C charger to reporting charging
state through sysfs, entirely in safe Rust, with the unsafe FFI confined
to the two abstraction layers.

The series is structured abstraction-first:

  1/3  Safe SMBus read/write/update_bits over i2c::I2cClient.
  2/3  A power_supply Driver trait, a generic get_property trampoline,
       and an RAII Registration that owns the descriptor lifetime.
  3/3  A Rust SMB347 charger driver consuming both: it binds over I2C
       and reports STATUS, ONLINE and CHARGE_TYPE.

Testing
-------
Built and exercised against an emulated SMB347 using i2c-stub: seeding
the chip's status registers and reading back the corresponding sysfs
attributes (status, online, charge_type) confirms the full C->Rust->C
path. No physical hardware or interrupt path has been tested.

Open questions / known limitations (hence RFC)
----------------------------------------------
  - get_property recovers the driver's private data via the parent
    device's drvdata. The current code relies on the observed ordering
    (callbacks only fire after probe() has set drvdata); the contract
    should be made explicit.
  - smbus_update_bits() is not atomic against concurrent callers; a lock
    will be required before a charger IRQ handler is added (not yet
    implemented).
  - Only get_property and a handful of properties are wired up;
    set_property, property_is_writeable and the IRQ-driven
    power_supply_changed() notification are future work.

Feedback on the abstraction's shape -- especially the descriptor
lifetime and the drvdata recovery -- would be very welcome.

checkpatch emits one MAINTAINERS warning on patch 3/3 (new driver file);
it is a false positive -- the driver is covered by the existing POWER
SUPPLY CLASS "F: drivers/power/supply/" glob and needs no new entry.
Patch 2/3 adds the one file outside any existing glob
(rust/kernel/power_supply.rs) and updates MAINTAINERS accordingly.

Based on rust-next (v7.2-rc1).

Bruce Robertson (3):
  rust: i2c: add SMBus byte transfer helpers
  rust: power_supply: add power supply class abstraction
  power: supply: add Rust SMB347 charger driver

 MAINTAINERS                                 |   1 +
 drivers/power/supply/Kconfig                |  14 ++
 drivers/power/supply/Makefile               |   1 +
 drivers/power/supply/smb347-charger_rust.rs | 180 ++++++++++++++++++++
 rust/bindings/bindings_helper.h             |   1 +
 rust/kernel/i2c.rs                          |  42 +++++
 rust/kernel/lib.rs                          |   1 +
 rust/kernel/power_supply.rs                 | 133 +++++++++++++++
 8 files changed, 373 insertions(+)
 create mode 100644 drivers/power/supply/smb347-charger_rust.rs
 create mode 100644 rust/kernel/power_supply.rs

-- 
2.43.0

