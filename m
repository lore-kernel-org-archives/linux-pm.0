Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F57A3E1216;
	Wed, 17 Jun 2026 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690402; cv=none; b=BJ2gor1NO0p+X49vvymTw2VHun9jdU26+acKOzby9VO+tGKkD2IDQi9Zm5bazt4tjw2z1Ft8RVWSycbr/Jp3HqesrFJqZw3szr6IYMNsMFsgLW34orvwq+jd66Qfua7UHtF9pa1E/nIfhjCiwbEyY1oyIQO+WOX2l1U472NaTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690402; c=relaxed/simple;
	bh=uQ2IxnI5PBbEK+vSVRZY0b0+hKZufqL3dFY/NKgEynE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iiy3BpX4CiFHwD1GyJSx8hIBHllaWU7k2iTrtooylgG9yHL67xOvEhMDNKpnQ84TGVFjJsx3epnIA64wGlHd+wIT2N4xE6In7CkATeORj4drH4uKsGNZvABcpggCdPTgKltY/Q3zOoiSMQo+v9W9jVkbHVNY/TcXVeWCPkBNAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fb4KH2eg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fb4KH2eg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 125F92E8E;
	Wed, 17 Jun 2026 02:59:55 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63E6A3F915;
	Wed, 17 Jun 2026 02:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781690399; bh=uQ2IxnI5PBbEK+vSVRZY0b0+hKZufqL3dFY/NKgEynE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fb4KH2egIRDRjwAOvCEK9JUixNmbOr4tnpIYvgtFlsXP0LvcktPpwHXUNErbHHcpr
	 MJDY3O2zl8+vRW01sdRkB0sT9m7TlKVq10SmkeKi+FmBxCDG9zA8bZfHVN+ZO0/eko
	 qU5wbefLXSocyDoXhnqPoG0PuG1jh2k0KNiSd7Uo=
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
Subject: [PATCH v7 12/13] powercap: arm_scmi: Add get_power_uw to synthetic node
Date: Wed, 17 Jun 2026 10:59:09 +0100
Message-ID: <20260617095910.1963578-13-philip.radford@arm.com>
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

Exposes the current power usage from the immediate children of the
synthetic (root) powercap node. Iterates over pr->spzones and sums per-zone
power.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V6->V7
- Fixed commit message length
V5->V6
- Moved multiple u64 values to the same line
- Reworked logic to walk SCMI zones and filter by parent
- Added to_scmi_powercap_root macro
---
 drivers/powercap/arm_scmi_powercap.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index d45e4af0cdc7..e1bad4b19990 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -17,6 +17,9 @@
 #define to_scmi_powercap_zone(z)		\
 	container_of(z, struct scmi_powercap_zone, zone)
 
+#define to_scmi_powercap_root(z)		\
+	container_of(z, struct scmi_powercap_root, instance_root.zone)
+
 static const struct scmi_powercap_proto_ops *powercap_ops;
 
 struct scmi_powercap_zone {
@@ -411,9 +414,37 @@ static int instance_root_release(struct powercap_zone *pz)
 	return 0;
 }
 
-static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *v)
+static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *power_uw)
 {
-	*v = 0;
+	struct scmi_powercap_root *pr = to_scmi_powercap_root(pz);
+	struct scmi_powercap_zone *child;
+
+	u64 p, acc = 0;
+	int i, ret;
+
+	if (!pz || !power_uw)
+		return -EINVAL;
+
+	if (!pr)
+		return -ENODEV;
+
+	for (i = 0; i < pr->num_zones; i++) {
+		child = &pr->spzones[i];
+
+		if (!child->registered || child->invalid)
+			continue;
+
+		if (child->info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID)
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

