Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCC83BED47
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847687; cv=none; b=UpBeFdPWV7xoHJICutAOydGWat5cHXo/Xwpd42DwWPdnhvTSq2duGPHLoPekyVgFgvxIQiY5TxzRbbev8V6/2r0F9gFRPkt5QdJZ4tBVmojFPvpujkxzLPgZeTQ+IYqjgGf7N45k7ioAlWs/U8wI7lLmU009OwTDo/H0Rpr3z58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847687; c=relaxed/simple;
	bh=EAmQZRATTdaODOrRvqE7MYwmRWHXiBe7qeDriZj7jEA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hc1DBXFHKmgZKHQ5nlJ1UADMSEhzA+iY2SSrv6M+HuOYzeZQQDH/xfnophFGPM7DP6tPYKR2B/yU5+KZn3LE6e4hiMH8XHDCLjVAtbf7+/tMygbDgV7Tn5MjKGs+jLhHaypWGfEpomCXFjsUxI6INPWZcz1jWMzbPhP4Hr3RdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rOzxs3pu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOzxs3pu"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8f97c626aaso147882766b.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773847679; x=1774452479; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1/n8hfafo3jEdh+I7U3FlFU+S14ha9GjdZSLZ73puJg=;
        b=rOzxs3puklv1fejRmxRz1361LbyLRXLHAuJRCQqdwjiMZNKm1C5nYOdl81YqRpF2IV
         cMh6EE6R3NQS/rRVCa001IrPBSiyYSXHRt3Ke624S3OLQXBzngUmYyum16a+8+BdAbNM
         E619QEEFs5VBrSOViChHt+FNdFF8FdxWKwaoeeAAqcnHLX991PUOWY48NNza7DVW2icX
         O7l7w3x5E/KVFYRR+Vcf0NmsnhHEAb3r18TY6MVBC6adZzyZzzo94bQktjb6fEFsn+8n
         xQS9NfjK7rxn4YLVUFn65x7NeGX+KOsTZ8DIHyD1rF5khoZqE1Mj23xDk2BS4W4/9QbG
         cYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847679; x=1774452479;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/n8hfafo3jEdh+I7U3FlFU+S14ha9GjdZSLZ73puJg=;
        b=VCIJNdG1gJBpYazjLdug/PNkG+0lPmu4WBb2Ybi54bioHmSxVIo3BQEWP0vkJfn1+e
         3HpY209/QOIihFpjSGlVvH5Fd9Wx7C/5mG5lUd6ct3Jbz7XeZEV+oJlDdZ1eV11u0VAC
         gtFrSSgoSxwRk0YkjSJraHxklqmE2vA41bUKc8s3NxnfPlAMd7/uSmcKtx8E0Z//F/Io
         hF2+3aC7MmsO21JfyJC8AYnbH5ES1rsMautg8r2VdJSx9DZ/jLJ3EktzjDlr/JBsboV3
         cE6TfaWR8DmXmweZCd1de/6qGcRZio2e12AWA27UIi9ySy2FEdJqnKjLUf9WNqjxXqdA
         Rotw==
X-Forwarded-Encrypted: i=1; AJvYcCWZEB3nF4afi4LnoaDHgknrdlV2gB++l4qtITxui8hKdop7afx6M9lbmkNij3XCIVQTsfbqOw/D4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRMwAgIo+noybgQg0LWoXd7Qg7+RkC6Xv2+3eFVIiipUz2QxPK
	8GGJB0G6fXGYd+rqMjNs2shBumb8chyCb8hu7/pQSHSiWFi7eCcXwX6t9NzUjNOyRFM=
X-Gm-Gg: ATEYQzz2nyOjbLZirXYn3BzogjeBGXc4nEpVgQA0OeWs5mGqZ2TRxCb3Q/GU510C5WU
	c5EZ0wgzwHjC+xQh1UxpAobq6s/NPqvmZvK43ZDPC2fzcLkNFyNjyyi1ygwerfzoVZccoyIet+I
	8n5YPPwtmbLl1NYTppnF8Sg4L+Axt18vTC92Qi/DLmO0yG1wWE9EgdcIRB7ivDKdNOQApfb8SqM
	5vJpW4RhK899J1LIM06DRvGNraXGiVNZKxnzvAINrFN9IFyzCFpVVgQrA8YR0CEGuDgxgNcQaA5
	BepQtkLX/MMt/cZ1OJaSXb829s+crQbkTCJCPBHd4KkuNtKEFbB1ywWQ1jY2AXC19+1JwgDqLWd
	EZ1PwlCI2ubFMeh7XQBSsel6T394Ieaxtgg1Nf7lZQvr9s/z0VIw0LWlQbUXMewmwDjiqwkO7+7
	s8fXfTALoeeap+aLsrI+vflORYaVsm29xiGCqh18/dIfIpx6zIOu/WK5x6SHH8MVx5HGqnZ9kFA
	hcdQj8XpddLaNI=
X-Received: by 2002:a17:907:f218:b0:b96:ef71:49f1 with SMTP id a640c23a62f3a-b97f48ed986mr213030066b.15.1773847678617;
        Wed, 18 Mar 2026 08:27:58 -0700 (PDT)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f173a3e3sm226989566b.61.2026.03.18.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:27:58 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v8 00/10] pmdomain: samsung: add support for Google GS101
