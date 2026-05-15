Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF00366830;
	Fri, 15 May 2026 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824257; cv=none; b=CmdVTXdTl8/kvHU8nhRZBQnWTGM6FRW5PqByN3O9ihzV/7I+eMmVNeq3WKX3XjKNTLynQ3Ryl87leCu5vJnHC/M/N04ESInqmjU+abLSisB1swVuZrF3ol5ILf0ZSNmojyNJ9+4LVzVQx6QGU1bz60t2E/H/PyXAhxNTWdmCzOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824257; c=relaxed/simple;
	bh=v0n4iL+ec7ubF7WE3r+09txUZuNOlRfNgY9pxDWbRgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TENKpT/1cLKj8x58UvLGzRcpaglWXQWp1qLi1KSn5KOIOskMbFpUjFscJkTehWJIc3uMx6C/6nAxijAUkam7wdW0f3lrw3E8uU1/VmPJpyFZQzDakyJ0C2rPWCbYJmlFHmbzrrfYAM1sXECZDiQ6guGQeGbQkvPxZ0MFy0VBXws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjC6g/ue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjC6g/ue"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C94DC2BCFB;
	Fri, 15 May 2026 05:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778824257;
	bh=v0n4iL+ec7ubF7WE3r+09txUZuNOlRfNgY9pxDWbRgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hjC6g/ue5VGk+RAa2i/AZCUGdEKSMNl1UoJc9IAloUNrZ2EPx98qKWurWkR2spxYB
	 3YBFnZDqrew8K6kX/rfmlds69+6YhcTzNZ2LoiGLomdYOktvc6O0MI3leYuDB8vTUk
	 kS8cIuu3LhII3J5u/QPu4sWaxINSq6uw+qG1tfmkqK0m7xElyTRqHfXLMb+mgRMZlC
	 0D/1DWNfRsyDVszpqatmTzminHVzeVe2Y1dhI/Cg6NOQE7txSCVt5bbb+ZUPm7NqBq
	 qh0tAv/lMOveZuv0QNnv/nEwwgbYMcYkfGL1myfNrX1BUDhonbEB0vbqZZVjeX5tCQ
	 7XEusK8P1+Gdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73454CD4851;
	Fri, 15 May 2026 05:50:57 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Fri, 15 May 2026 05:48:41 +0000
Subject: [PATCH 3/3] power: supply: max17042: add handler for energy_now
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-batt-status-v1-3-fed6b7d8cea7@google.com>
References: <20260515-batt-status-v1-0-fed6b7d8cea7@google.com>
In-Reply-To: <20260515-batt-status-v1-0-fed6b7d8cea7@google.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, RD Babiera <rdbabiera@google.com>, 
 Kyle Tso <kyletso@google.com>, Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778824256; l=3946;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=rZ4iAk16d2xmYX+iRg9d3aLsjlCGLdVUfG6+D9Nq6hY=;
 b=mP5j13ZK2htM+zjnJ8ThHRPxXR/MqZXaXDsFwNM3MXuPFJnxgRn6pYa1b9P0EF0FZFZ5S6+mj
 ATw1BO4vO+EDPgUyeEPZXs0dSzHVvnkrmOZf/gtkg+HPU+v6ig8qNHs
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add handler to report power_supply_prop_energy_now so that users can get
current SoC in uWH. Additionally, add helper functions to get avg_vcell
and repcap values in uv and uah units respectively to avoid code
duplication.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/power/supply/max17042_battery.c | 60 ++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 167fb3fb3732..e16eb6985b70 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -81,6 +81,7 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
 	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
@@ -95,6 +96,36 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 };
 
+static int max17042_get_repcap_uah(struct max17042_chip *chip, u64 *rep_cap)
+{
+	u32 data;
+	int ret;
+
+	ret = regmap_read(chip->regmap, MAX17042_RepCap, &data);
+	if (ret < 0)
+		return ret;
+
+	*rep_cap = data * 5000000ll;
+	*rep_cap *= chip->task_period;
+	do_div(*rep_cap, MAX17042_DEFAULT_TASK_PERIOD);
+	do_div(*rep_cap, chip->pdata->r_sns);
+
+	return 0;
+}
+
+static int max17042_get_avgvcell_uv(struct max17042_chip *chip, u32 *vcell)
+{
+	int ret;
+
+	ret = regmap_read(chip->regmap, MAX17042_AvgVCELL, vcell);
+	if (ret < 0)
+		return ret;
+
+	*vcell = (*vcell * 625) / 8;
+
+	return 0;
+}
+
 static int max17042_get_temperature(struct max17042_chip *chip, int *temp)
 {
 	int ret;
@@ -180,14 +211,12 @@ static int max17042_get_battery_health(struct max17042_chip *chip, int *health)
 	int temp, vavg, vbatt, ret;
 	u32 val;
 
-	ret = regmap_read(chip->regmap, MAX17042_AvgVCELL, &val);
+	ret = max17042_get_avgvcell_uv(chip, &val);
 	if (ret < 0)
 		goto health_error;
 
-	/* bits [0-3] unused */
-	vavg = val * 625 / 8;
 	/* Convert to millivolts */
-	vavg /= 1000;
+	vavg = val / 1000;
 
 	ret = regmap_read(chip->regmap, MAX17042_VCELL, &val);
 	if (ret < 0)
@@ -304,11 +333,10 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data * 625 / 8;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
-		ret = regmap_read(map, MAX17042_AvgVCELL, &data);
+		ret = max17042_get_avgvcell_uv(chip, &data);
 		if (ret < 0)
 			return ret;
-
-		val->intval = data * 625 / 8;
+		val->intval = data;
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
 		ret = regmap_read(map, MAX17042_OCVInternal, &data);
@@ -350,14 +378,9 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data64;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_NOW:
-		ret = regmap_read(map, MAX17042_RepCap, &data);
+		ret = max17042_get_repcap_uah(chip, &data64);
 		if (ret < 0)
 			return ret;
-
-		data64 = data * 5000000ll;
-		data64 *= chip->task_period;
-		do_div(data64, MAX17042_DEFAULT_TASK_PERIOD);
-		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
@@ -370,6 +393,17 @@ static int max17042_get_property(struct power_supply *psy,
 		data64 = div_s64(data64, MAX17042_DEFAULT_TASK_PERIOD);
 		val->intval = div_s64(data64, chip->pdata->r_sns);
 		break;
+	case POWER_SUPPLY_PROP_ENERGY_NOW:
+		ret = max17042_get_repcap_uah(chip, &data64);
+		if (ret < 0)
+			return ret;
+
+		ret = max17042_get_avgvcell_uv(chip, &data);
+		if (ret < 0)
+			return ret;
+
+		val->intval = data64 * data / 1000000;
+		break;
 	case POWER_SUPPLY_PROP_TEMP:
 		ret = max17042_get_temperature(chip, &val->intval);
 		if (ret < 0)

-- 
2.54.0.563.g4f69b47b94-goog


