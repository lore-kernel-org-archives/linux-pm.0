Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747449;
	b=VdFzAvhXUE0SpqfF3/FCN1IOGsPNDMV1riTgcITajVgLfprgwjwZTud4wcXOAheQZVIE
	 C26quAwiimUEvK7LwpLYzCnqV3N6cNU3Phk+WniAv9n3dXRyQbgeFm7tPtUWkSCzN3yoB
	 cU3heITGxjQYOr8juCFvW1qXhRNfoD4TXuYIXo5LkrUpyw2pEbob18tTrF39feIzcdfF9
	 MM42u5AjISEHpfFAnFVWYPXV41mkMMdh84QsH3ImR4VAGGc19DcwIk/3pE9hxT9+nX03/
	 IEJv9lMdWAVo6+abHO3vUXuAveZCmIP9790+1wBdESlT6fVFL5mA5Jy4SyOMlRTTbqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747449;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cxbutWg6i4wFHRwhf3YnsjzOn2o6h0xhLHPzCcEB5ls=;
	b=St8hErC6+Aeh7e6a1aBcpPJ/lhax97Q6FcarBe54ccKZO+LtZJn6h3YQVqTB++qqMYdj
	 QRqTMIlZlszaJ0h79aH/W/+LEDdHR32VqtMKRy53Jz4fVLJWcwxiP/eVQwwpIruAY/vNO
	 W7zO/UZ1evRBqWqfPuGCgqyZrKlPQnxmwB/KEC+kuK0lzVeAKfUSLFKVpsA62ExWAuA5t
	 hn18bsg7pfpf4hKTxz3yu7ULlc/kJDPq/IbJvIqaOhrzLbkSsfdLOtSfoCy0L7Br64wlO
	 iUFIsVfQlui5OA4PUXfIT/Olj32K02ZHmx41CdAMY5CAWZiqyzqWyYxhIIiAjlBpWQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eYoyLFzV;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E19606A336;
	Tue,  3 Nov 2026 23:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76E19606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=eYoyLFzV
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CABF91595;
	Tue,  3 Nov 2026 15:10:39 -0800 (PST)
Received: from e121740.manchester.arm.com (e121740.arm.com [10.33.8.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44E503F673;
	Tue,  3 Nov 2026 15:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793747442; bh=TODup+TmFI2DvvVOjdOpUsqzDIAgZx/aSSgK9KNsxJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYoyLFzVBjv8j5J3E0iZYWe8QzeWpJt9Em94PXylht4fNp2h3uoqQKvDTyZ9jgujG
	 IyQzcPM3VsQfZLtlEAgei5ik5Y8QWAGu2cBhPDvRgNwHaSQ+G6jI59w54+uo2CqH1A
	 ydTMghgljRQ5NJZ5KEC4nLfyW7n63Ho11otMXSTA=
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
Subject: [PATCH v10 07/13] firmware: arm_scmi: Extend powercap report to include MAI
Date: Tue,  3 Nov 2026 23:10:01 +0000
Message-Id: <20261103231007.537082-8-philip.radford@arm.com>
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

Extend scmi_powercap_meas_changed_report to include MAI change
notifications.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
 drivers/firmware/arm_scmi/powercap.c | 28 +++++++++++++++-------------
 include/linux/scmi_protocol.h        |  1 +
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index bcfc2d8c5abb..530e42e6a1fd 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/scmi_protocol.h>
+#include <linux/stddef.h>
 
 #include <trace/events/scmi.h>
 
@@ -21,6 +22,8 @@
 #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30000
 
 #define CPL0	0
+#define SZ_V3 (sizeof(struct scmi_powercap_meas_changed_notify_payld))
+#define SZ_V2 (SZ_V3 - sizeof(__le32))
 
 enum scmi_powercap_protocol_cmd {
 	POWERCAP_DOMAIN_ATTRIBUTES = 0x3,
@@ -164,6 +167,7 @@ struct scmi_powercap_meas_changed_notify_payld {
 	__le32 agent_id;
 	__le32 domain_id;
 	__le32 power;
+	__le32 mai;
 };
 
 struct scmi_msg_powercap_cpc {
@@ -1271,24 +1275,18 @@ static int scmi_powercap_notify(const struct scmi_protocol_handle *ph,
 		struct scmi_msg_powercap_notify_thresh *notify;
 
 		/*
-		 * Note that we have to pick the most recently configured
-		 * thresholds to build a proper POWERCAP_MEASUREMENTS_NOTIFY
-		 * enable request and we fail, complaining, if no thresholds
-		 * were ever set, since this is an indication the API has been
-		 * used wrongly.
+		 * Build the POWERCAP_MEASUREMENTS_NOTIFY enable request using the
+		 * most recently configured thresholds.
+		 *
+		 * The absence of thresholds is not considered an error:
+		 * notifications can still be generated to report MAI changes, even
+		 * when low and high are set to zero.
 		 */
 		ret = scmi_powercap_measurements_threshold_get(ph, domain,
 							       &low, &high);
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
@@ -1406,13 +1404,17 @@ scmi_powercap_fill_custom_report(const struct scmi_protocol_handle *ph,
 		const struct scmi_powercap_meas_changed_notify_payld *p = payld;
 		struct scmi_powercap_meas_changed_report *r = report;
 
-		if (sizeof(*p) != payld_sz)
+		if (payld_sz != SZ_V2 && payld_sz != SZ_V3)
 			break;
 
 		r->timestamp = timestamp;
 		r->agent_id = le32_to_cpu(p->agent_id);
 		r->domain_id = le32_to_cpu(p->domain_id);
 		r->power = le32_to_cpu(p->power);
+		r->mai = 0;
+		if (payld_sz == SZ_V3 && PROTOCOL_REV_MAJOR(ph->version) >= 0x3)
+			r->mai = le32_to_cpu(p->mai);
+
 		*src_id = r->domain_id;
 		rep = r;
 		break;
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index e41e972c7e4f..085ca1a1e3a7 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -1138,5 +1138,6 @@ struct scmi_powercap_meas_changed_report {
 	unsigned int	agent_id;
 	unsigned int	domain_id;
 	unsigned int	power;
+	unsigned int	mai;
 };
 #endif /* _LINUX_SCMI_PROTOCOL_H */
-- 
2.34.1

