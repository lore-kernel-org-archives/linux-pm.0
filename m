Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202485;
	b=uwiwbXGRCA3aqeGu8OVfSUZu5j5sjIgOZsm/9vy+OqEAjPda0P5X5SIW7bmZRD/ar50N
	 k2Pa1AUfQSXfxNUK/aLzTqSfEs5XVi5moNHhhW4iUNAldLV6dYb2vHJtDruO/gOnPEiRt
	 /FuYC43AErhgTTkALpwgLY7Lu2QC5cgaNdrJtFEygcMk4bSvBpyAM1mwVOOx9wmH6BP+y
	 ZjdixKG31m510gXsngJ09oUO3sDq8iZjPPEjKUDV0aUkMwMy3rGqkwbYQdhKbmgMSspq8
	 1OFAoarxb3wobiqWyBN7YLlwiDngABTBUV32lVH+O6XCCQIOpr75gWl7ArmC/Yy7BoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=M1PD8j6SB5PHO7xYIjTJBlDsua4DeMv0pZZa5raCSBY=;
	b=n+ZYSKYhOY3V7S/7bMHmiQFpsob4ejwTn+Dma41zvrRLByAHspq6JhCsscGpvrTzuIom
	 g6X2gvioCOmJR/yYdHTJ/LlPeZqCZqwe1mG7suZQmhK/Amh1UmXHz6a44TABKdmneF5Rq
	 iztgC2yeaszo8JKJGui5TX9e1BMu/Rlkx7T7ZRnUqcvyFl/M9mKfYt6Qg/SU1YBJf2BZm
	 EULm25AoYZF+mYvvphk+1iDkUtRTqlA6QFTT6VFwOHzvyoNXES/tbKU6S359RnIwCfVFL
	 3ff0sv3P4YH0/VtwBbRgBLZXCVOZ4QjgW1LKfDp/D3UWvKUNjN9Y+jCeABGRlAKdJDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T4tOW19Y;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B7E606A6DD
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 19:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B7E606A6DD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T4tOW19Y
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49412eb1474so791739f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 11:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202478; x=1795807278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1PD8j6SB5PHO7xYIjTJBlDsua4DeMv0pZZa5raCSBY=;
        b=T4tOW19YElmKFmop88otDRY1CZI7u/lkEIa3fMEFjJzWQzTGjqw17kwgJIVQmp+EF9
         izrrQM2EPFvaHM79PkUa5NLr+JSNnW3RcK03ZaSbJRrpW0H2+TYImcr+D8tqbkyRbtFg
         L4YgpZ87M/hvaSDxvM5ed4s3VVOt20i9CD1t7kl4GK2nB/uVqdiMNCH0vPXFti4o2Z+b
         4xvZgit33WpJ7mjUQq9QmMfEFIYyYKZX89q2qaEAdRcoN7LcMci+E1Jlgd3vWQ7zHqCq
         vWf/3uhvsKaT7z+wxaVFalLkGVlL5e8Yu0GXNq9vIZWakTd+ZbeD6iOp1Rgc/l/y46pv
         YfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202478; x=1795807278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1PD8j6SB5PHO7xYIjTJBlDsua4DeMv0pZZa5raCSBY=;
        b=2t+7HY9TsSIY9k5iWvMpsyyheMpkWIh/odBjtgmD/FBSX4m89iP+HZ6CxXJ7y8XTMC
         ycLZn2Fgfu14sN13cza9nSiFdMAAKFShgNY8QW/pWmY3ReyknHFU8mekgLzKpPfv3ood
         IFeCBUSG8trZ2fwAKZiZ55x7OtAhqJreg8xFss9JXkv/xMDtrx7OnFsbOvsG/ON6Kk4v
         byt1ZN6f3Yu3T2RRF8SCwiRbMZEzsnE6d9YRyxvWw81U6iOAnNnD7xmsLstdvXhJ4EGB
         xaahiJjjF2LeB+8PA32Quw6Uuk3AVkGKTPuAsh/dUp91QqvWov4gKCtJBVPVCg9T3E7/
         3YBg==
