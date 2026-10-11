Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499E3502A8
	for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791703305; cv=none; b=Ekxydsd0IpSmaRQK4F6lT9OTZ/LagnKJamgFGGSSfcbpQy1RBACxZ/MDmczMrqjdstsnoidZj4d9bBdHrO3XswDtYG+I3w9jdALymK5rFIAhiaHT0yTrLyAAX2idt+BOfU4bn/JicrH0tYegC3BoV6673aBYNsKqf9xQkmfNpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791703305; c=relaxed/simple;
	bh=0K4gCIyFe0Er8Bw8iuCwJ+ik6MmAivx3xfVB75VoEW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qezQgEMHHhbaalQCh7WsLjM2tahf8pKIJLzihxQQzhuV3uPwdd8hT9qbNYIFT3HoPwcO/v+rovZSLP8nLQGDgyNvzbmkDt7IFSxsykfEchjLl4zxCTKI0GtLnAcLZKB+wm+EVZzSDG761T3bkvGTHOIgZNsDclKmzMVnfVEsMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBCH/wnL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBCH/wnL"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so391039a91.2
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 00:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791703304; x=1792308104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+jU3Rmrk/nbOZWjxjv/jI52nizg3YlU+qRiUWSN3FI=;
        b=XBCH/wnLmre59r9B9sZ6NI/Z8XhscuLCXYpCil5REkeioODn3P8PE+nesYKuLvmQob
         jHUOHrCWgE1jTFXQ98MB/CbjIzExUY2iwUJ9RlLQiU8n6edWRPvbM63b55q/dSIDUSuv
         nHwM93S5o3mpaHdjZtOcADdiL6Bt1R7m1rjb7AxdFXH2VGZvhd2jJVepmyjniwF6Z/0s
         bKPDuKC7MsQhjuSI56qwNxXk80wooxUsSrqNVOGPE9iCFrlKX1mTa1SAUlfY3z5tPweT
         mqK6RtrEa39inglkFx0V++cjheskzVLCPXXcerfGamjwrZoRd+bWDTYcIH9Cxv9hFP4H
         uaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791703304; x=1792308104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u+jU3Rmrk/nbOZWjxjv/jI52nizg3YlU+qRiUWSN3FI=;
        b=s0s1IC+KeyPEhsMa4VlHMuLV0KeQWuB5mgX+XIgwXaOjI9KSLwvbX0XW14fNU7xXrk
         Wq9RDBVY5vdp73xS6N7/Q8rcdDlfGWMWV4nBJE8xHrIJrqCJQmT3UemnePQwfxBANTqg
         MlbWwjXzU8E7LwygfAGgkHQZw88bl5iZClLrykfdh393KqAO1i0fcnevH+ZxrOmowlbG
         aZpLPO+2Y8fUU4/WQN2UUf/D6Jc5vFtftWmAs2sn4kVcam1X9kWbiXsEIB2CpmeD/gqV
         Z2mBZetMbMY3MasUhvbP/vL/v2mCYBpL2qjMqLTsIKZO4HyqR9ujvoIEJ19BF2NaY7pq
         8g4w==
X-Gm-Message-State: AFq9FYInInrn78OGVxinmdeXIbwcZmfdTxqn4sv/YlSnnJMqBYtAt6wu
	MVS/VgEcxDIED0z+u4lP7YcBFrkvzvUEcPZRoY0CTbZgTd794CNmn9Hv
X-Gm-Gg: AYBFou3b2r5B2hI3l0KpY3RPgcQpDQUrn9m5ORTPDB6PlnAd5N5l+1d/YbteXnaB7iX
	ZChg6u7LsQN325qYLK667fOVH5mcFGP1J9UiGWAYf62c4tVTeUCTK6iUCRL9zdhh9UHRGuZGHct
	K8JfWNL5E//5kjslLA9vlklq2pP324VUNPnxzLM7CpO9uJOWdRqPCZckAgnjLBs2F6YbzS9xg0G
	aFs+L1YcKsmxT/Y4yx14nJ+iUrt47qtAyTVFLstb8eRslmLTHbyeKOn+SEOO1FUS5mzCuKUf2dd
	NDiNI0bxLkhwb1WqCgGIWGEITgkqwAOZSvMFyQ1x1nVF8oXmMkBsUJOQnlunFWz91AojOa8EE/K
	7UIhLcY9Exf1frqzfa9NQIJYTffGzNUkHLDjDhx47sIBb9DtRjjyGdMKRQxkZ7V1dgeX/jIYOLN
	cwsajIyGycufy7Tcxs7nqrYEs3PHouBLThyOpIVpJxnEDmrsjE2WuYy57jAlz7TiZ6ff3Q2ZS1Z
	flSDybMZePTyGMsVntDjpxjSbRUrTPK/tfMZGAsUSAn16YVlwuWXXgQ7uHu6ejE3w==
X-Received: by 2002:a17:90a:d450:b0:3a0:a912:e759 with SMTP id 98e67ed59e1d1-3ab3a79dd33mr5323176a91.25.1791703303511;
        Sun, 11 Oct 2026 00:21:43 -0700 (PDT)
