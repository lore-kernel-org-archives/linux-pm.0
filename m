Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747441;
	b=17xpg/CyrTCp8rC6DiIz7HuKcPLbfNcczQVVm7QSIY9C2eJNq2K0V4U6IPZUvqbJt+AT
	 RcW6ivYdo4pIeNW/U1NYVZdd+EntNzJhmTBMRhVx2OXc6vaGpkC6SWe5rSj1iLnqOhMXJ
	 DnUyC6KoHlH51iKhT0ev5QyVQ3eSNHsUIEXlwgLef0rJJ1OItF8pLAtJJTI39N/ZoASeO
	 RGU/noj4ABigKoz6AbDsZaTqkbpQNqz8P13Hs3ywtaAXMiN0Ahb6Rrr1tdljSvvKVNUJE
	 xSIaEJ0yT/zZ71OpsrTDfvMBJcTt0psDjLoUmk2FMJMFSXYdYYW0ByalvfAM2Br4rLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747441;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uC6BgPvNlF/5g1lcsRTy3xYeGVm1mRnFm48t9CTnYYQ=;
	b=zV+FEZDJnOjXbl3ZtdWtS5XM/f46LPnf4NI+/Qvcay760PFLdhv2NN+cADEnzHCbOKNZ
	 Wcq6BWTRCrTg24YD/iJD2ZXPB21pZrrr/WNdvhUj7lr5xWLKUDRqgCg3PEBd9B6xle5u3
	 yHJHQXVAwvfoz397F5vcpGALzcwJ7FmibM2Vc4f4xtzBgT4msvXsdmhyQDfhdN8jQcWq1
	 wi3uK+9jvR+OLRkQsFW+z1GJhuP1eEgO8Hhltn0xYX4gQyrIN6av50UPYF1aVMifokLNb
	 dfxfD/TRC1tHrtaW3hLAh30kUiJMTtLMqFBRjdoz7LspZsGSIWDvP2L1TlQa3UNtPVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jvmYy7OF;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711B1606A328;
	Tue,  3 Nov 2026 23:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 711B1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=jvmYy7OF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9DB11650;
	Tue,  3 Nov 2026 15:10:36 -0800 (PST)
