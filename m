Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688FF58279D
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420458; cv=none; b=RQ26GG+eSUqKCmh4ZwEMC+5yd6BRQQm2T4AuikITTr5+n7rKxfQ6cbkTvAtvkWmDr9aTc9UViMdCq5OMjT1K+oMNWfeJBPoxh83so4i44IHXGH4BBrj7Wu2HHWA2RBOQE1gzLSTBWdjn4vskEeM/hbFrDZNlTfbVGHmCA7T1++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420458; c=relaxed/simple;
	bh=4JSJXufm9LsiY0rDr+2Btai/o7jt1qtptG7YexnPAio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOCgfMSyKUEd6EFBTdpFqiA2wfmvXE4kqhY6lYAMsuPZQxUibgCVVlj28lP7ETsMXAHpA+zWH7bd+AdN2BvBBIO7b91tP+uuuYi4YnQ6XgeoI7p7fktHRm8QGC/eMVSVMiGCaGOAHBq/vq1Xr3ebGZ/gzy2jfbDJV9uscaCMY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTmdSjGE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTmdSjGE"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5364d86f7f0so22920111cf.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792420456; x=1793025256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5md3Uw5njNNzCzU28Ft2ytiIdYe8QUQ+L/EA5rf3o8g=;
        b=MTmdSjGEtfI35a6TJsOwRcXHzdk+BUaUJhLtGn7Y1+et+PmPxJl17ORonq5GDvM8rm
         tYjiNENID99q+0h5CfcK/m4raXCZJHafIKlxvftG1QK3p2aU6MGjy2EHk+wlHYknq4DS
         nx9+Wg2s1NcXlFP2k036tIUZwQBLTS6fKnPrNuls26ZvP3Ldr3ceXF1pKsdJxMnyM72g
         0QN3MXsn9yk/eprUGsjlcIvddtzUyd/Csa/mV0JA3oDsC2CBDcosxUvpFHRTyL8U50uh
         PpvB94AFl93cfYHYrfDcniKFwidIAXbVNjKVJ45QbjqlLhw/g0RYeac/R6Q9qfyqt4DS
         +ZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420456; x=1793025256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5md3Uw5njNNzCzU28Ft2ytiIdYe8QUQ+L/EA5rf3o8g=;
        b=rYvvGYQrCPPGRDZVYbuUS0+g0kIgjM+txnEvLFGNSkiaUtliVB+V6rDphOE8aIyKD1
         lqOdoKn5aJ+j0/JtQstQYE1R1l00OBgk8MLNsh424fzk1YvmiIMV8hgHrNppaN6nAmip
         8/gL4HvI+1hnRvdsYYZRSUN2msoOaB8MohDsf+WlTFPSQPKZnHxVWJnIYwmkZX2gvTL2
         JKL5K//R33kdQKc6xMY6bkpR+0vvX5/BGC7ALAFq12m1WvuZh2wBBVUo2lH9DIPjBtEk
         FATaact53lXIzydYt8Y8Gsq+irOai5lcyt7hM3uocVK3wYYYzty8cvIbE1+unAohGs3Z
         Xnnw==
X-Forwarded-Encrypted: i=1; AKwUvByfkBhiRgRFXz1QCcRMI5RyOcgiu9zjkEjtItkCUqU6BZNZPvfq+9k1OeEx+lglniQ3PMqD26A1MQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYISwkmd5BBv3/Gzv7lvE7OGnaRP9uU7OxSJ6he2uUW595WIMqLP
	ev5RNvE8g/tzdkMGZmjzQYYk6MdIh5WyhdO5Ds+WV7IqJGKHr7LcMsCa
