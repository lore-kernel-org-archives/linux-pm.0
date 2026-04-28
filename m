Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6F83EF0A8;
	Tue, 28 Apr 2026 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367410; cv=none; b=FfxRyGbedZOxgYGjsjS9bxncr5hlGotVfSmPiPbX3F7iG4ztkK9tS6xPV6s/i07wY9413zw4Xd45XRtmogp/Jw5EWWoEsXTXOqxsOxLoBdXnxchTtCVvV8BAaPg2WsdBxF/jHFmIekPPBTAD1+DM5EY9mgmI2oEOUbofYZh3el0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367410; c=relaxed/simple;
	bh=JUOAYUoA6ZULBMyS9cgEcmGlJ6DkFAap892e25+ywaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMx/eHXYTgOCH8lk8vpXS6yonf8I2MWCmgOygWgA1PrpezdwTRYIbRIFBOdafJ0pTfNCFzVPyQbkDTQzBxg+ifi1rKULzOjbzzfOOldkwtpdT97oHOmrhgyHwMIZFn3bVaZKD1jS1mZNhEnS9+TdNJMgAlM4hf6kS6x9aWQY7SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZVJraegf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZVJraegf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E8CE15A1;
	Tue, 28 Apr 2026 02:10:03 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B2433F62B;
	Tue, 28 Apr 2026 02:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777367408; bh=JUOAYUoA6ZULBMyS9cgEcmGlJ6DkFAap892e25+ywaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVJraegfG9O8iooQVT2WNbzCPlvjOV49BNZvoeGwVD6sMzmVT+jAf/F2g3o2YwUqG
	 wloV5dRDS/I+bud801RIyS4/RTiRjHsV7aCccgWKMfNYVOD37FTMg2H08QieNBVgqB
	 RR283x7tkLOAU8yAgvQc2dNp353q29NPkpqORTMU=
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
Subject: [PATCH v5 12/12] powercap: arm_scmi: Synthetic zone enable/disable
Date: Tue, 28 Apr 2026 10:09:21 +0100
Message-ID: <20260428090922.346069-13-philip.radford@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428090922.346069-1-philip.radford@arm.com>
References: <20260428090922.346069-1-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functionality to disable and enable the synthetic zone which
also affects the immediate children of the synthetic zone by applying
the same command to them.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 81 ++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 81b5214acda4..1ed2949b06cb 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -270,6 +270,85 @@ static int instance_root_release(struct powercap_zone *pz)
 	return 0;
 }
 
+static int instance_root_set_enable_state(struct powercap_zone *pz, bool enable)
+{
+	struct scmi_powercap_zone *root;
+	struct scmi_powercap_root *pr;
+	struct scmi_powercap_zone *child;
+	int ret, first_err = 0;
+
+	if (!pz)
+		return -EINVAL;
+
+	root = to_scmi_powercap_zone(pz);
+	pr = container_of(root, struct scmi_powercap_root, instance_root);
+
+	list_for_each_entry(child, &pr->registered_zones[0], node) {
+		if (child == &pr->instance_root)
+			continue;
+
+		if (child->info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID)
+			continue;
+
+		if (!child->info->cpli[0].cap_config)
+			continue;
+
+		ret = powercap_ops->cap_enable_set(child->ph, child->info->id, enable);
+
+		if (ret && !first_err) {
+			first_err = ret;
+			dev_err(child->dev, "failed to %s zone %s: %d\n",
+				enable ? "enable" : "disable",
+				child->info->name, ret);
+		}
+	}
+
+	return first_err;
+}
+
+static int instance_root_set_enable(struct powercap_zone *pz, bool mode)
+{
+	return instance_root_set_enable_state(pz, mode);
+}
+
+static int instance_root_get_enable(struct powercap_zone *pz, bool *mode)
+{
+	struct scmi_powercap_zone *root;
+	struct scmi_powercap_root *pr;
+	struct scmi_powercap_zone *child;
+	bool enabled;
+	int ret;
+
+	if (!pz || !mode)
+		return -EINVAL;
+
+	root = to_scmi_powercap_zone(pz);
+	pr = container_of(root, struct scmi_powercap_root, instance_root);
+
+	*mode = true;
+
+	list_for_each_entry(child, &pr->registered_zones[0], node) {
+		if (child == &pr->instance_root)
+			continue;
+		if (child->info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID)
+			continue;
+		if (!child->info->cpli[0].cap_config)
+			continue;
+
+		ret = powercap_ops->cap_enable_get(child->ph, child->info->id, &enabled);
+
+		if (ret)
+			return ret;
+
+		if (!enabled) {
+			*mode = false;
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
 static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *power_uw)
 {
 	struct scmi_powercap_zone *root = to_scmi_powercap_zone(pz);
@@ -315,6 +394,8 @@ static const struct powercap_zone_ops instance_root_ops = {
 	.get_max_power_range_uw = scmi_powercap_get_max_power_range_uw,
 	.get_power_uw = instance_root_get_power_uw,
 	.release = instance_root_release,
+	.set_enable = instance_root_set_enable,
+	.get_enable = instance_root_get_enable,
 };
 
 static const struct powercap_zone_constraint_ops instance_root_const_ops = {
-- 
2.47.3

