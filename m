Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB2C3DFC9E;
	Wed,  1 Apr 2026 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037273; cv=none; b=mWrkAToJiaJraDW/0253yChuif50BxecBdEY2so1OWH7IYOtaWNmTitytq+vWaEvCsU55B1nTtGHUcHHfZZkokmW7Y4VzXQVcv1v+7R3jyo5sNN0miJkAF49SCS6OqPp8fg3I0qH19hPzwKG+u+RZrLmGM79CfAf8Dl0gUYi7BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037273; c=relaxed/simple;
	bh=h5Ir1KiWUSZRowTk+VS/ZgfqrlKy67KWydZeVojwgsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRw6toDrPcmVFo3fsxe1Gc+zvvULVQjdLdM6smDCf5YjxIU2+JAr+z9oaZqhj5aYYdRe2hRXAa8qwnBVDayMBjsS07vuJYqD13uz7EEm3uIH8t0efeQ7HH7qaWS8o/vA4kTknC62v3ZUBM4xP/AKrv/T/yyUpAi7/Uq4gb8SqCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PAZRJbuw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PAZRJbuw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E22FA2E98;
	Wed,  1 Apr 2026 02:54:20 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D01513F7D8;
	Wed,  1 Apr 2026 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775037266; bh=h5Ir1KiWUSZRowTk+VS/ZgfqrlKy67KWydZeVojwgsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAZRJbuwARBiu7AxQeVMj7NXhgU3wVCWk5g7zLF09uCYk5TSZkZTR48e5oihFynpu
	 G+PlvaQvI7+9ccGB4s4f8x2eBzCYlpXtN8ZZCeiqwyXH2+qAvU01SB/2M3ajC4k0l/
	 uoMaO/K794QmSSKMWQwPQDEeJKR+8WQE3PKdd5Dk=
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
	Philip Radford <philip.radford@arm.com>
Subject: [PATCH v4 11/11] powercap: arm_scmi: Add get_power_uw to synthetic node
Date: Wed,  1 Apr 2026 10:53:49 +0100
Message-ID: <20260401095349.2217840-12-philip.radford@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401095349.2217840-1-philip.radford@arm.com>
References: <20260401095349.2217840-1-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exposes the current power usage from the immediate children of
the synthetic (root) powercap node. Iterates over pr->spzones and
sums per-zone power.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 29 ++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 6fc2cab30b05..53fcbf178e8c 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -270,9 +270,34 @@ static int instance_root_release(struct powercap_zone *pz)
 	return 0;
 }
 
-static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *v)
+static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *power_u)
 {
-	*v = 0;
+	struct scmi_powercap_zone *root = to_scmi_powercap_zone(pz);
+	struct scmi_powercap_zone *child;
+	struct scmi_powercap_root *pr;
+	u64 acc = 0;
+	u64 p;
+	int ret;
+
+	if (!pz || !power_uw)
+		return -EINVAL;
+
+	pr = container_of(root, struct scmi_powercap_root, agent_root);
+	if (!pr)
+		return -ENODEV;
+
+	list_for_each_entry(child, &pr->registered_zones[0], node) {
+		if (child == &pr->agent_root)
+			continue;
+
+		ret = scmi_powercap_get_power_uw(&child->zone, &p);
+		if (!ret)
+			acc += p;
+		else
+			dev_dbg(child->dev, "Failed to read child power: %u\n", ret);
+	}
+
+	*power_uw = acc;
 	return 0;
 }
 
-- 
2.47.3

