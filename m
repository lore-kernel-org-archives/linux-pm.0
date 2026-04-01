Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F023DE426;
	Wed,  1 Apr 2026 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775037265; cv=none; b=XRDVxSe/RxlMkTYFcztgsNdThbVMyI2ZSulLVJgVLC6oEioW4USDlwsNgdj9R1oWNFDEjoaNmiORvNRd6LSnFBQNH8lPbZOnKe0nHkxuWCVyqmKE/2jC9SPK9IpF9oRs6P7WMH7JUlzavtlfXjYsEOTljzXBCUR/i38eqHOMp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775037265; c=relaxed/simple;
	bh=Tr/I/efDffY7Qd3404yAJht1JzWyp8BMb9/E4Hz3Uv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuFx2mVVcczVQqEpwfaHzaJzR29YCeKZiM0jLKHLVVMlTnJ75bNsgqOqTP0tiUeJdm4rlwAMfKrlp+TG6A7Sqwf/6DfWQiEnMuJ+Ni2iYN7MSgmCRvDNCTPxXCKVuliMDcs9yPKoYkk3ja3ijYykTteGrCJmbZQs5LBWExdumAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NHAccUGc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NHAccUGc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 912CE2E98;
	Wed,  1 Apr 2026 02:54:09 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 752FB3F7D8;
	Wed,  1 Apr 2026 02:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775037255; bh=Tr/I/efDffY7Qd3404yAJht1JzWyp8BMb9/E4Hz3Uv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NHAccUGcWYNRCCB4AQ3707pX1iXyOlZ4mtsyiw0dQing0yk8QDk5Rgljg+jiuvrIa
	 WXnPaAJTnV3+rgef2gFQ9Eh45k06vJA6BS/DaY1K13jw0s06qRsEp8D59DY1vKVni7
	 z6Zjg1CTQuF53FJJfg2xrB0rFpCXCFjIiPz1/ccg=
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
Subject: [PATCH v4 06/11] firmware: arm_scmi: Extend powercap report to include MAI
Date: Wed,  1 Apr 2026 10:53:44 +0100
Message-ID: <20260401095349.2217840-7-philip.radford@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401095349.2217840-1-philip.radford@arm.com>
References: <20260401095349.2217840-1-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend scmi_powercap_meas_changed_report to include MAI change
notifications.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
 drivers/firmware/arm_scmi/powercap.c | 20 ++++++++++++--------
 include/linux/scmi_protocol.h        |  1 +
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 1d1188e98d49..b9d50f4e8ae5 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
+#include <linux/stddef.h>
 
 #include <trace/events/scmi.h>
 
@@ -164,6 +165,7 @@ struct scmi_powercap_meas_changed_notify_payld {
 	__le32 agent_id;
 	__le32 domain_id;
 	__le32 power;
+	__le32 mai;
 };
 
 struct scmi_msg_powercap_cpc {
@@ -1212,13 +1214,6 @@ static int scmi_powercap_notify(const struct scmi_protocol_handle *ph,
 		if (ret)
 			return ret;
 
-		if (enable && !low && !high) {
-			dev_err(ph->dev,
-				"Invalid Measurements Notify thresholds: %u/%u\n",
-				low, high);
-			return -EINVAL;
-		}
-
 		ret = ph->xops->xfer_get_init(ph, message_id,
 					      sizeof(*notify), 0, &t);
 		if (ret)
@@ -1333,14 +1328,23 @@ scmi_powercap_fill_custom_report(const struct scmi_protocol_handle *ph,
 	{
 		const struct scmi_powercap_meas_changed_notify_payld *p = payld;
 		struct scmi_powercap_meas_changed_report *r = report;
+		const size_t sz_v2 = offsetofend(struct scmi_powercap_meas_changed_notify_payld,
+						 power);
+		const size_t sz_v3 = sizeof(*p);
 
-		if (sizeof(*p) != payld_sz)
+		if (payld_sz != sz_v2 && payld_sz != sz_v3)
 			break;
 
 		r->timestamp = timestamp;
 		r->agent_id = le32_to_cpu(p->agent_id);
 		r->domain_id = le32_to_cpu(p->domain_id);
 		r->power = le32_to_cpu(p->power);
+
+		if (payld_sz == sz_v3 && PROTOCOL_REV_MAJOR(ph->version) >= 0x3)
+			r->mai = le32_to_cpu(p->mai);
+		else
+			r->mai = 0;
+
 		*src_id = r->domain_id;
 		rep = r;
 		break;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 299fa8499b3f..d0f6c0102559 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -1134,5 +1134,6 @@ struct scmi_powercap_meas_changed_report {
 	unsigned int	agent_id;
 	unsigned int	domain_id;
 	unsigned int	power;
+	unsigned int	mai;
 };
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.47.3

