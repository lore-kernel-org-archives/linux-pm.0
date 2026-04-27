Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8429B391E50
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276103; cv=none; b=o/ujO19gPk4XGYm7240XftUU7u9yEI98yCxKLnAJmQQ3q80tISOVr7zy4GWaDrwbuzOFXIsPykGxTCWx30RWLgIiJImvyHJJ1YGriWQUMKn4XpAm+KvqU+BFyADaQwRCdsaQOTWU+xKA2UdJaR/vPS1dMzgRlIgAwnI2UmtKpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276103; c=relaxed/simple;
	bh=ifmFZuT2yL65hYWXSntFE3Xxo4d0ZlqISyl1YG9tRuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzSqh3LNVR8BsgOLSGi/026TDNwN32N2OAMPgkarpUIMXW6i+FLwzywUvlWPhIPHHdSJIOO19353KGRBjp4rz0wXAD/30WMryu06s+EV4FmFKgZSveDhTkim2WookmBGE/UZ4LTQwzTudNiKRCxCtZRMj+k7/vkqb53SusK/+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edcsfd8M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edcsfd8M"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891cd41959so81669885e9.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777276100; x=1777880900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0XFTVZm6nDhiD0bMo8SDFHEq9ueglfbqYEb/g+IqfE=;
        b=edcsfd8MjvD65H4SZ7bFHypdIw9UzJZ0AZ3foWn/wGZq5sJBnhDypNljOERj5RgpM2
         beF3os0pQt9sWM8rdEJHwldUSvJi50KQ+0IrOwjvgICkQi72KYKLLw7oTWXIqsxwA329
         ix2d0+PFiVS5+Ngftx4RRgonD3pGWdI3Rdl4G+Xvf+KIvjiY/mCDvUTQOoSX5UPEDtkV
         GiPBrfaKRMa+9O+TE3P4Jj7R7X3q4jly4iQLGjv5BXHrGGr/bBzqiBdeHMqq4l2LHqEO
         wvYD9uc/4gb5zNQbrj6iy2yBa746RXxp2EIDVA6VYVZ8wGiw6Q8rO4+8ByOdPKR3wYTh
         uhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777276100; x=1777880900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0XFTVZm6nDhiD0bMo8SDFHEq9ueglfbqYEb/g+IqfE=;
        b=JSJWUYrtj6FrKe0KYzS3NVL6C82VAeVz2v/csmKZtaWC6fbpjrxW8y3enGVzNdrvGF
         k1CsEDkQ920M4bvY/oPk5y5UZ033SDJwFwA2yowpGu9kKkMMBo64HpWQ2fDUtyPVm0HQ
         WUEMQwMzQgTqiya2vgd86yFW1d4Ju1vBpc53H6BFNbpbGEa0flOErHN7pPrYInyFwRuq
         cB8BPWJpgWfYBUhJB6O+N8nve/YoZItUQq6X1Fg7OxkdDg2T70uY4pQ0IwSIUD7EVQ0H
         9j1EWVkZXOWChhEoHteyLH3/LvYXgWbEOSEhvkDiC96ERZFw0Ra7xcEkp9cgD17o9/rd
         Vk1A==
X-Forwarded-Encrypted: i=1; AFNElJ//sFlFqFmmpbBoZFBvYZyhPeX2bGbvBVUmlhgDas0ZahesdTn1BtWqBMkFwV1gvowsHd7b0PE/XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YypmT8vjty4Czi7S1T0OvL5nF/BkmERGx3/urwwhZ3sk1TrA/D+
	8KC/lHm42aluAWx/J55yITljGzgbW6n1DH1kM4CZXOaIiRr/nFX2fMMB
X-Gm-Gg: AeBDiesyI+er8xa28y6MxJT6s4t/CZlcnC9AhpeFDAk8fcy5XXRX+Ugn5MlFd31hN+O
	xojM3A7Af8HOm3YBhXEp1/Wof5xwgP12k7nCEDUuqFk5KZ7Si7UIQPGLRT8M4Im/FLGUbqvBvZL
	IlS4Uhabv7Wr1eEhOCAwd3M9Mvl1D3fWjXD/rzFE4ZY7OvhPL3S1zF22Wab0ftaWdLBrox14Q06
	2PEY74M2+AvGU6sF2fGa26cQMz1Nzn+sq2UCss+hH/5emcRwk1KaxTbfnotGYZ1N3J6qhH4cSU1
	z+bv+9Kd0lDOZWNSP3WIYw9+sWQn2nyL2X74KE5f9dOA+1X32smrOOb/32bNms0T/ua/rYg7N7p
	1ZG9zwo3VR2U3gVzbUHqww6UBSoE4synSQFtZIjwJMs+s3v256XWVdojjnTGHKfALOr2zOOgLte
	n/2GN7sJkwWNqg1tyBG7H9Zzog7mwfWHCuAocPJ1hEwkkCkE1kIQ==
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr578263265e9.21.1777276099604;
        Mon, 27 Apr 2026 00:48:19 -0700 (PDT)
