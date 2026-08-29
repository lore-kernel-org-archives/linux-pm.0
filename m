Received: from tabos.org (krueger-it.net [145.239.1.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9107361670;
	Sat, 29 Aug 2026 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.1.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787982354; cv=none; b=qgmrZrbuFqjvAc8EOoAbTZoEb5rOR3u8IZayquGA+Bu9WsFr+cIyFh3/6U1T6kBrAB77VQ58B2ASKemeaavZgsddHCPb5GVqabPZ2zk9OvdsgFRy0HVy8aG/qX1B8SB2fQ7sXyrGM1Fcp5EBO+zdr/+nwQmM2NF/ZTbUfc7tF8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787982354; c=relaxed/simple;
	bh=E24dwK4cuwwXfLQzX5CReQR5mwrDCDcxJr36SS/QdMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYlVQmgW7jdcGCIoirkxYoRQzQ3yx1xC8JgkFPGHLbGUGzB9KXiOzdjtUZy7z/OGez/oK9QrGumzJZ/CVoLzQFd8wwOh306Ghx5bLah+InOt17gHj2YYS7C/63PHxqkM/CHcmx/avIr9F6yrGLUWy0VY37Ugli5cC6dd41gE9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org; spf=pass smtp.mailfrom=tabos.org; dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b=SMMRJVmY; arc=none smtp.client-ip=145.239.1.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tabos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b="SMMRJVmY"
Received: from c0d1ngstat1on.fritz.box (unknown [94.31.74.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by dserver.krueger-it.net (Postfix) with ESMTPSA id EF1E362E0AD6;
	Sat, 29 Aug 2026 07:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tabos.org;
	s=default; t=1787982351;
	bh=N1SW0mGrVZtGWZxF2NK7+a18wctDFv+987Jnlcw83Hk=; h=From:To:Subject;
	b=SMMRJVmYoInedKIrHnuczC1u4+S4tIsA/9nJUn05aeJiSVdFZWWKAHigBiePJloJr
	 4EXXvx2b+rwjzZ9GMPjnUhaZ/wSJx+FauuTVYvPdArM8e2m+yKyHmoNmaphdUsSu7S
	 6M/2htACdY0rV2Mt1k1Ci0LTv7UnXgem61lLk+sW26uN8cDA2kswA47YS2h1kc+F7s
	 3SBm0kaVb7sqJqt9NRd6w3UPmWl+3gfftbNAK65R2hniw/eKL1r8XPI4rBi2PihyHo
	 cOakTZ7sehf+tDNYMTzMRQot09c9AQi85HX+ic7cHMRmo7OGt7/bLLGE7Zt0WVDCyK
	 NgVl4pUF1rzGg==
Authentication-Results: dserver.krueger-it.net;
	spf=pass (sender IP is 94.31.74.100) smtp.mailfrom=jan.brummer@tabos.org smtp.helo=c0d1ngstat1on.fritz.box
Received-SPF: pass (dserver.krueger-it.net: connection is authenticated)
From: Jan-Michael Brummer <jan.brummer@tabos.org>
To: sre@kernel.org
Cc: andersson@kernel.org,
	neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan-Michael Brummer <jan.brummer@tabos.org>
Subject: [PATCH 2/2] power: supply: qcom_battmgr: expose CHARGE_NOW on SM8350-class firmware
Date: Sat, 29 Aug 2026 07:45:46 +0200
Message-ID: <20260829054546.86210-3-jan.brummer@tabos.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829054546.86210-1-jan.brummer@tabos.org>
References: <20260829054546.86210-1-jan.brummer@tabos.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SM8350-class firmware does not implement a dedicated 'charge now'
property. It does however report BATT_CHG_COUNTER, and on this class of
firmware that value is the remaining charge in uAh rather than a
monotonic counter. Measured on a Fairphone 5 with charge_full at
4116000 uAh:

  BATT_CHG_COUNTER   reported capacity   counter / charge_full
  2434614            59%                 59.1%
  3525354            85%                 85.6%

Map POWER_SUPPLY_PROP_CHARGE_NOW onto the same firmware property and
store the value in status.capacity, which the CHARGE_NOW/ENERGY_NOW case
of qcom_battmgr_bat_get_property() already reads.

Together with the preceding patch this gives userspace both the full
charge and the current charge. UPower now derives an energy level and
runtime estimates in both directions:

    state:               discharging      state:               charging
    energy:              14.4347 Wh       energy:              15.6003 Wh
    energy-full:         16.8807 Wh       energy-full:         18.1505 Wh
    energy-rate:         3.39313 W        energy-rate:         7.3492 W
    time to empty:       4.3 hours        time to full:        20.8 minutes

Signed-off-by: Jan-Michael Brummer <jan.brummer@tabos.org>
---
 drivers/power/supply/qcom_battmgr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 98a70e1..f7c120f 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -441,6 +441,7 @@ static const u8 sm8350_bat_prop_map[] = {
 	[POWER_SUPPLY_PROP_CYCLE_COUNT] = BATT_CYCLE_COUNT,
 	[POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN] =  BATT_CHG_FULL_DESIGN,
 	[POWER_SUPPLY_PROP_CHARGE_FULL] = BATT_CHG_FULL,
+	[POWER_SUPPLY_PROP_CHARGE_NOW] = BATT_CHG_COUNTER,
 	[POWER_SUPPLY_PROP_MODEL_NAME] = BATT_MODEL_NAME,
 	[POWER_SUPPLY_PROP_TIME_TO_FULL_AVG] = BATT_TTF_AVG,
 	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG] = BATT_TTE_AVG,
@@ -878,6 +879,7 @@ static const enum power_supply_property sm8350_bat_props[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
@@ -910,6 +912,7 @@ static const enum power_supply_property sm8550_bat_props[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
@@ -1442,7 +1445,10 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 			battmgr->info.technology = le32_to_cpu(resp->intval.value);
 			break;
 		case BATT_CHG_COUNTER:
-			battmgr->info.charge_count = le32_to_cpu(resp->intval.value);
+			val = le32_to_cpu(resp->intval.value);
+			battmgr->info.charge_count = val;
+			/* the firmware reports the remaining charge here */
+			battmgr->status.capacity = val;
 			break;
 		case BATT_CYCLE_COUNT:
 			battmgr->info.cycle_count = le32_to_cpu(resp->intval.value);
