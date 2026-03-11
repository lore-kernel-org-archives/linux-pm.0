Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971D3DE43C
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230204; cv=none; b=Pn/g3jL7AY/A7guh2d/DvIUGzlKG3WA++tpo7j6yEm283d/ghIsG96mBE05N6A1eSy+qNiXxYJpgakkr2ALo/lge6jt02pkUWIYdiokp19pz+mGzDsIydqEHCd1Ui6FCkxFo5EDfZXdMGoC5IW0Z9Wo/vb4FBvhaZGSH1z9jacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230204; c=relaxed/simple;
	bh=xDe5OwkC59HG0l6E9h1OwEErzx9ysv39/KByzvSAFgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hb+V37e/b9FiByHJeQAkDBrwlfHVy9HACHfeEfksDy1yMdkX5EFmo7tOMU62iSia0Mt7b4QEjrwscjFgGmTbV3k8qo4OPRNjgwqZynuvX0Vqf8nj+ORlN5n4/BTPN87Q8DkS8lEgmmpV/dnjrXx75bI1enQ5aAt8tnQL8Mh9Uuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=dyJjo875; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="dyJjo875"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so5439306f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773230200; x=1773835000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AEOePYJtU4kn4mkWQfK7NUJrP7JZP+VFvVN1gskxyo=;
        b=dyJjo875bTZ6pO3TqpaO01tsiMFah/dqy0Ao27bDjB2En92LEuFexwjG9ur38dB74p
         xxLHEb/3ekk0dVh5HGpMbRRtkBNeJQQd/6HmYnS2SOYqRshKoADq7nZC2cJzDN7dLKFK
         L79mpZlZd0VMXWHhf/4oxcRLAhSw9C7euJkC+uNYZdFC3Cwipdi9MdLMlevltSi6844p
         z3iN8irHx7FDlaiB0qM9DMTABv1N1DdLXPWVPL/A0Gv1cQC1pkkaytp1PTgntlM5HIkZ
         b6ZI0W2AkBRpwMW48YRGWystVbm7UaqAGQOuUP/zWFtcrwFOiSyo/mIzS6qMAXP6iDs+
         gGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230200; x=1773835000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3AEOePYJtU4kn4mkWQfK7NUJrP7JZP+VFvVN1gskxyo=;
        b=XWfGnfwyszb9YwagMGDoalJghk57TGN8aLkcgbtWHoPdRONQjT4G/vyy62RUUMlRC8
         3V2QXcJHJCt00tnG+iELd22IPw1JDTdpysffi7P/DEOEuBoU0gXL9j7bP0MpL3zvm52J
         P0HPep/renXuDlWW9VTq+ZtIwT8CV/zdHrZdw35HdaTDu+oNoBn96NvZ9JVv9iRTq+C7
         iwf/gsgZmwS7gwPrWQzrLsPcgQq9DRzjbY2EPd0Ivqgh1P/QubsYXdG9K0lL3dY3GVd0
         nVoIgRkjoh6RI6Fs/FSHxNXFZ+KwwR8vhkAUdvfoNKbokpuQUS5CLzFvZ0PCqb2PupbI
         XXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1QZ41dbiM0R7arYLIctZDaxtxCUdruHPJR+47yu4EPyRj4ZFV0z9IhXD1usaXVAVE0UW2+RHNw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+S0c5GPhAeFXsxsfPbZOgc9xg2lg6i9dEjEJNXKmt6QT4IP6/
	MR/ZhnlhZdXAWAZBl20Ui4AzAzkdG0cnjccZuQG8WWPo9gNCJmsOVE7Oa5kh/mrdC3M=
X-Gm-Gg: ATEYQzya84C7t5Tin7GlX5UQIl9EZmNYLlkaWECneHQ7uraa8Wm59C4OqflsUwAxZev
	1N4vXPaHzpNXM3CxRgoeb8SgSvbKFpNGQHykWZGbJVwbyUPfkPyxyInXNYdC0D1yWjTVtuJx1Uu
	XDPUX+nOZhaZL2N9l6Yxjz+xAKpnlKoOqcumOGqMh8MQ+4YlgI6Yczf1irfpS61qrIvNVqfkSYl
	i4kOXEXh/ICl3nZE3eovVV4M4oUMB6qELl8y0/8U43r6iYB/anXHPVj2fbSLa8NNh9kJ+/Tra7e
	IQne4Hq8HSdu2Cg0Y9beOP/UsaYHFEPoUzDsDHido4Pp4blE5RvlpTLyctGJyC/GOFhvLRfRj9W
	+FZ9yMoniaNLGap1+jOVAwZnAacKDp2vg9NeyTlpTmaYKXZK+13yoNR6eNVdfeoB/FLDGoU32as
	Uc7zuR/HIpQGb6YVcNAE4zYCilEL8RuY7PLOaNsmKgfll1KzpRN8zJcWZIblpFGsLJibDFeM0Vw
	X4cKQ==
X-Received: by 2002:a05:600c:154d:b0:485:3a59:99ca with SMTP id 5b1f17b1804b1-4854b109cb4mr38226145e9.16.1773230199754;
        Wed, 11 Mar 2026 04:56:39 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm39586485e9.1.2026.03.11.04.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:56:39 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 15:56:21 +0400
Subject: [PATCH v4 08/11] power: supply: bq257xx: Add fields for 'charging'
 and 'overvoltage' states
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bq25792-v4-8-7213415d9eec@flipper.net>
References: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
In-Reply-To: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3105; i=alchark@flipper.net;
 h=from:subject:message-id; bh=xDe5OwkC59HG0l6E9h1OwEErzx9ysv39/KByzvSAFgU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRujEj2jLXpr3h9Y2aA1/I02b6LBz+p8BlkH6tdcEzGz
 PX5k+khHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEz1vSBGhlPs2w+Y1UpWHvoX/U3Lc5pXhMyUycksmp7/fA7KqL33aWNkaCy4WC9
 Yc9E0jyH6+8aqSfFLN563dg40/H7M717ZxTXbOAA=
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
2.52.0

