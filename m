Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2220E3AAF40
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997707; cv=none; b=t4Ip/u/hnWwgXhNuhQ3e4MPy99zeg/dbvETsNLKgojs0NGPzzytuZRsJk05XOTLG1qdG+jsOnmW1szuCpfCdR2cEQBzi8kbsRNa15ozr1GvDa28Yr+OPh4P4iWDZAG/K9denbEpl1flBYUg68PxzrfNNxnGdUC1KiSrm/uFwCKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997707; c=relaxed/simple;
	bh=j3nXkMsJdWKehS+eBrEBhVDV+Ebh7EVLigl6HYjdVE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYZM2/h87U908lpHD672lUQ+ixJcfQJ/v7tLfoNmogXZVlYrwlsbM3OmupDmgrpyD1pqgYr8XuJOhodrePCO/1Iu8oiHBwPvWEAFM7B+L364vZ+l7Js7HwuZpkIlC57s5uxlU3jsIYX9/MX0NmpwkL8SNhuZaOa/eSNqASjSm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8u+YtJf; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8u+YtJf"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso6166672e87.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 16:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788997702; x=1789602502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ThT5wu/no3JecMleRY6YhnuthYVTftRYEaBVTxj8kQc=;
        b=I8u+YtJfHEfdFVcvAi8iMZb+CsaYFlyZtEj3ND96sgBd+8B2ldUPTcPzNyrLAM7i9e
         JD11H3c8vvBn39sgidPnZ8eAdT01icuPsi+RPqeAQcq+yvxV+dp/84DWjW0Q3wGezQht
         ZkMqUFSW3xuhg4knXbxfclmzO0loKE05YQK8BJrg2Y1J2Um7MrC8emTzPI4v+igNO5OT
         XJEbPmKNPdyCLTuxUQrvd/kXxI2GyY0C6QxgkaBGYVcgMmAlo2onWWVPIcylHTIimU2z
         ZrwxYNXurThhms0PaQuxOkVyThKBGrqDpU/Lgncs37n2B2S5FsY2qIlsJPoIJzxGoOdE
         83gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997702; x=1789602502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ThT5wu/no3JecMleRY6YhnuthYVTftRYEaBVTxj8kQc=;
        b=EybjnPPzSfB/+pIZeDrFVYp66OPza894tecsguiVNI8aPr2uvIFNOm44SB5VnXWNEz
         W6dzPs0fCIun3ME1h3fto7obXxTLD2GvSSe8Cs/JNudoHUb9m5qHcKHM334CcE5nhjm4
         mXmwO5B4LIIB0Awjssmwg+kwwe/mBmm53a+WnQBCssHlKfQ6ld9gk/dj04I1SjJ1EU3u
         qkYmSKTuG8mOKvAjkjXV7rC6Y2F8QdEZtljhLgW6BUnDP4aDTIswWA9Y8q13mL+U8J2g
         aebn74yd6leVI6dXiCsnooJD6MR6YQ/GXuJQkq8B1VTMAq+DOQcWQKoJ1TwDwhqYTH/Z
         0guQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpCc0hFr3bbe6yV7R2Mvyx/xY6WkefYpy1LF6gHcHQmgTjFS5yFx1A63H4JxUKE/Kc8ooLKrCtzw==@vger.kernel.org
X-Gm-Message-State: AFuF++lHE9DecKPLHWK/TQGaY+XX7cuQwBQoy6r3NKmfYw+Kks8RfGOI
	f+Xx4kJtfp7to3G1MiA0K0/M2OfbIeLXd23WiUVclkifrKE3f7tdiaTz
X-Gm-Gg: AYBFou0ba8BbxLToef9m4duXv95JHPg/UwtWba+WHheEcAyHpICYVZs3f0V+fg7zfq9
	z5s16cqMtaRqkkz6+86WxXJ2apwyxbctdE7ffrzuR9cHrYrJEjHU2I1DFX8N3hsl26nbf5FN3eK
	XxWv5TefLJzwq3Qbrw0jW5xp2S2Yo6e7tQsYlManhZLE5xfYVX3MArEFn/H+juE3X+jNXZkC2Yp
	L7/tRmPbbYXVmB7uDDlaH0Iq9v/YOP4xp3iRQfe+GnaQk58IVyIw+S2H8CMupjSewu+gpzCkpF2
	aDkifTeaI6EEYRuWpJTq5vBGs7CqKnHDEka1aCWHsJjnTEEg8EzJ7urKc9qmsNH4FEHUHgvvbL1
	GhWNJFbrXL1SWyqgN8/ek/PRqNpE//IFbeDlqPrhmp9M8XZCICHiRg3pQWTAoA+zvn1Kznr6v3P
	aATUdY+MGqY6rgial7/APZxbWuu1ydbAkw2aS2bTmYWsuy6a76BZwihdOf+1yxdQRBdZQ92WxIf
	vklWbwBZN3JELylv2xs4IQbSXZwJdVtzspgGe/QVbM+8lUv4go=
X-Received: by 2002:a05:6512:3f0e:b0:5b5:e86f:3550 with SMTP id 2adb3069b0e04-5b616eed114mr6055767e87.9.1788997701538;
        Wed, 09 Sep 2026 16:48:21 -0700 (PDT)
Received: from notebook ([93.189.200.242])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166ed4cesm4153300e87.26.2026.09.09.16.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 16:48:20 -0700 (PDT)
From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	"Andrew F . Davis" <afd@ti.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Subject: [PATCH v3 0/3] bq27xxx: support interchangeable OnePlus 6/6T fuel gauges
Date: Thu, 10 Sep 2026 02:47:41 +0300
Message-ID: <20260909234744.1177153-1-rinat.muhamedgaliev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829205258.26955-1-rinat.muhamedgaliev@gmail.com>
References: <20260829205258.26955-1-rinat.muhamedgaliev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OnePlus 6 and OnePlus 6T battery packs may contain either a TI bq27411
or bq27541 fuel gauge. The DTS compatible used until now selects only
the bq27411 register map, while v2 proposed selecting bq27541 for every
device. Neither static choice supports both original and replacement
battery packs.

Add a generic ti,bq27xxx compatible and have the I2C driver issue the
DeviceType control command at probe time. It selects bq27411 for
DeviceType 0x0421 and bq27541 for 0x0541.

Tested on OnePlus 6T (fajita) with DeviceType 0x0541. After installing
the kernel and rebooting, the fuel gauge reported 4.360 V, 100% state
of charge, 27.8 C, and Full status.

Changes in v3:
- Replace the static bq27541 DTS change from v2 with runtime detection
  for both bq27411 and bq27541.
- Add the generic compatible to the binding and I2C driver.
- Split the change into binding, driver, and DTS patches.

Rinat Muhamedgaliev (3):
  dt-bindings: power: supply: bq27xxx: add generic compatible
  power: supply: bq27xxx: autodetect bq27411 and bq27541
  arm64: dts: qcom: sdm845-oneplus: use generic fuel gauge compatible

 .../bindings/power/supply/bq27xxx.yaml        |  1 +
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  |  4 +-
 .../dts/qcom/sdm845-oneplus-enchilada.dts     |  2 +-
 .../boot/dts/qcom/sdm845-oneplus-fajita.dts   |  2 +-
 drivers/power/supply/bq27xxx_battery_i2c.c    | 39 +++++++++++++++++++
 5 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.55.0
