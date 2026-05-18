Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E538248A2CE;
	Mon, 18 May 2026 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112386; cv=none; b=VFNrkTOpRrE1HIS7KQZeJw8NWM9VFmjLErBbySymsB870relaFkTp7F6WsZ8XLuX1OLXqR55Fm2pcc8IPTreyxwxFQlZ+ftQaami9DVgEw5Y79EPivxg9o/4PmkYkYcn/Y9chrn/dbGnamnOhCTbBJTSvHnjAzviz3tjTkIVw+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112386; c=relaxed/simple;
	bh=QnD9RSG/JDNn4vcquQDqlzUS6esWyYJrw8vo7lKbVhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSpu0HMzQSv+L3U8hzRSCYcKJmZMrPsycN1h2HfcWgwkjxPni1AYIBwNBW6HuDVWEqDKZK3bf6LFVBOgKKhLi4TkygJsQJbZcBeeYAZIhlumD1epBHEzPGhxGnxS9l3zByxmr1p21FDgKqhNA+s0Jh9r5em1zHnVGDoIdnt3UMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Zk66Za2z; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Zk66Za2z"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A07061D6F;
	Mon, 18 May 2026 06:52:57 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C89D43F7B4;
	Mon, 18 May 2026 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779112382; bh=QnD9RSG/JDNn4vcquQDqlzUS6esWyYJrw8vo7lKbVhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zk66Za2zEmQaJdMziPw9wN4qmR9ud2LAFtA35HoBj41jGCfBFUS1lw/hphr3uABhP
	 csn6Nt7cJQTmeIIq+7ACzM2GiveEIqzbGAknhva68oimD+8eyrb9kol3rsMofUYDVl
	 Od6DNMF1BhSWGJtKs+JNauA1D7ccMHWh5Eumeuzs=
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
Subject: [PATCH v6 06/12] firmware: arm_scmi: Extend powercap report to include MAI
Date: Mon, 18 May 2026 14:52:28 +0100
Message-ID: <20260518135234.2953532-7-philip.radford@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518135234.2953532-1-philip.radford@arm.com>
References: <20260518135234.2953532-1-philip.radford@arm.com>
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
V5->V6
- Re-worded existing comment for POWERCAP_MEASUREMENTS_NOTIFY
- Added define for V2/V3 sizes
- Used new definitions
---
 drivers/firmware/arm_scmi/powercap.c | 28 +++++++++++++++-------------
 include/linux/scmi_protocol.h        |  1 +
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 1d1188e98d49..fdfaf03277ab 100644
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
+#define SZ_V2 (sizeof(struct scmi_powercap_meas_changed_notify_payld))
+#define SZ_V3 (SZ_V2 - sizeof(__le32))
 
 enum scmi_powercap_protocol_cmd {
 	POWERCAP_DOMAIN_ATTRIBUTES = 0x3,
@@ -164,6 +167,7 @@ struct scmi_powercap_meas_changed_notify_payld {
 	__le32 agent_id;
 	__le32 domain_id;
 	__le32 power;
+	__le32 mai;
 };
 
 struct scmi_msg_powercap_cpc {
@@ -1201,24 +1205,18 @@ static int scmi_powercap_notify(const struct scmi_protocol_handle *ph,
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
@@ -1334,13 +1332,17 @@ scmi_powercap_fill_custom_report(const struct scmi_protocol_handle *ph,
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

