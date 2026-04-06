Received: from outbound.mr.icloud.com (p-west2-cluster1-host7-snip4-10.eps.apple.com [57.103.68.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBFF34DB4F
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775509125; cv=none; b=KNVNSoV1oLT8KrZos+CIbxIC5K1g6mk+Ttv73UsywVs/aafRBhj8W1iJ4Wh50tKAy2rXEUcFb+nn4G+LIsFBzqfYl7iStrSSBZ9ih+RRya4Ff8abQ3U6ASm1z+SFbObotkaxs3MggdxWUCwFwb+046UdB3H5dlolHYmdpgTsDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775509125; c=relaxed/simple;
	bh=Zol/c0u8gCjk/y6PHCslM73cSPGCqj/H69tMcdzX81w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYrD6Fn3+sVE3QXAV/6exYRsF5WPJ+PsJH39N20QvmEJWR4v+L85RJyz/5bhBWrc1oek3tl2A+lbCzARdejdnaqyZLcEQTb6eR6pdAztG8rkLe3neci9O+4oYj7Z8tCbcU5kO4nV/mjhwFLcvCckQ841dGm6WrzL+ehdGZ5mLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gYcuxApL; arc=none smtp.client-ip=57.103.68.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gYcuxApL"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id 74768180025D;
	Mon, 06 Apr 2026 20:58:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775509122; x=1778101122; bh=DiS+2JdIdao6qBuf3XG7vMy/ZCz17zV/PBWGg3obMj4=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=gYcuxApL5XT9UcsEzQlE0qeT2g639FkfTq59hivF/Fuq887k8+qH+mUWNro9cF0zPlNIyXfqdDOTUyG/n6stpsTepFuZB7cjcCg2aYLD8LUQZzdzUVvi8XjrKCHtqdsCgxWFugIRGjZz/GOYOmwRnqwyL2vtcd5Alu76k89vXLFLX+evYkzYCIbszcV4m1OXZorlrB3p0IsLG94CZLwz3OzT1qoxggg0Vikudk4081LEXgssejCArdpKQDHhD1PXb5goFgHoU9gCH6PYUZuyJVj4Bx23haxVIGjpOWoKfReYi43HkM9hEU5hGk0TzO+Y8sG1KTRxM6Yb/1Asvw//ug==
Received: from bigre.tail98293.ts.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id 4D205180024D;
	Mon, 06 Apr 2026 20:58:41 +0000 (UTC)
From: Vincent Cloutier <vincent.cloutier@icloud.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Cloutier <vincent@cloutier.co>
Subject: [PATCH v1 9/9] power: supply: max17042_battery: Treat MAX17055 VChg as explicit DT setting
Date: Mon,  6 Apr 2026 16:57:57 -0400
Message-ID: <20260406205759.493288-10-vincent.cloutier@icloud.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406205759.493288-1-vincent.cloutier@icloud.com>
References: <20260406205759.493288-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDIwNiBTYWx0ZWRfX44AxglPu5EJG
 6dIMC+9miKSD1VoeXoJX7fFahNYWCI+pA4WX2/lF+jdmlopcWTh3mro380wFyiKsamJH3WG9V2t
 DkjjAyJXpvSrQshovpPRxkDf3rbyZtdCX1MhvaUacTKozeV/J0HEbHJRLDfKHHeK76gFGuXDw9j
 ZnzjXpnbXjpif6LTFhY1mqEK0Fk1thaaS8zyxT3C1iTu3jKAu4J9u6j+Y8KJL+uduARmLloLo1g
 PLQteztx7+d/Jjl3Pxiaaz0QUCcbX+18PMumPPHlNPvgRz/tekooPFgA35fIFDlUPhY4rsbjV/+
 PfYrR872FD8h1Y9ueCpAZYRatRTxbIAdSzLjucdF3UJVnFAqGeC7r5NqpPMFLg=
X-Proofpoint-ORIG-GUID: GxDoZcNreyMXcwTMtynkmbAwA0XzbhNX
X-Proofpoint-GUID: GxDoZcNreyMXcwTMtynkmbAwA0XzbhNX
X-Authority-Info-Out: v=2.4 cv=HYgZjyE8 c=1 sm=1 tr=0 ts=69d41e82
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=5j__JWfIoqoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=f01FELvby5omiHkGd7wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=846
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604060206

From: Vincent Cloutier <vincent@cloutier.co>

Handle `voltage-max-design-microvolt` as an explicit `ModelCfg.VChg`
setting for MAX17055 so batteries at or below 4.25 V clear the default
bit instead of silently keeping it set.

Signed-off-by: Vincent Cloutier <vincent@cloutier.co>
---
 drivers/power/supply/max17042_battery.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 5bf15c19fc5d..ad6a341b8a4e 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -812,8 +812,13 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 		max17042_override_por(map, MAX17047_V_empty, config->vempty);
 	}
 
-	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055) {
 		max17042_override_por(map, MAX17055_ModelCfg, config->model_cfg);
+		/* VChg is 1 by default, so allow it to be set to 0 */
+		regmap_update_bits(map, MAX17055_ModelCfg,
+				   MAX17055_MODELCFG_VCHG_BIT,
+				   config->model_cfg);
+	}
 }
 
 static int max17042_init_chip(struct max17042_chip *chip)
@@ -1039,7 +1044,7 @@ static int max17042_apply_battery_properties(struct max17042_chip *chip,
 			(info->charge_full_design_uah != -EINVAL ||
 			 info->charge_term_current_ua != -EINVAL)) ||
 		       (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055 &&
-			info->voltage_max_design_uv > 4250000);
+			info->voltage_max_design_uv != -EINVAL);
 	if (!needs_config)
 		return 0;
 
@@ -1068,8 +1073,9 @@ static int max17042_apply_battery_properties(struct max17042_chip *chip,
 	}
 
 	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055 &&
-	    info->voltage_max_design_uv > 4250000) {
-		chip->config_data->model_cfg = MAX17055_MODELCFG_VCHG_BIT;
+	    info->voltage_max_design_uv != -EINVAL) {
+		if (info->voltage_max_design_uv > 4250000)
+			chip->config_data->model_cfg = MAX17055_MODELCFG_VCHG_BIT;
 		chip->enable_por_init = true;
 	}
 
-- 
2.53.0

