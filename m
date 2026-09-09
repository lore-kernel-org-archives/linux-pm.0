Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D18B4AB1AD;
	Wed,  9 Sep 2026 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991522; cv=none; b=eV6KhkWJuvpZ2HKWMprEKunuG2LeurkJduyB+MEA6QIgNbkNKFikJe7pQYW90wQfcG9qUBQK1gKEvJBg1ckBgNFGFB46VnUCPr1k6mreQj4aCabHJ1eOgGXssGzr2aG6hlEwZtSwc3mkzAOuLfQbmPH3BJtbHoD5SmConcrw7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991522; c=relaxed/simple;
	bh=OR9+1hsuKbRKn30pFMBe4EEVo2eTrp7YqHpCpE24iZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLF3qzAHVUu9zmiCvwSR3pIv2JdR+yroqK2nwG7ANd789KZrCNk0/rCkgmKiJjmsxdvLZ1eReBTRrKxvZ8GiHzunaFXSUugKrT96/FnEjzW4GqwcWKs6iYHu/phV74Fd+7vF+WnaDTzlbyHlSbvfvDgOHEKYUHPJegQEGsC4mF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pRVpLrvB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pRVpLrvB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22DA2169C;
	Wed,  9 Sep 2026 15:05:16 -0700 (PDT)
Received: from oss-apollo7005.lab.cambridge.arm.com (oss-apollo7005.lab.cambridge.arm.com [10.7.15.171])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A53D03F7D8;
	Wed,  9 Sep 2026 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788991519; bh=OR9+1hsuKbRKn30pFMBe4EEVo2eTrp7YqHpCpE24iZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRVpLrvBP9BjA0mry/TfwCU2gz7cEV83i+RtpfdHpCUOG+n3qAl+DyS/ZlshdHf76
	 VHreVRsDoaG9ESb2yAfqYX4gAjAQ7lAwUc2RJm6gJr4jzTS7OcdsBWAW1/IhJSKt6J
	 TCPja13n8+sdpTxcX9cs8BNDfCIuwo8qaEKq6YdQ=
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
	philip.radford@arm.com
Subject: [PATCH v9 13/13] powercap: arm_scmi: Synthetic zone enable/disable
Date: Wed,  9 Sep 2026 22:04:37 +0000
Message-Id: <20260909220437.1254412-14-philip.radford@arm.com>
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

The synthetic instance root contols the same set of top-level SCMI domains
already handled by the control-type enable/disable helpers previously
introduced.

Add synthetic zone enabled attribute to the existing per-instance helpers
instead of duplicating the enable-state tracking and rollback logic.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V8->V9
- Added mutex lock to instance_root_set_enable and instance_root_get_enable
---
 drivers/powercap/arm_scmi_powercap.c | 31 ++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index aac0b00490b2..f42b1e8d228a 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -499,10 +499,41 @@ static int instance_root_get_constraint(struct powercap_zone *pz, int cid, u64 *
 	return -EOPNOTSUPP;
 }
 
+static int instance_root_set_enable(struct powercap_zone *pz, bool mode)
+{
+	struct scmi_powercap_root *pr = to_scmi_powercap_root(pz);
+	int ret;
+
+	mutex_lock(&scmi_powercap_roots_lock);
+	ret = scmi_powercap_set_root_children_enable_state(pr, mode);
+	mutex_unlock(&scmi_powercap_roots_lock);
+
+	return ret;
+}
+
+static int instance_root_get_enable(struct powercap_zone *pz, bool *mode)
+{
+	struct scmi_powercap_root *pr = to_scmi_powercap_root(pz);
+	int ret;
+
+	if (!mode)
+		return -EINVAL;
+
+	mutex_lock(&scmi_powercap_roots_lock);
+	ret = scmi_powercap_read_root_children_enable_state(pr, mode);
+	if (!ret)
+		pr->enabled = *mode;
+	mutex_unlock(&scmi_powercap_roots_lock);
+
+	return ret;
+}
+
 static const struct powercap_zone_ops instance_root_ops = {
 	.get_max_power_range_uw = scmi_powercap_get_max_power_range_uw,
 	.get_power_uw = instance_root_get_power_uw,
 	.release = instance_root_release,
+	.set_enable = instance_root_set_enable,
+	.get_enable = instance_root_get_enable,
 };
 
 static const struct powercap_zone_constraint_ops instance_root_const_ops = {
-- 
2.25.1

