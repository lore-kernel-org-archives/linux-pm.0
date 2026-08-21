Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA4448D0E
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315838; cv=none; b=Z7fD6MZzP89/J10/pjXgqwAhA79TFlHgsSDAUa+3y/NPh6c5+zpbweF3wydqasDg7C+2Kj011Gd6d2Xg7xbgwhncNJADuIjdUkmgitZbPyGaLA10hSukmkuoXQGkofVaBgKvfcxr1KWBbXMiaVkRKMi3OJl9PAKOS+TTmfLloB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315838; c=relaxed/simple;
	bh=PrDZgKJSfpx6nKGCbhXpOA4dPKRcANDQUxU89FDpCMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gclBArzYnqoen/apn91akFtvwcgkvUbXbjVoGZwrkUqCK1MXgCbL+3xq2lU34qCur0hrq/OQfEoJKP4zM983yjBBJwxfvKCYhioMf+o5rNyzLnGQ3emXtTJXAyCy2PO/n/pUEQrFRanbqCLHN+XDZ5kuDMC0Fz85gdNOocpipr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db8EK8wQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db8EK8wQ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1677c91969so116163766b.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315835; x=1787920635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jLIbMgirXqtcsU6FvNo6N5DXtJvpeFxGtxPN2x+Chyo=;
        b=db8EK8wQn2CVnbUXZAUXm7mwyCUneQggozOBpIo2iF9G0Dyoln7y440LFKkgod2/Hz
         1L53km5V0uYRcMbNhqrAacBhmEVp3Iqt+ERumCrNduV1rXv9AKyuTVimebF0cqZBsSvf
         8XpZfEin5Og9JDLf9B6Ni61ti5NYWnHI2g/brmvStIRdvfZY+peKoc/JDSqLyhBSBJWT
         FvVIFfGWzvWdwhdcWXLRI/F/A3siVavaZ5u6cnRRQJn2Uw2CMBb0NinytPLr2gVIBVGe
         05QXpPneN51oDxz3wOq4FuptuUtBvMyWuR+Ty8cKeHOpfDe3/d6XgK2DDYwRnmM0w7C0
         J7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315835; x=1787920635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jLIbMgirXqtcsU6FvNo6N5DXtJvpeFxGtxPN2x+Chyo=;
        b=E65XcfwABPpn+u+7QKMGhe6/na0cmiIxMxRCKBlmQSOTcDJo2WEpbV8m7wTbgTYiwZ
         CPtywsr0jSaY/GAzwTUZByX9Lb0Dpo+e4qO25DJ2vRd7le5vZYew9RbLkR3Aa/lSZ1Sz
         VipoJGJoanl0S4iZ915Vf/9q6TT50AfEIoThfjNhFVSnaEA31TkGTj+KSD9xPmVBt0Cb
         ooa4M3xjdPruP+syRjOPYz06gmnuUDec3GRXm2iKxphT5VwxUF7CFLGxVYmA3VtZPy2N
         Lwtv9vcnT6nxHv9Pkq6moScdW8forCTqVJIBg47xW6tcmQhPaG+UTtN5vsrClv9z9EdN
         1uBQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGlMg0h+nbpU2yu8DfZmSF5SKXdFqN0b715LEHCd54dyAPUwklLb1wnhopX6ktc78MFL7I6Hfwyw==@vger.kernel.org
X-Gm-Message-State: AFuF++l884/3qWGt+EGtyLhpsMINH2PAV2TsC8bhgBDqD8QE0LgwT0Vj
	3ZNRl6rhzRLQF0Jakd/oks9n9t/yQWChYxaK++S2jsZWDsDKQM1XiBRb
X-Gm-Gg: AR+sD12REs6qQMLwxS1YOz81hYEftikSFLZuJ5HUYyvDfBDY6tUOUNT+j6BIhoep0Xc
	D87h9wkK44DgZuzq2awHl+MLWl4cxl3FDrVrqgM69zcgxwF2v/ydW516fLgZA5fRc3ZwP9WHOXR
	FWbOfeVyaRbQeyslBFwhRwEzeCFSVnL5HAm31/sli6Ps7fzm1lFDiNFaBsrbfaRWxifDKiQZiTa
	qL/SfMe3872PpGJ8O4+B/KxkCGlD0pmjUFBxL3dKqHUhK+/7xieNua4S3B1HwtF0ioK7HMQhuw1
	ysakbcBQU88sxS9omOsEKNWjH0fAzySgpztqmovSfl1DkQjsab1VUn0vSsGT1Zea/A8mmyiWSKM
	YOEMyeyGkl0+kA/3exNlrjw0hUrDNpd0P0jMxfOTP/wiKavJl5kqxoTbQUkTWUpQ3jc2/sEZg7P
	rpNtKrV3pmpvg8M4uqeGRo1/UUBKsL1eHVrBcvu65NNd4XjD3YglqASvmLgx45qrwezX4Ogw0a9
	6ZFxqHwtxKwZ6FUvdmlgw/l3E0tD4w0/A==
X-Received: by 2002:a17:907:3e02:b0:c1f:8145:820c with SMTP id a640c23a62f3a-c246a4aca6amr616460266b.2.1787315834806;
        Fri, 21 Aug 2026 05:37:14 -0700 (PDT)
Received: from workstation (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591e0397sm451194666b.53.2026.08.21.05.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:37:13 -0700 (PDT)
From: Stanislav Zaikin <zstaseg@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stanislav Zaikin <zstaseg@gmail.com>
Subject: [RFC PATCH v3 0/3] Add Xiaomi 12 Lite 5G (taoyao) battery support
Date: Fri, 21 Aug 2026 14:37:08 +0200
Message-ID: <20260821123711.1579539-1-zstaseg@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xiaomi 12 Lite 5G (taoyao) has an additional property with ID 12 that
breaks the parsing in qcom_battmgr. Fix that by introducing separate
maps for lookups properties in both directions.

The other approach that I tried is manual shifting properties:

+	if (battmgr->variant == QCOM_BATTMGR_TAOYAO && prop > BATT_CHG_CTRL_LIM_MAX)
+		prop++;
...
+		if (battmgr->variant == QCOM_BATTMGR_TAOYAO && property > BATT_CHG_CTRL_LIM_MAX + 1)
+			property--;

But I found that more obscure.

Will be happy to switch if the maintainers prefer this one.

Changes in v3:
- Fix QCOM_BATTMGR_TAOYAO enum ordering (patch #2)
- Order in qcom_battmgr_of_variants[] is already right (no change)
- Revert the qcom,sm7325-pmic-glink SoC fallback (patch #1 and #3)
- Rephrased commit message (patch #3)
- Design question from v1/v2 still open: lookup tables vs. inline shift

Changes in v2:
- Keep the qcom,sm7325-pmic-glink SoC fallback in the compatible chain
  of the taoyao pmic-glink node (review feedback, patch #1 and #3)

Stanislav Zaikin (3):
  dt-bindings: soc: qcom: add xiaomi,taoyao-pmic-glink compatible
  power: supply: qcom_battmgr: add Xiaomi taoyao support
  arm64: dts: qcom: sm7325-xiaomi-taoyao: switch to device-specific
    pmic-glink compatible

 .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  1 +
 .../boot/dts/qcom/sm7325-xiaomi-taoyao.dts    |  2 +-
 drivers/power/supply/qcom_battmgr.c           | 86 ++++++++++++++++++-
 3 files changed, 84 insertions(+), 5 deletions(-)

-- 
2.53.0