Received: from vitor-nb (dsl-43-224.bl27.telepac.pt. [176.79.43.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm718761025e9.9.2026.04.27.00.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 00:48:19 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Kevin Hilman <khilman@baylibre.com>,
	vishalm@ti.com,
	sebin.francis@ti.com,
	d-gole@ti.com,
	Devarsh Thakkar <devarsht@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] pmdomain: ti_sci: re-sync TIFS with genpd on resume
Date: Mon, 27 Apr 2026 08:48:03 +0100
Message-ID: <20260427074808.3244226-2-ivitro@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitor Soares <vitor.soares@toradex.com>

When a device in a TI SCI power domain is on the wakeup path of a
wakeup-capable child, the suspend path skips genpd_sync_power_off().
No put_device is sent to TIFS and the domain's genpd status remains
ON.

TIFS powers off the hardware during deep sleep regardless, since it
was never informed to keep the domain active. On resume, because the
domain's genpd status is ON, no get_device is issued. The driver
then accesses registers of a powered-off domain, causing a
synchronous external abort (AXI bus error, ESR 0x96000010).

Commit 0b5fe1c4ab3c ("pmdomain: ti-sci: Set PD on/off state according
to the HW state") exposed this. Before, domain status was initialized
to OFF, so get_device was always issued on resume.

Add a .resume hook that queries the domain's state from TIFS and
re-syncs TIFS with get_device when genpd has it ON but TIFS has it
OFF. The hook is only registered when the is_on op is available,
since detection depends on it.

Move ti_sci_pm_pd_is_on() earlier in the file so it is available to
the resume hook.

Fixes: 0b5fe1c4ab3c ("pmdomain: ti-sci: Set PD on/off state according to the HW state")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 66 ++++++++++++++++++-------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index e5d1934f78d9..ec976d77b818 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -131,6 +131,23 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
 		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
 }
 
+static bool ti_sci_pm_pd_is_on(struct ti_sci_genpd_provider *pd_provider,
+			       int pd_idx)
+{
+	bool is_on;
+	int ret;
+
+	if (!pd_provider->ti_sci->ops.dev_ops.is_on)
+		return false;
+
+	ret = pd_provider->ti_sci->ops.dev_ops.is_on(pd_provider->ti_sci,
+						     pd_idx, NULL, &is_on);
+	if (ret)
+		return false;
+
+	return is_on;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int ti_sci_pd_suspend(struct device *dev)
 {
@@ -149,8 +166,37 @@ static int ti_sci_pd_suspend(struct device *dev)
 
 	return 0;
 }
+
+static int ti_sci_pd_resume(struct device *dev)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	int ret;
+
+	/*
+	 * If genpd's domain state is ON but TIFS powered it OFF during
+	 * suspend, re-sync by issuing get_device before the driver resumes.
+	 */
+	if (genpd->status == GENPD_STATE_ON &&
+	    !ti_sci_pm_pd_is_on(pd->parent, pd->idx)) {
+		dev_dbg(dev, "ti_sci_pd: ID:%d genpd/TIFS out of sync on resume, re-syncing\n",
+			pd->idx);
+		if (pd->exclusive)
+			ret = ti_sci->ops.dev_ops.get_device_exclusive(ti_sci,
+								       pd->idx);
+		else
+			ret = ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
+		if (ret)
+			return ret;
+	}
+
+	return pm_generic_resume(dev);
+}
+
 #else
 #define ti_sci_pd_suspend		NULL
+#define ti_sci_pd_resume		NULL
 #endif
 
 /*
@@ -200,23 +246,6 @@ static bool ti_sci_pm_idx_exists(struct ti_sci_genpd_provider *pd_provider, u32
 	return false;
 }
 
-static bool ti_sci_pm_pd_is_on(struct ti_sci_genpd_provider *pd_provider,
-			       int pd_idx)
-{
-	bool is_on;
-	int ret;
-
-	if (!pd_provider->ti_sci->ops.dev_ops.is_on)
-		return false;
-
-	ret = pd_provider->ti_sci->ops.dev_ops.is_on(pd_provider->ti_sci,
-						     pd_idx, NULL, &is_on);
-	if (ret)
-		return false;
-
-	return is_on;
-}
-
 static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -283,6 +312,9 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				    pd_provider->ti_sci->ops.pm_ops.set_latency_constraint)
 					pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
 
+				if (pd_provider->ti_sci->ops.dev_ops.is_on)
+					pd->pd.domain.ops.resume = ti_sci_pd_resume;
+
 				is_on = ti_sci_pm_pd_is_on(pd_provider,
 							   pd->idx);
 
-- 
2.53.0

