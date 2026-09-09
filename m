Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241F83F210A;
	Wed,  9 Sep 2026 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991501; cv=none; b=CCthUIJ2i8lllNQeJuVX4jA6xOijyA1y5XcFUfUCBuvHC7bLX+KJLEH6cn+RIeAe4CPJAbppt5fhIU/rzfb0EayyoFrmLB9Fo899/uDKCw+M1Etm7zBeC6TKscRAntgwjuAAAzdEfimhHHgIOAelVkXMUrWNBxJrGqAjZcIaVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991501; c=relaxed/simple;
	bh=zbL3g4ZseXM/rxQi03bOBSesLNwnYVQ1HasS/Y0NHoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHCYtzauVsuirHfFoRyw+5tebuNnzynliVwLv2TSCAKygcGdZ5gTN8PVHMbOYbgrHzNlnCLh3JrdE+VPwMVr8G/DVDJEm0nn1mhNJC566Y9cZG+eotM38hcApT+s/OA0ypHgdoOpEJBs8OO6uZF59dXn49nhDwi1uM49Jh/Dfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HIs0BEhC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HIs0BEhC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED736169C;
	Wed,  9 Sep 2026 15:04:54 -0700 (PDT)
Received: from oss-apollo7005.lab.cambridge.arm.com (oss-apollo7005.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4689E3FA32;
	Wed,  9 Sep 2026 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788991498; bh=zbL3g4ZseXM/rxQi03bOBSesLNwnYVQ1HasS/Y0NHoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIs0BEhCWdMr979fsoQ2qqadHEpHIoyVIdYUt3gNdWWQEW4LNV7v9BD00OECtQaYv
	 vtsILFlYJeYF2bKMgmyuFTa/VtvIDnC0/wpSwTadNCPyry0kx/uXFoPAng4B2IEUj7
	 OfpuUVyzA17gjyPWK/TGLOxZsbdaToLKkRodGMyY=
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
	philip.radford@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v9 04/13] firmware: arm_scmi: Add SCMIv4.0 Powercap basic support
Date: Wed,  9 Sep 2026 22:04:28 +0000
Message-Id: <20260909220437.1254412-5-philip.radford@arm.com>
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

From: Cristian Marussi <cristian.marussi@arm.com>

