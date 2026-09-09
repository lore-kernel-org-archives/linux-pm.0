Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765D493D5D;
	Wed,  9 Sep 2026 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991510; cv=none; b=tkWwoUufRXPj5/4ALOAwkaFzTIhiMeRc+37NpWOcHbEVj3ElLek5KPJn2QJX3dqFDnh8cDdCogA6aTNboS/rV3hABPRfCN92QRVj+e4fbEmorfAVf6JvnVPiFusm1C04oORSc4sLbytKTOY2IrME87h/7aRIAM7y+LgLq6aAuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991510; c=relaxed/simple;
	bh=DBc1CUKQsyLSaWL5KNbvl9X9PnkANQ3XRP/x4evCVDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsKXxzZ39FWavd2xS34czhkXc1sHSIyNIYK1nzJyYcmwituUtObYAhjfjn/QDDpbEGjOOj9wyp/rHGpHTlZbsxvYq67RIOswZgwy9Nbm6VOEIuN9npcFT7O9K2azEb4adu4wBERGOzVw1oKYeIDSLawQ7iSs6RI4ePgCa+rwTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AUdkoCCu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AUdkoCCu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F319169C;
	Wed,  9 Sep 2026 15:05:04 -0700 (PDT)
Received: from oss-apollo7005.lab.cambridge.arm.com (oss-apollo7005.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB5F13F7D8;
	Wed,  9 Sep 2026 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788991508; bh=DBc1CUKQsyLSaWL5KNbvl9X9PnkANQ3XRP/x4evCVDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AUdkoCCu9KNMvqzZa1Zqq5MeWtvRDkwIb43YFtzPeg6CVzUAmQqUkl947WQY1GXp2
	 CoSG9YGnoC6R0GIFq01i/u28lz9j1Qkmv/eEHI6n7Sn50JDqqNLJbyHJSzIS8KoBOJ
	 FRjo+6pDw1t1ESzBLGGP+d2JZuonZ5GLbnQkn8cM=
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
Subject: [PATCH v9 08/13] include: trace: Add new parameter to trace_scmi_fc_call
Date: Wed,  9 Sep 2026 22:04:32 +0000
Message-Id: <20260909220437.1254412-9-philip.radford@arm.com>
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

Since SCMIv4.0 some of the supported Fastchannels can be configured using
an additional parameter like CPL_ID or Capability_ID.

Add equivalent support in the SCMI fastchannel traces to printout also such
parameter and fix all the existent call sites.

When such parameter is not used, it will simply show up as zero.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Philip Radford <philip.radford@arm.com>
---
 drivers/firmware/arm_scmi/perf.c     |  8 ++++----
 drivers/firmware/arm_scmi/powercap.c | 12 +++++++-----
 include/trace/events/scmi.h          | 12 +++++++-----
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 7f283f457e02..88d614e3184b 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -552,7 +552,7 @@ static int __scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
 
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_SET,
-				   dom->id, min_perf, max_perf);
+				   dom->id, 0, min_perf, max_perf);
 		iowrite32(max_perf, fci->set_addr);
 		iowrite32(min_perf, fci->set_addr + 4);
 		ph->hops->fastchannel_db_ring(fci->set_db);
@@ -636,7 +636,7 @@ static int __scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
 		*max_perf = ioread32(fci->get_addr);
 		*min_perf = ioread32(fci->get_addr + 4);
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LIMITS_GET,
-				   dom->id, *min_perf, *max_perf);
+				   dom->id, 0, *min_perf, *max_perf);
 		return 0;
 	}
 
@@ -706,7 +706,7 @@ static int __scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LEVEL];
 
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_SET,
-				   dom->id, level, 0);
+				   dom->id, 0, level, 0);
 		iowrite32(level, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
 		return 0;
@@ -769,7 +769,7 @@ static int __scmi_perf_level_get(const struct scmi_protocol_handle *ph,
 	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].get_addr) {
 		*level = ioread32(dom->fc_info[PERF_FC_LEVEL].get_addr);
 		trace_scmi_fc_call(SCMI_PROTOCOL_PERF, PERF_LEVEL_GET,
-				   dom->id, *level, 0);
+				   dom->id, 0, *level, 0);
 		return 0;
 	}
 
diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index b032c8181458..2e30bc00f056 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -638,7 +638,7 @@ static int __scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
 	    dom->cpli[cpl_id].fc_info[POWERCAP_FC_CAP].get_addr) {
 		*power_cap = ioread32(dom->cpli[cpl_id].fc_info[POWERCAP_FC_CAP].get_addr);
 		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_CAP_GET,
-				   dom->id, *power_cap, 0);
+				   dom->id, cpl_id, *power_cap, 0);
 		return 0;
 	}
 
@@ -771,7 +771,7 @@ static int __scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 		iowrite32(power_cap, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
 		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_CAP_SET,
-				   domain_id, power_cap, 0);
+				   domain_id, cpl_id, power_cap, 0);
 		ret = 0;
 	} else {
 		ret = pi->xfer_cap_set(ph, pc, cpl_id, power_cap, ignore_dresp);
@@ -880,7 +880,8 @@ static int scmi_powercap_avg_interval_get(const struct scmi_protocol_handle *ph,
 			POWERCAP_PAI_GET : POWERCAP_CAI_GET;
 
 		*val = ioread32(dom->cpli[cpl_id].fc_info[POWERCAP_FC_XAI].get_addr);
-		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, trace_cmd, domain_id, *val, 0);
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, trace_cmd, domain_id,
+				   cpl_id, *val, 0);
 		return 0;
 	}
 
@@ -953,7 +954,8 @@ static int scmi_powercap_avg_interval_set(const struct scmi_protocol_handle *ph,
 			POWERCAP_PAI_SET : POWERCAP_CAI_SET;
 		struct scmi_fc_info *fci = &pc->cpli[cpl_id].fc_info[POWERCAP_FC_XAI];
 
-		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, trace_cmd, domain_id, ivl, 0);
+		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, trace_cmd, domain_id,
+				   cpl_id, ivl, 0);
 		iowrite32(ivl, fci->set_addr);
 		ph->hops->fastchannel_db_ring(fci->set_db);
 		return 0;
@@ -1006,7 +1008,7 @@ static int scmi_powercap_measurements_get(const struct scmi_protocol_handle *ph,
 		/* See SCMIv4.0 3.10.2 - Payload is 32bit ONLY avg_power */
 		*avg_ivl = 0;
 		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_MEASUREMENTS_GET,
-				   pc->id, *avg_power, *avg_ivl);
+				   pc->id, 0, *avg_power, *avg_ivl);
 		return 0;
 	}
 
diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index 703b7bb68e44..b03da7323d04 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -10,13 +10,14 @@
 #define TRACE_SCMI_MAX_TAG_LEN	6
 
 TRACE_EVENT(scmi_fc_call,
-	TP_PROTO(u8 protocol_id, u8 msg_id, u32 res_id, u32 val1, u32 val2),
-	TP_ARGS(protocol_id, msg_id, res_id, val1, val2),
+	TP_PROTO(u8 protocol_id, u8 msg_id, u32 res_id, u32 sub_id, u32 val1, u32 val2),
+	TP_ARGS(protocol_id, msg_id, res_id, sub_id, val1, val2),
 
 	TP_STRUCT__entry(
 		__field(u8, protocol_id)
 		__field(u8, msg_id)
 		__field(u32, res_id)
+		__field(u32, sub_id)
 		__field(u32, val1)
 		__field(u32, val2)
 	),
@@ -25,13 +26,14 @@ TRACE_EVENT(scmi_fc_call,
 		__entry->protocol_id = protocol_id;
 		__entry->msg_id = msg_id;
 		__entry->res_id = res_id;
+		__entry->sub_id = sub_id;
 		__entry->val1 = val1;
 		__entry->val2 = val2;
 	),
 
-	TP_printk("pt=%02X msg_id=%02X res_id:%u vals=%u:%u",
-		__entry->protocol_id, __entry->msg_id,
-		__entry->res_id, __entry->val1, __entry->val2)
+	TP_printk("pt=%02X msg_id=%02X res_id:%u sub_id:%u vals=%u:%u",
+		  __entry->protocol_id, __entry->msg_id,
+		  __entry->res_id, __entry->sub_id, __entry->val1, __entry->val2)
 );
 
 TRACE_EVENT(scmi_xfer_begin,
-- 
2.25.1

