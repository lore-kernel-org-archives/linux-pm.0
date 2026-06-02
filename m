Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2820E3537F9
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431099; cv=none; b=s/876tC0PuL7Ko5OSTdPinCRRSRYS8Yo3il16qKVPEiJgS8Rx9/nnxVHhHj6fVAbtsr4Td/gF9I3lR4CzYWzLAhw0amdEcdyUp6Go5XrXxwiPAuH0kDePSJwXVw4N2E9FUOsjjLS5nT4liIzxc9uBaOJzNYNSWwPfAt++3OyAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431099; c=relaxed/simple;
	bh=QX6okppMDyrxTZ7OSaWmNrFDIXP96tCcnvzzlwPJ6Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkpgjwMEz4PXtjA8yqUGdQ1TB4c6D+T6vD3b5r1K/agjtBLS9vYCPuCJDOxZS2tn4wVMhSNc+ovpFfd55Lp+PcWZBo7PCPERlQGh+T+ZsPyFibnFRHRWJ4AZRJ7LTSEcrrqQjHNT/PCnoFZsA9vCE8Rmxxg04dfyeL2P+D5QVC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=ghw6GBtX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="ghw6GBtX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso107481265e9.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1780431096; x=1781035896; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aA0GAlxgKtzqwruXUmo8+gBxnOZJJsH0+VpSj9nEF8w=;
        b=ghw6GBtXWopXQ1dgGZj+xPgvtVD6W05Ne6B9iaPE8UuX8jR8CZ0/crrGPrpSCce++3
         XTIYQeqwadhhWpxltdvRFBkV4Y9nHnVqIJ/yBDHzsuNnjvvfuIRs+QR6QmzTQQm68xab
         fvuSq+ELYXpGgIVq86OYGkNMEM4A04ZpoQidR9cb1GvsQepr9TUooESx937aRFUsvYIB
         LdrInhpwFdf5VCuyV4TWkL2c9hR5PTccjTmNDYK3NbpqhAAZZblCItSr6RLdPcoCuIwf
         uUGbK3W6q/NYvfKIKFcV1krwYRJSKJn2XP5Am45x992x6tpc39jh9Q0Q9KKrfyfSNc/r
         8i5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431096; x=1781035896;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aA0GAlxgKtzqwruXUmo8+gBxnOZJJsH0+VpSj9nEF8w=;
        b=idlPjQyADkgUu0K2H80T8Ki9mQtjmT3UMGYaYwqh9zvninmJ4IqMQuSPf4cEcv3l65
         +OKqlmpBGajmjwaXSm8EksPybX+LyQrC1PhwrD+XyaXlCPj1YEsm6CVj2inp8SmOk7Cl
         Jopeth3POZR78E+j0Rev/ogrqVTxjv2khK+58nmPSSv3UtCBeB6ePKC0CXeruAZhp0Xw
         K+JTlFj6SFDXzL6FiYplMY5/L6iPus0Hxkpc8D9vJv6xbXqRI80p3us7bZXsoZIypH/W
         oG4lsv24UsCrNnRroavgXcfaXxKtyA76p1bgo8kuRLzfrtnU5a2YaDOZlRC09bfR9mNa
         GmPg==
X-Forwarded-Encrypted: i=1; AFNElJ/RhkQjMsU+GtHvbGdfXwVAvgRrS34UXjt98KeiKitqr/nw6DckzqWDpPxN+1LZl/ALb2GkrfEriQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ/Ewa4EN4CSkBFN1lbxXXGK+yg1FDooJyI1CB2+2aSUd1wde0
	tPGoibzpwxwJE6wHNMXkohekD/Zx7Swmw2QBiaZL/O+mJ1QEC2iAocEjP2bcbH1GdR0=
X-Gm-Gg: Acq92OEDTeg09pVUBhJliQ6RPBmN6cNEohz7XpaQAnr8uyg2rSuAfCeuzKJXgys/NVN
	GCn/6QF2X9jT92C1CNIePeLZGcCeIkm2o2UJszpCNIbDipZ15AC0ItT8CQAS6XdWVklKsQ2LXi4
	Z4jVr1mt8K5Sj5unzzSU3EK9v1GdRWeEeWw0pK1KfQO/0SjX9Eb28gI5OF51zHVwpM+2wiyy43X
	ku2dixuZd5QGMLe4RTUXRQdAyA60dEMrS7PW4n0ks27nTlFXRH1jCzgAQYfPqK/v9mp5/GENs6L
	ERIx67KYY5rNWDZ5qa7jQmiY2Jviri2eiE60BJ7Prg9HuzTVJ/Yba7EZue1+Ap+OJrINPQGboDa
	EY0SGxJKFi/W09kNf8QujcNkdA+SFwxsK5s8V9uG/HlG8+6Ekn7bkjM11DYvltBvJlKhesrx3L/
	/QtUKnR5Yxjt6yrWrLe0cOfzeDofDKWS1VCavkE0dzRneVfzXvGmU=
