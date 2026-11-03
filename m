Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747432;
	b=cpBk3o12QBPAXlL/pLR3C9uECRtIJc54unY+fH4yLmVoE0V0lXLGW2X+sPknhdRIY1PX
	 87bN338+jm0qX//365KoJcvrukjihIZSbRmjGyTMDmzQPKCR5Xf4dDk/uaRlNkNxquJpv
	 WiNcHdsw6KWHWiX63wkdFqgqKbQITl1mcnqwZWTxyfMCwQ6znxqsF4aJ6z28NDEhRg4pF
	 ap2fzR45oED+DvL/sg2wDcwn//WfR9lJuJy5Z2CGm53KFgJrP6j3/mjD0Y7L7eQ7xMYnW
	 yn5KH3+880NUYtjHir2X5J4yyQuR2vhhjUr9UuJ7OVgSCW9VriwzPBHjzNYGKfeGt3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747432;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ApyEn0PHCY4PsNDgcVx6BTXPhhGUvK9z5SH9Ex9qtVA=;
	b=yUZu7OOOzCYBp6TiCPxkdBIE1+1l0nfBr7zVfDp2D/frI6tkv00BVG2KzwGwkdMo5EDK
	 G5FdlOP5wsGipz0Tn95g5AeFa2hidC4J3PjbAhUjOXw0czMGItvJzhyGZ9jI7OIDVp8po
	 daeq3bnN+5jze1aOHalJuXQuNrSYexi4HDy+JSUTzjVgRDHW1EY9dmuRlWn7MFAPpWSvE
	 CxGHCfkglr+reEgdrp5rdteriJ0+reZf84G3IC5uZcaq8odyxKT/oa168G7npyYFmq0pz
	 v7ZCS7hSAGW9cGckjzSHt3T7KPP8BY3nXjls1GoGzCa0AzL9gWL0RRXUWByanDuF95w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GYsxTMG4;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F248B606A326;
	Tue,  3 Nov 2026 23:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F248B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GYsxTMG4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C4331C2B;
	Tue,  3 Nov 2026 15:10:27 -0800 (PST)
