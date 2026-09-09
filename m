Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FC95AEC5D;
	Wed,  9 Sep 2026 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991496; cv=none; b=Zsi/PynppSXIura7TkuDjGUs/j1NsRleDEh7pLkc95ex1m2i5ilPjesfeMs4aD3e+1NVPSRJZUhmUtB0RGzQCRdHIfYJsROf1stwpwiIO6CDBzSqGFGaKrsYm8edXE449YzNVlqpheKgsC3rJli6Ih4JzwYMxEY4Bu1eEi+QhJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991496; c=relaxed/simple;
	bh=VaIjpliNHMdmpjcZ2+EaV8d740iUXIoJDb8F//xzL00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MKx3moAiNyjCpI8SC/ZN0Ej8kpxa0uysBC5qzsv6Sq0wUtfmNmIf24ckyrazxcfZxggpHF3KEC8dr6ik//NR2zdhEbUbP+xplz3J2utn8gX9D1CQfFh9RO32ONyDpvKWSiPd6FAqsF2R1wb+NTqzDX7TWDbJrpTSl/M7V2+QI14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IMLUagqT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IMLUagqT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC15D169C;
	Wed,  9 Sep 2026 15:04:49 -0700 (PDT)
Received: from oss-apollo7005.lab.cambridge.arm.com (oss-apollo7005.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F1433F7D8;
	Wed,  9 Sep 2026 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788991493; bh=VaIjpliNHMdmpjcZ2+EaV8d740iUXIoJDb8F//xzL00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMLUagqT5uhVayad3yYOTL4c4s8B3sW0Dz7KO0VGZ2bvvIo4b+G+c+IaqcDPNtq4g
	 knQYeIjdQoeLdv/9OY0ahuOY1GqXZlUJ+mcz9NyB34YFsISBtvajXdBLrAJhYYLCsY
	 bMbx1iYUaSI8L94NpY9hS/ie598YVqzUmkFSGfV8=
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
Subject: [PATCH v9 02/13] firmware: arm_scmi: Add an optional custom parameter to fastchannel helpers
Date: Wed,  9 Sep 2026 22:04:26 +0000
Message-Id: <20260909220437.1254412-3-philip.radford@arm.com>
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

Starting from SCMIv4.0 the protocols DESCRIBE_FASTCHANNEL commands allow
to specify one additional per-protocol custom field in the outgoing message
request in order to, optionally, further narrow down the scope of the
fastchannel discovery request; the related message-reply format is instead
unchanged.

Add an optional custom protocol parameter to the common fastchannel helper
so as to enable the caller to choose the kind of message to send based on
the detected protocol version.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Philip Radford <philip.radford@arm.com>
---
 drivers/firmware/arm_scmi/driver.c    | 12 ++++++++++--
 drivers/firmware/arm_scmi/perf.c      |  8 ++++----
 drivers/firmware/arm_scmi/powercap.c  |  8 ++++----
 drivers/firmware/arm_scmi/protocols.h |  2 +-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 3e0d975ec94c..81cb8eec14bc 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1902,6 +1902,11 @@ static int scmi_iterator_run_bound(void *iter, unsigned int *start,
 struct scmi_msg_get_fc_info {
 	__le32 domain;
 	__le32 message_id;
+	__le32 custom;
+#define MSG_FC_INFO_SZ_EXTENDED	\
+	(sizeof(struct scmi_msg_get_fc_info))
+#define MSG_FC_INFO_SZ		\
+	(sizeof(struct scmi_msg_get_fc_info) - sizeof(__le32))
 };
 
 struct scmi_msg_resp_desc_fc {
@@ -1930,7 +1935,7 @@ struct scmi_msg_resp_desc_fc {
 static void
 scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 			     u8 describe_id, u32 message_id, u32 valid_size,
-			     u32 domain, void __iomem **p_addr,
+			     u32 domain, u32 *custom, void __iomem **p_addr,
 			     struct scmi_fc_db_info **p_db, u32 *rate_limit)
 {
 	int ret;
@@ -1961,13 +1966,16 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 	}
 
 	ret = ph->xops->xfer_get_init(ph, describe_id,
-				      sizeof(*info), sizeof(*resp), &t);
+				      custom ? MSG_FC_INFO_SZ_EXTENDED :
+				      MSG_FC_INFO_SZ, sizeof(*resp), &t);
 	if (ret)
 		goto err_out;
 
 	info = t->tx.buf;
 	info->domain = cpu_to_le32(domain);
 	info->message_id = cpu_to_le32(message_id);
+	if (custom)
+		info->custom = cpu_to_le32(*custom);
 
 	/*
 	 * Bail out on error leaving fc_info addresses zeroed; this includes
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 4583d02bee1c..7f283f457e02 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -835,25 +835,25 @@ static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
 		return;
 
 	ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
-				   PERF_LEVEL_GET, 4, dom->id,
+				   PERF_LEVEL_GET, 4, dom->id, NULL,
 				   &fc[PERF_FC_LEVEL].get_addr, NULL,
 				   &fc[PERF_FC_LEVEL].rate_limit);
 
 	ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
-				   PERF_LIMITS_GET, 8, dom->id,
+				   PERF_LIMITS_GET, 8, dom->id, NULL,
 				   &fc[PERF_FC_LIMIT].get_addr, NULL,
 				   &fc[PERF_FC_LIMIT].rate_limit);
 
 	if (dom->info.set_perf)
 		ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
-					   PERF_LEVEL_SET, 4, dom->id,
+					   PERF_LEVEL_SET, 4, dom->id, NULL,
 					   &fc[PERF_FC_LEVEL].set_addr,
 					   &fc[PERF_FC_LEVEL].set_db,
 					   &fc[PERF_FC_LEVEL].rate_limit);
 
 	if (dom->set_limits)
 		ph->hops->fastchannel_init(ph, PERF_DESCRIBE_FASTCHANNEL,
-					   PERF_LIMITS_SET, 8, dom->id,
+					   PERF_LIMITS_SET, 8, dom->id, NULL,
 					   &fc[PERF_FC_LIMIT].set_addr,
 					   &fc[PERF_FC_LIMIT].set_db,
 					   &fc[PERF_FC_LIMIT].rate_limit);
diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 27e3c805e927..31b19967452f 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -726,24 +726,24 @@ static void scmi_powercap_domain_init_fc(const struct scmi_protocol_handle *ph,
 		return;
 
 	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
-				   POWERCAP_CAP_SET, 4, domain,
+				   POWERCAP_CAP_SET, 4, domain, NULL,
 				   &fc[POWERCAP_FC_CAP].set_addr,
 				   &fc[POWERCAP_FC_CAP].set_db,
 				   &fc[POWERCAP_FC_CAP].rate_limit);
 
 	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
-				   POWERCAP_CAP_GET, 4, domain,
+				   POWERCAP_CAP_GET, 4, domain, NULL,
 				   &fc[POWERCAP_FC_CAP].get_addr, NULL,
 				   &fc[POWERCAP_FC_CAP].rate_limit);
 
 	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
-				   POWERCAP_PAI_SET, 4, domain,
+				   POWERCAP_PAI_SET, 4, domain, NULL,
 				   &fc[POWERCAP_FC_PAI].set_addr,
 				   &fc[POWERCAP_FC_PAI].set_db,
 				   &fc[POWERCAP_FC_PAI].rate_limit);
 
 	ph->hops->fastchannel_init(ph, POWERCAP_DESCRIBE_FASTCHANNEL,
-				   POWERCAP_PAI_GET, 4, domain,
+				   POWERCAP_PAI_GET, 4, domain, NULL,
 				   &fc[POWERCAP_FC_PAI].get_addr, NULL,
 				   &fc[POWERCAP_FC_PAI].rate_limit);
 
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 15ad5162e37a..6b27e1b531a1 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -291,7 +291,7 @@ struct scmi_proto_helpers_ops {
 				  u32 message_id, u32 *attributes);
 	void (*fastchannel_init)(const struct scmi_protocol_handle *ph,
 				 u8 describe_id, u32 message_id,
-				 u32 valid_size, u32 domain,
+				 u32 valid_size, u32 domain, u32 *custom,
 				 void __iomem **p_addr,
 				 struct scmi_fc_db_info **p_db,
 				 u32 *rate_limit);
-- 
2.25.1

