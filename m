Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795829095;
	b=FAzGt3Eormg8uZOE7Zck3xY5JLvqgmzS31KLF97sfAkOb8uRe+YDZbR78JlmEZBD75wB
	 P39IWrCicVnCYBrE96VNbRmNkXY5yrEV1iRGcVpwrXPdywbnNrghilLbkoRp3e/zmLehI
	 BxvOu7sVRSoXxQjklgKuZRLnwzsg/t9rFGtVd8RhZAN9fQe5lLYUh+ghgve/Gnfd1i+nV
	 /PEh9peniZd1L0jqGUTa7Nur11jvw/ZOcWtXa74nYddrXOewwNpjbLBMSBFAuYHb8fNyk
	 McDauVchdsXRbvXFtxbFtsZvPJKhBhsfMkeOg3QK+GUAzn2sCUpy0UZUw1kfA9rvNEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795829095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OWNGxbponyKfeyRlTE7MEjwwreM5am00CUo8E20vsbk=;
	b=XopwN09HUH1SgDaCmlpbnTNOe1fewGY5H/e168Hs4K1YOH4k/T/FNUuJQGeg0WzrGXZm
	 S1AkS77Cd6KRY3vccQRhg4glPZX2j6a2SebWCK6e+4t1c6/DRyN2+9AKEzcu87aPuxOTh
	 4PWJGqcZqFNfu5ksip4aLdW7NJH7pi3Bk7dxf5AtjmOuMSo30ue6igWM0PWcN8m9gd5Or
	 P81CRc1f8KXbgKPMNbTq8ApDWV2XrRTDI1MV15kHjx/pRuFLHwJBUtPwc/iVJRyrM2RUf
	 vcPMU4mcQSwdeXvqYOO6BZNa02Mwo2WHO/zH97VOe91q4k5lXzQO+zxBVEsSsjPV+Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ksQFYsod;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE5606A31F
	for <linux-pm@vger.kernel.org>; Sat, 28 Nov 2026 01:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03CE5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ksQFYsod
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67be9601f31so7420524d50.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 17:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795829094; x=1796433894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWNGxbponyKfeyRlTE7MEjwwreM5am00CUo8E20vsbk=;
        b=ksQFYsodPDGdp7EnIkIthOcdhW3Ho6POpCgmWo06HcHx7CM2uDECQE6JLgFOtFX+uS
         wwiNCleRKgX/0hRnp0SzYPzS0vEq7xewx5ThO3Nd4c+jc927eTCYOYV9i87wQ3s7QX9g
         gM4oteXd7fQNqEZ4XqviJ7RFBjejJgM9Z85Rs6YeLXmlaquJawaGoZNglCJzagobxWXL
         PNh6IzvM0AaX47sndHCfGkEGT06zcmJIk1HumtzWpSVgwl4qDlcHJpPcTfVgSiawlJCK
         8nQ3kPQdEIAr4/VK0Y/pvLGwi/31bJjkTNaNezz3wQfoUfik/dcCkg50LN670OhAON0l
         Ld3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795829094; x=1796433894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWNGxbponyKfeyRlTE7MEjwwreM5am00CUo8E20vsbk=;
        b=mFzekG8BSOXCwe1+zL8wp2pNdtHwW/ReAkg2TZP6vJv1GGilYUrlcOUf5G6hjnvJsJ
         1Z6fNbotwdYNhzKGip/xJZGYAOhfUUyxpkWMoXTzz26Bx+VqUFn7M42hxhcV1qrMXwn+
         49AtUBojaJPayNQoo34BZFIZOzXb3Xkz58LWOnfiDOgVNYPNQVPnnGy0npGQUTcYiK+h
         CVuFlCToHLXafI5/8YfDWnwWI7/ldWX1zsdHF/YOi/5gufzYxgZ/w8IyKs6W0yhSBO3H
         ckQj5AXVSVgHaH3YWCXUSeNUwuyvj2l1skcToHxgFc06OPLuaHBbR20t8ODWYQORAUb9
         Zwuw==
