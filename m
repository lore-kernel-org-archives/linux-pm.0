Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806596;
	b=XIbd5raaqwnWICQgh+ASSrlucxw8LaawVtven6+lHwSIwm8IOA6KTm18N60037bHsQKI
	 lSi7LijXVqHi5VWIxJchr6ufAlGvrxQQ3Jdy+nVbVESR72GimP5mSh5/dbzhxtZNfRL0n
	 og5L84aR7OgrrIfqva2Ee28IYtsNcPQe/3+0HRA3qzZSL70wZIE+v/MJPRVVsx7WTFyjp
	 7HJq4+76UOAPLKmrcuspxpW04xh0lNOzz1lKRZvLfwNt77Uw80NnmOSI+12f7VorGFqCv
	 v5ax0yiXPKGweIdX5HAA8Qo6u8fkkX3jWFxK9kQ4nk+LroFuYiR7IrztU0xAJ3SDU7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Tu6aU5M+2skw7CfMYibCOfN2VIrKMUr0DGrXBqKQg/o=;
	b=nHR8EHj7qmefwKJBt7dvG8Lv9ZEek95/Kh1sUR3ndrU9pTvYLHeMUyHdnCynNArfqSPr
	 o8mxkXuw8H3V2eiZtJy3z1drmhICBRQ1kRPJIsJCScnQfku6wmuknVXGCwdnD6iK19cu+
	 z2u+UI4DJ2T7E3t6bQZEbbDEp+fM+Ytt8aVj0+DPpHRSnVV3+2SKx6xE01lWLQA4+syXu
	 skO/R6DfCMn5iIpQxjhB4Dt4MbZVMaC8oDxKd+UwqhtDW3A/1jcpEg20F6thMmN2m1Aan
	 OiESvjdvCGbFvixe0v2LT2Khx75K5E71V1H/ix1H3IDGa4Du4DiYOJVBpFCaOlXqTXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KuHLCcON;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA6606A329
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 19:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ABA6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KuHLCcON
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d581da0aaso1156483666b.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806595; x=1796411395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tu6aU5M+2skw7CfMYibCOfN2VIrKMUr0DGrXBqKQg/o=;
        b=KuHLCcONKN/HVhsBI9TzyEi5Mg9Hq3SCuUlQlJ79BrOlTnZklbpObXySoxYMduP4Z0
         ijRMm1JehwT/dvpBiNKTqYY2VYRE1RMUEB/3QAJbBEkoaLbVn+3WbVhFaPZ3Rv9QgEgS
         GtuStUWfebq0CM2RF1shYKfHry5QmOreDOAKNbz6ccJGegteTode191u1yJ4Tnjnh+Yl
         K9LgTInPnq+2E4tzlMHKxQttEwyUvE1u9rtO4elaqL8Pq664+79udIBBG0orbYRzVV3v
         Z8+/0VWiVm+kcpKYqWz1+mubXEoVCmIMIR7FddYfSdiVf2tHL/BhBi1oKilFp1sFJLvN
         I4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806595; x=1796411395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tu6aU5M+2skw7CfMYibCOfN2VIrKMUr0DGrXBqKQg/o=;
        b=J5sfDTDKaWJ+08Gk22uYPBIKHvf1d89St/uMTZE6MmA8qsJAtW1NrT+WbEyXOl90U2
         mf17UY7V3y/uUi7Vnq6nEtL4625KAaUFeJ81uQZbKZCxQJvuuMcFVGYdS7xchzrIermU
         bVhlE8eq89irCIsRxEn5Ye9P6GvJXEIH/jHUCQDXnF2gaDnfhC80+125Jqn6Dt3H56nd
         p2dimXgtjwm10oNdGHmsRt1EEaRv6U7vdn58lAmwis6vl3AyMSGZVITTmaqvKY2MU5ox
         U7oA3JDXY5Ppv9yYpNFcHjGqwKiVamgMJm0nXgVN1VBIArOJiT+yrHMO5/iG4YXXz5bF
         4Kew==
X-Forwarded-Encrypted: i=1; AL+hErG+miEtGINO9uDU5DSAd1bZZfu42VuX/gfzoapGVaAYAhUqRdtqszNVX9AZy9wpmCnxigNUlDzb9w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/NRTpgj8ydpI8cWNZGQvgmVJtiH9V2G1DzjyyywetE7rbCUwTv
	xK+DHhO0MKNpRCEB+zFa6oI/4G4+R8r6T3+21RnlGYSgjCSG2I1vr0VXxq/WtaERc8I=
X-Gm-Gg: AZFdTZflWF0quJLWDYYE5/ItdEAhFIUj60ik05t5NUoN2ezBYexUVgKGkECKhBIZq1j
	S7HUg8924eoC05JDhxMgapBDIGsWGH/iY4RR2fOpaXIZCi1CvOpydsuDcHt/y7JcVqgFX1QEhEl
	fSiGd4lRcnKNIoZB5SpbvtFYDbfT2lJab+UB/7k7yPGgcLcNCuHgRSKNhqOmIXyChVxDWJHUqUP
	Ur5WzLGR8d438dYiY1MzFHXP5NdzIeuKZqsqG/pviNGems5jfSKlmLvgjcGy6LC0KkBkiKKAYLn
	Ilt63P/qCwyE//RTEkXdbXd3/6JTyqdk2oR8QhloMDfINW2cy9bbbE4bj3aKy+cj1/z/3MgNEpr
	59dWTjDjSN93vHikgknUKf356xGJuhOV1q7vAUdvoYlCET/2c4X1qwHhmWlDevvssBEcyijth+x
	uZICfSp3K2azUIrVcLLZNe9XLbEdMN9djRLxn3r/NrfSv2yZH/p4KcFaKTKREXxufFOnK8V48bh
	wU1xofGmUqz/kLZLHx35bpZHxHRlWdJUZNH2xALEDmStNDbA6h+VhIPfBwHxaabHO1Z8b9yR/md
	TnyLQrKM2PNaFFNJEBR1KLwcaZA2eEFBeqZE2nTF+vTGPbfHAv6b0rn1aDuIng/L21Yyl8PlhqL
	9pHf5jNPfEVdhmS4zzw==
