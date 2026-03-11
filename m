Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955D3D9035
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230183; cv=none; b=rD3pfdAxAlLqLKed7PteDFIjDbIuKtxjf21vKLh5yWUU3N+r7Tex5e2n+qpPtEjETOGmTMi3j4Nbuuv2Z4wRmp9rSIhXFZ88gfpv85/2reV2XAzyDexjIJ6KZTAP4EFD8ZeqTxI13FNLUXF4Nlzqlf0QgTD041xQcNDqEuoqogE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230183; c=relaxed/simple;
	bh=x5H+Ty35z/JQ0YvCd3YuUitbcY1C+rVXjfO5WNFbeIo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ktdo5q4FXvfIxq0gZ1l86jrLShKViTqIJ1eoemmq09L/Ih9skEUA2ZNq5MedmwkUeAvZJyhCnIKDpny++QLowR1kPesa/r1e0liEOqlRfBsMr59DbKi4EL9560hA4M1sw5uk9Dl8nV8m6gCXJSmtd9axTXeRsnih8NvYP8L3m7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=1sdouiJE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="1sdouiJE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so31063565e9.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773230179; x=1773834979; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x1Cht8uRSf2FyMM2VofwaPUErjVTJDATYO+ETNMehnE=;
        b=1sdouiJE1eKBSrVKSE48EIViGrek6TmeSJC6W+4e/TarbFJDlrdt4RaeIQOgIqFHlm
         WzIustyfC6xg4ve8R1qYcWprncv2nXy6CF+uVT6s97hMfejyyofkuK0UnlQbiXo0NbgS
         PG6Bjzwty4NUU+CwsjV/qrXchlgINrGgTyW3Kml/kjMRnKkX+ZnZEuxZ0MWnqvt2OpNB
         R3G0XonVw75WMZeL48EdtuXlGKNWjlZZzSPIVBH0lM+X2HAxwBMeUH6Ism3ipzZhKJB6
         rbmeRW/H3W2b/VeA2xV0KChZ4cQSdrm3LW4E0SVZzmY9JjU/JD3oskYuyrW9Y/Y4nlKx
         vYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230179; x=1773834979;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1Cht8uRSf2FyMM2VofwaPUErjVTJDATYO+ETNMehnE=;
        b=nrt6EF5c73wbQxUx+ATdJ5ylIeuw3iLKSFit4C8iHFB3ri/xjdiqfw6hDgQSCJEtdB
         mCouw8FmNBS3AkJRKlSd4WPnMFqYfcOPcsBBvnW9A4lUbo+PqVrfohz9nUFBj7KCJyu+
         2ziJBa+3sAMHjvZuNIcvwO7270mUEUxfKZzU5nkoTW7h88DDzviAZtpVS1TIseN/36La
         CYF2uRVCtKuKe6qdKsAYI5FgUId5s4E/oQV8StNlHPr0DHlO17gYtO/b6una77TEIeA7
         PQYdri5t8LC7tAHSYWIEdTC1nnM9qBRvCwFamcB+0y/HDIGvjFGTX+1tiDm2Z/ufmGDh
         OL9A==
X-Forwarded-Encrypted: i=1; AJvYcCWN+nXt63IWwumV3S8s3HmP4z8PjdAOOCh8KZ2c1qeVG/YGVJN7lffs9NkNurBXM46BDB+fF1KkZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1v+exQWzPoYvhObAsN0hpHdGVQR6oMFnesal0imZ/o7AZ0xKE
	6H4gD7Urp0SEhYClPtxlsroU/SCM8FtI2XVOwxYiLyIePo0GfFJ7S5grkowBS4bSSHE=
X-Gm-Gg: ATEYQzw5Q1OTTNYYxL8fUqKPlhRghOUYaMZ0U1GXP+bJiklbzDRvJ9Xj2jwAbOaTKAj
	Qo8YY91uf1OfHr2az07nPqarlFH8k56aWd/Qa73Q/Mc7CObsJxh4AMk9oizJmeklKbln3tg5SEJ
	LQpdqJ2AVPYgRf2L66AVsGRBHiQSLuA+8D7Ayp6jYUl6USV+z4cvVbmj82KjuBKybHiJ3nHozUQ
	GFAYYBCfn5wZwYN3kPDvgFqsUP29AduNpUkrcOJcR1mFItTPkVUYzva4HmBxF4uVAlZdyCzhnBp
	/+MgBOjigrx9aJ9cX2B6zG6HM2dkIs6092bKJ9oelP+S1EQb613HVaCiXtUOBSWViZEvxrI1MsV
	C5+zqtjN0s/Q+zbw48b5EZMaLnummQHMSs+cgml6KnsIqBFnKrVE1sPrm5nzvpyXY/BlbNcxGdD
	DcWBqvZxQLUJ4EkFelkyn9g/SMtw/pSEbW+mwlHFJ1sX1zAZVnX4c59p0F3vZOY7ve/o/P2RSuK
	tfMLg==