X-Forwarded-Encrypted: i=1; AL+hErErmp//Q387Sft8bIgax824KS66UUqDldCrVNQk4x1whnOvieMLHbBD5SZIOdzyrPPRMXgDcxbcVQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+JDc5SekMF4YWeiK0IK7pt/NFZiEWdcRFTsA7LDlJwHUsmOU3b
	/ly3jcqwdvV4u5FA3NSmrTr4G9eLqWWXYSRhU4Ypng/L1E4hFW2oe/eZ
X-Gm-Gg: AZFdTZcSoPXehh9YnvGIid2dEaRXGUcq5FiV9TZ4yhFecSCYDTwj8cIZU3/0jmAtow/
	2bT9kCcYUFkBo0+15zYKfkvHBHu/13v7QsZTiII85bxKlEr7ZwYr9fGJ2iU98V+peMPvHf5jBdi
	g/ZaKuQTmlyLjr/j5Sr5eYhaqhCvfnWONPvwM1735HfLDWICJjLsKluJ6ojSy0V1tQCFnJNQg0/
	G8h/iDXaEX2VDPDedqVRCtZtI+EJQ/Cqd0Qea/qVvjAnqTimp7ac1Jchm/Ro1LArLs0QfFVPntC
	eqzgO4WYTeF+k45bP/ol/iWOEYqJ3yKLq9EwM9Eh3Aal++3DRS/pfLMp2KxAEc6K6zrz9HJY/6/
	uNgDpB4yJvqlI2Lz3YB6uJEJgmmTz5yZsGiCceGkSjExOHU60n7Toz5kc/ElmcrbJrN+J166Cq/
	kDdXjVy74GwJ/mOJND2NjYLvWt2Fw1/a9gtsAg7g4Wij1ZcpLZsCsCenynsrJEFAYZ5yPhFPNI9
	0OAtqC1qy919//FmSf7jOVog0FK2oCPJ1opQB2+yLRaJPqYMNw3+QIMrBMpMAalMimn6m4MC8jk
	kPnS51ktbIVeHMOUqBp+UP23oYgQDxfPh16h1oE=
X-Received: by 2002:a05:690e:4504:10b0:67d:c165:7f0c with SMTP id 956f58d0204a3-67df44555e5mr6440765d50.54.1795829093954;
        Fri, 27 Nov 2026 17:24:53 -0800 (PST)
Received: from WillzDenali.tail339aa4.ts.net ([2600:1702:7a80:3c5e::c81])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33105fesm11921499d50.7.2026.11.27.17.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 17:24:53 -0800 (PST)
From: turbinebmw <turbine.bmw@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brandon Williams <turbine.bmw@gmail.com>,
	Val Packett <val@packett.cool>,
	Fenglin Wu <fenglin.wu@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH] power: supply: qcom_battmgr: treat a start threshold of 0 as none
Date: Fri, 27 Nov 2026 20:24:49 -0500
Message-ID: <20261128012449.323479-1-turbine.bmw@gmail.com>
X-Mailer: git-send-email 2.56.1
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

From: Brandon Williams <turbine.bmw@gmail.com>