Add SCMIv4.0 Powercap support for enumerating multiple CPLs of a domain
when available.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
[Philip: Fixed sparse issues where int was expected]
Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V8->V9
- included validation of the number of cpls in iter_powercap_cpls_update_state
- re-ordered validation of cap_config and num_cpli in powercap_domain_attrs_process
- included validation of length in powercap_domain_attributes_get
- amended cap_get and cap_set referencing apl_id array index instead fo firmware CPL identifier
- added bounds check to make sure cpl_id is less than num_cpli
---
 drivers/firmware/arm_scmi/powercap.c | 495 ++++++++++++++++++++++-----
 drivers/powercap/arm_scmi_powercap.c |   2 +-
 include/linux/scmi_protocol.h        |   1 +
 3 files changed, 402 insertions(+), 96 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 4666030176c3..7ee39434a4db 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -33,6 +33,7 @@ enum scmi_powercap_protocol_cmd {
 	POWERCAP_CAP_NOTIFY = 0xa,
 	POWERCAP_MEASUREMENTS_NOTIFY = 0xb,
 	POWERCAP_DESCRIBE_FASTCHANNEL = 0xc,
+	POWERCAP_CPC_ATTRIBUTES = 0xd,
 };
 
 enum {
@@ -69,17 +70,56 @@ struct scmi_msg_resp_powercap_domain_attributes {
 	__le32 parent_id;
 };
 
+struct scmi_msg_resp_powercap_domain_attributes_v3 {
+	__le32 attributes;
+#define SUPPORTS_POWERCAP_MAI_CONFIGURATION(x)		((x) & BIT(25))
+#define SUPPORTS_POWERCAP_FASTCHANNELS(x)		((x) & BIT(22))
+#define SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY_V3(x)	((x) & BIT(21))
+#define SUPPORTS_POWERCAP_CAI_CONFIGURATION(x)		((x) & BIT(20))
+	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
+	__le32 min_mai;
+	__le32 max_mai;
+	__le32 mai_step;
+	__le32 min_power_cap;
+	__le32 max_power_cap;
+	__le32 power_cap_step;
+	__le32 sustainable_power;
+	__le32 accuracy;
+	__le32 parent_id;
+	__le32 min_cai;
+	__le32 max_cai;
+	__le32 cai_step;
+};
+
+struct scmi_msg_powercap_get_v3 {
+	__le32 domain_id;
+	__le32 cpli;
+};
+
 struct scmi_msg_powercap_set_cap_or_pai {
-	__le32 domain;
+	__le32 domain_id;
 	__le32 flags;
 #define CAP_SET_ASYNC		BIT(1)
 #define CAP_SET_IGNORE_DRESP	BIT(0)
 	__le32 value;
 };
 
+struct scmi_msg_powercap_set_cap_v3 {
+	__le32 domain_id;
+	__le32 cpli;
+	__le32 flags;
+	__le32 power_cap;
+};
+
 struct scmi_msg_resp_powercap_cap_set_complete {
-	__le32 domain;
+	__le32 domain_id;
+	__le32 power_cap;
+};
+
+struct scmi_msg_resp_powercap_cap_set_complete_v3 {
+	__le32 domain_id;
 	__le32 power_cap;
+	__le32 cpli;
 };
 
 struct scmi_msg_resp_powercap_meas_get {
@@ -112,6 +152,33 @@ struct scmi_powercap_meas_changed_notify_payld {
 	__le32 power;
 };
 
+struct scmi_msg_powercap_cpc {
+	__le32 domain_id;
+	__le32 desc_index;
+};
+
+struct scmi_msg_resp_powercap_cpc {
+	__le32 num_cpl;
+#define NUM_RETURNED(n)		(le32_get_bits((n), GENMASK(15, 0)))
+#define NUM_REMAINING(n)	(le32_get_bits((n), GENMASK(31, 16)))
+	struct {
+		__le32 cpli;
+		__le32 flags;
+		__le32 min_power_cap;
+		__le32 max_power_cap;
+		__le32 power_cap_step;
+		__le32 min_cai;
+		__le32 max_cai;
+		__le32 cai_step;
+		u8 name[SCMI_SHORT_NAME_MAX_SIZE];
+	} desc[];
+};
+
+struct scmi_cpls_priv {
+	u32 domain_id;
+	struct scmi_powercap_cpl_info *cpli;
+};
+
 struct scmi_powercap_state {
 	bool enabled;
 	u32 last_pcap;
@@ -129,6 +196,11 @@ struct powercap_info {
 	bool notify_measurements_cmd;
 	struct scmi_powercap_state *states;
 	struct scmi_powercap_info *powercaps;
+	int (*xfer_cap_get)(const struct scmi_protocol_handle *ph,
+			    const struct scmi_powercap_info *pc, u32 cpl_id, u32 *power_cap);
+	int (*xfer_cap_set)(const struct scmi_protocol_handle *ph,
+			    const struct scmi_powercap_info *pc,
+			    u32 cpl_id, u32 power_cap, bool ignore_dresp);
 };
 
 static enum scmi_powercap_protocol_cmd evt_2_cmd[] = {
@@ -192,18 +264,227 @@ scmi_powercap_validate(unsigned int min_val, unsigned int max_val,
 	return 0;
 }
 
+static void iter_powercap_cpls_prepare_message(void *message,
+					       unsigned int desc_index,
+					       const void *priv)
+{
+	struct scmi_msg_powercap_cpc *msg = message;
+	const struct scmi_cpls_priv *p = priv;
+
+	msg->domain_id = cpu_to_le32(p->domain_id);
+	msg->desc_index = cpu_to_le32(desc_index);
+}
+
+static int iter_powercap_cpls_update_state(struct scmi_iterator_state *st,
+					   const void *response, void *priv)
+{
+	const struct scmi_msg_resp_powercap_cpc *r = response;
+	size_t needed;
+
+	if (st->rx_len < sizeof(r->num_cpl))
+		return -EPROTO;
+
+	st->num_returned = NUM_RETURNED(r->num_cpl);
+	st->num_remaining = NUM_REMAINING(r->num_cpl);
+
+	needed = struct_size(r, desc, st->num_returned);
+	if (st->rx_len < needed)
+		return -EPROTO;
+
+	return 0;
+}
+
+static int
+iter_powercap_cpls_process_response(const struct scmi_protocol_handle *ph,
+				    const void *response,
+				    struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_msg_resp_powercap_cpc *r = response;
+	struct scmi_cpls_priv *p = priv;
+	struct scmi_powercap_cpl_info *cpl;
+
+	cpl = &p->cpli[st->desc_index + st->loop_idx];
+
+	cpl->id = le32_to_cpu(r->desc[st->loop_idx].cpli);
+	cpl->cap_config = le32_to_cpu(r->desc[st->loop_idx].flags) & BIT(0);
+
+	cpl->min_power_cap = le32_to_cpu(r->desc[st->loop_idx].min_power_cap);
+	cpl->max_power_cap = le32_to_cpu(r->desc[st->loop_idx].max_power_cap);
+	cpl->power_cap_step = le32_to_cpu(r->desc[st->loop_idx].power_cap_step);
+	if (!cpl->power_cap_step && cpl->min_power_cap != cpl->max_power_cap)
+		return -EINVAL;
+
+	cpl->min_avg_ivl = le32_to_cpu(r->desc[st->loop_idx].min_cai);
+	cpl->max_avg_ivl = le32_to_cpu(r->desc[st->loop_idx].max_cai);
+	cpl->avg_ivl_step = le32_to_cpu(r->desc[st->loop_idx].cai_step);
+	if (!cpl->avg_ivl_step && cpl->min_avg_ivl != cpl->max_avg_ivl)
+		return -EINVAL;
+
+	cpl->avg_ivl_config = cpl->min_avg_ivl != cpl->max_avg_ivl;
+
+	strscpy(cpl->name, r->desc[st->loop_idx].name, SCMI_SHORT_NAME_MAX_SIZE);
+
+	return 0;
+}
+
+static int scmi_powercap_cpls_enumerate(const struct scmi_protocol_handle *ph,
+					struct scmi_powercap_info *dom_info)
+{
+	void *iter;
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_powercap_cpls_prepare_message,
+		.update_state = iter_powercap_cpls_update_state,
+		.process_response = iter_powercap_cpls_process_response,
+	};
+	struct scmi_cpls_priv cpriv = {
+		.domain_id = dom_info->id,
+		.cpli = dom_info->cpli,
+	};
+
+	iter = ph->hops->iter_response_init(ph, &ops, dom_info->num_cpli,
+					    POWERCAP_CPC_ATTRIBUTES,
+					    sizeof(struct scmi_msg_powercap_cpc),
+					    &cpriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
+static int
+scmi_powercap_domain_attrs_process(const struct scmi_protocol_handle *ph,
+				   struct powercap_info *pinfo,
+				   struct scmi_powercap_info *dom_info, void *r)
+{
+	struct scmi_msg_resp_powercap_domain_attributes *resp = r;
+	u32 flags = le32_to_cpu(resp->attributes);
+	bool cap_config;
+	int ret;
+
+	cap_config = SUPPORTS_POWERCAP_CAP_CONFIGURATION(flags);
+	if (PROTOCOL_REV_MAJOR(ph->version) < 0x3) {
+		dom_info->num_cpli = 1;
+	} else {
+		dom_info->num_cpli = le32_get_bits(resp->attributes,
+						   GENMASK(18, 15));
+
+		if (cap_config && !dom_info->num_cpli)
+			return -EINVAL;
+
+		if (!dom_info->num_cpli)
+			dom_info->num_cpli = 1;
+	}
+
+	dom_info->cpli = devm_kcalloc(ph->dev, dom_info->num_cpli,
+				      sizeof(*dom_info->cpli), GFP_KERNEL);
+	if (!dom_info->cpli)
+		return -ENOMEM;
+
+	if (pinfo->notify_cap_cmd) {
+		if (PROTOCOL_REV_MAJOR(ph->version) < 0x3)
+			dom_info->notify_powercap_cap_change =
+				SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY(flags);
+		else
+			dom_info->notify_powercap_cap_change =
+				SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY_V3(flags);
+	}
+
+	if (pinfo->notify_measurements_cmd)
+		dom_info->notify_powercap_measurement_change =
+			SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
+
+	dom_info->extended_names = SUPPORTS_EXTENDED_NAMES(flags);
+
+	dom_info->async_powercap_cap_set =
+		SUPPORTS_ASYNC_POWERCAP_CAP_SET(flags);
+
+	dom_info->powercap_monitoring =
+		SUPPORTS_POWERCAP_MONITORING(flags);
+	dom_info->powercap_scale_mw =
+		SUPPORTS_POWER_UNITS_MW(flags);
+	dom_info->powercap_scale_uw =
+		SUPPORTS_POWER_UNITS_UW(flags);
+	dom_info->fastchannels =
+		SUPPORTS_POWERCAP_FASTCHANNELS(flags);
+
+	strscpy(dom_info->name, resp->name, SCMI_SHORT_NAME_MAX_SIZE);
+
+	dom_info->sustainable_power =
+		le32_to_cpu(resp->sustainable_power);
+	dom_info->accuracy = le32_to_cpu(resp->accuracy);
+
+	dom_info->parent_id = le32_to_cpu(resp->parent_id);
+	if (dom_info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID &&
+	    (dom_info->parent_id >= pinfo->num_domains ||
+	     dom_info->parent_id == dom_info->id)) {
+		dev_err(ph->dev,
+			"Platform reported inconsistent parent ID for domain %d - %s\n",
+			dom_info->id, dom_info->name);
+		return -ENODEV;
+	}
+
+	dom_info->cpli[0].id = CPL0;
+	if (PROTOCOL_REV_MAJOR(ph->version) < 0x3)
+		dom_info->cpli[0].avg_ivl_config =
+			SUPPORTS_POWERCAP_PAI_CONFIGURATION(flags);
+	else
+		dom_info->cpli[0].avg_ivl_config =
+			SUPPORTS_POWERCAP_CAI_CONFIGURATION(flags);
+
+	if (PROTOCOL_REV_MAJOR(ph->version) < 0x3) {
+		dom_info->cpli[0].min_avg_ivl = le32_to_cpu(resp->min_pai);
+		dom_info->cpli[0].max_avg_ivl = le32_to_cpu(resp->max_pai);
+		dom_info->cpli[0].avg_ivl_step = le32_to_cpu(resp->pai_step);
+	} else {
+		struct scmi_msg_resp_powercap_domain_attributes_v3 *resp = r;
+
+		dom_info->cpli[0].min_avg_ivl = le32_to_cpu(resp->min_cai);
+		dom_info->cpli[0].max_avg_ivl = le32_to_cpu(resp->max_cai);
+		dom_info->cpli[0].avg_ivl_step = le32_to_cpu(resp->cai_step);
+	}
+
+	ret = scmi_powercap_validate(dom_info->cpli[0].min_avg_ivl,
+				     dom_info->cpli[0].max_avg_ivl,
+				     dom_info->cpli[0].avg_ivl_step,
+				     dom_info->cpli[0].avg_ivl_config);
+	if (ret) {
+		dev_err(ph->dev,
+			"Platform reported inconsistent PAI config for domain %d - %s\n",
+			dom_info->id, dom_info->name);
+		return ret;
+	}
+
+	dom_info->cpli[0].cap_config = cap_config;
+	dom_info->cpli[0].min_power_cap = le32_to_cpu(resp->min_power_cap);
+	dom_info->cpli[0].max_power_cap = le32_to_cpu(resp->max_power_cap);
+	dom_info->cpli[0].power_cap_step = le32_to_cpu(resp->power_cap_step);
+	ret = scmi_powercap_validate(dom_info->cpli[0].min_power_cap,
+				     dom_info->cpli[0].max_power_cap,
+				     dom_info->cpli[0].power_cap_step,
+				     dom_info->cpli[0].cap_config);
+	if (ret) {
+		dev_err(ph->dev,
+			"Platform reported inconsistent CAP config for domain %d - %s\n",
+			dom_info->id, dom_info->name);
+		return ret;
+	}
+	/* Just using same short name */
+	strscpy(dom_info->cpli[0].name, dom_info->name, SCMI_SHORT_NAME_MAX_SIZE);
+
+	return 0;
+}
+
 static int
 scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
 				    struct powercap_info *pinfo,
 				    struct scmi_powercap_info *dom_info)
 {
 	int ret;
-	u32 flags;
 	struct scmi_xfer *t;
 	struct scmi_msg_resp_powercap_domain_attributes *resp;
 
 	ret = ph->xops->xfer_get_init(ph, POWERCAP_DOMAIN_ATTRIBUTES,
-				      sizeof(dom_info->id), sizeof(*resp), &t);
+				      sizeof(dom_info->id), 0, &t);
 	if (ret)
 		return ret;
 
@@ -212,91 +493,34 @@ scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
 
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
-		flags = le32_to_cpu(resp->attributes);
-
-		if (pinfo->notify_cap_cmd)
-			dom_info->notify_powercap_cap_change =
-				SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY(flags);
-		if (pinfo->notify_measurements_cmd)
-			dom_info->notify_powercap_measurement_change =
-				SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
-		dom_info->async_powercap_cap_set =
-			SUPPORTS_ASYNC_POWERCAP_CAP_SET(flags);
-
-		dom_info->powercap_monitoring =
-			SUPPORTS_POWERCAP_MONITORING(flags);
-		dom_info->powercap_scale_mw =
-			SUPPORTS_POWER_UNITS_MW(flags);
-		dom_info->powercap_scale_uw =
-			SUPPORTS_POWER_UNITS_UW(flags);
-		dom_info->fastchannels =
-			SUPPORTS_POWERCAP_FASTCHANNELS(flags);
-
-		strscpy(dom_info->name, resp->name, SCMI_SHORT_NAME_MAX_SIZE);
-
-		dom_info->sustainable_power =
-			le32_to_cpu(resp->sustainable_power);
-		dom_info->accuracy = le32_to_cpu(resp->accuracy);
-
-		dom_info->parent_id = le32_to_cpu(resp->parent_id);
-		if (dom_info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID &&
-		    (dom_info->parent_id >= pinfo->num_domains ||
-		     dom_info->parent_id == dom_info->id)) {
-			dev_err(ph->dev,
-				"Platform reported inconsistent parent ID for domain %d - %s\n",
-				dom_info->id, dom_info->name);
-			ret = -ENODEV;
-		}
-
-		dom_info->cpli[0].avg_ivl_config =
-			SUPPORTS_POWERCAP_PAI_CONFIGURATION(flags);
-		dom_info->cpli[0].min_avg_ivl = le32_to_cpu(resp->min_pai);
-		dom_info->cpli[0].max_avg_ivl = le32_to_cpu(resp->max_pai);
-		dom_info->cpli[0].avg_ivl_step = le32_to_cpu(resp->pai_step);
-		ret = scmi_powercap_validate(dom_info->cpli[0].min_avg_ivl,
-					     dom_info->cpli[0].max_avg_ivl,
-					     dom_info->cpli[0].avg_ivl_step,
-					     dom_info->cpli[0].avg_ivl_config);
-		if (ret) {
-			dev_err(ph->dev,
-				"Platform reported inconsistent PAI config for domain %d - %s\n",
-				dom_info->id, dom_info->name);
-			goto clean;
-		}
+		size_t min_len;
 
-		dom_info->cpli[0].cap_config =
-			SUPPORTS_POWERCAP_CAP_CONFIGURATION(flags);
-		dom_info->cpli[0].min_power_cap = le32_to_cpu(resp->min_power_cap);
-		dom_info->cpli[0].max_power_cap = le32_to_cpu(resp->max_power_cap);
-		dom_info->cpli[0].power_cap_step = le32_to_cpu(resp->power_cap_step);
-		ret = scmi_powercap_validate(dom_info->cpli[0].min_power_cap,
-					     dom_info->cpli[0].max_power_cap,
-					     dom_info->cpli[0].power_cap_step,
-					     dom_info->cpli[0].cap_config);
-		if (ret) {
-			dev_err(ph->dev,
-				"Platform reported inconsistent CAP config for domain %d - %s\n",
-				dom_info->id, dom_info->name);
-			goto clean;
-		}
+		if (PROTOCOL_REV_MAJOR(ph->version) >= 0x3)
+			min_len = sizeof(struct scmi_msg_resp_powercap_domain_attributes_v3);
+		else
+			min_len = sizeof(struct scmi_msg_resp_powercap_domain_attributes);
 
-		/* Just using same short name */
-		strscpy(dom_info->cpli[0].name, dom_info->name,
-			SCMI_SHORT_NAME_MAX_SIZE);
+		if (t->rx.len < min_len)
+			ret = -EPROTO;
+		else
+			ret = scmi_powercap_domain_attrs_process(ph, pinfo, dom_info, resp);
 	}
 
-clean:
 	ph->xops->xfer_put(ph, t);
 
 	/*
 	 * If supported overwrite short name with the extended one;
 	 * on error just carry on and use already provided short name.
 	 */
-	if (!ret && SUPPORTS_EXTENDED_NAMES(flags))
+	if (!ret && dom_info->extended_names)
 		ph->hops->extended_name_get(ph, POWERCAP_DOMAIN_NAME_GET,
 					    dom_info->id, NULL, dom_info->name,
 					    SCMI_MAX_STR_SIZE);
 
+	/* When protocol version > 0x3 there can possibly be more than 1 CPLs */
+	if (!ret && dom_info->num_cpli > 1)
+		ret = scmi_powercap_cpls_enumerate(ph, dom_info);
+
 	return ret;
 }
 
@@ -306,14 +530,7 @@ scmi_powercap_domain_initialize(const struct scmi_protocol_handle *ph,
 {
 	struct scmi_powercap_info *dom_info = pinfo->powercaps + domain;
 
-	dom_info->num_cpli = 1;
-	dom_info->cpli = devm_kcalloc(ph->dev, dom_info->num_cpli,
-				      sizeof(*dom_info->cpli), GFP_KERNEL);
-	if (!dom_info->cpli)
-		return -ENOMEM;
-
 	dom_info->id = domain;
-	dom_info->cpli[0].id = CPL0;
 
 	return scmi_powercap_domain_attributes_get(ph, pinfo, dom_info);
 }
@@ -337,7 +554,8 @@ scmi_powercap_dom_info_get(const struct scmi_protocol_handle *ph, u32 domain_id)
 }
 
 static int scmi_powercap_xfer_cap_get(const struct scmi_protocol_handle *ph,
-				      u32 domain_id, u32 *power_cap)
+				      const struct scmi_powercap_info *pc, u32 cpl_id,
+				      u32 *power_cap)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -347,7 +565,34 @@ static int scmi_powercap_xfer_cap_get(const struct scmi_protocol_handle *ph,
 	if (ret)
 		return ret;
 
-	put_unaligned_le32(domain_id, t->tx.buf);
+	put_unaligned_le32(pc->id, t->tx.buf);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret)
+		*power_cap = get_unaligned_le32(t->rx.buf);
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int scmi_powercap_xfer_cap_get_v3(const struct scmi_protocol_handle *ph,
+					 const struct scmi_powercap_info *pc, u32 cpl_id,
+					 u32 *power_cap)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_powercap_get_v3 *msg;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAP_GET, sizeof(*msg),
+				      sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->domain_id = cpu_to_le32(pc->id);
+	msg->cpli = cpu_to_le32(pc->cpli[cpl_id].id);
+
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret)
 		*power_cap = get_unaligned_le32(t->rx.buf);