Received: from localhost.localdomain ([58.186.105.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm11591358a91.4.2026.10.11.00.21.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 00:21:41 -0700 (PDT)
From: Adrian Nguyen <thenguyen1024@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Casey Connolly <casey.connolly@linaro.org>,
	Adrian Nguyen <thenguyen1024@gmail.com>
Subject: [PATCH v1 0/2] power: supply: Add Qualcomm SMB1351 charger driver
Date: Sun, 11 Oct 2026 14:21:33 +0700
Message-ID: <20261011072135.12757-1-thenguyen1024@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Vsmart Active 1 (SDM660, PM660) has a Qualcomm SMB1351 parallel
charger at 0x1d on blsp_i2c2, next to the PM660 charger. Its version
register reads 0xb2, which the downstream driver identifies as an
SMB1350. Without a driver it runs on its OTP defaults: charging is
enabled through an active-low pin that the PM660 holds low, with a
4.5 V float voltage on a 4.4 V battery. It is powered from VBUS alone,
so it does not answer on I2C without VBUS and starts over from those
defaults whenever VBUS comes back. As a result, whenever the PM660
suspends its USB input, the SMB1351 charges the battery on its own.
Since commit 98d68b74ebb9 ("power: supply: qcom_smbx: allow disabling
charging"), qcom_smbx does that when user space writes 0 to the status
property of the PM660 charger to stop charging.

Patch 1 documents the chip with the battery it charges, its STAT output
as an optional interrupt and, on a parallel charger, the PMIC charger
that shares its USB input. The SMB1350 gets its own compatible with
qcom,smb1351 as the fallback. Patch 2 adds a driver that keeps the
SMB1351 from charging: each time the PMIC charger reports a change, it
hands the charge enable control to I2C with charging disabled and sets
the float voltage from the battery. A status or charge_type read that
finds the chip reset, or not answering, makes it configure the chip
again. Its power supply reports whether the chip has VBUS, the charging
status, the charge type and the float voltage set in the chip. Parallel
charging is left for later, since it also needs the PMIC charger to
split the current and to drive the enable pin. Patch 2 also explains
why this is a new driver rather than part of smb347-charger.

Making qcom_smbx drive the enable pin high would also keep the chip
off, but only because of the pin polarity in its OTP, which the
downstream driver does not rely on: it programs the polarity over I2C.
A driver that programs the enable control over I2C works whatever the
PMIC does with the pin, gets the chip described in DT, and gives
parallel charging something to build on.

Tested on the Vsmart Active 1 with a 7.2-based kernel from the
sdm660-mainline tree [1] (its qcom-sdm660-7.2.y branch plus a few
pending pull requests), with the same driver as this series,
CONFIG_CHARGER_QCOM_SMB1351=m and a DT node [2] that also passes
dtbs_check against this binding:

- With the PM660 USB input suspended (on that kernel through
  charge_behaviour=force-discharge, which the sdm660-mainline tree adds
  to qcom_smbx and which sets the same USBIN_SUSPEND bit as writing 0
  to status), the battery discharges at 250 to 470 mA and the SMB1351
  reports "Not charging". Without the driver it charged the battery at
  about 390 mA in that state.
- After an unplug, smb1351-charger goes offline 2.35 s after the PM660
  charger reports the change (2.37 s in a second run), when the
  driver's retries run out.
- After a replug, the chip is back on its OTP defaults (0x03 = 0xf2,
  0x06 = 0x6b) and is configured again (0x03 = 0xed, 0x06 = 0x0b)
  within about 0.4 s of VBUS settling. This also works while the PM660
  has its USB input suspended, because the PM660 charger still reports
  plug events then. In that run nothing read the status, so the PM660
  events alone were enough.
- Writing the OTP enable setting (0x06 = 0x6b) behind the driver's back
  makes the next status read return "Unknown", and the chip is
  configured again within a second.
- Probing without VBUS, unbind/bind, and unloading the module inside
  the retry windows work without warnings.

While the PM660 has its USB input suspended, smb1351-charger still
reports online = 1, because VBUS is present, so user space such as
UPower sees external power in that state.

On sre/for-next (5c1c602463d5), the driver builds without warnings
with ARCH=arm64 LLVM=1 W=1 (clang 23.1.3), sparse (C=2) and the
coccinelle report scripts find nothing in it, dt_binding_check and
dt-check-style --mode=strict pass for the new schema, and
checkpatch.pl --strict only asks whether MAINTAINERS needs updating
for the new files.

The Vsmart Active 1 DT is only in the sdm660-mainline tree so far, and
the SMB1351 node for it is in [2]. sdm630-sony-xperia-nile.dtsi also
mentions an SMB1351 on blsp_i2c2, and msm8996pro-xiaomi-scorpio.dts
names a STAT_SMB1351 line, so the binding may find more users.

About the Assisted-by tags: this series was made with an LLM coding
assistant over longer interactive sessions. I asked it to find out why
the battery kept charging while the PM660 had its USB input suspended,
and later to fix that in the kernel. It read the SMB1351 registers over
i2c-dev and the PM660 registers through regmap debugfs on the phone,
compared them with the stock DT and the downstream driver, and laid out
the options. After I chose a separate I2C driver, it wrote the binding,
the driver, the commit messages and this cover letter, and ran the
build checks and the device test scripts above. It also ran sparse and
the coccinelle report scripts on the driver; they found nothing, and
patch 2 names them in its Assisted-by tag. I did the cable tests on
the phone and reviewed the result.

[1] https://github.com/sdm660-mainline/linux
[2] https://github.com/sdm660-mainline/linux/pull/241

Adrian Nguyen (2):
  dt-bindings: power: supply: Add Qualcomm SMB1351 charger
  power: supply: Add Qualcomm SMB1351 charger driver

 .../bindings/power/supply/qcom,smb1351.yaml   |  71 +++
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/qcom_smb1351.c           | 426 ++++++++++++++++++
 4 files changed, 512 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smb1351.yaml
 create mode 100644 drivers/power/supply/qcom_smb1351.c


base-commit: 5c1c602463d597c5189ddc5a73dece588ba2c57a
-- 
2.43.0

