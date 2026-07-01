Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8DF48BD42;
	Wed,  1 Jul 2026 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910687; cv=none; b=mVMO1BQAy6k3IIUQnF1S6LGlzkyL3kTRx3BPnvU6vTt/dprRD0pMVCl2VTsxFMgnWhKx01QsdChEo8NWD8PNPqgHhRHkmS4D/chdiDonQBZw5Bo4xJYK8iWVqOnmQLe+0gtdbWgJqAuyxyzcu3WvlfBE7B3LRNZDVTCRy92BpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910687; c=relaxed/simple;
	bh=p3qMpjUZwo/8kPo/OA4+5ZyaP3kzjJMWb3Hdwz0VXRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gongq9ouRre74waYyvze4k+N264a3gaHf/eBECQdLdyc7RDAUWhHtXSDkEYmYkITB7u+16y7qWfG0bN4eMo4tZlQsTM6X0IFCKiJr5Hdiz1zVMphhQcyInPRf6URFXWLiFAeV1K0fD4MIMbPqSyX5wDYsv3XDmXNfCpSsiqDN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iwqzG8PI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iwqzG8PI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A182237B;
	Wed,  1 Jul 2026 05:58:01 -0700 (PDT)
Received: from oss-apollo7005.oss.cambridge.arm.com (oss-apollo7005.oss.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F7CD3F85F;
	Wed,  1 Jul 2026 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782910685; bh=p3qMpjUZwo/8kPo/OA4+5ZyaP3kzjJMWb3Hdwz0VXRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwqzG8PIXLpw+P/FqlSGAmik7W2ph1xZd9lfZFtY5vf1pb+cxax/Zb4TYerNGbIjR
	 hSmDQZKWIOp06MOyWKT8TM1EK4G2QckHEiMfy3GnDun/SUdK2ZqcFM6sbJJGnPsW/n
	 prP/Eo5OtY2yJqfe3vTxQmom0MOdefBRJGqZ50Bg=
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
Subject: [PATCH v8 01/13] powercap: Add enable disable control-type
Date: Wed,  1 Jul 2026 12:57:35 +0000
Message-Id: <20260701125747.407921-2-philip.radford@arm.com>
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

Add functionality to disable or enable the Powercap control-type by writing
directly into sys/class/powercap/arm-scmi/enabled.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 155 ++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index ab66e9a3b1e2..e33829d5c551 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -33,13 +33,151 @@ struct scmi_powercap_zone {
 
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
+static int
+scmi_powercap_control_type_set_enable(struct powercap_control_type *pct, bool mode)
+{
+	struct scmi_powercap_root *pr;
+	int ret = 0;
+
+	mutex_lock(&scmi_powercap_roots_lock);
+	list_for_each_entry(pr, &scmi_powercap_roots, node) {
+		ret = scmi_powercap_set_root_children_enable_state(pr, mode);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&scmi_powercap_roots_lock);
+
+	return ret;
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
@@ -495,6 +633,16 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
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
@@ -505,6 +653,10 @@ static void scmi_powercap_remove(struct scmi_device *sdev)
 	struct device *dev = &sdev->dev;
 	struct scmi_powercap_root *pr = dev_get_drvdata(dev);
 
+	mutex_lock(&scmi_powercap_roots_lock);
+	list_del(&pr->node);
+	mutex_unlock(&scmi_powercap_roots_lock);
+
 	scmi_powercap_unregister_all_zones(pr);
 }
 
@@ -525,7 +677,8 @@ static int __init scmi_powercap_init(void)
 {
 	int ret;
 
-	scmi_top_pcntrl = powercap_register_control_type(NULL, "arm-scmi", NULL);
+	scmi_top_pcntrl = powercap_register_control_type(NULL, "arm-scmi",
+							 &scmi_powercap_control_type_ops);
 	if (IS_ERR(scmi_top_pcntrl))
 		return PTR_ERR(scmi_top_pcntrl);
 
-- 
2.25.1

