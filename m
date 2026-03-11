Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8981B31714A
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188391; cv=none; b=hko5FePK098wbJWpwfyoHV1Bbzo5Z3QJ8KsbCWZP61jzBXaoNF2Ie00U4CmM81KLyWyVgZnGdvb94LsTjXcroxIjGjcxYQo4lMs/ZthbE4td1fFMVUygnkmK5kKxkFLsLUeQOWcTWQTqcPEwb8AWDoiid6TS1tCZvBBy340fYdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188391; c=relaxed/simple;
	bh=6Ortp2qq9rULdDJuVn66N0Ei8iDpZMGkkqjcAu1CgyQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lzAunAPhmWBzcjfnwzDGfYV+EJahOZAzYQXpGPyfw/2de8lKb3HPOcCON2QmybdXz1nfrrxBGxRxBHgsve+1fWZNXihcWcR06pVnz+qS30RUfC8WsGIzusd9U2DU1TzroguJZW5U9rgstiYReT6HXzNwTR5coiaHnKpTU5CIEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=owUGBEXJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="owUGBEXJ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae82df847bso31367185ad.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 17:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773188388; x=1773793188; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4gbKDbPXbOL00FNYZLFnwugvEIUZemApaFjbSsjN8o=;
        b=owUGBEXJqZcL0qqkMwBpibLyCafIpP+U4nu9A6qeI/SL625HZ7fpiQDyrJq1IMuRRZ
         DGJDaxHZ07FjDmwZ7XFnZ7UVKJXpCzd5hfXJIzc8rdcIdWWlf+bTmOIYzPvGVt1riOSZ
         Yg20/uL3JXH/6LWwdVHqFsPwPI7DhzyciXmQACbSFdMUIWDj3NcIBoodDdWcPXH7UlTp
         gETzpVUp6yw2TVpV6soCpfGf6JKc+IYpadNWtY5Q25TaLNstN0/m1BlvfdSJblhz98Le
         o9quglNuwznvhzfoo39WfvJUxrCkwr6V5vH+TpC83d3Vvvi7ox39n11LkC1197+3Z2Wh
         j9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773188388; x=1773793188;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4gbKDbPXbOL00FNYZLFnwugvEIUZemApaFjbSsjN8o=;
        b=LpikbuLhAdcmqJiMq1um2KweOp6qBs6veM9peNSP1jOIQLPAEb1sp7h4D7PDHAlCjg
         RH5+xixG3csXVf30kLsqO+y5rBsOI3oPSdwsWYjoVk5SfLBwDRgghwHipFAHEBmbA+gg
         c8spjI1/i6vyTEE7IDGHGcZqFY+CBUZB7BuJ4mW5ZuU7DOUFDDJolDf+h4FF9VhKne62
         qWELPiiUwaCB2rvpz9jC33bRaloLzjSz347H+0TOBcNCdx7SZVemkOMYPT/JQco3pWpo
         ingOOR+W8prPGH4hT+B0BaLrw82/g45BhWcmPeTYuA2GllqPHftnPjolPwrif4dfhvad
         XRiw==
X-Forwarded-Encrypted: i=1; AJvYcCVU/Hn5jZFEoIJB9mUHm1F8VwJguDGBj3qaT6kV5kOYdPPCmUAkCvXq37eAG8106NB6Ca+mrULlkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhzn+RTg0kBi0oEkg99dXxe0/MY1/4Ldamw287eUQ7+dg/wuOD
	KZ7m3AamkFGPVNso/lQrmOkFP3e0gtaLjVuzXASORzoc/crDK5ueTorr1tAEW1v3COg=
X-Gm-Gg: ATEYQzzibo5mZC3KY4BA3nEI4+Kn8lMK5Zwxtgbpy6oaSKxo6boB4FRiZIftWHuOQPo
	JmLgbiXuNBCNp+NAxgRz34dpv/qvoPC7O5efP6Q8eaN+v/iDLi83qCD3ZQxLobwufJTSxWLuIdf
	GwTbxKDzbG4+2Rk1m+kVmOqIwH2w1RiVLt8VQuSIc8KOZMXP+zCXsmUm9Er2G182sXKPq5WLnkQ
	JSab6xhTMO/9LzmT7GaDlNEm1A5gId/vhsHa6OwopnG/kLlwlSTa+Y4q866Ngj/ltyU6DNjG4Zn
	T+BAtP0gtPQklvRO+l+LM5q7NxzlT1/rGFqVKFx8TqDj+O9CLa4X1NumM6hDun5ipi+Dlybyl/m
	8TRGohadUOwInpRoBNJKUHbs3N0U0hKq/fJDgLS4HtpEkOBYGDLc7Iup3UKLIuG5CNHgEvSAZt7
	v3OWiU2ETzxZ58pTdBD2AegrcKfgMBMuc=
X-Received: by 2002:a17:903:1249:b0:2ae:4409:5993 with SMTP id d9443c01a7336-2aeae90f919mr5730215ad.55.1773188387884;
        Tue, 10 Mar 2026 17:19:47 -0700 (PDT)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae361a00sm4023795ad.76.2026.03.10.17.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:19:47 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Subject: [PATCH 0/3] pmdomain: core: add support for domain hierarchies in
 DT
