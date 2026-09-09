Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D800045D905;
	Wed,  9 Sep 2026 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991506; cv=none; b=CvxpjdEDlOLE+hdvEoLT+PxfQIk4ZCZ5LLc6qWAMxDdJFsPTkMAS35yUdy2xM8JxLwQySuTCS4bvsFE26rrPZKIh1mD+IIYV2opZFtkxsGs59PO5sgewTFzFj0WtcCuqIHOkT5qdjiS9gL4faAlsWXP88XM1aizkm/jXgsiMt4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991506; c=relaxed/simple;
	bh=BYeCQt5NaEq8E1gBj8dBtfs3f4F4ZCZN9kmhY/dO47I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sW3Vs+NlBXbECBP47TFlngqcV4hW0IzOcOZnTaGiFDKwRtOMorVc3m20WipLujPSzxLQSSRnFkM/jCD9Ka7hez7fZOciD7NWk0jJ6MMiD0k9E44o/mB3ZlZkx69rXEu9wg5Nr9hXi2ggCEfWCgkdfp3u3jhpEuO1JcgX3QpT9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JIadh7gF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JIadh7gF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEE10169C;
	Wed,  9 Sep 2026 15:04:59 -0700 (PDT)
Received: from oss-apollo7005.lab.cambridge.arm.com (oss-apollo7005.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 327E53F7D8;
	Wed,  9 Sep 2026 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788991503; bh=BYeCQt5NaEq8E1gBj8dBtfs3f4F4ZCZN9kmhY/dO47I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JIadh7gFST135EYcJ9nQnB2GhFdoyplnHNNVKGK611elZU3xTcGKlWwRUwjEQW0ql
	 Abz1wa44MrMJarh7Ji2yUyEkCUZHP2lak9CV5Ao9wwHjMmQQ5k0hYnABd0W4/eKhHN
	 pqverSjTcPDDf3WSswaIC01cM+QKRRKRSqZrvHFQ=
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
Subject: [PATCH v9 06/13] firmware: arm_scmi: Add SCMIV4.0 Powercap notifications support
Date: Wed,  9 Sep 2026 22:04:30 +0000
Message-Id: <20260909220437.1254412-7-philip.radford@arm.com>
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

Extend notification support to the new SCMIv4.0 Powercap format that carry
also a CPL identifier where specified.

Since this addition completes SCMIv4.0 Powercap support bump also the
protocol version define.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V8->V9
- fixed CAP_CHANGED notification paring to accept old payload without cpli
- changed secondary CPL validation to use scmi_powercap_validate to catch
  zero steps when min and max differ
---
 drivers/firmware/arm_scmi/powercap.c | 37 +++++++++++++++++++++-------
 include/linux/scmi_protocol.h        |  3 ++-
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index a9566341682c..0357784a1e8d 100644
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
@@ -319,6 +320,7 @@ iter_powercap_cpls_process_response(const struct scmi_protocol_handle *ph,
 	const struct scmi_msg_resp_powercap_cpc *r = response;
 	struct scmi_cpls_priv *p = priv;
 	struct scmi_powercap_cpl_info *cpl;
+	int ret;
 
 	cpl = &p->cpli[st->desc_index + st->loop_idx];
 
@@ -328,17 +330,28 @@ iter_powercap_cpls_process_response(const struct scmi_protocol_handle *ph,
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
 
+	ret = scmi_powercap_validate(cpl->min_avg_ivl,
+				     cpl->max_avg_ivl,
+				     cpl->avg_ivl_step,
+				     cpl->avg_ivl_config);
+
+	if (ret)
+		return ret;
+
 	strscpy(cpl->name, r->desc[st->loop_idx].name, SCMI_SHORT_NAME_MAX_SIZE);
 
 	return 0;
@@ -1349,14 +1362,20 @@ scmi_powercap_fill_custom_report(const struct scmi_protocol_handle *ph,
 		const struct scmi_powercap_cap_changed_notify_payld *p = payld;
 		struct scmi_powercap_cap_changed_report *r = report;
 
-		if (sizeof(*p) != payld_sz)
+		if (payld_sz < offsetofend(struct scmi_powercap_cap_changed_notify_payld,
+		    avg_ivl))
 			break;
 
 		r->timestamp = timestamp;
 		r->agent_id = le32_to_cpu(p->agent_id);
 		r->domain_id = le32_to_cpu(p->domain_id);
 		r->power_cap = le32_to_cpu(p->power_cap);
-		r->pai = le32_to_cpu(p->pai);
+		r->avg_ivl = le32_to_cpu(p->avg_ivl);
+		if (payld_sz >= offsetofend(struct scmi_powercap_cap_changed_notify_payld,
+		    cpli))
+			r->cpli = le32_to_cpu(p->cpli);
+		else
+			r->cpli = 0;
 		*src_id = r->domain_id;
 		rep = r;
 		break;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 8b539bfcf482..ce00106d2b65 100644
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
2.25.1