X-Forwarded-Encrypted: i=1; AL+hErEnrnQsQ6rxnfIjdxzzjYhqoRMi81MD9ByX0pk1hsbw81HcVmKlR7piTKIEF4f6bbhYveqtO2qN2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ndr1B2m7NL06vny/Yu7pi8mcFNHCGr3Rd6Y9t5w/5Pg6ikyre
	IrD0CwsSmcAD5aynMInBLK8rOytjuoOwYIkWhNngz3Y3C7nbxSDIQNPY
X-Gm-Gg: AZFdTZcUbVjMUerYc2TfudTFRQjcaw9RbyentAds9PzHsxLkd9Xur8nubqTxx+mBfuE
	ZASKITKpQe4FEtQ6QrPY4YmndPObKXrsjNab67XrddzlyNG1R+jF4E0y1f9pQx7Bf4QI480iNZl
	KNRFnrsPh4+NHFOjg6V0rPEVowPhNpeOOH5aeC/J34/KKXqviAwCYhVDmzb0eaCMjVr1gW7nm9e
	3FteFMZdDawRkFYqnMe2EjGvZlh+KkXbdPC7CADLuRJZSlIi4sET405s8N+L8tUrrWekfcibi9Z
	fo3HoaH6eOcHDYCuRrkZ+jchHLO7+C0MsAbTuDb4VVaXrde8iweO5otpgJfrdbBWHWdIhjA0z1l
	n758+Kct079P+txjKR5uh4S9yfoLWyFYYN4nhb3M5e+QiXOZl5yW0LTkIjWLRCvCN9hCO3ImrpK
	+28UMYy5pszlwE/oZC6IgvMqj+B77IlhzYSkuuSYV7V+PNuMflHdjYSNa0wTaGMN/aH+B7kSYTn
	dAPr2HmXoNBrPozOdPvG6vEEIfRJm187dIzCg7+9b7RdddXiUTQng9OCYaPZL4MmH5XOlyX2tmB
	kL1IaJ89uPCY57KZ0U+yZo4a+066fgZa00aderitJoyigG/BEL2igqd27A3Dpg==
X-Received: by 2002:adf:e014:0:20b0:4a4:ee9f:a3d9 with SMTP id ffacd0b85a97d-4abb3d2c028mr6479804f8f.16.1795202477805;
        Fri, 20 Nov 2026 11:21:17 -0800 (PST)
