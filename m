Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425423DEAD3;
	Wed, 17 Jun 2026 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690395; cv=none; b=A2uHoGT4Np2UpG4rl9AxpAs486h93TTe1lI0RYNT2GPblHshxJpKI22mD+wZTUV+W2UOD8sHdICluutOhJX1M7wsw2XnnCiYJ0mcW600+E62BFqFvG/kwco8egF20PpoBk2rbCoHdEmSbW/CJyNUZcOFQi+crUgKp1QSjZRm07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690395; c=relaxed/simple;
	bh=DaBtTc44ZyRVxzGxVQBX/VonOPX9QiFrI2KUSG4ItFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7T0VARSacikeln1GtGBpnbbUwRDZmsw8K4/HUzk6UHG0ocdllnmToTAc5xZE6QJGMJpdbrkATDz3zVh8FJMDRsn6v75QkP76YfKCM/sSLTotnLPSaXmkZq//ODk5cSW4UQz+hX1jpG3AaD0X6nDWTI7uBH+wopSIX7J1aJyJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=relyCZ52; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="relyCZ52"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12AEF483F;
	Wed, 17 Jun 2026 02:59:47 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23E2E3F915;
	Wed, 17 Jun 2026 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781690391; bh=DaBtTc44ZyRVxzGxVQBX/VonOPX9QiFrI2KUSG4ItFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=relyCZ526Tbi6T4WX9R/x+kZMFgqaAVZYrre+ucHVrkrdskmjbn43fXUyBasArqUV
	 ldXbBwNDdtYPwFn1Oa9PgHamyyviB4EPeTOTpKPyuIZMxL1//uDn/eUYRcpHrRiecV
	 LZEBHlPuhCAxuVNcqZV1A9w0LUFQnTsSwFG/r66k=
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
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Philip Radford <philip.radford@arm.com>
Subject: [PATCH v7 09/13] powercap: arm_scmi: Enable multiple constraints support
Date: Wed, 17 Jun 2026 10:59:06 +0100
Message-ID: <20260617095910.1963578-10-philip.radford@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617095910.1963578-1-philip.radford@arm.com>
References: <20260617095910.1963578-1-philip.radford@arm.com>
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
 drivers/powercap/arm_scmi_powercap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 90d1fa70b1d4..2f8a1e0ecccf 100644
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
@@ -449,7 +449,7 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
 
 	z = powercap_register_zone(&spz->zone, scmi_top_pcntrl, spz->info->name,
 				   parent ? &parent->zone : NULL,
-				   &zone_ops, 1, &constraint_ops);
+				   &zone_ops, spz->info->num_cpli, &constraint_ops);
 	if (!IS_ERR(z)) {
 		spz->height = scmi_powercap_get_zone_height(spz);
 		spz->registered = true;
-- 
2.47.3