Received: from e121740.manchester.arm.com (e121740.arm.com [10.33.8.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 656973F673;
	Tue,  3 Nov 2026 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793747430; bh=3eEJVjR5PctPRJSQFmQ7RKj9+vm3LVi13GYujomF2+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYsxTMG4FdDmmgHGineo4W3dcBFfUDrD3eWonTToHdEc41R6CDGtcrU4WNvEQipe1
	 Pkc/f2AhBfUKBZj36FSXpnot0AvxoWOzW+Q4xhonulr6FIS3oAk30OryFyIQXo2RYe
	 QfyznBj3WtlH4dNFbBG9iahaHYY55kreB+MrS3aw=
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
	Philip Radford <philip.radford@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v10 03/13] firmware: arm_scmi: Refactor powercap domain layout
Date: Tue,  3 Nov 2026 23:09:57 +0000
Message-Id: <20261103231007.537082-4-philip.radford@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103231007.537082-1-philip.radford@arm.com>
References: <20261103231007.537082-1-philip.radford@arm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCMIv4.0 introduces the idea of an optional Concurrent Power Limit (CPL)
for each powercap domain, where CPL0 coincides with the one and only
per-domain constraint limit that was available in pre-v4.0 SCMI Powercap.

Refactor the powercap domain descriptors and powercap operations to allow
future v4.0 extensions to cope with multiple CPLs.

While at that generalize the powercap protocol API to drop PAI references
in favour of a more generic avg_ivl naming, since from v4.0 the number and
types of averaging intervals will change in a non-backward compatible way,
so let's bury these changes within the protocol layer.

Last but not least, make the necessary changes to the ARM SCMI Powwercap
driver in order to support all of these new capabilities.

No functional change.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
[Philip: Adjusted domain_id comparitor in scmi_powercap_pai_get]
Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V9->V10
- fixed remaining powercap_cap_config use after the CPL layout refactor
- adjusted contorl-type enable handling to use cpli[0].cap_config after
  refactor
---
 drivers/firmware/arm_scmi/powercap.c | 182 +++++++++++++++++----------
 drivers/powercap/arm_scmi_powercap.c |  60 ++++-----
 include/linux/scmi_protocol.h        |  74 +++++++----
 3 files changed, 193 insertions(+), 123 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 31b19967452f..4666030176c3 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Management Interface (SCMI) Powercap Protocol
  *
- * Copyright (C) 2022 ARM Ltd.
+ * Copyright (C) 2022-2026 ARM Ltd.
  */
 
 #define pr_fmt(fmt) "SCMI Notifications POWERCAP - " fmt
@@ -20,6 +20,8 @@
 /* Updated only after ALL the mandatory features for that version are merged */
 #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20000
 
+#define CPL0	0
+
 enum scmi_powercap_protocol_cmd {
 	POWERCAP_DOMAIN_ATTRIBUTES = 0x3,
 	POWERCAP_CAP_GET = 0x4,
@@ -192,27 +194,26 @@ scmi_powercap_validate(unsigned int min_val, unsigned int max_val,
 
 static int
 scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
-				    struct powercap_info *pinfo, u32 domain)
+				    struct powercap_info *pinfo,
+				    struct scmi_powercap_info *dom_info)
 {
 	int ret;
 	u32 flags;
 	struct scmi_xfer *t;
-	struct scmi_powercap_info *dom_info = pinfo->powercaps + domain;
 	struct scmi_msg_resp_powercap_domain_attributes *resp;
 
 	ret = ph->xops->xfer_get_init(ph, POWERCAP_DOMAIN_ATTRIBUTES,
-				      sizeof(domain), sizeof(*resp), &t);
+				      sizeof(dom_info->id), sizeof(*resp), &t);
 	if (ret)
 		return ret;
 
-	put_unaligned_le32(domain, t->tx.buf);
+	put_unaligned_le32(dom_info->id, t->tx.buf);
 	resp = t->rx.buf;
 
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		flags = le32_to_cpu(resp->attributes);
 
-		dom_info->id = domain;
 		if (pinfo->notify_cap_cmd)
 			dom_info->notify_powercap_cap_change =
 				SUPPORTS_POWERCAP_CAP_CHANGE_NOTIFY(flags);
@@ -221,12 +222,9 @@ scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
 				SUPPORTS_POWERCAP_MEASUREMENTS_CHANGE_NOTIFY(flags);
 		dom_info->async_powercap_cap_set =
 			SUPPORTS_ASYNC_POWERCAP_CAP_SET(flags);
-		dom_info->powercap_cap_config =
-			SUPPORTS_POWERCAP_CAP_CONFIGURATION(flags);
+
 		dom_info->powercap_monitoring =
 			SUPPORTS_POWERCAP_MONITORING(flags);
-		dom_info->powercap_pai_config =
-			SUPPORTS_POWERCAP_PAI_CONFIGURATION(flags);
 		dom_info->powercap_scale_mw =
 			SUPPORTS_POWER_UNITS_MW(flags);
 		dom_info->powercap_scale_uw =
@@ -236,13 +234,29 @@ scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
 
 		strscpy(dom_info->name, resp->name, SCMI_SHORT_NAME_MAX_SIZE);
 
-		dom_info->min_pai = le32_to_cpu(resp->min_pai);
-		dom_info->max_pai = le32_to_cpu(resp->max_pai);
-		dom_info->pai_step = le32_to_cpu(resp->pai_step);
-		ret = scmi_powercap_validate(dom_info->min_pai,
-					     dom_info->max_pai,
-					     dom_info->pai_step,
-					     dom_info->powercap_pai_config);
+		dom_info->sustainable_power =
+			le32_to_cpu(resp->sustainable_power);
+		dom_info->accuracy = le32_to_cpu(resp->accuracy);
+
+		dom_info->parent_id = le32_to_cpu(resp->parent_id);
+		if (dom_info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID &&
+		    (dom_info->parent_id >= pinfo->num_domains ||
+		     dom_info->parent_id == dom_info->id)) {
+			dev_err(ph->dev,
+				"Platform reported inconsistent parent ID for domain %d - %s\n",
+				dom_info->id, dom_info->name);
+			ret = -ENODEV;
+		}
+
+		dom_info->cpli[0].avg_ivl_config =
+			SUPPORTS_POWERCAP_PAI_CONFIGURATION(flags);
+		dom_info->cpli[0].min_avg_ivl = le32_to_cpu(resp->min_pai);
+		dom_info->cpli[0].max_avg_ivl = le32_to_cpu(resp->max_pai);
+		dom_info->cpli[0].avg_ivl_step = le32_to_cpu(resp->pai_step);
+		ret = scmi_powercap_validate(dom_info->cpli[0].min_avg_ivl,
+					     dom_info->cpli[0].max_avg_ivl,
+					     dom_info->cpli[0].avg_ivl_step,
+					     dom_info->cpli[0].avg_ivl_config);
 		if (ret) {
 			dev_err(ph->dev,
 				"Platform reported inconsistent PAI config for domain %d - %s\n",
@@ -250,13 +264,15 @@ scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
 			goto clean;
 		}
 
-		dom_info->min_power_cap = le32_to_cpu(resp->min_power_cap);
-		dom_info->max_power_cap = le32_to_cpu(resp->max_power_cap);
-		dom_info->power_cap_step = le32_to_cpu(resp->power_cap_step);
-		ret = scmi_powercap_validate(dom_info->min_power_cap,
-					     dom_info->max_power_cap,
-					     dom_info->power_cap_step,
-					     dom_info->powercap_cap_config);
+		dom_info->cpli[0].cap_config =
+			SUPPORTS_POWERCAP_CAP_CONFIGURATION(flags);
+		dom_info->cpli[0].min_power_cap = le32_to_cpu(resp->min_power_cap);
+		dom_info->cpli[0].max_power_cap = le32_to_cpu(resp->max_power_cap);
+		dom_info->cpli[0].power_cap_step = le32_to_cpu(resp->power_cap_step);
+		ret = scmi_powercap_validate(dom_info->cpli[0].min_power_cap,
+					     dom_info->cpli[0].max_power_cap,
+					     dom_info->cpli[0].power_cap_step,
+					     dom_info->cpli[0].cap_config);
 		if (ret) {
 			dev_err(ph->dev,
 				"Platform reported inconsistent CAP config for domain %d - %s\n",
@@ -264,19 +280,9 @@ scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
 			goto clean;
 		}
 
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
+		/* Just using same short name */
+		strscpy(dom_info->cpli[0].name, dom_info->name,
+			SCMI_SHORT_NAME_MAX_SIZE);
 	}
 
 clean:
@@ -288,12 +294,30 @@ scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	 */
 	if (!ret && SUPPORTS_EXTENDED_NAMES(flags))
 		ph->hops->extended_name_get(ph, POWERCAP_DOMAIN_NAME_GET,
-					    domain, NULL, dom_info->name,
+					    dom_info->id, NULL, dom_info->name,
 					    SCMI_MAX_STR_SIZE);
 
 	return ret;
 }
 
+static int
+scmi_powercap_domain_initialize(const struct scmi_protocol_handle *ph,
+				struct powercap_info *pinfo, u32 domain)
+{
+	struct scmi_powercap_info *dom_info = pinfo->powercaps + domain;
+
+	dom_info->num_cpli = 1;
+	dom_info->cpli = devm_kcalloc(ph->dev, dom_info->num_cpli,
+				      sizeof(*dom_info->cpli), GFP_KERNEL);
+	if (!dom_info->cpli)
+		return -ENOMEM;
+
+	dom_info->id = domain;
+	dom_info->cpli[0].id = CPL0;
+
+	return scmi_powercap_domain_attributes_get(ph, pinfo, dom_info);
+}
+
 static int scmi_powercap_num_domains_get(const struct scmi_protocol_handle *ph)
 {
 	struct powercap_info *pi = ph->get_priv(ph);
@@ -335,10 +359,11 @@ static int scmi_powercap_xfer_cap_get(const struct scmi_protocol_handle *ph,
 
 static int __scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
 				   const struct scmi_powercap_info *dom,
-				   u32 *power_cap)
+				   u32 cpl_id, u32 *power_cap)
 {
-	if (dom->fc_info && dom->fc_info[POWERCAP_FC_CAP].get_addr) {
-		*power_cap = ioread32(dom->fc_info[POWERCAP_FC_CAP].get_addr);
+	if (dom->cpli[cpl_id].fc_info &&
+	    dom->cpli[cpl_id].fc_info[POWERCAP_FC_CAP].get_addr) {
+		*power_cap = ioread32(dom->cpli[cpl_id].fc_info[POWERCAP_FC_CAP].get_addr);
 		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_CAP_GET,
 				   dom->id, *power_cap, 0);
 		return 0;
@@ -348,7 +373,7 @@ static int __scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
 }
 
 static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 *power_cap)
+				 u32 domain_id, u32 cpl_id, u32 *power_cap)
 {
 	const struct scmi_powercap_info *dom;
 
@@ -359,12 +384,13 @@ static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
 	if (!dom)
 		return -EINVAL;
 
-	return __scmi_powercap_cap_get(ph, dom, power_cap);
+	return __scmi_powercap_cap_get(ph, dom, cpl_id, power_cap);
 }
 
 static int scmi_powercap_xfer_cap_set(const struct scmi_protocol_handle *ph,
 				      const struct scmi_powercap_info *pc,
-				      u32 power_cap, bool ignore_dresp)
+				      u32 cpl_id, u32 power_cap,
+				      bool ignore_dresp)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -406,21 +432,23 @@ static int scmi_powercap_xfer_cap_set(const struct scmi_protocol_handle *ph,
 
 static int __scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 				   struct powercap_info *pi, u32 domain_id,
-				   u32 power_cap, bool ignore_dresp)
+				   u32 cpl_id, u32 power_cap, bool ignore_dresp)
 {
 	int ret = -EINVAL;
 	const struct scmi_powercap_info *pc;
 
 	pc = scmi_powercap_dom_info_get(ph, domain_id);
-	if (!pc || !pc->powercap_cap_config)
+	if (!pc || !pc->cpli[cpl_id].cap_config)
 		return ret;
 
 	if (power_cap &&
-	    (power_cap < pc->min_power_cap || power_cap > pc->max_power_cap))
+	    (power_cap < pc->cpli[cpl_id].min_power_cap ||
+	     power_cap > pc->cpli[cpl_id].max_power_cap))
 		return ret;
 
