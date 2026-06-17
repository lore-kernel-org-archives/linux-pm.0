Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596E53BF69E;
	Wed, 17 Jun 2026 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690373; cv=none; b=Ly9q/ROZF/eSkS+dYs1h5ZaXt/1lVv3hs53uQu8eTCq2n1ALwpiB/simdfCtycIqe8SGZfuCqRVZ9qIuu7NGMZV8qFjW31qZSfwGrSoF+msvmrF2TPnyCN5A1erpmhZAVozEGicOh7k4pS05+SC4fc/F6qJuyDQej8RcRXPNjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690373; c=relaxed/simple;
	bh=v4PQvJxXL6yAb8eVisl3HMvO3Ev5F2132vGHAZ1Y3G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEdSLRD3HkxRVJ1vhKPQiKrQFhy0+QuVDlurMycSlIHlTpsJW6I7104EHalgQhgHYWKTWnKNVtGApUBc1p7/X0U2eSaTpTKapPwXyXns2jBIyaQHC3l67+Lz6QMKhCQ59qXQ4IlLMzrHxowCSzveCTvk9jKlvRGY+Xa25AScl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ocKnKrUN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ocKnKrUN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AB124800;
	Wed, 17 Jun 2026 02:59:24 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC1E13F915;
	Wed, 17 Jun 2026 02:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781690369; bh=v4PQvJxXL6yAb8eVisl3HMvO3Ev5F2132vGHAZ1Y3G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocKnKrUNbDSGDgA+dgTEXWVBhPgJ7ntsBDPjrnt8OqAIa8r32N4spvPd7My6PyJvx
	 TUxBfqGpcPYMnbZlDMMzfcrE7k6FOTS8URajgVXp6ldMHyNNAvzzeqHVTrDFGOVYvG
	 rVE5k76a00UbE9b6wqoWjPYkuEkvXnNHaUL0XZxY=
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
Subject: [PATCH v7 01/13] powercap: Add enable disable control-type
Date: Wed, 17 Jun 2026 10:58:58 +0100
Message-ID: <20260617095910.1963578-2-philip.radford@arm.com>
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
2.47.3

