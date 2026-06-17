Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABDC3DBD47;
	Wed, 17 Jun 2026 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690397; cv=none; b=A+X0KC3mLNddMw/qhhdHtPMO/0ifCy6/hhpsvYAaw+QaAVE1JoDP2aFWRHxCLscmAKDqwQf9Ngx6CoSMxi5IGNLELUtSLOkhh2OQbsMDUzRKNs1vTxVLuaDTa7xRuqPQ6eQqzdwzubLB2r3Mu08JgAKoz5mtJcEivTco7hlulII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690397; c=relaxed/simple;
	bh=uHOz5ORKFey5MkQv6J72tUxFO1GdRC0tk8q6upiT31o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPnoDLQPZNjLRgBpfC6FQLMlSPOl2x8UwvXIAUHxsToFdCtqUyz6M2S9sNOCllO98+Iw6SFmNJYi0Q12zjtkZ2Y3dmqditkoq6i12Jjh6FbDE3fcrDLgCZwr676IfNOUktcQzmel7sU7d/DiYuxsHn9M4ahJ+utcmu9l8Oe1nTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N5UmhY/B; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N5UmhY/B"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B486D2E8E;
	Wed, 17 Jun 2026 02:59:49 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 145BC3F915;
	Wed, 17 Jun 2026 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781690394; bh=uHOz5ORKFey5MkQv6J72tUxFO1GdRC0tk8q6upiT31o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5UmhY/BgX58SNeyva122ajvksMr/g/o+INdFxIJFi3L1ONWHdNXvMJqiajDd1Qf+
	 Q6s34EIMF1IHfSeb7JLKyHWnDS8YC5vb5cQY3I9tRyO7Eseay+hgOIr0zg/aZcLQqU
	 1CIrkKeROpgaJLxH05HYpBJWv9Uwsvx0dme/sw/0=
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
Subject: [PATCH v7 10/13] firmware: arm_scmi: add Powercap MAI get/set support
Date: Wed, 17 Jun 2026 10:59:07 +0100
Message-ID: <20260617095910.1963578-11-philip.radford@arm.com>
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

Add support for Power Measurement Averaging Interval (MAI) get and set
operations to the SCMI powercap protocol driver. Extends scmi_powercap_info
to store MAI configuration and implement MAI get/set via xfer and optional
fast-channel support.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V5-V6
- Fixed commit length
- Changed warning message wording
- Fixed line lengths and alignment
- Updated docs for new fields
---
 drivers/firmware/arm_scmi/powercap.c | 127 +++++++++++++++++++++++++++
 include/linux/scmi_protocol.h        |  18 ++++
 2 files changed, 145 insertions(+)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 1800ee295b07..03ce02b1b83b 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -407,6 +407,34 @@ scmi_powercap_domain_attrs_process(const struct scmi_protocol_handle *ph,
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
@@ -1088,6 +1116,103 @@ static int scmi_powercap_cap_enable_get(const struct scmi_protocol_handle *ph,
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
@@ -1100,6 +1225,8 @@ static const struct scmi_powercap_proto_ops powercap_proto_ops = {
 	.measurements_get = scmi_powercap_measurements_get,
 	.measurements_threshold_set = scmi_powercap_measurements_threshold_set,
 	.measurements_threshold_get = scmi_powercap_measurements_threshold_get,
+	.measurements_interval_get = scmi_powercap_measurements_interval_get,
+	.measurements_interval_set = scmi_powercap_measurements_interval_set,
 };
 
 static void scmi_powercap_domain_init_fc(const struct scmi_protocol_handle *ph,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index d0f6c0102559..90615611be4a 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -654,6 +654,12 @@ struct scmi_powercap_cpl_info {
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
@@ -675,6 +681,10 @@ struct scmi_powercap_info {
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
@@ -733,6 +743,10 @@ struct scmi_powercap_info {
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
@@ -758,6 +772,10 @@ struct scmi_powercap_proto_ops {
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
2.47.3