-	if (pc->fc_info && pc->fc_info[POWERCAP_FC_CAP].set_addr) {
-		struct scmi_fc_info *fci = &pc->fc_info[POWERCAP_FC_CAP];
+	if (pc->cpli[cpl_id].fc_info &&
+	    pc->cpli[cpl_id].fc_info[POWERCAP_FC_CAP].set_addr) {
+		struct scmi_fc_info *fci = &pc->cpli[cpl_id].fc_info[POWERCAP_FC_CAP];
 
 		iowrite32(power_cap, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
@@ -428,7 +456,7 @@ static int __scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 				   domain_id, power_cap, 0);
 		ret = 0;
 	} else {
-		ret = scmi_powercap_xfer_cap_set(ph, pc, power_cap,
+		ret = scmi_powercap_xfer_cap_set(ph, pc, cpl_id, power_cap,
 						 ignore_dresp);
 	}
 
@@ -440,7 +468,7 @@ static int __scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 }
 
 static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 power_cap,
+				 u32 domain_id, u32 cpl_id, u32 power_cap,
 				 bool ignore_dresp)
 {
 	struct powercap_info *pi = ph->get_priv(ph);
@@ -463,7 +491,7 @@ static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 		}
 	}
 
-	return __scmi_powercap_cap_set(ph, pi, domain_id,
+	return __scmi_powercap_cap_set(ph, pi, domain_id, cpl_id,
 				       power_cap, ignore_dresp);
 }
 