X-Received: by 2002:a17:907:c612:20b0:c51:2583:78b9 with SMTP id a640c23a62f3a-c513ab477e2mr1558459766b.34.1795806594992;
        Fri, 27 Nov 2026 11:09:54 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:54 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 19:09:52 +0000
Subject: [PATCH 1/6] power: supply: max77759: fix use-after-free of
 tcpm_psy
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
Message-Id: <20261127-max77759-charger-fixes-v1-1-b364a0862d72@linaro.org>
References: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
In-Reply-To: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Unbinding the TCPM supplier triggers a use-after-free oops in
psy_work_item():

    max77759-charger max77759-charger.1.auto: Failed to get
     CURRENT_MAX psy property, ret=-19
    Internal error: Oops - BRK: 00000000f20003e8 [#1]  SMP
    CPU: 6 UID: 0 PID: 96 Comm: kworker/6:2 Tainted: G     U
    Hardware name: Oriole (DT)
    Workqueue: events psy_work_item [max77759_charger]
    pc : queued_spin_lock_slowpath+0x388/0x3c0
    lr : queued_spin_lock_slowpath+0x120/0x3c0

psy_changed() caches the raw struct power_supply * in chg->tcpm_psy
without holding a reference. When the TCPM supply unbinds,
psy_work_item() gets -ENODEV, schedules a 10 ms retry, and dereferences
the freed chg->tcpm_psy pointer.

Read ONLINE and CURRENT_MAX directly inside psy_changed() where that's
safe and store the plain integer values for psy_work_item() while
dropping max77759_charger::tcpm_psy.

On read error, fall back to offline (0) so psy_work_item() disables
charging without retrying against a disappearing supply. This is fine,
because the only in-tree provider matching "tcpm-source" is tcpm, which
returns cached fields from memory. Charger I2C retries on write error
remain unchanged.

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max77759_charger.c | 55 ++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index e792327ff14f..a75005c0b582 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -77,9 +77,10 @@ struct max77759_charger {
 	struct power_supply *psy;
 	struct regulator_dev *chgin_otg_rdev;
 	struct notifier_block nb;
-	struct power_supply *tcpm_psy;
 	struct delayed_work psy_work;
-	struct mutex retry_lock; /* Protects psy_work_retry_cnt */
+	struct mutex retry_lock; /* Protects psy_work state below */
+	int tcpm_current_limit;
+	int tcpm_online;
 	u32 psy_work_retry_cnt;
 	int irqs[NUM_IRQS];
 	struct mutex lock; /* protects the state below */
@@ -595,30 +596,15 @@ static void psy_work_item(struct work_struct *work)
 {
 	struct max77759_charger *chg =
 		container_of(work, struct max77759_charger, psy_work.work);
-	union power_supply_propval current_limit, online;
-	int ret;
-
-	ret = power_supply_get_property(chg->tcpm_psy,
-					POWER_SUPPLY_PROP_CURRENT_MAX,
-					&current_limit);
-	if (ret) {
-		dev_err(chg->dev,
-			"Failed to get CURRENT_MAX psy property, ret=%d\n",
-			ret);
-		goto err;
-	}
+	int current_limit, online, ret;
 
-	ret = power_supply_get_property(chg->tcpm_psy, POWER_SUPPLY_PROP_ONLINE,
-					&online);
-	if (ret) {
-		dev_err(chg->dev,
-			"Failed to get ONLINE psy property, ret=%d\n",
-			ret);
-		goto err;
+	scoped_guard(mutex, &chg->retry_lock) {
+		current_limit = chg->tcpm_current_limit;
+		online = chg->tcpm_online;
 	}
 
-	if (online.intval && current_limit.intval) {
-		ret = set_input_current_limit(chg, current_limit.intval);
+	if (online && current_limit) {
+		ret = set_input_current_limit(chg, current_limit);
 		if (ret) {
 			dev_err(chg->dev,
 				"Unable to set current limit, ret=%d\n", ret);
@@ -660,16 +646,35 @@ static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
 {
 	struct max77759_charger *chg = container_of(nb, struct max77759_charger,
 						    nb);
+	union power_supply_propval current_limit, online;
 	static const char *psy_name = "tcpm-source";
 	struct power_supply *psy = data;
+	int ret;
 
 	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)) ||
 	    evt != PSY_EVENT_PROP_CHANGED)
 		return NOTIFY_OK;
 
-	chg->tcpm_psy = psy;
-	scoped_guard(mutex, &chg->retry_lock)
+	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
+					&online);
+	if (!ret && online.intval)
+		ret = power_supply_get_property(psy,
+						POWER_SUPPLY_PROP_CURRENT_MAX,
+						&current_limit);
+	if (ret) {
+		if (ret != -ENODEV)
+			dev_err(chg->dev,
+				"Failed to get supplier psy property: %d\n",
+				ret);
+		online.intval = 0;
+	}
+
+	scoped_guard(mutex, &chg->retry_lock) {
+		chg->tcpm_online = online.intval;
+		chg->tcpm_current_limit = online.intval ?
+					  current_limit.intval : 0;
 		chg->psy_work_retry_cnt = 0;
+	}
 
 	schedule_delayed_work(&chg->psy_work, 0);
 

-- 
2.56.1.839.g22a8290db9-goog

