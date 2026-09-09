Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E194A68AE;
	Wed,  9 Sep 2026 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991515; cv=none; b=J4t7/kL2W/Rnj7kWhYJDuyvNdvhudxTxx9zZu3qeJuseXI3cTh1qjOURFjkZTOzwubxlEj0IlHNl+EYFyihuCISXrD70dvJosWT3Bupy0T3aERepIrpROfUB0KdIf/PqCiOfZsIHKwBwbdlDVYQjmvE/aAKCXe12cwJY37mWy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991515; c=relaxed/simple;
	bh=ef6477RX1SfbSDDZb7uxx5n4DKa8eFEJI2ut9zi+u/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MEhdH7bjmY+KyYyHVRlekk9Mq7j+MWjcrW9Pq2kI3/HpUStwGK0Ko2aRrqH5RA/NXSHA85zcWgVqOUE5WEkIaqtj6ZcxSuVu5JdNSv3AQi3iJ+k+Eh0A6As7IqMJLeoflYPKninKcP6/axpfEe9PambJe7kwQD0hqD6tyZl4FO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H9Om7Jes; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H9Om7Jes"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42BD01F02;
	Wed,  9 Sep 2026 15:05:09 -0700 (PDT)
Received: from oss-apollo7005.lab.cambridge.arm.com (oss-apollo7005.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6B6A3F7D8;
	Wed,  9 Sep 2026 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788991512; bh=ef6477RX1SfbSDDZb7uxx5n4DKa8eFEJI2ut9zi+u/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9Om7JesHCwfATNdzDlg8Qb+DhYNd9EtmOI4cYAb0ZBiMRUq+7/4z+74JJH/YlKKr
	 Py07qOOmFtmF9M9MH+kaDh0RKHSo9rL1OjiorW8XnwQ6/KiUs4oDeXFBgAv2E0Grpz
	 7sRWduRz1eY3cqKvCvdS9R0QZnsmgq3Cy9P3f+i4=
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
Subject: [PATCH v9 10/13] firmware: arm_scmi: add Powercap MAI get/set support
Date: Wed,  9 Sep 2026 22:04:34 +0000
Message-Id: <20260909220437.1254412-11-philip.radford@arm.com>
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

Add support for Power Measurement Averaging Interval (MAI) get and set
operations to the SCMI powercap protocol driver. Extends scmi_powercap_info
to store MAI configuration and implement MAI get/set via xfer and optional
fast-channel support.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V8->V9
- Separated out domain specific fastchannel initialisation from per-cpl loop
- Amended per-cpl fast channels to use firmware cpl id instead of relying on
  num_cpli numbering
---
 drivers/firmware/arm_scmi/powercap.c | 175 ++++++++++++++++++++++++---
 include/linux/scmi_protocol.h        |  18 +++
 2 files changed, 173 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 2e30bc00f056..7d426c56b9c1 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -427,6 +427,34 @@ scmi_powercap_domain_attrs_process(const struct scmi_protocol_handle *ph,
 		dom_info->notify_powercap_measurement_change =
 			SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
 
+	if (PROTOCOL_REV_MAJOR(ph->version) >= 0x3) {
+		struct scmi_msg_resp_powercap_domain_attributes_v3 *resp_v3 = r;
+
+		flags = le32_to_cpu(resp_v3->attributes);
+		if (pinfo->notify_measurements_cmd)
+			dom_info->notify_powercap_measurement_change =
+			       SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
+
+		dom_info->mai_config = SUPPORTS_POWERCAP_MAI_CONFIGURATION(flags);
+		dom_info->min_mai = le32_to_cpu(resp_v3->min_mai);
+		dom_info->max_mai = le32_to_cpu(resp_v3->max_mai);
+		dom_info->mai_step = le32_to_cpu(resp_v3->mai_step);
+
+		if (dom_info->mai_config) {
+			ret = scmi_powercap_validate(dom_info->min_mai,
+						     dom_info->max_mai,
+						     dom_info->mai_step,
+						     dom_info->mai_config);
+
+			if (ret) {
+				dev_warn(ph->dev, "Platform reported invalid MAI config for domain %d - %s\n",
+					 dom_info->id, dom_info->name);
+
+				return ret;
+			}
+		}
+	}
+
 	dom_info->extended_names = SUPPORTS_EXTENDED_NAMES(flags);
 
 	dom_info->async_powercap_cap_set =
@@ -1133,6 +1161,103 @@ static int scmi_powercap_cap_enable_get(const struct scmi_protocol_handle *ph,
 	return 0;
 }
 
+static int scmi_powercap_xfer_mai_get(const struct scmi_protocol_handle *ph,
+				      u32 domain_id, u32 *mai)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_MAI_GET, sizeof(u32),
+				      sizeof(u32), &t);
+
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(domain_id, t->tx.buf);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*mai = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int scmi_powercap_xfer_mai_set(const struct scmi_protocol_handle *ph,
+				      u32 domain_id, u32 mai)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_powercap_cap_or_pai_set *msg;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_MAI_SET, sizeof(*msg),
+				      0, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->domain_id = cpu_to_le32(domain_id);
+	msg->flags = cpu_to_le32(0);
+	msg->value = cpu_to_le32(mai);
+
+	ret = ph->xops->do_xfer(ph, t);
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
+static int
+scmi_powercap_measurements_interval_get(const struct scmi_protocol_handle *ph,
+					u32 domain_id,
+					u32 *val)
+{
+	const struct scmi_powercap_info *pc;
+	struct scmi_fc_info *fci;
+
+	if (!val)
+		return -EINVAL;
+
+	pc = scmi_powercap_dom_info_get(ph, domain_id);
+	if (!pc)
+		return -EINVAL;
+
+	fci = pc->cpli[CPL0].fc_info;
+	if (fci && fci[POWERCAP_FC_MAI].get_addr) {
+		*val = ioread32(fci[POWERCAP_FC_MAI].get_addr);
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_MAI_GET,
+				   domain_id, 0, *val, 0);
+		return 0;
+	}
+
+	return scmi_powercap_xfer_mai_get(ph, domain_id, val);
+}
+
+static int
+scmi_powercap_measurements_interval_set(const struct scmi_protocol_handle *ph,
+					u32 domain_id,
+					u32 val)
+{
+	const struct scmi_powercap_info *pc;
+	struct scmi_fc_info *fci;
+
+	pc = scmi_powercap_dom_info_get(ph, domain_id);
+	if (!pc)
+		return -EINVAL;
+
+	if (!pc->mai_config || !val || val < pc->min_mai || val > pc->max_mai)
+		return -EINVAL;
+
+	fci = pc->cpli[CPL0].fc_info;
+	if (fci && fci[POWERCAP_FC_MAI].set_addr) {
+		iowrite32(val, fci[POWERCAP_FC_MAI].set_addr);
+		ph->hops->fastchannel_db_ring(fci[POWERCAP_FC_MAI].set_db);
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_MAI_SET, domain_id, 0, val, 0);
+		return 0;
+	}
+
+	return scmi_powercap_xfer_mai_set(ph, domain_id, val);
+}
+
 static const struct scmi_powercap_proto_ops powercap_proto_ops = {
 	.num_domains_get = scmi_powercap_num_domains_get,
 	.info_get = scmi_powercap_dom_info_get,
@@ -1145,6 +1270,8 @@ static const struct scmi_powercap_proto_ops powercap_proto_ops = {
 	.measurements_get = scmi_powercap_measurements_get,
 	.measurements_threshold_set = scmi_powercap_measurements_threshold_set,
 	.measurements_threshold_get = scmi_powercap_measurements_threshold_get,
+	.measurements_interval_get = scmi_powercap_measurements_interval_get,
+	.measurements_interval_set = scmi_powercap_measurements_interval_set,
 };
 
 static void scmi_powercap_domain_init_fc(const struct scmi_protocol_handle *ph,
@@ -1154,14 +1281,14 @@ static void scmi_powercap_domain_init_fc(const struct scmi_protocol_handle *ph,
 
 	for (int id = 0; id < dom_info->num_cpli; id++) {
 		struct scmi_fc_info *fc;
-		u32 *cpl_id, zero_cpl_id = 0;
+		u32 *cpl_id;
+		u32 cpl_fw_id = dom_info->cpli[id].id;
 
 		fc = devm_kcalloc(ph->dev, POWERCAP_FC_MAX, sizeof(*fc), GFP_KERNEL);
 		if (!fc)
 			return;
 
-		/* NOTE THAT when num_cpli == 1 the arg *cpl_id is 0 */
-		cpl_id = (PROTOCOL_REV_MAJOR(ph->version) >= 0x3) ? &id : NULL;
+		cpl_id = (PROTOCOL_REV_MAJOR(ph->version) >= 0x3) ? &cpl_fw_id : NULL;
 
 		ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
 					   POWERCAP_CAP_SET, 4, dom_info->id,
@@ -1188,29 +1315,37 @@ static void scmi_powercap_domain_init_fc(const struct scmi_protocol_handle *ph,
 						dom_info->id, cpl_id,
 						&fc[POWERCAP_FC_XAI].get_addr, NULL,
 						&fc[POWERCAP_FC_XAI].rate_limit);
-			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
-							POWERCAP_MAI_SET, 4,
-							dom_info->id, &zero_cpl_id,
-							&fc[POWERCAP_FC_MAI].set_addr,
-							&fc[POWERCAP_FC_MAI].set_db,
-							&fc[POWERCAP_FC_MAI].rate_limit);
-
-			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
-							POWERCAP_MAI_GET, 4,
-							dom_info->id, &zero_cpl_id,
-							&fc[POWERCAP_FC_MAI].get_addr, NULL,
-							&fc[POWERCAP_FC_MAI].rate_limit);
 
-			ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
-							POWERCAP_MEASUREMENTS_GET, 4,
-							dom_info->id, &zero_cpl_id,
-							&fc[POWERCAP_FC_MEASUREMENT].get_addr, NULL,
-							&fc[POWERCAP_FC_MEASUREMENT].rate_limit);
 		}
 
 		dom_info->cpli[id].fc_info = fc;
 	}
 