UPower turns a charge limit off by writing 0 to
charge_control_start_threshold and 100 to charge_control_end_threshold.
Since commit 8809980fdc8a ("power: supply: qcom_battmgr: clamp charge
control thresholds") the driver raises the 0 to
CHARGE_CTRL_START_THR_MIN, so the firmware is told to charge to 100%
but resume only below 50%. A battery that the limit had stopped at its
end threshold, say 80%, then stays at "Not charging" until it drains
below 50%, and turning the limit off appears to do nothing.

Disabling charge control through the request's enable bit was tried
and reverted, as the firmware did not behave as expected with it.
Instead, take a start threshold of 0 to mean that there is none: keep
the end threshold and use the smallest step, CHARGE_CTRL_DELTA_SOC, so
that charging resumes as soon as the level drops below it. The start
sent to the firmware stays within [50, 95], as the end threshold is at
least 55. The start is remembered as 0, so a following end threshold
write keeps the small step, whichever order userspace writes them in.

Tested on a Microsoft Surface Pro 11 (X1E80100) with UPower 1.91.5: with
the battery held at 80% on a 75-80 window, turning the limit off set
95-100 and the battery charged at once; turning it back on restored
75-80.

Link: https://gitlab.freedesktop.org/upower/upower/-/issues/327
Fixes: 8809980fdc8a ("power: supply: qcom_battmgr: clamp charge control thresholds")
Cc: Val Packett <val@packett.cool>
Cc: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Brandon Williams <turbine.bmw@gmail.com>
---
Based on sre/linux-power-supply for-next. Hardware-tested as a backport
to 7.3.6 (the same logic laid out with a goto, on top of a local change
that returns the request status like ffce9bb777f2); a userspace harness
running both versions' setters over 120000 random threshold writes gave
identical firmware requests and sysfs values. Compile-tested with W=1.

This keeps the 50% floor Fenglin explained in the thread on Val's series
and does not use the enable bit, whose removal is 8e8856396b54.

 drivers/power/supply/qcom_battmgr.c | 43 +++++++++++++++++++----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 0789303..45bd1ff 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -762,21 +762,36 @@ static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr,
 	u32 target_soc, delta_soc;
 	int ret;
 
-	start_soc = clamp(start_soc, CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
-
-	/*
-	 * If the new start threshold is larger than the old end threshold,
-	 * move the end threshold one step (DELTA_SOC) after the new start
-	 * threshold.
-	 */
-	if (start_soc > battmgr->info.charge_ctrl_end) {
-		target_soc = start_soc + CHARGE_CTRL_DELTA_SOC;
-		target_soc = min_t(u32, target_soc, CHARGE_CTRL_END_THR_MAX);
-		delta_soc = target_soc - start_soc;
-		delta_soc = min_t(u32, delta_soc, CHARGE_CTRL_DELTA_SOC);
+	if (start_soc <= 0) {
+		/*
+		 * A start threshold of 0 means there is none: charging resumes
+		 * as soon as the level drops below the end threshold. Userspace
+		 * writes it, with an end threshold of 100, to turn the limit
+		 * off. Use the smallest step below the end threshold, which
+		 * keeps the start within the firmware's range, and remember 0
+		 * so that a following end threshold write keeps that step.
+		 */
+		start_soc = 0;
+		target_soc = battmgr->info.charge_ctrl_end ?: CHARGE_CTRL_END_THR_MAX;
+		delta_soc = CHARGE_CTRL_DELTA_SOC;
 	} else {
-		target_soc =  battmgr->info.charge_ctrl_end;
-		delta_soc = battmgr->info.charge_ctrl_end - start_soc;
+		start_soc = clamp(start_soc, CHARGE_CTRL_START_THR_MIN,
+				  CHARGE_CTRL_START_THR_MAX);
+
+		/*
+		 * If the new start threshold is larger than the old end
+		 * threshold, move the end threshold one step (DELTA_SOC)
+		 * after the new start threshold.
+		 */
+		if (start_soc > battmgr->info.charge_ctrl_end) {
+			target_soc = start_soc + CHARGE_CTRL_DELTA_SOC;
+			target_soc = min_t(u32, target_soc, CHARGE_CTRL_END_THR_MAX);
+			delta_soc = target_soc - start_soc;
+			delta_soc = min_t(u32, delta_soc, CHARGE_CTRL_DELTA_SOC);
+		} else {
+			target_soc =  battmgr->info.charge_ctrl_end;
+			delta_soc = battmgr->info.charge_ctrl_end - start_soc;
+		}
 	}
 
 	mutex_lock(&battmgr->lock);
base-commit: 4f9bf356cbfb8aa6e73b1d05e182445723a4bb49
-- 
2.56.1