X-Received: by 2002:a05:600c:314e:b0:485:3e00:9452 with SMTP id 5b1f17b1804b1-4854b10f5cbmr41854135e9.24.1773230179285;
        Wed, 11 Mar 2026 04:56:19 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm39586485e9.1.2026.03.11.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:56:18 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v4 00/11] Add support for the TI BQ25792 battery charger
Date: Wed, 11 Mar 2026 15:56:13 +0400
Message-Id: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF1YsWkC/2XOTQ6CMBCG4auQrq0ZZugIrryHccHPIE0MYEuIh
 nB3CxswLL9JnzedlBdnxatrNCkno/W2a8NITpEqm7x9irZV2AoBGQhIF280lww1xIR5mXKacKX
 C695JbT9r6f4Iu7F+6Nx3DY/xcj02xliDFhYjAESJSW/1y/a9uHMrg1oqI+4lbzJ8QLPJDCZZx
 cL1UdJOxrBJChKwTgUJK6biX87z/AOmK6RgFAEAAA==
X-Change-ID: 20260303-bq25792-0132ac86846d
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3497; i=alchark@flipper.net;
 h=from:subject:message-id; bh=x5H+Ty35z/JQ0YvCd3YuUitbcY1C+rVXjfO5WNFbeIo=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRujEjqfM3wiP3Fxf09MWLbZrH+WfnldYrMpaIdvufUQ
 xzmWLOqdExkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDVvayMDB3aJtejja8dttf36vbQkFqkfWN2hfTOqUUWWfvyjFj2BjD8r/8ZumV
 Kh6tT7w+71oUfhM3W/DsvtfDlnO7/bI+2zDn0jBsA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

This adds support for the TI BQ25792 battery charger, which is similar in
overall logic to the BQ25703A, but has a different register layout and
slightly different lower-level programming logic.

The series is organized as follows:
- Patch 1 adds the new variant to the existing DT binding, including the
  changes in electrical characteristics
- Patches 2-4 are minor cleanups to the existing BQ25703A OTG regulator
  driver, slimming down the code and making it more reusable for the new
  BQ25792 variant
- Patch 5 is a logical fix to the BQ25703A clamping logic for VSYSMIN
  (this is a standalone fix which can be applied independently and may be
  backported to stable)
- Patches 6-8 are slight refactoring of the existing BQ25703A charger
  driver to make it more reusable for the new BQ25792 variant
- Patch 9 adds platform data to distinguish between the two variants in
  the parent MFD driver, and binds it to the new compatible string
- Patches 10-11 add variant-specific code to support the new BQ25792
  variant in the regulator part and the charger part respectively,
  selected by the platform data added in patch 9

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v4:
- Avoid additional data structures and pass 'type' within the existing
  struct bq257xx_device instead (Lee Jones)
- Move comments for new struct fields to the patches where those fields
  are added (Sebastian Reichel)
- Collect tags from Sebastian Reichel (thanks!)
- Link to v3: https://lore.kernel.org/r/20260310-bq25792-v3-0-02f8e232d63b@flipper.net

Changes in v3:
- Move MFD cell definitions back out of the probe function (Lee Jones)
- Collect tags from Mark Brown, Krzysztof Kozlowski and Chris Morgan (thanks!)
- Enable ship FET functionality at init for BQ25792
- Link to v2: https://lore.kernel.org/r/20260306-bq25792-v2-0-6595249d6e6f@flipper.net

Changes in v2:
- Fix an error in DT schema (thanks Rob's bot)
- Ensure the broadest constraints for all variants remain in the common
  part of the schema, per writing-schema doc (thanks Krzysztof)
- Link to v1: https://lore.kernel.org/r/20260303-bq25792-v1-0-e6e5e0033458@flipper.net

---
Alexey Charkov (11):
      dt-bindings: mfd: ti,bq25703a: Expand to include BQ25792
      regulator: bq257xx: Remove reference to the parent MFD's dev
      regulator: bq257xx: Drop the regulator_dev from the driver data
      regulator: bq257xx: Make OTG enable GPIO really optional
      power: supply: bq257xx: Fix VSYSMIN clamping logic
      power: supply: bq257xx: Make the default current limit a per-chip attribute
      power: supply: bq257xx: Consistently use indirect get/set helpers
      power: supply: bq257xx: Add fields for 'charging' and 'overvoltage' states
      mfd: bq257xx: Add BQ25792 support
      regulator: bq257xx: Add support for BQ25792
      power: supply: bq257xx: Add support for BQ25792

 .../devicetree/bindings/mfd/ti,bq25703a.yaml       |  73 ++-
 drivers/mfd/bq257xx.c                              |  54 ++-
 drivers/power/supply/bq257xx_charger.c             | 534 ++++++++++++++++++++-
 drivers/regulator/bq257xx-regulator.c              | 121 ++++-
 include/linux/mfd/bq257xx.h                        | 412 ++++++++++++++++
 5 files changed, 1156 insertions(+), 38 deletions(-)
---
base-commit: 343f51842f4ed7143872f3aa116a214a5619a4b9
change-id: 20260303-bq25792-0132ac86846d

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>

