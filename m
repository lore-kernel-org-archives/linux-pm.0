Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BC54963BF;
	Mon, 18 May 2026 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112399; cv=none; b=YowTuHD3O+ZNra/ke46tPq9LIoIZiTk2+gtDTKHQZdi6WKhJxqsqBP79vIyq8zZqjZwdZvhqhmGU8zYog8jQS4h+kLrTeDH2aXlDxRRYFBhQGIyMIx0xPUfO13W2yOS0LeHdGZHMZvgDBHpJ41bHb4o2HsKDbOklcd7CJYLVciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112399; c=relaxed/simple;
	bh=KH0xrCitYzGGE60nSgMbouzyCYUKb4SZBjGg3aYh7pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPyQwZjxyu+HXxFv+soA06sVAixrzA+r3B9fSqACILf/OqttMCppBqpPW4d46armUnUqMUeU7WiVbC5zGm+r8NUf1lL09burCUoyNA3Alp8mZsZhnP36CdF+5ASOnulIN+/8VQDmXHmKveBPK6yllb29UPpBQEr2gPSIxidWtmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vwH6sZ94; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vwH6sZ94"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8F451D6F;
	Mon, 18 May 2026 06:53:11 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3CF63F7B4;
	Mon, 18 May 2026 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779112396; bh=KH0xrCitYzGGE60nSgMbouzyCYUKb4SZBjGg3aYh7pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vwH6sZ94pQKEF0AlYLVsDstC5Q2auI9r0sFzMWXvT0xWKu9VOgcmU2z2JupkhR3uX
	 6S3D5SxWStG7c2vMklwBiNIO856MlQLr0+pPBygPxq7eDaHyBA8Zylr9HeLzjreqeE
	 8HnikLFd0U9ddIVN8JJxfKL+5S19IHIYIJsFizM4=
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
Subject: [PATCH v6 12/12] powercap: arm_scmi: Synthetic zone enable/disable
Date: Mon, 18 May 2026 14:52:34 +0100
Message-ID: <20260518135234.2953532-13-philip.radford@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518135234.2953532-1-philip.radford@arm.com>
References: <20260518135234.2953532-1-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functionality to disable and enable the synthetic zone which
also affects the immediate children of the synthetic zone by applying
the same command to them.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V5->V6
- Added use of to_scmi_powercap_root macro
- Changed instance_root_set_enable_state to bail out on any error
- Changed logic in instance_root_get_enable to not check child states
---
 drivers/powercap/arm_scmi_powercap.c | 128 +++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index f1cb25a408bb..d911e623e2d7 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -36,6 +36,7 @@ struct scmi_powercap_zone {
 
 struct scmi_powercap_root {
 	unsigned int num_zones;
+	bool enabled;
 	struct scmi_powercap_zone *spzones;
 	struct list_head *registered_zones;
 	struct list_head scmi_zones;
@@ -276,6 +277,127 @@ static int instance_root_release(struct powercap_zone *pz)
 	return 0;
 }
 
+static int instance_root_read_children_enable_state(struct scmi_powercap_root *pr,
+						    bool *mode)
+{
+	struct scmi_powercap_zone *child;
+	bool enabled;
+	int i, ret;
+
+	if (!pr || !mode)
+		return -EINVAL;
+
+	*mode = true;
+
+	for (i = 0; i < pr->num_zones; i++) {
+		child = &pr->spzones[i];
+
+		if (!child->registered || child->invalid)
+			continue;
+		if (child->info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID)
+			continue;
+
+		ret = powercap_ops->cap_enable_get(child->ph, child->info->id, &enabled);
+		if (ret)
+			return ret;
+
+		if (!enabled) {
+			*mode = false;
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
+static int instance_root_set_enable_state(struct powercap_zone *pz, bool enable)
+{
+	struct scmi_powercap_zone *child;
+	struct scmi_powercap_root *pr = to_scmi_powercap_root(pz);
+	int i, ret;
+	bool *prev_state;
+
+	if (!pz)
+		return -EINVAL;
+
+	prev_state = kcalloc(pr->num_zones, sizeof(*prev_state), GFP_KERNEL);
+	if (!prev_state)
+		return -ENOMEM;
+
+	for (i = 0; i < pr->num_zones; i++) {
+		child = &pr->spzones[i];
+
+		if (!child->registered || child->invalid)
+			continue;
+		if (child->info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID)
+			continue;
+
+		ret = powercap_ops->cap_enable_get(child->ph, child->info->id,
+						   &prev_state[i]);
+
+		if (ret)
+			goto revert;
+
+		if (prev_state[i] == enable)
+			continue;
+
+		ret = powercap_ops->cap_enable_set(child->ph, child->info->id, enable);
+
+		if (ret) {
+			dev_err(child->dev, "failed to %s zone %s: %d\n",
+				enable ? "enable" : "disable",
+				child->info->name, ret);
+			goto revert;
+		}
+	}
+
+	kfree(prev_state);
+	return 0;
+
+revert:
+	while (--i >= 0) {
+		child = &pr->spzones[i];
+
+		if (!child->registered || child->invalid)
+			continue;
+		if (child->info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID)
+			continue;
+		if (!child->info->cpli[0].cap_config)
+			continue;
+		if (prev_state[i] == enable)
+			continue;
+
+		powercap_ops->cap_enable_set(child->ph, child->info->id,
+					     prev_state[i]);
+	}
+
+	kfree(prev_state);
+	return ret;
+}
+
+static int instance_root_set_enable(struct powercap_zone *pz, bool mode)
+{
+	struct scmi_powercap_root *pr = to_scmi_powercap_root(pz);
+	int ret;
+
+	ret = instance_root_set_enable_state(pz, mode);
+	if (!ret)
+		pr->enabled = mode;
+
+	return ret;
+}
+
+static int instance_root_get_enable(struct powercap_zone *pz, bool *mode)
+{
+	struct scmi_powercap_root *pr = to_scmi_powercap_root(pz);
+
+	if (!pz || !mode)
+		return -EINVAL;
+
+	*mode = pr->enabled;
+	return 0;
+}
+
 static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *power_uw)
 {
 	struct scmi_powercap_root *pr = to_scmi_powercap_root(pz);
@@ -324,6 +446,8 @@ static const struct powercap_zone_ops instance_root_ops = {
 	.get_max_power_range_uw = scmi_powercap_get_max_power_range_uw,
 	.get_power_uw = instance_root_get_power_uw,
 	.release = instance_root_release,
+	.set_enable = instance_root_set_enable,
+	.get_enable = instance_root_get_enable,
 };
 
 static const struct powercap_zone_constraint_ops instance_root_const_ops = {
@@ -600,6 +724,10 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 	if (ret)
 		return ret;
 
+	ret = instance_root_read_children_enable_state(pr, &pr->enabled);
+	if (ret)
+		return ret;
+
 	dev_set_drvdata(dev, pr);
 
 	return ret;
-- 
2.47.3