+	if (PROTOCOL_REV_MAJOR(ph->version) >= 0x3) {
+		u32 zero_cpl_id = 0;
+
+		fc_cpl0 = dom_info->cpli[CPL0].fc_info;
+
+		ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+					   POWERCAP_MAI_SET, 4,
+					   dom_info->id, &zero_cpl_id,
+					   &fc_cpl0[POWERCAP_FC_MAI].set_addr,
+					   &fc_cpl0[POWERCAP_FC_MAI].set_db,
+					   &fc_cpl0[POWERCAP_FC_MAI].rate_limit);
+
+		ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+					   POWERCAP_MAI_GET, 4,
+					   dom_info->id, &zero_cpl_id,
+					   &fc_cpl0[POWERCAP_FC_MAI].get_addr, NULL,
+					   &fc_cpl0[POWERCAP_FC_MAI].rate_limit);
+
+		ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
+					   POWERCAP_MEASUREMENTS_GET, 4,
+					   dom_info->id, &zero_cpl_id,
+					   &fc_cpl0[POWERCAP_FC_MEASUREMENT].get_addr, NULL,
+					   &fc_cpl0[POWERCAP_FC_MEASUREMENT].rate_limit);
+	}
+
 	if (PROTOCOL_REV_MAJOR(ph->version) < 0x3) {
 		fc_cpl0 = dom_info->cpli[CPL0].fc_info;
 		ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 583122037bf6..eeb5e609e782 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -658,6 +658,12 @@ struct scmi_powercap_cpl_info {
  *		       reports power data on an abstract linear scale.
  * @extended_names: Support for long names.
  * @fastchannels: Support for at least one fastchannel,
+ * @mai_config: MAI configuration support.
+ * @min_mai: Minimum supported Power Measurement Averaging Interval in
+ *			microseconds.
+ * @max_mai: Maximum supporte Power Measurement Averaging Interval in
+			microseconds.
+ * @mai_step: Step size between supported MAI values in microseconds.
  * @name: name assigned to the Powercap Domain by platform.
  * @sustainable_power: Maximum sustainable power consumption for this domain
  *		       under normal conditions.
@@ -679,6 +685,10 @@ struct scmi_powercap_info {
 	bool powercap_scale_uw;
 	bool extended_names;
 	bool fastchannels;
+	bool mai_config;
+	u32 min_mai;
+	u32 max_mai;
+	u32 mai_step;
 	char name[SCMI_MAX_STR_SIZE];
 	unsigned int sustainable_power;
 	unsigned int accuracy;
@@ -737,6 +747,10 @@ struct scmi_powercap_info {
  * @measurements_threshold_get: get the currently configured low and high power
  *				thresholds used when registering callbacks for
  *				notification POWERCAP_MEASUREMENTS_NOTIFY.
+ * @measurements_interval_get: get the current Power Measurement Averaging
+ *				Interval (MAI) value for the specified domain.
+ * @measurements_interval_set: set the Power Measurement Averaging Interval
+ *				(MAI) value for the specified domain.
  */
 struct scmi_powercap_proto_ops {
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
@@ -762,6 +776,10 @@ struct scmi_powercap_proto_ops {
 	int (*measurements_threshold_get)(const struct scmi_protocol_handle *ph,
 					  u32 domain_id, u32 *power_thresh_low,
 					  u32 *power_thresh_high);
+	int (*measurements_interval_get)(const struct scmi_protocol_handle *ph,
+					 u32 domain_id, u32 *val);
+	int (*measurements_interval_set)(const struct scmi_protocol_handle *ph,
+					 u32 domain_id, u32 val);
 };
 
 enum scmi_pinctrl_selector_type {
-- 
2.25.1