Received: from e121740.manchester.arm.com (e121740.arm.com [10.33.8.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21F9D3F673;
	Tue,  3 Nov 2026 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793747439; bh=cRGgnFZQVKHOiOSQ+qbNegRvTsybdbXb0bPTQ3rcxgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvmYy7OFyiqj/Oxv4U/tg34FJq5n5VbgGKOPBceHWCa6WsRjet03K+FyrBM4g8wwF
	 uiUX98MtlZ7Gibddr1AvS6XTgE0UZj/eXQhve4AJBjoN4UwOzge5Psw+pCMCF1if+N
	 iM0jJpHfVHG7h74y76bKaCIuWRV3qycm+tz8184Y=
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
	Cristian Marussi <cristian.marussi@arm.com>,
	Philip Radford <philip.radford@arm.com>
Subject: [PATCH v10 06/13] firmware: arm_scmi: Add SCMIV4.0 Powercap notifications support
Date: Tue,  3 Nov 2026 23:10:00 +0000
Message-Id: <20261103231007.537082-7-philip.radford@arm.com>
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

From: Cristian Marussi <cristian.marussi@arm.com>

Extend notification support to the new SCMIv4.0 Powercap format that carry
also a CPL identifier where specified.

Since this addition completes SCMIv4.0 Powercap support bump also the
protocol version define.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V9->V10
- use interval-specific validation for CPC-reported CAI values
- allow all--zero CPC CAI values to mean teh platform did not report the interval
---
 drivers/firmware/arm_scmi/powercap.c | 37 +++++++++++++++++++++-------
 include/linux/scmi_protocol.h        |  3 ++-
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index dd99f3eae9e9..bcfc2d8c5abb 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -18,7 +18,7 @@
 #include "notify.h"
 
 /* Updated only after ALL the mandatory features for that version are merged */
-#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20000
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30000
 
 #define CPL0	0
 
@@ -156,7 +156,8 @@ struct scmi_powercap_cap_changed_notify_payld {
 	__le32 agent_id;
 	__le32 domain_id;
 	__le32 power_cap;
-	__le32 pai;
+	__le32 avg_ivl;
+	__le32 cpli;
 };
 
 struct scmi_powercap_meas_changed_notify_payld {
@@ -339,6 +340,7 @@ iter_powercap_cpls_process_response(const struct scmi_protocol_handle *ph,
 	const struct scmi_msg_resp_powercap_cpc *r = response;
 	struct scmi_cpls_priv *p = priv;
 	struct scmi_powercap_cpl_info *cpl;
+	int ret;
 
 	cpl = &p->cpli[st->desc_index + st->loop_idx];
 
@@ -348,17 +350,28 @@ iter_powercap_cpls_process_response(const struct scmi_protocol_handle *ph,
 	cpl->min_power_cap = le32_to_cpu(r->desc[st->loop_idx].min_power_cap);
 	cpl->max_power_cap = le32_to_cpu(r->desc[st->loop_idx].max_power_cap);
 	cpl->power_cap_step = le32_to_cpu(r->desc[st->loop_idx].power_cap_step);
-	if (!cpl->power_cap_step && cpl->min_power_cap != cpl->max_power_cap)
-		return -EINVAL;
+
+	ret = scmi_powercap_validate(cpl->min_power_cap,
+				     cpl->max_power_cap,
+				     cpl->power_cap_step,
+				     cpl->cap_config);
+
+	if (ret)
+		return ret;
 
 	cpl->min_avg_ivl = le32_to_cpu(r->desc[st->loop_idx].min_cai);
 	cpl->max_avg_ivl = le32_to_cpu(r->desc[st->loop_idx].max_cai);
 	cpl->avg_ivl_step = le32_to_cpu(r->desc[st->loop_idx].cai_step);
-	if (!cpl->avg_ivl_step && cpl->min_avg_ivl != cpl->max_avg_ivl)
-		return -EINVAL;
-
 	cpl->avg_ivl_config = cpl->min_avg_ivl != cpl->max_avg_ivl;
 
+	ret = scmi_powercap_interval_validate(cpl->min_avg_ivl,
+					      cpl->max_avg_ivl,
+					      cpl->avg_ivl_step,
+					      &cpl->avg_ivl_config);
+
+	if (ret)
+		return ret;
+
 	strscpy(cpl->name, r->desc[st->loop_idx].name, SCMI_SHORT_NAME_MAX_SIZE);
 
 	return 0;
@@ -1370,14 +1383,20 @@ scmi_powercap_fill_custom_report(const struct scmi_protocol_handle *ph,
 		const struct scmi_powercap_cap_changed_notify_payld *p = payld;
 		struct scmi_powercap_cap_changed_report *r = report;
 
-		if (sizeof(*p) != payld_sz)
+		if (payld_sz < offsetofend(struct scmi_powercap_cap_changed_notify_payld,
+					   avg_ivl))
 			break;
 
 		r->timestamp = timestamp;
 		r->agent_id = le32_to_cpu(p->agent_id);
 		r->domain_id = le32_to_cpu(p->domain_id);
 		r->power_cap = le32_to_cpu(p->power_cap);
-		r->pai = le32_to_cpu(p->pai);
+		r->avg_ivl = le32_to_cpu(p->avg_ivl);
+		if (payld_sz >= offsetofend(struct scmi_powercap_cap_changed_notify_payld,
+					    cpli))
+			r->cpli = le32_to_cpu(p->cpli);
+		else
+			r->cpli = 0;
 		*src_id = r->domain_id;
 		rep = r;
 		break;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b6bc7fabd099..e41e972c7e4f 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -1129,7 +1129,8 @@ struct scmi_powercap_cap_changed_report {
 	unsigned int	agent_id;
 	unsigned int	domain_id;
 	unsigned int	power_cap;
-	unsigned int	pai;
+	unsigned int	avg_ivl;
+	unsigned int	cpli;
 };
 
 struct scmi_powercap_meas_changed_report {
-- 
2.34.1