Date: Wed, 18 Mar 2026 15:27:45 +0000
Message-Id: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHHEumkC/2XPy2rDMBAF0F8JWtdl9Bwrq/5H6UJPR1DsIBfTE
 vzvnQSCFbQRXDHnDnNja6olrex8urGatrKWZaYwvp1YuLh5SkOJlJkAoTkAH6aV03uNQ1QxWIw
 IblSMxq815fL7qPr8onwp689S/x7NG7//PkvMUbLxAYYMwUMAnhz6j+8yu7q8L3Vi95ZNtNI2U
 pCUWTkTvXBZ2k7KRvJ2pySJXgJalNYk7KR6SgNcjI1UJINP6KN2Cgx0Uh9SgG6kJpliUjZEr9G
 ZTppDyhdpSI7BWy0DdyhkJ7GV7Z1IEmTGgNZo7/SL3Pf9Hz3ALtX9AQAA
X-Change-ID: 20251001-gs101-pd-d4dc97d70a84
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3

Hi,

This series adds support for the power domains on Google GS101.

There are a few differences compared to SoCs already supported by this
driver:
* register access does not work via plain ioremap() / readl() /
  writel().
  Instead, the regmap created by the PMU driver must be used (which
  uses Arm SMCC calls under the hood).
* DTZPC: a call needs to be made before and after power domain off/on,
  to inform the EL3 firmware of the request.
* power domains can and are fed by a regulator rail and therefore
  regulator control needed be implemented.

Bullet points 2 and 3 are new since version 4 of this series, and
related changes are in patches 1, 2, 9, and 10. I can merge patch 9
(SMC call) into the gs101 patch (patch 7) if preferred, but for now I
kept them independent to make it easier to see changes compared to
previous versions of this series, and because patch 9 actually applies
to not only gs101, but to many newer Exynos SoCs, and to make patches 9
and 10 themselves easier to review and reason about.

The DT update to add the new required properties on gs101 will be
posted separately.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v8:
- correct use of ranges (patches 4 && 7) (Rob)
- add missing \n in some of the new log messages (patches 5 && 10)
- Link to v7: https://lore.kernel.org/r/20260306-gs101-pd-v7-0-03f7c7965ba5@linaro.org

Changes in v7:
- really be consistent with quoting (Krzysztof, patch 4)
- drop invalid tested-by tag (Krzysztof, patch 3 & 4)
- Link to v6: https://lore.kernel.org/r/20260305-gs101-pd-v6-0-8cb953c1a723@linaro.org

Changes in v6:
- collect tags
- patch 4: update commit message footer to clarify that while
  old/existing DT are now incomplete, they'll be updated once binding
  is accepted.
- Link to v5: https://lore.kernel.org/r/20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org

Changes in v5:
- add domain-supply to binding (patch 2)
- Link to v4: https://lore.kernel.org/r/20260128-gs101-pd-v4-0-cbe7bd5a4060@linaro.org

Changes in v4:
- drop unneeded or already merged patches
- drop patch "pmdomain: samsung: convert to regmap_read_poll_timeout()"
  as Marek reported issues on some platforms
- rebase
- DTZPC related changes
- Link to v3: https://lore.kernel.org/r/20251016-gs101-pd-v3-0-7b30797396e7@linaro.org

Changes in v3:
- use additionalProperties, not unevaluatedProperties in patch 2
- fix path in $id in patch 2 (Rob)
- drop comment around 'select' in patch 2 (Rob)
- collect tags
- Link to v2: https://lore.kernel.org/r/20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org

Changes in v2:
- Krzysztof:
  - move google,gs101-pmu binding into separate file
  - mark devm_kstrdup_const() patch as fix
  - use bool for need_early_sync_state
  - merge patches 8 and 10 from v1 series into one patch
- collect tags
- Link to v1: https://lore.kernel.org/r/20251006-gs101-pd-v1-0-f0cb0c01ea7b@linaro.org

---
André Draszik (10):
      dt-bindings: soc: google: add google,gs101-dtzpc
      dt-bindings: power: samsung: add google,gs101-pd
      dt-bindings: soc: samsung: exynos-pmu: move gs101-pmu into separate binding
      dt-bindings: soc: google: gs101-pmu: allow power domains as children
      pmdomain: samsung: convert to using regmap
      pmdomain: samsung: don't hard-code offset for registers to 0 and 4
      pmdomain: samsung: add support for google,gs101-pd
      pmdomain: samsung: use dev_err() instead of pr_err()
      pmdomain: samsung: implement SMC to save / restore TZ config
      pmdomain: samsung: implement domain-supply regulator

 .../devicetree/bindings/power/pd-samsung.yaml      |  33 ++-
 .../bindings/soc/google/google,gs101-dtzpc.yaml    |  42 ++++
 .../bindings/soc/google/google,gs101-pmu.yaml      |  97 ++++++++
 .../bindings/soc/samsung/exynos-pmu.yaml           |  20 --
 MAINTAINERS                                        |   2 +
 drivers/pmdomain/samsung/exynos-pm-domains.c       | 262 +++++++++++++++++++--
 6 files changed, 407 insertions(+), 49 deletions(-)
---
base-commit: 5c9e55fecf9365890c64f14761a80f9413a3b1d1
change-id: 20251001-gs101-pd-d4dc97d70a84

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

