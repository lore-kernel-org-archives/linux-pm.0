Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B364AB1A1;
	Wed,  9 Sep 2026 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991519; cv=none; b=VRx6iWMyqnrLpenbc83zSQNJG8qUuXx3YcPONd9ArM1qm9xH0cq0Q0EsJTs7Hj9E3bPaMRxNitoTbUVFjc3Q9soa03Ld6Ksd9e/y8+SRZoXi8lZ9e4eXyg+rnwZUV55FFrMBgRf6VLnsWsHKPS7K8rEQeSqRtA6WgyvSaNGnz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991519; c=relaxed/simple;
	bh=yzdZeYTmEZftojUpT9D3ZlNs2/1bcHwNlWKDhmH6rjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6u6yvQ3MyChpxwZmBHFfJWKuwTSqgKKd/xUHLWQf8TFPmEbx+yZ5HkX4JHD1i3qXNULRIrmblO+Lbw8A2Aw8/MqMqYemtshKAUM398PZC8I8gxT2cYONqNhtQHnI1WHlyo2XXF+UqP2o1fXCIzrX8Dtowtp0/hOtlg8IaFqH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=styYlpZ6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="styYlpZ6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEB7D1D31;
	Wed,  9 Sep 2026 15:05:13 -0700 (PDT)
Received: from oss-apollo7005.lab.cambridge.arm.com (oss-apollo7005.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F04E3F7D8;
	Wed,  9 Sep 2026 15:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788991517; bh=yzdZeYTmEZftojUpT9D3ZlNs2/1bcHwNlWKDhmH6rjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=styYlpZ6A25hcY3/Lug1In80sdVOazJ5jYSfhtg+Einh5vto7DMDCL3X8knill71h
	 sh1xiSZNVwzfkHQJ2PTnJRDLV5KMU3yUnOfAeiT33cOctwnQx4hHdUst4MfStjM0pe
	 i2/3CH2UvjDW5W5M0fk5wWEpYDSgEJykACJrseYo=
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
	philip.radford@arm.com
Subject: [PATCH v9 12/13] powercap: arm_scmi: Add get_power_uw to synthetic node
Date: Wed,  9 Sep 2026 22:04:36 +0000
Message-Id: <20260909220437.1254412-13-philip.radford@arm.com>
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

Exposes the current power usage from the immediate children of the
synthetic (root) powercap node. Iterates over pr->spzones and sums per-zone
power.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V8->V9
- Removed redundant if (!pr) check from instance_root_get_power_uw()
- Stopped returning a partial sum if one child read fails
---
 drivers/powercap/arm_scmi_powercap.c | 34 ++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index b5397d7675e6..aac0b00490b2 100644
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
@@ -453,9 +456,36 @@ static int instance_root_release(struct powercap_zone *pz)
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
+		if (ret) {
+			dev_dbg(child->dev, "Failed to read child power: %d\n", ret);
+			return ret;
+		}
+
+		acc += p;
+	}
+
+	*power_uw = acc;
 	return 0;
 }
 
-- 
2.25.1