Date: Tue, 10 Mar 2026 17:19:22 -0700
Message-Id: <20260310-topic-lpm-pmdomain-child-ids-v1-0-5361687a18ff@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAq1sGkC/y2NQQ6CMBAAv0L27JoWBAxfMRxKu8oaSmtbiAnh7
 1bxOMlkZoNIgSlCV2wQaOXIbs4gTwXoUc0PQjaZoRRlIyopMDnPGidv0VvjrOIZ9ciTyV5Eqkz
 dKqpbcRGQEz7Qnd+//K0/OC7Dk3T6Nv9GoNeSv+nQYFCRUDtrOXXF2pzlFfp9/wAeN1H/qQAAA
 A==
X-Change-ID: 20260310-topic-lpm-pmdomain-child-ids-e3d57ae57040
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev-53144
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=6Ortp2qq9rULdDJuVn66N0Ei8iDpZMGkkqjcAu1CgyQ=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBpsLUiM05+PR9pR5YLqjfw9+cFI+c5ucZfyQF5p
 p+lPCd72oaJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCabC1IgAKCRBZNxia0/vG
 ZS1oD/4x2mqWfLt1MAFIqsfziojPD3xLYTRrYeJyPAT3KCbqlFVTfIM+6+Xy4IJrB8w0JvadZR0
 Vqwd0ukODb2BJo3AIFTiw1NAQQG9yXNSq0JTbohmEXaEEa9Q2Do0neOaeaxUnwQ1nkhPg8X9zjM
 SW0or1GABD/q4bR1HWDcgAGynbTiQbnB/tsR1jd9IfrMUjI7rQ5UyA2CMq5oLFTXOIgd1d0rsQy
 NjIftYUFNHL7g4oUTLAg6IKrM5CiAm7V4STroOqyR3E5t4hA+nIswqoi0+epBeG9Eg5vBl/o8XX
 csibD+sW0GefgcHfAMU+EjMu6xq9d53fC5uFJMU6Mfku88ZudHWiO85hCh7K7l5d+pSzhFPQ+PO
 uV4mV7CjNqF5optte9B61Vi/2007ep6sLMtbz4VA314IDmWbVH+FECnpGdkLkuc1n3kku7GuZQO
 nlH6RC32zOzjyfxFmSv4zXGqA4w98NnMNgnkggXxxYmSUn3Ez92baszynk+FtzTweDCB+2sBsKG
 Z0K3qET3l8OOjN4aiG4XhBxDe1Znz1hk2cuyCE4yMoSI5uruPY9/XFiAdNWZ5n0h4SLV8Gl1LRH
 OYxbcRqvAoCydhb/2iMn2ne+cqQYc8+VSVuzV0K6Gp+YaqeMiVonRB1ga4RgtmoOa3EIQOJRYOv
 1qnWae3pQguJVSg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Currently, PM domains can only support hierarchy for simple
providers (e.g. ones with #power-domain-cells = 0).

Add support for oncell providers as well by adding a new property
`power-domains-child-ids` to describe the parent/child relationship.

This idea was previously discussed on the arm-scmi mailing list[1]
where this approach was proposed by Ulf, and then an initial RFC[2]
implementation was made.  From there, it was suggested by Rob[3] to
use a nexus node map instead, which led to several more versions
attempting to implement that, culminating in v5[4], where Rob and
Geert then had second thoughts about the power-domain-map approach.

Therefore, I've gone back to the approach in the initial RFC[2] to use
the child-ids approach.

Changes compared to initial RFC[2]
- dropped RFC
- rewrote the parse/add function to use iterators/helpers from of.h
- add a remove function for cleanup
- use child domain language instead of subdomain

[1] https://lore.kernel.org/arm-scmi/CAPDyKFo_P129sVirHHYjOQT+QUmpymcRJme9obzKJeRgO7B-1A@mail.gmail.com/
[2] https://lore.kernel.org/all/20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com/
[3] https://lore.kernel.org/all/20250528203532.GA704342-robh@kernel.org/
[4] https://lore.kernel.org/r/20260122-pmdomain-hierarchy-onecell-v5-0-76855ec856bd@baylibre.com

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
Kevin Hilman (TI) (3):
      dt-bindings: power: Add power-domains-child-ids property
      pmdomain: core: add support for power-domains-child-ids
      pmdomain: arm_scmi: add support for domain hierarchies

 Documentation/devicetree/bindings/power/power-domain.yaml |  35 ++++++++++++++++++++++++++++++++++
 drivers/pmdomain/arm/scmi_pm_domain.c                     |  14 +++++++++++++-
 drivers/pmdomain/core.c                                   | 169 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h                                 |  16 ++++++++++++++++
 4 files changed, 233 insertions(+), 1 deletion(-)
---
base-commit: f7b88edb52c8dd01b7e576390d658ae6eef0e134
change-id: 20260310-topic-lpm-pmdomain-child-ids-e3d57ae57040

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>

