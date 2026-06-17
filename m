Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB00C3D904C;
	Wed, 17 Jun 2026 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690386; cv=none; b=B389mOg+k9+aJqJBTNkqeuRO6St2REWrVACwd6yGZb8rFVC0X2oHbr3SnNlx8b6P1fMjKiuFhkKVfNajCVrGYSUDhwsIYG58O050x3XD0kqSPlGWKnnAi+plq6rLur6PYqz53Zx3w9eztO0sg368TAvT/rzxuMrLKmmIu05eZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690386; c=relaxed/simple;
	bh=ATBrsW2D3HgXXET57HMCGq3nDiZ26OtuLIrk0GitQpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwxWHlLj8TTaXmLu+/UKWSWQS2ZowiDknt8lAW39Sld6RE8WAoUZfaJsnB/k+ROc6hX1RdW3Y2zXrukuTSsN47qHy6kcn70mvdrwTAfrUbkQXTXPMaszl/yKS0bs5VuGg7+Xwc8xEFw5NKFKeO14r0OnCzE26cNoSNBZ5plIAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IFMF0i+m; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IFMF0i+m"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3FBE2E8E;
	Wed, 17 Jun 2026 02:59:38 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8AFF3F915;
	Wed, 17 Jun 2026 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781690383; bh=ATBrsW2D3HgXXET57HMCGq3nDiZ26OtuLIrk0GitQpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFMF0i+m+aOXu5QwYwfhX/7bLpvGrGt159a/cg8S898UrfKOt6zMKFH9sAYfQQBJF
	 vhMGdpvVdAV2QDD+4LbwEZoCig5fljgRhjlvsDPRxtDPgLYklZy54FPtZY9YQtnqAb
	 8s0bQv1Xa+Q2bMSctaZNTtZq5WPYlyg39fsrgrHw=
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
Subject: [PATCH v7 06/13] firmware: arm_scmi: Add SCMIV4.0 Powercap notifications support
Date: Wed, 17 Jun 2026 10:59:03 +0100
Message-ID: <20260617095910.1963578-7-philip.radford@arm.com>
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
index ba037e906640..7ed6b6467813 100644
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
@@ -1316,14 +1317,18 @@ scmi_powercap_fill_custom_report(const struct scmi_protocol_handle *ph,
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
index 547ab4763a63..299fa8499b3f 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -1125,7 +1125,8 @@ struct scmi_powercap_cap_changed_report {
 	unsigned int	agent_id;
 	unsigned int	domain_id;
 	unsigned int	power_cap;
-	unsigned int	pai;
+	unsigned int	avg_ivl;
+	unsigned int	cpli;
 };
 
 struct scmi_powercap_meas_changed_report {
-- 
2.47.3

