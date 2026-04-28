Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888F53ECBC4;
	Tue, 28 Apr 2026 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367407; cv=none; b=gyzl8vXPGpwZ7Ip7B98QUITQxSbMg0kZHBCPCyqfEcDZYeDFVY5fwOW6GZnE14CIstobrikJ3DzD7Rw0jwrI7nLyZfe5k04xLjgJLFJXtIe6hN8RAvr/J3ZWIk+Eo8ns2fC+kait5+FZgeINpMUJ9ijTi5nMbufJE2ulCuBd7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367407; c=relaxed/simple;
	bh=oOi5+FezjQ1e4aYyhZu1Gg6yAKds2xcysyHCBosKTyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enp8VI1J8rW+yCu1EP3OdzR8vmT5aJOHz+hOqTjhUOBiF/UyrhzAMZ1s0VCW1w2utXiiQFhMmoQkvDQaLBsZdVF3T4Gt3as0QKin36InfXtySyDMNCw2JlZH0H2HXo3i3ILFyRPmpH4R6wayxtrniIa0acyRXc3MT88Sk8PGU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PB4Qye36; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PB4Qye36"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C50515A1;
	Tue, 28 Apr 2026 02:10:00 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98DD43F62B;
	Tue, 28 Apr 2026 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777367405; bh=oOi5+FezjQ1e4aYyhZu1Gg6yAKds2xcysyHCBosKTyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PB4Qye368hQF247pfeKONgd9KffNTVB+6mns4vpxfnYS3Af2Sm3C8nFbGy7yirghc
	 +BtF6RgfwYNP49ABKyT43K7eMq7QvtvBPHSXn4Vott8GDxcmWUN6zg02SNvoRkkBV6
	 WdWTEabO8+9fpkBOpMHcD19jqr86xTlb8vsXEEt0=
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
Subject: [PATCH v5 11/12] powercap: arm_scmi: Add get_power_uw to synthetic node
Date: Tue, 28 Apr 2026 10:09:20 +0100
Message-ID: <20260428090922.346069-12-philip.radford@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428090922.346069-1-philip.radford@arm.com>
References: <20260428090922.346069-1-philip.radford@arm.com>
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
index d74869af1633..81b5214acda4 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -270,9 +270,34 @@ static int instance_root_release(struct powercap_zone *pz)
 	return 0;
 }
 
-static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *v)
+static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *power_uw)
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
+	pr = container_of(root, struct scmi_powercap_root, instance_root);
+	if (!pr)
+		return -ENODEV;
+
+	list_for_each_entry(child, &pr->registered_zones[0], node) {
+		if (child == &pr->instance_root)
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

