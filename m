Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747462;
	b=0sLQ6B1Khvd3cyK+bPyDanwEJj22gSQ3lI6q0WsV8dEIVlDMZ6CubYLXKG7v6xvYJ2I5
	 nn5rYA+c5UjKsvcLZPmPQCQ0wBJAgCkfLOHohSS8AdOZtaWDHkiFjufgvaBkjMztHp8Wx
	 6EnkDP1wd5bwo1yWsU/xELkSbIeCcXqTHj4ItSFImzzxpiuF7NKcVYHGhKAzVBsgGZ/gM
	 n8SYuxiB7cLdihRFJoxqNOFULdtfiFx9ux6nKtejZnCdhrdklM0hKDp+896s+VWi+oj2w
	 FCxajbFy1wxPit8naaaDEzxcx6R/RFH7dPHnMe/V/yQt7PttjHyGaecjZWe2Ly29EIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747462;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d4vGSbGLP5QmQjtMYL4YtbBW4RNR7njSMHoefQg68F8=;
	b=I0/3x/suey5ctSpzUIwJg6E469iZMDKzP5R4xcJph3eADH6DsdnvLZEpKM4W2wFtEcql
	 g7/zaOCVCHYvZBoqsaWgoRu9gaBMF6B0IbQaqQRsD1klB5pr4xrYGTYq+5nPkl+rgNkB8
	 ZnWPK9hC2GK19tmtxuFnvb+EirIASL15m71mJqcRoVFwDTXfywuAsFHoWfDgJ1hletie3
	 0QxgrSH6C/oVGEhsHPcQUPK1rSgN9oDdOmqJPWYVdMxJoyJ0DzVGwX49nNiQPcjLSLSdL
	 XE6kJ//q1eYpEH0CnWWQhHct6OQE2gkx+qBocIeUnJu2Wz9b7PIX6OZw/tFUQkdCOEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=u+o0mys5;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AEE606D80C;
	Tue,  3 Nov 2026 23:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22AEE606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=u+o0mys5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C1661650;
	Tue,  3 Nov 2026 15:10:58 -0800 (PST)
Received: from e121740.manchester.arm.com (e121740.arm.com [10.33.8.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9AA13F673;
	Tue,  3 Nov 2026 15:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793747461; bh=gtZfVqpym8AznIcNX4e0EWJGiRVBh8hgiCGZKcj+Omg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+o0mys5UwYS+xRie1FMPV+oD6wW76RtE1TXoQAw+3f3IGY4J28zZLui5+bRPf8PY
	 +t6DnvQuCMma9aR1Av/fP9VrzF0WYZva5tcG3w2a4/ABnzSqtCZd/FfahO0sIeUItx
	 wpNeLNIu90nYw2pGNEokKq+Q3ncRTHNgSmqhlnU4=
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
Subject: [PATCH v10 13/13] powercap: arm_scmi: Synthetic zone enable/disable
Date: Tue,  3 Nov 2026 23:10:07 +0000
Message-Id: <20261103231007.537082-14-philip.radford@arm.com>
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

The synthetic instance root contols the same set of top-level SCMI domains
already handled by the control-type enable/disable helpers previously
introduced.

Add synthetic zone enabled attribute to the existing per-instance helpers
instead of duplicating the enable-state tracking and rollback logic.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V9->V10
- add synthetic-root enable helper with per-zone state snapshot and roolback
- abort synthetic-root enables writes if any root child zone is not configurable
- restore each changed child zone to its previous state on failure
---
 drivers/powercap/arm_scmi_powercap.c | 104 +++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index d0255fd42007..0e86ad605189 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -489,10 +489,114 @@ static int instance_root_get_constraint(struct powercap_zone *pz, int cid, u64 *
 	return -EOPNOTSUPP;
 }
 
+static int scmi_powercap_set_root_children_enable_state(struct scmi_powercap_root *pr,
+							bool mode)
+{
+	struct scmi_powercap_zone_state *states;
+	struct scmi_powercap_zone *spz;
+	int num_zones = 0, nr_states = 0;
+	int i, ret = 0;
+
+	for (i = 0; i < pr->num_zones; i++) {
+		spz = &pr->spzones[i];
+
+		if (scmi_powercap_is_control_type_child(spz))
+			num_zones++;
+	}
+
+	states = kcalloc(num_zones, sizeof(*states), GFP_KERNEL);
+	if (!states)
+		return -ENOMEM;
+
+	for (i = 0; i < pr->num_zones; i++) {
+		spz = &pr->spzones[i];
+
+		if (!scmi_powercap_is_control_type_child(spz))
+			continue;
+
+		if (!spz->info->cpli[0].cap_config) {
+			ret = -EOPNOTSUPP;
+			goto out_free;
+		}
+
+		states[nr_states].spz = spz;
+
+		ret = powercap_ops->cap_enable_get(spz->ph, spz->info->id,
+			&states[nr_states].prev_enabled);
+
+		if (ret)
+			goto out_free;
+
+		nr_states++;
+	}
+
+	for (i = 0; i < nr_states; i++) {
+		spz = states[i].spz;
+
+		if (states[i].prev_enabled == mode)
+			continue;
+
+		ret = powercap_ops->cap_enable_set(spz->ph, spz->info->id, mode);
+		if (ret)
+			goto revert;
+
+		states[i].changed = true;
+	}
+
+	pr->enabled = mode;
+	goto out_free;
+
+revert:
+	while (i--) {
+		spz = states[i].spz;
+
+		if (!states[i].changed)
+			continue;
+
+		powercap_ops->cap_enable_set(spz->ph, spz->info->id,
+			states[i].prev_enabled);
+	}
+
+out_free:
+	kfree(states);
+	return ret;
+}
+
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
2.34.1

