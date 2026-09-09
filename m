Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAB74A6897;
	Wed,  9 Sep 2026 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991513; cv=none; b=VGmhr51EuKweUDcco0cFXJSNWlQ9RosyZKdLSyLSezR4tglw5hV/tBKcJBCWynsD4UuwQU0DC6kA48ZG8QZTjJ/uuiAACwKlSPdiGX8UsKW7psM3L6dlbRxQXt1ik0CsH9//UxutJaM/pwvXggusFFfKdmvJ4WBClD0eZoXTTOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991513; c=relaxed/simple;
	bh=aknyCKmZa6bn8Vc/kSGrTAa8/4N0iLTZTK5+nRuMgKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVna+92Bdpz8rzRoOQcIExs2vmRM70PWAEfG4+LwBpUn65HKHNIFbgoCZiYJYWIncFfOn03E5ksQOrACLAG8caxiRTgNo8wcILz5uIGO4lPp7IRmO3XXX76cSBxHOoPGU8nRtapCor0UHAFsZ2IWOOkjEg4aJTDl1+VYgseBhiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gplb/gyJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gplb/gyJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F21BD1D31;
	Wed,  9 Sep 2026 15:05:06 -0700 (PDT)
Received: from oss-apollo7005.lab.cambridge.arm.com (oss-apollo7005.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4908E3F7D8;
	Wed,  9 Sep 2026 15:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788991510; bh=aknyCKmZa6bn8Vc/kSGrTAa8/4N0iLTZTK5+nRuMgKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gplb/gyJeohXIPitwZP2G3RjpNt5XEw/W5q73ElKR0adExkca+Fs7Yhsj5yVMIvls
	 MeVGIiqdKhnRFCrEvlYiN4OXBJgN7kYFpRd+AnuRf6dI07fcJ6y71Ij3cJU0ZdHc6v
	 PS7lY+TCP65/Tpsw6xv1cIK19qC7QcWutQj4UUcA=
From: Philip Radford <philip.radford@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	d-gole@ti.com,
	souvik.chakravarty@arm.com,
	philip.radford@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v9 09/13] powercap: arm_scmi: Enable multiple constraints support
Date: Wed,  9 Sep 2026 22:04:33 +0000
Message-Id: <20260909220437.1254412-10-philip.radford@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260909220437.1254412-1-philip.radford@arm.com>
References: <20260909220437.1254412-1-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cristian Marussi <cristian.marussi@arm.com>

Initialize the domains with all the discovered available constraints,
making available multiple per-domain constraints when the platform has
advertised support for multiple concurrent power limits.

CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: linux-pm@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
[Philip: Amended Copyright]
Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V8->V9
- Added validation check to make sure powercap domain doesn't have too
many constraints
---
 drivers/powercap/arm_scmi_powercap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 2d9370aaaf5d..bcd1ba0bde8c 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -2,7 +2,7 @@
 /*
  * SCMI Powercap support.
  *
- * Copyright (C) 2022 ARM Ltd.
+ * Copyright (C) 2022-2026 ARM Ltd.
  */
 
 #include <linux/device.h>
@@ -491,7 +491,7 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
 
 	z = powercap_register_zone(&spz->zone, scmi_top_pcntrl, spz->info->name,
 				   parent ? &parent->zone : NULL,
-				   &zone_ops, 1, &constraint_ops);
+				   &zone_ops, spz->info->num_cpli, &constraint_ops);
 	if (!IS_ERR(z)) {
 		spz->height = scmi_powercap_get_zone_height(spz);
 		spz->registered = true;
@@ -649,6 +649,13 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 		 */
 		spz->info = powercap_ops->info_get(ph, i);
 
+		if (spz->info->num_cpli > MAX_CONSTRAINTS_PER_ZONE) {
+			dev_err(dev, "Powercap domain %s has too many constraints: %u > %u\n",
+				spz->info->name, spz->info->num_cpli,
+				MAX_CONSTRAINTS_PER_ZONE);
+			return -EINVAL;
+		}
+
 		spz->dev = dev;
 		spz->ph = ph;
 		spz->spzones = pr->spzones;
-- 
2.25.1