Received: from [192.168.0.2] ([197.250.160.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm8405703f8f.21.2026.11.20.11.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:21:16 -0800 (PST)
From: =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>
Date: Fri, 20 Nov 2026 22:20:51 +0300
Subject: [PATCH 2/6] mfd: zx297520v3: Add socsys to the mfd host driver
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261120-zx29usb-v1-2-b0433258e51b@gmail.com>
References: <20261120-zx29usb-v1-0-b0433258e51b@gmail.com>
In-Reply-To: <20261120-zx29usb-v1-0-b0433258e51b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Stefan_D=C3=B6singer?= <stefandoesinger@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Lee Jones <lee@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Agustin Santiago Isasmendi <isasmendi.agus@gmail.com>, 
 Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-phy@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235;
 i=stefandoesinger@gmail.com; h=from:subject:message-id;
 bh=haBO5T9O8DxAeLkHhQl6vHvSOM2ApNjiaO+2we2t8aM=;
 b=owEBiQJ2/ZANAwAIAT0TvMhUTxoiAcsmYgBrAJ2WR3OKSSthkwM8w2YGowPMIiV8WT0ADPYEg
 gyX3RTbznaJAk8EAAEIADkWIQRDFvS2qgVbJ5UyXWw9E7zIVE8aIgUCawCdlhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQPRO8yFRPGiJkcA/8CdzFthVu8Y5p4obuulOSnPPIeLQWVnC
 UpCUT/7T/s39YYU9rQ4pkMeAqBP7ctNWI21AIp9weT6VcqwQYN5x4QtRqXyFUSYTWQh1UnuZzO/
 uGObg2YzD/iK1GSAHk+30Ia3CYmsHJ7m9KuqJ9V6Mt7NNwSiaUTUKbFnk3FVauzrAYWxtpPnzyD
 d1zZ6BANKQVtMIQZQitU5JruOEKaTAqI1iKobUI8TnrqBXgFVzPxvF1Ik5skRlkWGkcYmxp7lhT
 U4nsJy9P/R0FT1hkJdo4AGdrDTkMjHKOh28vHZTGjwwlAePl7Zbt5PzvmiVIIrsBKDAVvbtx9+x
 veAk1nCXL8il4O1ssjB8MBk3Y47cNzVLeV/eZAYSHXacsk2RGACAL4QciW9wPRMS2g9KPy7p/gR
 83CGrOjaPU2i1O+GQq7VhXn9WXWTreWgQGYpPus75EeoBmZJfbtkQw46XMHxMB/0tpuAp3Gwujh
 5d+56Qd4I6w+xqBvuQAJHBCOlGbKKilro5h9H+P+lcy/DvSCQBcqpsm+V+c249lxUykPTWYbMRc
 SGVEQv0O/w42BhSCtahVA2SwKuD7dzvxDl8DL2+OeVCJt8sRgY2To86kbvtoabvrprLodxo8L+0
 ZLJqtiSbQRMUSLLn3do8j1mpqqou+WNLFwjlh/1DQcrHo23Mh454=
X-Developer-Key: i=stefandoesinger@gmail.com; a=openpgp;
 fpr=4F9C2C8728019633893EBBB98CB81F9A72BBA155

This patch adds the parts of the zx297520v3 socsys controller, that can
be exposed via established driver APIs to the MFD host driver, so that
drivers in the respective subsystems can consume them. For now these are
a reset controller for Ethernet and maybe more, and a power domain
controller for USB, GSM and possibly a cryptographic engine.

Signed-off-by: Stefan Dösinger <stefandoesinger@gmail.com>

---

This series does not contain a driver for the reset child, as
implementing Ethernet is beyond the scope of the series and needs other
prerequisites (namely pincontrol).
---
 drivers/mfd/zte-zx297520v3-crm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/zte-zx297520v3-crm.c b/drivers/mfd/zte-zx297520v3-crm.c
index 7c29a860be3f..3d542e3dd7b8 100644
--- a/drivers/mfd/zte-zx297520v3-crm.c
+++ b/drivers/mfd/zte-zx297520v3-crm.c
@@ -23,6 +23,7 @@ enum zx_device_type {
 	TYPE_TOPCRM,
 	TYPE_MATRIXCRM,
 	TYPE_LSPCRM,
+	TYPE_SOCSYS,
 };
 
 static const struct mfd_cell zx297520v3_topcrm_cells[] = {
@@ -42,6 +43,11 @@ static const struct mfd_cell zx297520v3_lspcrm_cells[] = {
 	MFD_CELL_NAME("zx297520v3-lspreset"),
 };
 
+static const struct mfd_cell zx297520v3_socsys_cells[] = {
+	MFD_CELL_NAME("zx297520v3-socsys-reset"),
+	MFD_CELL_NAME("zx297520v3-socsys-power"),
+};
+
 static int zx297520v3_crm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -77,6 +83,11 @@ static int zx297520v3_crm_probe(struct platform_device *pdev)
 					     "Failed to deassert reset control\n");
 		break;
 
+	case TYPE_SOCSYS:
+		cells = zx297520v3_socsys_cells;
+		num_cells = ARRAY_SIZE(zx297520v3_socsys_cells);
+		break;
+
 	default:
 		return -ENODEV;
 	}
@@ -88,6 +99,7 @@ static const struct of_device_id of_match_zx297520v3_crm[] = {
 	{ .compatible = "zte,zx297520v3-topcrm", .data = (void *)TYPE_TOPCRM },
 	{ .compatible = "zte,zx297520v3-matrixcrm", .data = (void *)TYPE_MATRIXCRM },
 	{ .compatible = "zte,zx297520v3-lspcrm", .data = (void *)TYPE_LSPCRM },
+	{ .compatible = "zte,zx297520v3-socsys", .data = (void *)TYPE_SOCSYS },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, of_match_zx297520v3_crm);

-- 
2.56.1

