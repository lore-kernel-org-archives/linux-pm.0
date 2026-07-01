Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB348125C;
	Wed,  1 Jul 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910701; cv=none; b=aM9xdgg/K7letlsSJl2q/icIIv1P0G8PSHRzeIkc/w0l+TSBBIEKpTmGpRWR5FqlRhw3FcTS1pMyTPbzzK8BzevlE3V9dZUoAFjXIoJMI/eHI66jIltSZdSOaIq7fr+RLCt0qZi2Ih3ObfzrXPj0DVp1fBpBECcG8kqjOen6uTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910701; c=relaxed/simple;
	bh=SoT2xmBVfDbTDLmJU1ewMwTP951Qvvta5aWClhfdxZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QXIXbwyeJsxegmwWYoauqt24yK+ifMibHX5H9DA/01pM+ZfHwMBD6uN6DxEXb1z3zYTjcaqVRZT0MSKLJTPUE28yaoPDDV88OwXGpvh3QBjG7OqC0dv+b3X+d2p0USCbM1Gd20NT3AjMtq7x63zJ+VGOwVKREfhd1Sh8SglOqBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TEFb7lo8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TEFb7lo8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1B362309;
	Wed,  1 Jul 2026 05:58:14 -0700 (PDT)
Received: from oss-apollo7005.oss.cambridge.arm.com (oss-apollo7005.oss.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03BDE3F85F;
	Wed,  1 Jul 2026 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782910699; bh=SoT2xmBVfDbTDLmJU1ewMwTP951Qvvta5aWClhfdxZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEFb7lo8AOBWiDgqoeFvTavPCn2zAXgLLLu/sc1BrLJkOivc8SWXZj4IiGxdB4bKC
	 sSdrjLM8V6oPpKgsZdct52JHWrXvciUlTo6MBoxL4sJsdf4iu7DeawcEki41wZkijV
	 zE6wgwzcu+GoVDnB7b5qe0162xyVlJHtbSPcD4Ao=
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
Subject: [PATCH v8 06/13] firmware: arm_scmi: Add SCMIV4.0 Powercap notifications support
Date: Wed,  1 Jul 2026 12:57:40 +0000
Message-Id: <20260701125747.407921-7-philip.radford@arm.com>
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

From: Cristian Marussi <cristian.marussi@arm.com>

Extend notification support to the new SCMIv4.0 Powercap format that carry
also a CPL identifier where specified.

Since this addition completes SCMIv4.0 Powercap support bump also the
protocol version define.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Philip Radford <philip.radford@arm.com>
---
 drivers/firmware/arm_scmi/powercap.c | 13 +++++++++----
 include/linux/scmi_protocol.h        |  3 ++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index cfa1dde71ff4..65fac7fc6169 100644
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
@@ -1326,14 +1327,18 @@ scmi_powercap_fill_custom_report(const struct scmi_protocol_handle *ph,
 		const struct scmi_powercap_cap_changed_notify_payld *p = payld;
 		struct scmi_powercap_cap_changed_report *r = report;
 
-		if (sizeof(*p) != payld_sz)
+		if (sizeof(*p) > payld_sz)
 			break;
 
 		r->timestamp = timestamp;
 		r->agent_id = le32_to_cpu(p->agent_id);
 		r->domain_id = le32_to_cpu(p->domain_id);
 		r->power_cap = le32_to_cpu(p->power_cap);
-		r->pai = le32_to_cpu(p->pai);
+		r->avg_ivl = le32_to_cpu(p->avg_ivl);
+		if (sizeof(*p) == payld_sz)
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

