Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571364;
	b=LYR2we5cKQjYG7TIXL3X7wSe/Y/eDA+q8vnPs8GfZrxNmNdKFnTrgQxJJ7f16lenti3K
	 IiP19zHlpwY74V46FT6SC4KQUR0nE2btrMRteQr/lBKj5qxyh9uBmRxISmZUxG4qfNFxM
	 r3SvaCI1GdkS1o/dzKNNZee8qQuJB97S+X4rWoVATFBdCzU6mtZ1SwuB7cKBunJQ9yY4p
	 7//8dG6nTE/7KV5s6ANJY/KcEw+2SxfD3xTiE6SMNDVZgCslQVqUIj4egsZCD1HCdm17h
	 SEN68KadX/pS7YLnIxnzan55ZkBM3ipQYtZUFXp6gbYNt9moRs+XsZAceu+3FjrAaiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lWZkTV4baMpXFSYDCA2jq8E9sFQlynhJ2fEhBW3is/Y=;
	b=CIJm1MlDEHSwnOZeJB2w2n084w4yAglxtkis/1xdcKFOXmdqjvTRKNU4TO+688wt/1z9
	 6aFupHQuIByc10GpUe3qGSFwxY5zAqOTAAsOuZjKVaxJHG35aJmJqQxdoUrYSbiewF56P
	 wclV1inqTtKilfUbCLdYdDkoC/ApUSErjDvklxt8Xeq/YopTwfiyUgDnSLgCBGvjy+rPx
	 AlUnl8bKwkHLEPgqRO8xB2ukRNl7cJ7ZKPM2CpsuvE68XA2OjQHDdEz8SvOi5mNls70qw
	 M0siKzvxgmJLUsjpzkdsioz5SFxJmBEYMMGRAG0bCJBX7cftIpyBABVDJKXbspdhQvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T1xV8FdQ;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC2606A327
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8CC2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T1xV8FdQ
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36661f953e4so922692eec.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 01:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571363; x=1793176163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lWZkTV4baMpXFSYDCA2jq8E9sFQlynhJ2fEhBW3is/Y=;
        b=T1xV8FdQnYgzTMs0Cowoo1KlHMZjZS/2gGqAMwwDjbdo5Crgzpbz64lsmDNFMEGigQ
         R0qmcY24L1V1sZxRV3YgJWgY29IAMUPSvL6pgsCZSSOjz4qJM/72K50+F0oPbiry/hhv
         VqDWRNXHyG8tAP+L9T0BGYjjXn4X+qDZ86C8y4u5xfD1Jb+1wGTTrcaJDJu8m7OS+Tl9
         UVGT/hQMOqeOyenq9A9ftLlnnWvBoppgoVIJEOxflwJq9njW2ayIurQOxToOLvCiqILP
         UJhmyQT6NXUb7QkSLnM1nXpDMWlSuHq/YdN1EtOXiuzKOgPbyvqYWaZu91Dv47yFeXCB
         nQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571363; x=1793176163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lWZkTV4baMpXFSYDCA2jq8E9sFQlynhJ2fEhBW3is/Y=;
        b=QplZmAF8FkIA8+btWjj3j6kpR1PyQs/jBvP+rKrCrkdU3xTokNnLBzr/zTVMMca2gW
         lB7RRdkTosGgAfPEdfU66bq+6y4uRKUAUHkMXcxPlcdpX2MsG8Gjd25jEJha7UpVRnhT
         ksDBGJBgY5k5jik05ltX53eYc8MTkkJkx7t0cGGSSHK+sLuRNjNQT2ELMGrZX3RFBhKG
         AeOPyeCccvyTEAHy3QMUVyTakZBfZTD2IzM7PYpIvjMseUrkr9d2Be+8zjqQDct9Xs5P
         vij9y+u3vT5s4E819+BXQ+y9TSCJjHs+6kXDEU90kuvtUDpXnqlUJJr1td6ABwKS8bkm
         PR3Q==
X-Gm-Message-State: AFq9FYKhXAoEtHZ421eabLdeHg3t+EhQxEiT9rNyokFsrbnvNhlwD5KG
	Um64OTTQaxEiiE2jhIkV4dOTxPpsaXcQTjdlXdvaMXuiDsmN2bEkk39/RHS7ZQxub+s=
X-Gm-Gg: AYBFou3tC/7NLHAdayd//sQEi6Bl9vhXadsaA/xdcjr3AZ3YKIlQovzPbZo6tQzkgS7
	bRwqG7XBccxLlN/F+LXrL7Bx8WGSqubvliXj5PdSm2jirGSZ48tIW9vCzaxnFsOxTyrheRG3NIp
	EbH3Uj42pCt5Dh99qcUS4wfCzJCU8dK+vG1f5TkQnYu4Af7l0Il1JoTw5fzvMALLXvQtkQYIqAn
	RZd+qzsXQxVL20IWDOgGlaZ+9a8zO11KpYIJ/PcOlo+aNhjFV16tGX9cy+mV4vHP5mYTI/b85mT
	V/1WhqcpckpexllTqeqcodIpz2E3ps1MfEM7OnPP1fgAeOuBQajdWikKWeb6ZidNWa0GkCDwR8K
	tSZfKNEPSB97y9BtWsVjIkUk4LNeE8zC4J+FYffhlCmRk/Oogb1FXATT4ez1fAo7b/Rn6ipfc0P
	L49AJ2o0fThVyThBgEg4I77qS0tg9/5tEuAiTq1b1ySwZt/lOxexZN86olM7oCb2BqkvpSHJR6Y
	uR/ckAqTwq2im+Kgrl+9ok8Mp/deIz0RIXRbmYJybVBg/YrHoyNW34o0mtDM4GVjZLki6n60Ecf
	JJImOpKc3KWfCfaDl0TpVIqA96PG63xouHvhY2TLuxNFAQ==
X-Received: by 2002:a05:7301:fc17:b0:35f:227b:f8bc with SMTP id 5a478bee46e88-3674d447cc2mr2246570eec.11.1792571362546;
        Wed, 21 Oct 2026 01:29:22 -0700 (PDT)
Received: from localhost.localdomain ([113.161.48.203])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405edd7bsm5199132eec.6.2026.10.21.01.29.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 01:29:21 -0700 (PDT)
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
Subject: [PATCH v2 0/2] power: supply: Add Qualcomm SMB1351 charger driver
Date: Wed, 21 Oct 2026 15:28:39 +0700
Message-ID: <20261021082841.79147-1-thenguyen1024@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
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

On sre/for-next (f0f400459bf6), the driver builds without warnings
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

Changes in v2:
- Patch 1: drop monitored-battery from properties, power-supply.yaml
  brings it (Krzysztof). Add Krzysztof's Reviewed-by.
- Patch 2: unchanged.
- Link to v1: https://lore.kernel.org/r/20261011072135.12757-1-thenguyen1024@gmail.com

Adrian Nguyen (2):
  dt-bindings: power: supply: Add Qualcomm SMB1351 charger
  power: supply: Add Qualcomm SMB1351 charger driver

 .../bindings/power/supply/qcom,smb1351.yaml   |  69 +++
 drivers/power/supply/Kconfig                  |  14 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/qcom_smb1351.c           | 426 ++++++++++++++++++
 4 files changed, 510 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,smb1351.yaml
 create mode 100644 drivers/power/supply/qcom_smb1351.c


base-commit: f0f400459bf6a037e70768de623fff3f8920b8bb
-- 
2.43.0