X-Gm-Gg: AYBFou00+MER8ZMSqINIatycvCI8SnPMNEDO/mwqeEJLMWIUUFx9c8B+K4EWb2sPwc3
	kIvu6l+mfUkdX0RQTHO69wnGjBmAnX8vcxnvG8mqIS8yHPtXj9s4/c6usAg6QRFJXgQErLa8YpC
	4zNNelT68vDtK/QzFSXr2WfC71pvRLiLf6L1G3Ni3iI/z6nw5RFySTGuP2iNBxKc41blUpXjiOz
	JqH8IPVi+YXPINplQtkEuIaCvJ3mu7xrj2WZlFl9ojHSnxEDNSm5Kt1cmubVVMb9kvp3uuG7CSf
	YIAiZ7oCkhCGq9cT8D6r1gF9NGCXzaPI2ovm9JlQpi2XJ7xOx56aG1t5OHPnnWIfsoPk3MGU5OT
	0vdFfbbao7NrOICkcmVAnO/VnPLs45N/TIRkckTKYJEHJfQ8R2zviXTrQqmv956EKA0aDFt5mVJ
	g18zQeNVvXN93dyFIliLnhPNtr6sWcglep8g64TFzBhfEFN5ZGyUARXjcE0fKXYUiSR7wuOHr2/
	GXmI31vrBHgbeoGiJQ9zsjwI/GGi6u5Wr0mBo0mtYJyRbsN
X-Received: by 2002:ac8:5dd2:0:b0:535:1393:a82e with SMTP id d75a77b69052e-53645f74f23mr119555391cf.23.1792420456068;
        Mon, 19 Oct 2026 07:34:16 -0700 (PDT)
Received: from omarchy.tail6c35b.ts.net ([2601:984:200:5fa7:1bb2:d04:663e:4c74])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa332b0sm100192851cf.26.2026.10.19.07.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:34:14 -0700 (PDT)
From: Derek Ross <derekross@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	kernel@puri.sm,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Derek Ross <derekross@gmail.com>
Subject: [PATCH] power: supply: max17042_battery: infer the status when no supplier is described
Date: Mon, 19 Oct 2026 10:33:02 -0400
Message-ID: <20261019143307.2109629-1-derekross@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When no power supply is described as supplying the battery,
power_supply_am_i_supplied() returns -ENODEV and the driver reports
POWER_SUPPLY_STATUS_UNKNOWN, even though the gauge measures the battery
current itself.

That is the case on the Pixel 7 Pro, where the charger is left running
by the bootloader and no charger driver is bound yet. The battery read
"Unknown" while taking in 1.2 A, so the desktop showed no charging
indicator and upower treated the phone as discharging: at its critical
percentage it put a charging phone to sleep.

When no supplier is described and current sense is enabled, take the
status from the measured current: charging while current flows into the
battery, full when the gauge reports end of charge and no current flows,
discharging otherwise. A described supplier keeps the existing logic, and
without current sense the status stays unknown.

Signed-off-by: Derek Ross <derekross@gmail.com>
---
 drivers/power/supply/max17042_battery.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 8138b52e05e1..c437d80700a6 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -148,18 +148,26 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
 {
 	int ret, charge_full, charge_now;
 	int current_now;
+	bool supplied, full;
 	u32 data;
 
 	ret = power_supply_am_i_supplied(chip->battery);
-	if (ret < 0) {
-		*status = POWER_SUPPLY_STATUS_UNKNOWN;
-		return 0;
-	}
 	if (ret == 0) {
 		*status = POWER_SUPPLY_STATUS_DISCHARGING;
 		return 0;
 	}
 
+	/*
+	 * A negative value means no supplier is described, e.g. a charger the
+	 * bootloader left running that no driver owns. The gauge's own current
+	 * sense still tells which way charge flows, so use it when it's there.
+	 */
+	supplied = ret > 0;
+	if (!supplied && !chip->enable_current_sense) {
+		*status = POWER_SUPPLY_STATUS_UNKNOWN;
+		return 0;
+	}
+
 	/*
 	 * The MAX170xx has builtin end-of-charge detection and will update
 	 * FullCAP to match RepCap when it detects end of charging.
@@ -178,7 +186,8 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
 	if (ret < 0)
 		return ret;
 
-	if ((charge_full - charge_now) <= MAX17042_FULL_THRESHOLD) {
+	full = (charge_full - charge_now) <= MAX17042_FULL_THRESHOLD;
+	if (supplied && full) {
 		*status = POWER_SUPPLY_STATUS_FULL;
 		return 0;
 	}
@@ -200,6 +209,8 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
 
 	if (current_now > 0)
 		*status = POWER_SUPPLY_STATUS_CHARGING;
+	else if (full && current_now == 0)
+		*status = POWER_SUPPLY_STATUS_FULL;
 	else
 		*status = POWER_SUPPLY_STATUS_DISCHARGING;
 
-- 
2.56.0