@@ -361,6 +606,11 @@ static int __scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
 				   const struct scmi_powercap_info *dom,
 				   u32 cpl_id, u32 *power_cap)
 {
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (cpl_id >= dom->num_cpli)
+		return -EINVAL;
+
 	if (dom->cpli[cpl_id].fc_info &&
 	    dom->cpli[cpl_id].fc_info[POWERCAP_FC_CAP].get_addr) {
 		*power_cap = ioread32(dom->cpli[cpl_id].fc_info[POWERCAP_FC_CAP].get_addr);
@@ -369,7 +619,7 @@ static int __scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
 		return 0;
 	}
 
-	return scmi_powercap_xfer_cap_get(ph, dom->id, power_cap);
+	return pi->xfer_cap_get(ph, dom, cpl_id, power_cap);
 }
 
 static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
@@ -402,7 +652,7 @@ static int scmi_powercap_xfer_cap_set(const struct scmi_protocol_handle *ph,
 		return ret;
 
 	msg = t->tx.buf;
-	msg->domain = cpu_to_le32(pc->id);
+	msg->domain_id = cpu_to_le32(pc->id);
 	msg->flags =
 		cpu_to_le32(FIELD_PREP(CAP_SET_ASYNC, pc->async_powercap_cap_set) |
 			    FIELD_PREP(CAP_SET_IGNORE_DRESP, ignore_dresp));
@@ -416,7 +666,7 @@ static int scmi_powercap_xfer_cap_set(const struct scmi_protocol_handle *ph,
 			struct scmi_msg_resp_powercap_cap_set_complete *resp;
 
 			resp = t->rx.buf;
-			if (le32_to_cpu(resp->domain) == pc->id)
+			if (le32_to_cpu(resp->domain_id) == pc->id)
 				dev_dbg(ph->dev,
 					"Powercap ID %d CAP set async to %u\n",
 					pc->id,
@@ -430,6 +680,51 @@ static int scmi_powercap_xfer_cap_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static int scmi_powercap_xfer_cap_set_v3(const struct scmi_protocol_handle *ph,
+					 const struct scmi_powercap_info *pc,
+					 u32 cpl_id, u32 power_cap,
+					 bool ignore_dresp)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_powercap_set_cap_v3 *msg;
+
+	ret = ph->xops->xfer_get_init(ph, POWERCAP_CAP_SET,
+				      sizeof(*msg), 0, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->domain_id = cpu_to_le32(pc->id);
+	msg->cpli = cpu_to_le32(pc->cpli[cpl_id].id);
+	msg->flags =
+		cpu_to_le32(FIELD_PREP(CAP_SET_ASYNC, pc->async_powercap_cap_set) |
+			    FIELD_PREP(CAP_SET_IGNORE_DRESP, ignore_dresp));
+	msg->power_cap = cpu_to_le32(power_cap);
+
+	if (!pc->async_powercap_cap_set || ignore_dresp) {
+		ret = ph->xops->do_xfer(ph, t);
+	} else {
+		ret = ph->xops->do_xfer_with_response(ph, t);
+		if (!ret) {
+			struct scmi_msg_resp_powercap_cap_set_complete_v3 *resp;
+
+			resp = t->rx.buf;
+			if (le32_to_cpu(resp->domain_id) == pc->id &&
+			    le32_to_cpu(resp->cpli) == pc->cpli[cpl_id].id)
+				dev_dbg(ph->dev,
+					"Powercap ID:%d/CPLI:%d CAP set async to %u\n",
+					pc->id, cpl_id,
+					get_unaligned_le32(&resp->power_cap));
+			else
+				ret = -EPROTO;
+		}
+	}
+
+	ph->xops->xfer_put(ph, t);
+	return ret;
+}
+
 static int __scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 				   struct powercap_info *pi, u32 domain_id,
 				   u32 cpl_id, u32 power_cap, bool ignore_dresp)
@@ -438,7 +733,7 @@ static int __scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 	const struct scmi_powercap_info *pc;
 
 	pc = scmi_powercap_dom_info_get(ph, domain_id);
-	if (!pc || !pc->cpli[cpl_id].cap_config)
+	if (!pc || cpl_id >= pc->num_cpli || !pc->cpli[cpl_id].cap_config)
 		return ret;
 
 	if (power_cap &&
@@ -456,12 +751,12 @@ static int __scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 				   domain_id, power_cap, 0);
 		ret = 0;
 	} else {
-		ret = scmi_powercap_xfer_cap_set(ph, pc, cpl_id, power_cap,
-						 ignore_dresp);
+		ret = pi->xfer_cap_set(ph, pc, cpl_id, power_cap, ignore_dresp);
 	}
 
-	/* Save the last explicitly set non-zero powercap value */
-	if (PROTOCOL_REV_MAJOR(ph->version) >= 0x2 && !ret && power_cap)
+	/* Save the last explicitly set non-zero powercap value for CPL0 */
+	if (PROTOCOL_REV_MAJOR(ph->version) >= 0x2 && !ret &&
+	    cpl_id == CPL0 && power_cap)
 		pi->states[domain_id].last_pcap = power_cap;
 
 	return ret;
@@ -480,8 +775,8 @@ static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 	if (!power_cap)
 		return -EINVAL;
 
-	/* Just log the last set request if acting on a disabled domain */
-	if (PROTOCOL_REV_MAJOR(ph->version) >= 0x2) {
+	/* Just log the last set request on CPL0 if acting on a disabled domain */
+	if (PROTOCOL_REV_MAJOR(ph->version) >= 0x2 && cpl_id == CPL0) {
 		if (!scmi_powercap_dom_info_get(ph, domain_id))
 			return -EINVAL;
 
@@ -558,7 +853,7 @@ static int scmi_powercap_xfer_pai_set(const struct scmi_protocol_handle *ph,
 		return ret;
 
 	msg = t->tx.buf;
-	msg->domain = cpu_to_le32(domain_id);
+	msg->domain_id = cpu_to_le32(domain_id);
 	msg->flags = cpu_to_le32(0);
 	msg->value = cpu_to_le32(pai);
 
@@ -1023,6 +1318,16 @@ scmi_powercap_protocol_init(const struct scmi_protocol_handle *ph)
 	if (!pinfo)
 		return -ENOMEM;
 
+	ph->set_priv(ph, pinfo);
+
+	if (PROTOCOL_REV_MAJOR(ph->version) < 0x3) {
+		pinfo->xfer_cap_get = scmi_powercap_xfer_cap_get;
+		pinfo->xfer_cap_set = scmi_powercap_xfer_cap_set;
+	} else {
+		pinfo->xfer_cap_get = scmi_powercap_xfer_cap_get_v3;
+		pinfo->xfer_cap_set = scmi_powercap_xfer_cap_set_v3;
+	}
+
 	ret = scmi_powercap_attributes_get(ph, pinfo);
 	if (ret)
 		return ret;
diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 7c2dbba5002c..2d9370aaaf5d 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -96,7 +96,7 @@ scmi_powercap_set_root_children_enable_state(struct scmi_powercap_root *pr, bool
 		if (!scmi_powercap_is_control_type_child(spz))
 			continue;
 
-		if (!spz->info->powercap_cap_config)
+		if (!spz->info->cpli[0].cap_config)
 			continue;
 
 		ret = powercap_ops->cap_enable_get(spz->ph, spz->info->id,
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index ecd99b24ae92..8b539bfcf482 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -677,6 +677,7 @@ struct scmi_powercap_info {
 	bool powercap_monitoring;
 	bool powercap_scale_mw;
 	bool powercap_scale_uw;
+	bool extended_names;
 	bool fastchannels;
 	char name[SCMI_MAX_STR_SIZE];
 	unsigned int sustainable_power;
-- 
2.25.1

