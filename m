Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60DB4921B1;
	Wed,  1 Jul 2026 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910717; cv=none; b=N/wk2B4dhHc/Kwy88MEdanUI9vfyI7FH4czDDaoTRGYgNJnnAzWRqb+1/at3KB8il/gedkTH9Cl7xeqPTl5KHCfbVvalOnPUSKoOS6CUtqO6Y3t19fmMxeQ+vF0icOLI+zl8cBbbKxkF1c5h0I+Pq9/imZB8uhTTix4Bknkat+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910717; c=relaxed/simple;
	bh=J5Zo54T4PBEcdOpVJmm5U9rGJ3i91Fo7IyoirXIQrbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IpyfxLVPxtxdzQTJXu/NH4t3kVoOymdj3fMKEqGYnBPzLdiMkh1AN14qlQoitC12Rq/kIAw268vSU6wDD8XGG1dQegL7KyMUG1uEy6ycZ3+NDBGUeiudcXihBEUeYr714z+FKWRjm4keZH5Fu9W1Lzfa728A4yC2709GCUtx7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=b3lHcacT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="b3lHcacT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C717A168F;
	Wed,  1 Jul 2026 05:58:30 -0700 (PDT)
Received: from oss-apollo7005.oss.cambridge.arm.com (oss-apollo7005.oss.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E70283F85F;
	Wed,  1 Jul 2026 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782910715; bh=J5Zo54T4PBEcdOpVJmm5U9rGJ3i91Fo7IyoirXIQrbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3lHcacTOqEFQMryKuKx8mi0s7bS3VU9kwZduRvLqWkAW4NwqgP36AgO4iKmteYb2
	 ks0/NecjUtowdDebsGk2wY+bCHm5G6dJwzwq5xMZt/QPvaUp7jALYVK3LJfriZZiX8
	 jIdTSTG3uJSlDuYLtTCsA4gb5pIcfLjigc0LO93s=
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
Subject: [PATCH v8 12/13] powercap: arm_scmi: Add get_power_uw to synthetic node
Date: Wed,  1 Jul 2026 12:57:46 +0000
Message-Id: <20260701125747.407921-13-philip.radford@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260701125747.407921-1-philip.radford@arm.com>
References: <20260701125747.407921-1-philip.radford@arm.com>
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
2.25.1

