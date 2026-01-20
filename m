Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1693D5247
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 23:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768953547; cv=none; b=Xjv1k1y1R8tpTlkYeNcJLfnxUvoThAMr4B34wjPwkrHxC7kKZIGrGFzVrv616kl2ZOM2KXANdZAv1ihMoto+FGjsqy9+rGJ4qB8fY64DkUWVzRtSedYRq3bJg5Nb4QsCyQNXVEk4h9x2daOts9IDNUME8vVEFk2306s2ZMQ5UBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768953547; c=relaxed/simple;
	bh=iCgyARgrL4jNc+f7AfiLwakcw8KtvOcHUGBvFMS8Dxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPzuJNtQl4fjptaeJG9Jl8voYywbI4W7w2rKeeA318f9n9QIu/SOWp5xHXnxoVBhm0sVZO8uI564TJlgOe61n6xIf4ZiAlPh5dJdlDcwPhPPi7cwZRJOz9tB4drfhvMMS+4vWGmq1ONCuc/DTYAlh2jmeuMYt/eet+QMzHRAZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=Jdd9XQ6M; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="Jdd9XQ6M"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1768953533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G/t8n4CvPeAIf8maRs4pi1rTzryPPyw3YqamULJfMYo=;
	b=Jdd9XQ6MFA2UTzbhfvSI9aHS7nhYSc7nPicTRADMvrjdxHU7F5PJAzgHI8WdiV0yJX4YfH
	hFtiWWGXNbF+kgJhFIev2xkGzvqevwng/auxOZC6K4+BW5YArfEYaDHAqIutO7s9EDH97u
	sEoIx9nwnDJv5zVxx/GBJw100ZoeXZ33dCKaPL8amxEUQJqT6XU6NB0nzu9/w1u1EouRax
	ZuVFlo8brBcU3Fxwjy0eDbytUbtQHdfQBoo8AV4cen/KVetWHJIXziit+ywLahBpBTzNzq
	P8hGntUmvG1OmKHh2UkxtQp8ohJjgeVvZYann31qM7HMoXk+GS8D1h0P6ViKAw==
From: Val Packett <val@packett.cool>
To: Sebastian Reichel <sre@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Val Packett <val@packett.cool>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] power: supply: qcom_battmgr: Recognize "LiP" as lithium-polymer
Date: Tue, 20 Jan 2026 20:57:58 -0300
Message-ID: <20260120235831.479038-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On the Dell Latitude 7455, the firmware uses "LiP" with a lowercase 'i'
for the battery chemistry type, but only all-uppercase "LIP" was being
recognized. Add the CamelCase variant to the check to fix the "Unknown
battery technology" warning.

Fixes: 202ac22b8e2e ("power: supply: qcom_battmgr: Add lithium-polymer entry")
Signed-off-by: Val Packett <val@packett.cool>
---
v2: removed extra parentheses
v1: https://lore.kernel.org/all/20260117210941.6219-1-val@packett.cool/

 drivers/power/supply/qcom_battmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index c8028606bba0..80572ee945b4 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1240,7 +1240,8 @@ static unsigned int qcom_battmgr_sc8280xp_parse_technology(const char *chemistry
 	if ((!strncmp(chemistry, "LIO", BATTMGR_CHEMISTRY_LEN)) ||
 	    (!strncmp(chemistry, "OOI", BATTMGR_CHEMISTRY_LEN)))
 		return POWER_SUPPLY_TECHNOLOGY_LION;
-	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN))
+	if (!strncmp(chemistry, "LIP", BATTMGR_CHEMISTRY_LEN) ||
+	    !strncmp(chemistry, "LiP", BATTMGR_CHEMISTRY_LEN))
 		return POWER_SUPPLY_TECHNOLOGY_LIPO;
 
 	pr_err("Unknown battery technology '%s'\n", chemistry);
-- 
2.51.2