X-Received: by 2002:a05:600c:6385:b0:490:46df:a87a with SMTP id 5b1f17b1804b1-490b5e73e7dmr6125765e9.1.1780431096457;
        Tue, 02 Jun 2026 13:11:36 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63e6720sm2588515e9.13.2026.06.02.13.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:11:36 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 03 Jun 2026 00:10:53 +0400
Subject: [PATCH v7 5/7] power: supply: bq257xx: Add fields for 'charging'
 and 'overvoltage' states
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-bq25792-v7-5-d487bed276d0@flipper.net>
References: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
In-Reply-To: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105; i=alchark@flipper.net;
 h=from:subject:message-id; bh=QX6okppMDyrxTZ7OSaWmNrFDIXP96tCcnvzzlwPJ6Rw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJWzw7ULjc8EP5JC2/FXU/vcKSLBz0xafL/Oef8VW6z
 GjjH7dfHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEx1wCpGhnlqB7st5qls9NDmPChv+k6xf1/8NRFWzlMLa/S0PttpODP8FUmrSxT
 WNjKzuvzwvaHPvHwp1ZByjvT/zx0vavyenubECQA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The driver currently reports the 'charging' and 'overvoltage' states based
on a logical expression in the get_charger_property() wrapper function.
This doesn't scale well to other chip variants, which may have a different
number and type of hardware reported conditions which fall into these
broad power supply states.

Move the logic for determining 'charging' and 'overvoltage' states into
chip-specific accessors, which can be overridden by each variant as
needed.

This helps keep the get_charger_property() wrapper function chip-agnostic
while allowing for new chip variants to be added bringing their own logic.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 0765673728e4..9c082865e745 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -54,8 +54,10 @@ struct bq257xx_chip_info {
  * @bq: parent MFD device
  * @charger: power supply device
  * @online: charger input is present
+ * @charging: charger is actively charging the battery
  * @fast_charge: charger is in fast charge mode
  * @pre_charge: charger is in pre-charge mode
+ * @overvoltage: overvoltage fault detected
  * @ov_fault: charger reports over voltage fault
  * @batoc_fault: charger reports battery over current fault
  * @oc_fault: charger reports over current fault
@@ -71,8 +73,10 @@ struct bq257xx_chg {
 	struct bq257xx_device *bq;
 	struct power_supply *charger;
 	bool online;
+	bool charging;
 	bool fast_charge;
 	bool pre_charge;
+	bool overvoltage;
 	bool ov_fault;
 	bool batoc_fault;
 	bool oc_fault;
@@ -106,8 +110,10 @@ static int bq25703_get_state(struct bq257xx_chg *pdata)
 	pdata->online = reg & BQ25703_STS_AC_STAT;
 	pdata->fast_charge = reg & BQ25703_STS_IN_FCHRG;
 	pdata->pre_charge = reg & BQ25703_STS_IN_PCHRG;
+	pdata->charging = pdata->fast_charge || pdata->pre_charge;
 	pdata->ov_fault = reg & BQ25703_STS_FAULT_ACOV;
 	pdata->batoc_fault = reg & BQ25703_STS_FAULT_BATOC;
+	pdata->overvoltage = pdata->ov_fault || pdata->batoc_fault;
 	pdata->oc_fault = reg & BQ25703_STS_FAULT_ACOC;
 
 	return 0;
@@ -478,14 +484,14 @@ static int bq257xx_get_charger_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_STATUS:
 		if (!pdata->online)
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
-		else if (pdata->fast_charge || pdata->pre_charge)
+		else if (pdata->charging)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		break;
 
 	case POWER_SUPPLY_PROP_HEALTH:
-		if (pdata->ov_fault || pdata->batoc_fault)
+		if (pdata->overvoltage)
 			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		else if (pdata->oc_fault)
 			val->intval = POWER_SUPPLY_HEALTH_OVERCURRENT;

-- 
2.53.0

