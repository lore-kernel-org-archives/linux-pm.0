Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747466;
	b=S/Pt1ZFPUV3Co8WpMDsvTiXmVRcl83aSdpLmnEmvfJC9EAtjxIde1A0qs4io9E5izDyr
	 woO38NP66F2XH4evh2kQokAR8zYinN9m53XjzODIIC2tKeKaovM5uGferqQkUOsFTbFFV
	 /uws8gVcc0LMSFWOHxlRM8tSueC1ZD27F6N5p7TnqKz+CprUnMBySfrBiVM2cZIxa0P61
	 wfaj+QK/5znUBxU4HU8Z2MAqL2xGj+nXDcW0kjdc0JUp0BBbHWBrTzb0FFC1l3hamkuZk
	 YoqvffYJaPWwOdEquHIq8t37MTzMQ0LavGbVXOWZ4fso1wugNdLtN0/4BzhVtnSFuiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747466;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hnRNJDC9zZzpskW7KFxOEfChNL+3CoFVY77+rrtTJUk=;
	b=oVhpIJ1/62+81Bo6dk1F8RfhT53i94WG5LE/Bo50XjeeXnGRuQmEpzaTO7Ts3K7jFIdG
	 sgBpk+adFEnX676WAzTuxTgFF1WICmmU+xKIU9+H3NzXN4yDeoLh5PUHB6dByY3ZL41aP
	 jqoLvxp5LtQI7dX7MiGjjpZPs5kP6j0cA55n0M/lp6rhluRZ1ND/mjJqh992L1GBnWvPp
	 4diY6ecE9JKSKtGv2DUY9pIbV57oVNJwQ6qTPHE9bVpg3uZHXE+clpLjBrCs1MK+jZHCy
	 yzTFL5C2jcQZpQkXJ3KPNkp8ljZh5NZYYrBP5ZtvfyHgxIphNRqjcq0DR3klsvIFkbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Dm8azli5;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0552D606A33D;
	Tue,  3 Nov 2026 23:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0552D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Dm8azli5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 589581595;
	Tue,  3 Nov 2026 15:10:55 -0800 (PST)
Received: from e121740.manchester.arm.com (e121740.arm.com [10.33.8.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C54AD3F673;
	Tue,  3 Nov 2026 15:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793747458; bh=TheZWpVaLFvYFp0EOHxjK4eXwGVqyf0Ejvl0GkdFhEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dm8azli55m6AwuvsF2cZVyMMUpBi5OYK26MKqFtJcVy6AN3Js6kog8ehGs09k/WvA
	 Ll++b88DJLxT2WzTv0oX9aERuA2aQc8uMnUVvrK6ID/CS2WJN8rL7wYvSaDWpK2Ce+
	 qoR+giYC4iQf1zav2322Sy104Ico+qqkI1N1PqNc=
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
Subject: [PATCH v10 12/13] powercap: arm_scmi: Add get_power_uw to synthetic node
Date: Tue,  3 Nov 2026 23:10:06 +0000
Message-Id: <20261103231007.537082-13-philip.radford@arm.com>
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

Exposes the current power usage from the immediate children of the
synthetic (root) powercap node. Iterates over pr->spzones and sums per-zone
power. Domains without powercap monitoring are skipped. If none of the
children can be measured, return -ENODATA.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V9->V10
- skip immediate child zones that do not support power monitoring
- return -ENODATA if none of the synthetic root children can be measured
---
 drivers/powercap/arm_scmi_powercap.c | 46 ++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 88003564581e..d0255fd42007 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -17,6 +17,9 @@
 #define to_scmi_powercap_zone(z)		\
 	container_of(z, struct scmi_powercap_zone, zone)
 
+#define to_scmi_powercap_root(z)		\
+	container_of(z, struct scmi_powercap_root, instance_root.zone)
+
 static const struct scmi_powercap_proto_ops *powercap_ops;
 
 struct scmi_powercap_zone {
@@ -431,9 +434,48 @@ static int instance_root_release(struct powercap_zone *pz)
 	return 0;
 }
 
-static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *v)
+static int instance_root_get_power_uw(struct powercap_zone *pz, u64 *power_uw)
 {
-	*v = 0;
+	struct scmi_powercap_root *pr = to_scmi_powercap_root(pz);
+	struct scmi_powercap_zone *child;
+
+	u64 p, acc = 0;
+	int i, ret;
+	bool measured = false;
+
+	if (!pz || !power_uw)
+		return -EINVAL;
+
+	for (i = 0; i < pr->num_zones; i++) {
+		child = &pr->spzones[i];
+
+		if (!child->registered || child->invalid)
+			continue;
+
+		if (child->info->parent_id != SCMI_POWERCAP_ROOT_ZONE_ID)
+			continue;
+
+		/*
+		 * The synthetic root reports the sum of measureable immediate children.
+		 * Control-only children do not contribute to the sum.
+		 */
+		if (!child->info->powercap_monitoring)
+			continue;
+
+		ret = scmi_powercap_get_power_uw(&child->zone, &p);
+		if (ret) {
+			dev_dbg(child->dev, "Failed to read child power: %d\n", ret);
+			return ret;
+		}
+
+		acc += p;
+		measured = true;
+	}
+
+	if (!measured)
+		return -ENODATA;
+
+	*power_uw = acc;
 	return 0;
 }
 
-- 
2.34.1

