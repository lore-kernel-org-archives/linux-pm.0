Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E43EF0C8
	for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2026 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791087031; cv=none; b=bg0caQfI0EGzHDRltMx2OIiw7kTyI28/U2IVH93w6jmtCNRbAaera60psIcgK/KiHvI00ZP0NyMv5NK8lPb5gqSSKVPhaysj9Ux47P/eHoJmIvlVRh/wHEpMByPOS8vnNRQi2a6jb7IUQ+qMTIN9CC/trQQbKoOnlEHpY5WIbew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791087031; c=relaxed/simple;
	bh=NjL6Dz3ATof4xFu51ZKZGgvreurCkfkXi5SOJyRAhac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/L/zkiGnyyIwHOprGhSaERw0qYq6njTdUl8GzIm8bsi5N3qvcLdtqd6dM7AoE9JsD4qFAK59EeTpGrKggMoJEnqOp8NRCEXD0ExGgVXv5nrJXUq5yeJ1gXWUJXRAqo4VDM3biTeqWRJxL3jpzpK1lH1nVqJz+4zTXbMyod+MZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zte3/aaS; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zte3/aaS"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5350c1b9e0dso11978641cf.0
        for <linux-pm@vger.kernel.org>; Sat, 03 Oct 2026 21:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791087023; x=1791691823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gZl0h+Rgpt7vIrQ3DFHi4uK4eDGZkHcBR93y6eKzCg=;
        b=Zte3/aaSR226cz1HRUtJRct3y3diWGSE0F329TBA9VuqUQTQzkH34DPK2BIKOh+GYA
         6f6Lzy4h/QZzvvL14L1K+BSetoNcJqdHF0rPoUXyVgb3QP/T4GFWD7cTvDCSmjyFQkPB
         k1URsnaIvVAkZXqJgp7hydAOP9po774oY+EudvjakLPiCpj7MERbkyi9APbGQn5Km0Ng
         hEit4OoUYySjzDD45WwRgExIcTRyP6r1KN1hrvoOdNe7MSqksTighBAIdb2qY1I30/Qu
         g5w2QQNOoXBbcy1ReqYYXbejRrtMMfWqzmxd17a4sVsGaoMAWcERdepCGzC4QRiaN3/V
         u5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791087023; x=1791691823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1gZl0h+Rgpt7vIrQ3DFHi4uK4eDGZkHcBR93y6eKzCg=;
        b=yfu0KoJANNIvpt96V6cVtnaOvuLpIw1vdIYTuYdz7M3zyTJLXiEySEtYNH4xtekg2a
         6AOdynNx1cD3VWI5Epq5fxFt8D03DfcBZmw+jR4ECp/ibRG4uhBzR5DQnIiYhj6CS8pn
         jQqwzwcAHs9jD54gWfYHpUodNfxHpIV8zf4wYUdOrsg+VMwWfHVSIi8S73hVG1ANSo2R
         l+tZTmhJlg2L2TXcHE5oLLE4SgQc10T4UUh2CK8Jxf0oqCnwg61PbMHHdLpQyLy1BiuR
         FGQ4fmV2YhFiGVJ1M3gk94ZkNk/emnUQLDAugyp0n8G/zblvLWsDakRxL1QyxuXZEX2F
         PEqQ==
X-Gm-Message-State: AFuF++lICWELaOzPnNJdtnINUPSMWLOWMdhek91iJ6bieSe2/Y+KZIQJ
	ic0x2Vymt5EdUxqeC18/Fqa+i9uYDDYBHqBeG9BB3rBDncytcNuaql4=
X-Gm-Gg: AYBFou0D+YXWSniELxj2FWTq4OMzTB1voj3vyCRWVGEzGe2iQWLpwBZyYg/9n4RCh5d
	yaLiBv4VqvY5Z0E/Jl3KKBeu+sWM7yQl7G7qTDC+yhdAfpqiXUi2JwgVZO/ebLV3QYlGhTO2pWF
	TOxHUXWD8tKYUtbv4YSZk9LCA5J/ehHOH+L5kpqm3jmvL50WV9yNM40zDdn2slOV2RFPFWBwr3e
	LPEfLeqofsktcmKILwGdMOBdEp931ACvDH/9JagCn6fJ/NKVUOOiF8gPgm9FF3KKq5BKiflkDGt
	0ZRUJuN1xukauStuzg2PnwilxBO8bn9yA4gDa6oZ+v1hf2mH7U2DWbtwu9rqiTsTwLc/I/Dh6NF
	iqezW3Lcj1HULteGYReMPxTOTuXa1mHNdE92w8r7QU738OHUTxOrwnFPMx/JET6I2dnfmp0D64/
	qy0cJZNIk7C0xg/+bQEf+r08ma5v7fvIGAyHs9xW4WW1xPPS6DQrR/H5AcFNUH9adHTuipy46ct
	6jEt0lKnSoP7+ASbxmIZa6AjdQwCHoJTUGzQPpmgMqmEu2hwQn+FAt7eBkfDfOjIaG2VYwCX3eR
	2r+/6QxcACJMjAd46HTCnIowUSQW
X-Received: by 2002:a05:622a:3c6:b0:530:b2e4:4e28 with SMTP id d75a77b69052e-5351203787amr67100211cf.53.1791087023409;
        Sat, 03 Oct 2026 21:10:23 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0b19424sm57968806d6.15.2026.10.03.21.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:10:22 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] power: supply: sbs-battery: disable polling before supply teardown
Date: Sun,  4 Oct 2026 00:10:19 -0400
Message-ID: <20261004041019.1123723-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The managed poll-work cancellation is registered before the power
supply, so cleanup unregisters the supply before draining polling.
A pending or running poller can then call power_supply_changed() on
the released supply.

Commit 8d59cf3887fb ("power: supply: sbs-battery: Fix use-after-free in
power_supply_changed()") moved the IRQ request after supply registration,
but did not change the poll-work cancellation order.

Add a later managed action that disables and drains polling before
supply teardown. Its retained disabled state prevents external-power
callbacks from rearming the poll work after it has been drained.
Keep the original autocancel to initialize work before supply callbacks
can run and to cover failed supply registration.

The teardown ordering issue was found by static analysis.

Fixes: 6d0c5de2fd84 ("power: supply: Clean-up few drivers by using managed work init")
Cc: stable@vger.kernel.org # 6.10+
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 501c8e069755..6714313bb3a3 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1068,6 +1068,13 @@ static void sbs_alert(struct i2c_client *client, enum i2c_alert_protocol prot,
 	sbs_supply_changed(i2c_get_clientdata(client));
 }
 
+static void sbs_disable_work(void *data)
+{
+	struct sbs_info *chip = data;
+
+	disable_delayed_work_sync(&chip->work);
+}
+
 static void sbs_external_power_changed(struct power_supply *psy)
 {
 	struct sbs_info *chip = power_supply_get_drvdata(psy);
@@ -1208,6 +1215,10 @@ static int sbs_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(chip->power_supply),
 				     "Failed to register power supply\n");
 
+	rc = devm_add_action_or_reset(&client->dev, sbs_disable_work, chip);
+	if (rc)
+		return rc;
+
 	if (!chip->gpio_detect)
 		goto out;
 