@@ -489,7 +517,7 @@ static int scmi_powercap_xfer_pai_get(const struct scmi_protocol_handle *ph,
 }
 
 static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 *pai)
+				 u32 domain_id, u32 cpl_id, u32 *pai)
 {
 	struct scmi_powercap_info *dom;
 	struct powercap_info *pi = ph->get_priv(ph);
@@ -498,8 +526,11 @@ static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
 		return -EINVAL;
 
 	dom = pi->powercaps + domain_id;
-	if (dom->fc_info && dom->fc_info[POWERCAP_FC_PAI].get_addr) {
-		*pai = ioread32(dom->fc_info[POWERCAP_FC_PAI].get_addr);
+	if (cpl_id >= dom->num_cpli)
+		return -EINVAL;
+
+	if (dom->cpli[cpl_id].fc_info && dom->cpli[cpl_id].fc_info[POWERCAP_FC_PAI].get_addr) {
+		*pai = ioread32(dom->cpli[cpl_id].fc_info[POWERCAP_FC_PAI].get_addr);
 		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_PAI_GET,
 				   domain_id, *pai, 0);
 		return 0;
@@ -508,6 +539,12 @@ static int scmi_powercap_pai_get(const struct scmi_protocol_handle *ph,
 	return scmi_powercap_xfer_pai_get(ph, domain_id, pai);
 }
 
+static int scmi_powercap_avg_interval_get(const struct scmi_protocol_handle *ph,
+					  u32 domain_id, u32 cpl_id, u32 *val)
+{
+	return scmi_powercap_pai_get(ph, domain_id, cpl_id, val);
+}
+
 static int scmi_powercap_xfer_pai_set(const struct scmi_protocol_handle *ph,
 				      u32 domain_id, u32 pai)
 {
@@ -532,17 +569,18 @@ static int scmi_powercap_xfer_pai_set(const struct scmi_protocol_handle *ph,
 }
 
 static int scmi_powercap_pai_set(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 pai)
+				 u32 domain_id, u32 cpl_id, u32 pai)
 {
 	const struct scmi_powercap_info *pc;
 
 	pc = scmi_powercap_dom_info_get(ph, domain_id);
-	if (!pc || !pc->powercap_pai_config || !pai ||
-	    pai < pc->min_pai || pai > pc->max_pai)
+	if (!pc || cpl_id >= pc->num_cpli || !pc->cpli[cpl_id].avg_ivl_config ||
+	    !pai || pai < pc->cpli[cpl_id].min_avg_ivl ||
+	    pai > pc->cpli[cpl_id].max_avg_ivl)
 		return -EINVAL;
 
-	if (pc->fc_info && pc->fc_info[POWERCAP_FC_PAI].set_addr) {
-		struct scmi_fc_info *fci = &pc->fc_info[POWERCAP_FC_PAI];
+	if (pc->cpli[cpl_id].fc_info && pc->cpli[cpl_id].fc_info[POWERCAP_FC_PAI].set_addr) {
+		struct scmi_fc_info *fci = &pc->cpli[cpl_id].fc_info[POWERCAP_FC_PAI];
 
 		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_PAI_SET,
 				   domain_id, pai, 0);
@@ -554,6 +592,12 @@ static int scmi_powercap_pai_set(const struct scmi_protocol_handle *ph,
 	return scmi_powercap_xfer_pai_set(ph, domain_id, pai);
 }
 
+static int scmi_powercap_avg_interval_set(const struct scmi_protocol_handle *ph,
+					  u32 domain_id, u32 cpl_id, u32 val)
+{
+	return scmi_powercap_pai_set(ph, domain_id, cpl_id, val);
+}
+
 static int scmi_powercap_measurements_get(const struct scmi_protocol_handle *ph,
 					  u32 domain_id, u32 *average_power,
 					  u32 *pai)
@@ -652,11 +696,11 @@ static int scmi_powercap_cap_enable_set(const struct scmi_protocol_handle *ph,
 		if (!pi->states[domain_id].last_pcap)
 			return -EINVAL;
 
-		ret = __scmi_powercap_cap_set(ph, pi, domain_id,
+		ret = __scmi_powercap_cap_set(ph, pi, domain_id, CPL0,
 					      pi->states[domain_id].last_pcap,
 					      true);
 	} else {
-		ret = __scmi_powercap_cap_set(ph, pi, domain_id, 0, true);
+		ret = __scmi_powercap_cap_set(ph, pi, domain_id, CPL0, 0, true);
 	}
 
 	if (ret)
@@ -667,7 +711,7 @@ static int scmi_powercap_cap_enable_set(const struct scmi_protocol_handle *ph,
 	 * server could have ignored a disable request and kept enforcing some
 	 * powercap limit requested by other agents.
 	 */
-	ret = scmi_powercap_cap_get(ph, domain_id, &power_cap);
+	ret = scmi_powercap_cap_get(ph, domain_id, CPL0, &power_cap);
 	if (!ret)
 		pi->states[domain_id].enabled = !!power_cap;
 
@@ -692,7 +736,7 @@ static int scmi_powercap_cap_enable_get(const struct scmi_protocol_handle *ph,
 	 * Report always real platform state; platform could have ignored
 	 * a previous disable request. Default true on any error.
 	 */
-	ret = scmi_powercap_cap_get(ph, domain_id, &power_cap);
+	ret = scmi_powercap_cap_get(ph, domain_id, CPL0, &power_cap);
 	if (!ret)
 		*enable = !!power_cap;
 
@@ -709,8 +753,8 @@ static const struct scmi_powercap_proto_ops powercap_proto_ops = {
 	.cap_set = scmi_powercap_cap_set,
 	.cap_enable_set = scmi_powercap_cap_enable_set,
 	.cap_enable_get = scmi_powercap_cap_enable_get,
-	.pai_get = scmi_powercap_pai_get,
-	.pai_set = scmi_powercap_pai_set,
+	.avg_interval_get = scmi_powercap_avg_interval_get,
+	.avg_interval_set = scmi_powercap_avg_interval_set,
 	.measurements_get = scmi_powercap_measurements_get,
 	.measurements_threshold_set = scmi_powercap_measurements_threshold_set,
 	.measurements_threshold_get = scmi_powercap_measurements_threshold_get,
@@ -1001,18 +1045,18 @@ scmi_powercap_protocol_init(const struct scmi_protocol_handle *ph)
 	 * formed and correlated by sane parent-child relationship (if any).
 	 */
 	for (domain = 0; domain < pinfo->num_domains; domain++) {
-		ret = scmi_powercap_domain_attributes_get(ph, pinfo, domain);
+		ret = scmi_powercap_domain_initialize(ph, pinfo, domain);
 		if (ret)
 			return ret;
 
 		if (pinfo->powercaps[domain].fastchannels)
 			scmi_powercap_domain_init_fc(ph, domain,
-						     &pinfo->powercaps[domain].fc_info);
+						     &pinfo->powercaps[domain].cpli[CPL0].fc_info);
 
 		/* Grab initial state when disable is supported. */
 		if (PROTOCOL_REV_MAJOR(ph->version) >= 0x2) {
 			ret = __scmi_powercap_cap_get(ph,
-						      &pinfo->powercaps[domain],
+						      &pinfo->powercaps[domain], CPL0,
 						      &pinfo->states[domain].last_pcap);
 			if (ret)
 				return ret;
diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index ba398048bf21..0753a6938512 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -110,14 +110,14 @@ scmi_powercap_control_type_set_enable(struct powercap_control_type *pct, bool mo
 		goto out_unlock;
 	}
 
-	list_for_each_entry(pr, &scmi_powercap_roots, node)	{
+	list_for_each_entry(pr, &scmi_powercap_roots, node) {
 		for (i = 0; i < pr->num_zones; i++) {
 			spz = &pr->spzones[i];
 
 			if (!scmi_powercap_is_control_type_child(spz))
 				continue;
 
-			if (!spz->info->powercap_cap_config) {
+			if (!spz->info->cpli[0].cap_config) {
 				ret = -EOPNOTSUPP;
 				goto out_free;
 			}
@@ -161,12 +161,12 @@ scmi_powercap_control_type_set_enable(struct powercap_control_type *pct, bool mo
 	}
 
 out_free:
-			kfree(states);
+	kfree(states);
 
 out_unlock:
-			mutex_unlock(&scmi_powercap_roots_lock);
+	mutex_unlock(&scmi_powercap_roots_lock);
 
-			return ret;
+	return ret;
 }
 
 static int
@@ -255,7 +255,7 @@ static const struct powercap_zone_ops zone_ops = {
 };
 
 static void scmi_powercap_normalize_cap(const struct scmi_powercap_zone *spz,
-					u64 power_limit_uw, u32 *norm)
+					u64 power_limit_uw, int cid, u32 *norm)
 {
 	bool scale_mw = spz->info->powercap_scale_mw;
 	u64 val;
@@ -266,9 +266,9 @@ static void scmi_powercap_normalize_cap(const struct scmi_powercap_zone *spz,
 	 * the range [min_power_cap, max_power_cap] whose bounds are assured to
 	 * be two unsigned 32bits quantities.
 	 */
-	*norm = clamp_t(u32, val, spz->info->min_power_cap,
-			spz->info->max_power_cap);
-	*norm = rounddown(*norm, spz->info->power_cap_step);
+	*norm = clamp_t(u32, val, spz->info->cpli[cid].min_power_cap,
+			spz->info->cpli[cid].max_power_cap);
+	*norm = rounddown(*norm, spz->info->cpli[cid].power_cap_step);
 
 	val = (scale_mw) ? *norm * 1000 : *norm;
 	if (power_limit_uw != val)
@@ -283,12 +283,12 @@ static int scmi_powercap_set_power_limit_uw(struct powercap_zone *pz, int cid,
 	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
 	u32 norm_power;
 
-	if (!spz->info->powercap_cap_config)
+	if (!spz->info->cpli[cid].cap_config)
 		return -EINVAL;
 
-	scmi_powercap_normalize_cap(spz, power_uw, &norm_power);
+	scmi_powercap_normalize_cap(spz, power_uw, cid, &norm_power);
 
-	return powercap_ops->cap_set(spz->ph, spz->info->id, norm_power, false);
+	return powercap_ops->cap_set(spz->ph, spz->info->id, cid, norm_power, false);
 }
 
 static int scmi_powercap_get_power_limit_uw(struct powercap_zone *pz, int cid,
@@ -298,7 +298,7 @@ static int scmi_powercap_get_power_limit_uw(struct powercap_zone *pz, int cid,
 	u32 power;
 	int ret;
 
-	ret = powercap_ops->cap_get(spz->ph, spz->info->id, &power);
+	ret = powercap_ops->cap_get(spz->ph, spz->info->id, cid, &power);
 	if (ret)
 		return ret;
 
@@ -310,19 +310,20 @@ static int scmi_powercap_get_power_limit_uw(struct powercap_zone *pz, int cid,
 }
 
 static void scmi_powercap_normalize_time(const struct scmi_powercap_zone *spz,
-					 u64 time_us, u32 *norm)
+					 u64 time_us, int cid, u32 *norm)
 {
 	/*
 	 * This cast is lossless since here @time_us is certain to be within the
-	 * range [min_pai, max_pai] whose bounds are assured to be two unsigned
-	 * 32bits quantities.
+	 * range [min_avg_ivl, max_avg_ivl] whose bounds are assured to be two
+	 * unsigned 32bits quantities.
 	 */
-	*norm = clamp_t(u32, time_us, spz->info->min_pai, spz->info->max_pai);
-	*norm = rounddown(*norm, spz->info->pai_step);
+	*norm = clamp_t(u32, time_us, spz->info->cpli[cid].min_avg_ivl,
+			spz->info->cpli[cid].max_avg_ivl);
+	*norm = rounddown(*norm, spz->info->cpli[cid].avg_ivl_step);
 
 	if (time_us != *norm)
 		dev_dbg(spz->dev,
-			"Normalized %s:PAI - requested:%llu - normalized:%u\n",
+			"Normalized %s:AVG_IVL - requested:%llu - normalized:%u\n",
 			spz->info->name, time_us, *norm);
 }
 
@@ -332,12 +333,13 @@ static int scmi_powercap_set_time_window_us(struct powercap_zone *pz, int cid,
 	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
 	u32 norm_pai;
 
-	if (!spz->info->powercap_pai_config)
+	if (!spz->info->cpli[cid].avg_ivl_config)
 		return -EINVAL;
 
-	scmi_powercap_normalize_time(spz, time_window_us, &norm_pai);
+	scmi_powercap_normalize_time(spz, time_window_us, cid, &norm_pai);
 
-	return powercap_ops->pai_set(spz->ph, spz->info->id, norm_pai);
+	return powercap_ops->avg_interval_set(spz->ph, spz->info->id,
+					      cid, norm_pai);
 }
 
 static int scmi_powercap_get_time_window_us(struct powercap_zone *pz, int cid,
@@ -347,7 +349,7 @@ static int scmi_powercap_get_time_window_us(struct powercap_zone *pz, int cid,
 	int ret;
 	u32 pai;
 
-	ret = powercap_ops->pai_get(spz->ph, spz->info->id, &pai);
+	ret = powercap_ops->avg_interval_get(spz->ph, spz->info->id, cid, &pai);
 	if (ret)
 		return ret;
 
@@ -361,7 +363,7 @@ static int scmi_powercap_get_max_power_uw(struct powercap_zone *pz, int cid,
 {
 	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
 
-	*max_power_uw = spz->info->max_power_cap;
+	*max_power_uw = spz->info->cpli[cid].max_power_cap;
 	if (spz->info->powercap_scale_mw)
 		*max_power_uw *= 1000;
 
@@ -373,7 +375,7 @@ static int scmi_powercap_get_min_power_uw(struct powercap_zone *pz, int cid,
 {
 	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
 
-	*min_power_uw = spz->info->min_power_cap;
+	*min_power_uw = spz->info->cpli[cid].min_power_cap;
 	if (spz->info->powercap_scale_mw)
 		*min_power_uw *= 1000;
 
@@ -385,7 +387,7 @@ static int scmi_powercap_get_max_time_window_us(struct powercap_zone *pz,
 {
 	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
 
-	*time_window_us = spz->info->max_pai;
+	*time_window_us = spz->info->cpli[cid].max_avg_ivl;
 
 	return 0;
 }
@@ -395,14 +397,16 @@ static int scmi_powercap_get_min_time_window_us(struct powercap_zone *pz,
 {
 	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
 
-	*time_window_us = (u64)spz->info->min_pai;
+	*time_window_us = (u64)spz->info->cpli[cid].min_avg_ivl;
 
 	return 0;
 }
 
 static const char *scmi_powercap_get_name(struct powercap_zone *pz, int cid)
 {
-	return "SCMI power-cap";
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+
+	return spz->info->cpli[cid].name;
 }
 
 static const struct powercap_zone_constraint_ops constraint_ops  = {
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 3f7cc35eb861..626990d38b38 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -2,7 +2,7 @@
 /*
  * SCMI Message Protocol driver header
  *
- * Copyright (C) 2018-2021 ARM Ltd.
+ * Copyright (C) 2018-2026 ARM Ltd.
  */
 
 #ifndef _LINUX_SCMI_PROTOCOL_H
@@ -617,6 +617,35 @@ struct scmi_voltage_proto_ops {
 			 s32 *volt_uV);
 };
 
+/**
+ * struct scmi_powercap_cpl_info  - Describe one CPL - Concurrent Powercap Limit
+ *
+ * @id: CPL ID as advertised by the platform.
+ * @cap_config: CAP configuration support for this CPL.
+ * @min_power_cap: Minimum configurable CAP.
+ * @max_power_cap: Maximum configurable CAP.
+ * @power_cap_step: Step size between two consecutive CAP values.
+ * @avg_ivl_config: Powercap averaging interval configuration support.
+ * @min_avg_ivl: Minimum configurable powercap averaging interval.
+ * @max_avg_ivl: Maximum configurable powercap averaging interval.
+ * @avg_ivl_step: Step size between two consecutive averaging intervals.
+ * @name: name assigned to the Powercap Domain by platform.
+ * @fc_info: Reference to the FastChannels descriptors supported by this CPL
+ */
+struct scmi_powercap_cpl_info {
+	unsigned int id;
+	bool cap_config;
+	unsigned int min_power_cap;
+	unsigned int max_power_cap;
+	unsigned int power_cap_step;
+	bool avg_ivl_config;
+	unsigned int min_avg_ivl;
+	unsigned int max_avg_ivl;
+	unsigned int avg_ivl_step;
+	char name[SCMI_SHORT_NAME_MAX_SIZE];
+	struct scmi_fc_info *fc_info;
+};
+
 /**
  * struct scmi_powercap_info  - Describe one available Powercap domain
  *
@@ -625,21 +654,15 @@ struct scmi_voltage_proto_ops {
  * @notify_powercap_measurement_change: MEASUREMENTS change notifications
  *				       support.
  * @async_powercap_cap_set: Asynchronous CAP set support.
- * @powercap_cap_config: CAP configuration support.
  * @powercap_monitoring: Monitoring (measurements) support.
- * @powercap_pai_config: PAI configuration support.
  * @powercap_scale_mw: Domain reports power data in milliwatt units.
  * @powercap_scale_uw: Domain reports power data in microwatt units.
  *		       Note that, when both @powercap_scale_mw and
  *		       @powercap_scale_uw are set to false, the domain
  *		       reports power data on an abstract linear scale.
+ * @extended_names: Support for long names.
+ * @fastchannels: Support for at least one fastchannel,
  * @name: name assigned to the Powercap Domain by platform.
- * @min_pai: Minimum configurable PAI.
- * @max_pai: Maximum configurable PAI.
- * @pai_step: Step size between two consecutive PAI values.
- * @min_power_cap: Minimum configurable CAP.
- * @max_power_cap: Maximum configurable CAP.
- * @power_cap_step: Step size between two consecutive CAP values.
  * @sustainable_power: Maximum sustainable power consumption for this domain
  *		       under normal conditions.
  * @accuracy: The accuracy with which the power is measured and reported in
@@ -647,30 +670,25 @@ struct scmi_voltage_proto_ops {
  * @parent_id: Identifier of the containing parent power capping domain, or the
  *	       value 0xFFFFFFFF if this powercap domain is a root domain not
  *	       contained in any other domain.
+ * @num_cpli: Number of discovered CPLs.
+ * @cpli: Reference to an array holding descriptors to all the discovered CPLs.
  */
 struct scmi_powercap_info {
 	unsigned int id;
 	bool notify_powercap_cap_change;
 	bool notify_powercap_measurement_change;
 	bool async_powercap_cap_set;
-	bool powercap_cap_config;
 	bool powercap_monitoring;
-	bool powercap_pai_config;
 	bool powercap_scale_mw;
 	bool powercap_scale_uw;
 	bool fastchannels;
 	char name[SCMI_MAX_STR_SIZE];
-	unsigned int min_pai;
-	unsigned int max_pai;
-	unsigned int pai_step;
-	unsigned int min_power_cap;
-	unsigned int max_power_cap;
-	unsigned int power_cap_step;
 	unsigned int sustainable_power;
 	unsigned int accuracy;
 #define SCMI_POWERCAP_ROOT_ZONE_ID     0xFFFFFFFFUL
 	unsigned int parent_id;
-	struct scmi_fc_info *fc_info;
+	unsigned int num_cpli;
+	struct scmi_powercap_cpl_info *cpli;
 };
 
 /**
@@ -699,8 +717,12 @@ struct scmi_powercap_info {
  *		    on the system: for this reason @cap_get and @cap_enable_get
  *		    will always report the final platform view of the powercaps.
  * @cap_enable_get: get the current CAP enable status for the specified domain.
- * @pai_get: get the current PAI value for the specified domain.
- * @pai_set: set the PAI value for the specified domain to the provided value.
+ * @avg_interval_get: get the current averaging interval value for the specified
+ *		      domain. This will get the PAI or CAI depending on the used
+ *		      protocol version.
+ * @avg_interval_set: set the current averaging interval value for the specified
+ *		      domain. This will set the PAI or CAI depending on the used
+ *		      protocol version.
  * @measurements_get: retrieve the current average power measurements for the
  *		      specified domain and the related PAI upon which is
  *		      calculated.
@@ -724,17 +746,17 @@ struct scmi_powercap_proto_ops {
 	const struct scmi_powercap_info __must_check *(*info_get)
 		(const struct scmi_protocol_handle *ph, u32 domain_id);
 	int (*cap_get)(const struct scmi_protocol_handle *ph, u32 domain_id,
-		       u32 *power_cap);
+		       u32 cpl_id, u32 *power_cap);
 	int (*cap_set)(const struct scmi_protocol_handle *ph, u32 domain_id,
-		       u32 power_cap, bool ignore_dresp);
+		       u32 cpl_id, u32 power_cap, bool ignore_dresp);
 	int (*cap_enable_set)(const struct scmi_protocol_handle *ph,
 			      u32 domain_id, bool enable);
 	int (*cap_enable_get)(const struct scmi_protocol_handle *ph,
 			      u32 domain_id, bool *enable);
-	int (*pai_get)(const struct scmi_protocol_handle *ph, u32 domain_id,
-		       u32 *pai);
-	int (*pai_set)(const struct scmi_protocol_handle *ph, u32 domain_id,
-		       u32 pai);
+	int (*avg_interval_get)(const struct scmi_protocol_handle *ph,
+				u32 domain_id, u32 cpl_id, u32 *val);
+	int (*avg_interval_set)(const struct scmi_protocol_handle *ph,
+				u32 domain_id, u32 cpl_id, u32 val);
 	int (*measurements_get)(const struct scmi_protocol_handle *ph,
 				u32 domain_id, u32 *average_power, u32 *pai);
 	int (*measurements_threshold_set)(const struct scmi_protocol_handle *ph,
-- 
2.34.1

