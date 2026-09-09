Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060214A0921;
	Wed,  9 Sep 2026 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991494; cv=none; b=bRwiXpJ0V0rI6n2uusBdxmz6RVPRTZE8Mj+WHyw7PXthUisuKHnwTb5hJor5vgKOTXKg+z4CQCqmuoXq+vd+VaO49PF6g3fqzsYKrHvBwaaA//wz73lxiNfnWbXCgmsEbNzh9Dc9skIwsUvA/csi/TCJFBSLmjvJOpmycJj+ww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991494; c=relaxed/simple;
	bh=M/aymMCxdad6o8xZrcE7yr4IgP4ULSikmAxmrW9dYkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IQdkJj5HvH1ylcoVdphleK6rkPpwJPvFyRBdgaXGKaIivvPUYuGxkNaobkR8N2LDq4gKadpAlj6y3bJB29qnavz9Cj5pddPQrGsg0AF1l6lG1eJWMGByP4NVsr7dHC/9ItJQg1ATWYXJxtbaNSoNr8X9VUZYdPV2jhvrCTIRuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fy9mL7b8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fy9mL7b8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A3081576;
	Wed,  9 Sep 2026 15:04:47 -0700 (PDT)
Received: from oss-apollo7005.lab.cambridge.arm.com (oss-apollo7005.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBD653F7D8;
	Wed,  9 Sep 2026 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788991490; bh=M/aymMCxdad6o8xZrcE7yr4IgP4ULSikmAxmrW9dYkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fy9mL7b8SXMoStw25MlOMMYqYLALUBODLEhk3PWiXpC1ftRwqhP0cY+kyG71gFj7H
	 uDMqRoYBytAhkSnrH99aNtO4+KcfEgprWQtxQdsh83d+pYODSrHx9Xw44fln+dB9FD
	 kx+uH2Ej5d+P5RS9MU5JXN/e7a2qiUNiISLNX1Gs=
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
Subject: [PATCH v9 01/13] powercap: Add enable disable control-type
Date: Wed,  9 Sep 2026 22:04:25 +0000
Message-Id: <20260909220437.1254412-2-philip.radford@arm.com>
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

Add functionality to disable or enable the Powercap control-type by writing
directly into sys/class/powercap/arm-scmi/enabled.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V8->V9
- added check to powercap_set_root_children_enable to make sure it is configurable
- added rollback in powercap_control_type_set_enable in case of failure of one root zone
---
 drivers/powercap/arm_scmi_powercap.c | 197 ++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index ab66e9a3b1e2..96d55921fefc 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -33,13 +33,193 @@ struct scmi_powercap_zone {
 
 struct scmi_powercap_root {
 	unsigned int num_zones;
+	bool enabled;
+	struct list_head node;
 	struct scmi_powercap_zone *spzones;
 	struct list_head *registered_zones;
 	struct list_head scmi_zones;
 };
 
+static LIST_HEAD(scmi_powercap_roots);
+static DEFINE_MUTEX(scmi_powercap_roots_lock);
+
 static struct powercap_control_type *scmi_top_pcntrl;
 
+static bool scmi_powercap_is_control_type_child(const struct scmi_powercap_zone *spz)
+{
+	return spz->registered && !spz->invalid &&
+	       spz->info->parent_id == SCMI_POWERCAP_ROOT_ZONE_ID;
+}
+
+static int
+scmi_powercap_read_root_children_enable_state(struct scmi_powercap_root *pr, bool *mode)
+{
+	struct scmi_powercap_zone *spz;
+	bool enabled;
+	int i, ret;
+
+	*mode = true;
+
+	for (i = 0; i < pr->num_zones; i++) {
+		spz = &pr->spzones[i];
+
+		if (!scmi_powercap_is_control_type_child(spz))
+			continue;
+
+		ret = powercap_ops->cap_enable_get(spz->ph, spz->info->id, &enabled);
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
+static int
+scmi_powercap_set_root_children_enable_state(struct scmi_powercap_root *pr, bool enable)
+{
+	struct scmi_powercap_zone *spz;
+	bool *prev_state;
+	int i, ret;
+
+	prev_state = kcalloc(pr->num_zones, sizeof(*prev_state), GFP_KERNEL);
+	if (!prev_state)
+		return -ENOMEM;
+
+	for (i = 0; i < pr->num_zones; i++) {
+		spz = &pr->spzones[i];
+
+		if (!scmi_powercap_is_control_type_child(spz))
+			continue;
+
+		if (!spz->info->powercap_cap_config)
+			continue;
+
+		ret = powercap_ops->cap_enable_get(spz->ph, spz->info->id,
+						   &prev_state[i]);
+
+		if (ret)
+			goto revert;
+
+		if (prev_state[i] == enable)
+			continue;
+
+		ret = powercap_ops->cap_enable_set(spz->ph, spz->info->id, enable);
+		if (ret)
+			goto revert;
+	}
+
+	pr->enabled = enable;
+	kfree(prev_state);
+	return 0;
+
+revert:
+	while (--i >= 0) {
+		spz = &pr->spzones[i];
+
+		if (!scmi_powercap_is_control_type_child(spz))
+			continue;
+		if (!spz->info->powercap_cap_config)
+			continue;
+		if (prev_state[i] == enable)
+			continue;
+
+		powercap_ops->cap_enable_set(spz->ph, spz->info->id, prev_state[i]);
+	}
+
+	kfree(prev_state);
+	return ret;
+}
+
+struct scmi_powercap_root_state {
+	struct scmi_powercap_root *pr;
+	bool prev_enabled;
+};
+
+static int
+scmi_powercap_control_type_set_enable(struct powercap_control_type *pct, bool mode)
+{
+	struct scmi_powercap_root_state *states;
+	struct scmi_powercap_root *pr;
+	int num_roots = 0, changed = 0, ret = 0;
+
+	mutex_lock(&scmi_powercap_roots_lock);
+	list_for_each_entry(pr, &scmi_powercap_roots, node)
+		num_roots++;
+
+	states = kcalloc(num_roots, sizeof(*states), GFP_KERNEL);
+	if (!states) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	list_for_each_entry(pr, &scmi_powercap_roots, node)	{
+		bool prev;
+
+		ret = scmi_powercap_read_root_children_enable_state(pr, &prev);
+		if (ret)
+			goto revert;
+
+		if (prev == mode)
+			continue;
+
+		ret = scmi_powercap_set_root_children_enable_state(pr, mode);
+		if (ret)
+			goto revert;
+
+		states[changed].pr = pr;
+		states[changed].prev_enabled = prev;
+		changed++;
+	}
+	goto out_free;
+
+revert:
+	while (changed--)
+		scmi_powercap_set_root_children_enable_state(states[changed].pr,
+				states[changed].prev_enabled);
+
+out_free:
+			kfree(states);
+
+out_unlock:
+			mutex_unlock(&scmi_powercap_roots_lock);
+
+			return ret;
+}
+
+static int
+scmi_powercap_control_type_get_enable(struct powercap_control_type *pct, bool *mode)
+{
+	struct scmi_powercap_root *pr;
+	int ret = 0;
+
+	*mode = true;
+
+	mutex_lock(&scmi_powercap_roots_lock);
+	list_for_each_entry(pr, &scmi_powercap_roots, node) {
+		ret = scmi_powercap_read_root_children_enable_state(pr, &pr->enabled);
+
+		if (ret)
+			break;
+		if (!pr->enabled) {
+			*mode = false;
+			break;
+		}
+	}
+	mutex_unlock(&scmi_powercap_roots_lock);
+
+	return ret;
+}
+
+static const struct powercap_control_type_ops scmi_powercap_control_type_ops = {
+	.set_enable = scmi_powercap_control_type_set_enable,
+	.get_enable = scmi_powercap_control_type_get_enable,
+};
+
 static int scmi_powercap_zone_release(struct powercap_zone *pz)
 {
 	return 0;
@@ -495,6 +675,16 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
 	if (ret)
 		return ret;
 
+	INIT_LIST_HEAD(&pr->node);
+
+	ret = scmi_powercap_read_root_children_enable_state(pr, &pr->enabled);
+	if (ret)
+		return ret;
+
+	mutex_lock(&scmi_powercap_roots_lock);
+	list_add_tail(&pr->node, &scmi_powercap_roots);
+	mutex_unlock(&scmi_powercap_roots_lock);
+
 	dev_set_drvdata(dev, pr);
 
 	return ret;
@@ -505,6 +695,10 @@ static void scmi_powercap_remove(struct scmi_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct scmi_powercap_root *pr = dev_get_drvdata(dev);
 
+	mutex_lock(&scmi_powercap_roots_lock);
+	list_del(&pr->node);
+	mutex_unlock(&scmi_powercap_roots_lock);
+
 	scmi_powercap_unregister_all_zones(pr);
 }
 
@@ -525,7 +719,8 @@ static int __init scmi_powercap_init(void)
 {
 	int ret;
 
-	scmi_top_pcntrl = powercap_register_control_type(NULL, "arm-scmi", NULL);
+	scmi_top_pcntrl = powercap_register_control_type(NULL, "arm-scmi",
+							 &scmi_powercap_control_type_ops);
 	if (IS_ERR(scmi_top_pcntrl))
 		return PTR_ERR(scmi_top_pcntrl);
 
-- 
2.25.1

