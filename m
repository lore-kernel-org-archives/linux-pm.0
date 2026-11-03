Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747450;
	b=m6Y+yIxqSMhffEqXpQ+et7oy3IAOSYdegSdXK2YqwIxXyjbRS7/O1aagKz70af1TDY6r
	 cV+1vswk/2GzRVPEwT6YKU1WqsbHxKJ2TWY7OtxJwRDDRwj76l2iu7p4OnjqhW7vAMEW7
	 UPZyHyPS9P3Vp8+1nUPc4omUIaro9GZujTxkdGvYtCjsFoZvQuKakdIq44V35y7nl9/6X
	 ifV5axhoC+rUmUEx4heRBDn3TZmRXtiUyiQ3qXurg73Kbb1yB8RzZQi7tx9DzFrn4vyd4
	 7p5TVyrE8zmBGp5t2BxBWxCX/OUCwZqyZNfCq5It1m/Q21aTbO1sYZq6ITT8yd4Nrpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747450;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l8CeoFAiWciwWHbMHzBEA3tAAikKBiiZd2x+URbDIqs=;
	b=M3fEotRzhcYMyw8ZhmNHIxCm8I5Z3hTTddgTCM6enHJrdx/Zgv30KSBV3xQpNl9yhl9G
	 c0cGndLXH88UD74sbwZOnMP0NgNYKdDtfXlSIH38kqdontb9zE/9TKwnAKBOKhbj1Ak1t
	 YFeOvL4xD6xSQKrQMQ5UdQ6a4B0pp4Os5g2HgXdPhiQa/0Eq/ZhwgGK98ghFDqSCFLtZ7
	 G7bAjKmOEZoIdXzbxeSw5oAfmXQomEfetsDN1R5jyXYE+FZ0rUCqAvnrXxn2kA74nsE5x
	 YKNm6S7LLF0sF2d5O+POpf/5K2ZPu834gdaJ5Pw41vqKiNjN1HHReGFn2HzDdGuo+EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NZnzBvrd;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C92606A33E;
	Tue,  3 Nov 2026 23:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C92606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NZnzBvrd
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BDE41595;
	Tue,  3 Nov 2026 15:10:46 -0800 (PST)
Received: from e121740.manchester.arm.com (e121740.arm.com [10.33.8.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 720B63F673;
	Tue,  3 Nov 2026 15:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793747449; bh=V2Dfh3i0wYp9MNOKvKOfAQgrxIlDapReeG/2i0tOW5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZnzBvrdOnrdJ0HZ0/sE/3uxl4dJ0SzVJxfQRb7YD+tHKjkJNvcYMKbAkDLeRaWFL
	 ciRYzrrbpnWbd2Sd/Jv/ejZBBFDgWLyloyy+w2lZ3cWfCLL2BBCOrI+9QdmrSX3nH/
	 CcFuZ4YBAk6qo4AZzg2+zuZrUSvIwbLUXqUSjXu4=
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
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Philip Radford <philip.radford@arm.com>
Subject: [PATCH v10 09/13] powercap: arm_scmi: Enable multiple constraints support
Date: Tue,  3 Nov 2026 23:10:03 +0000
Message-Id: <20261103231007.537082-10-philip.radford@arm.com>
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

Initialize the domains with all the discovered available constraints,
making available multiple per-domain constraints when the platform has
advertised support for multiple concurrent power limits.

CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: linux-pm@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
[Philip: Amended Copyright]
Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V9->V10
- clamp exposed constraints to MAX_CONSTRAINTS_PER_ZONE instead of failing probe
- warn when firmware advertises more CPLs than the powercap core can expose
---
 drivers/powercap/arm_scmi_powercap.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 0753a6938512..0c2a20f06979 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -2,7 +2,7 @@
 /*
  * SCMI Powercap support.
  *
- * Copyright (C) 2022 ARM Ltd.
+ * Copyright (C) 2022-2026 ARM Ltd.
  */
 
 #include <linux/device.h>
@@ -461,15 +461,23 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
 {
 	int ret = 0;
 	struct powercap_zone *z;
+	unsigned int nr_constraints;
 
 	if (spz->invalid) {
 		list_del(&spz->node);
 		return -EINVAL;
 	}
 
+	nr_constraints = min_t(unsigned int, spz->info->num_cpli,
+			       MAX_CONSTRAINTS_PER_ZONE);
+
+	if (spz->info->num_cpli > MAX_CONSTRAINTS_PER_ZONE)
+		dev_warn(spz->dev, "Powercap domain %s advertises %u CPLs, exposing only %u constraints\n",
+			 spz->info->name, spz->info->num_cpli, nr_constraints);
+
 	z = powercap_register_zone(&spz->zone, scmi_top_pcntrl, spz->info->name,
 				   parent ? &parent->zone : NULL,
-				   &zone_ops, 1, &constraint_ops);
+				   &zone_ops, nr_constraints, &constraint_ops);
 	if (!IS_ERR(z)) {
 		spz->height = scmi_powercap_get_zone_height(spz);
 		spz->registered = true;
-- 
2.34.1

