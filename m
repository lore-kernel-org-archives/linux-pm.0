Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5949551C;
	Mon, 18 May 2026 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112396; cv=none; b=tTbOuFh1+l0UKrB51QCOrAeaXRO+NRI5Yq5u6ek8IT85IPt0Eu6oBdbhv8S5Ee1gu8i8XLv+ZUwC97mYGBqCOrXdgGM6u9aO+uEbVcgmud4E3pptObhPFxrGKPjANeGF3Xrj/7BQx8SMfF+XRbA/9gfpzQfk8/ZjurGjDGP7eqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112396; c=relaxed/simple;
	bh=f9VAJAVk33CvV3c3BskgiL++l1yOos1V84XA6CDRE/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oN9N6I+4qpJ3R442djb+OZtpNzlGnyM5gQ2Xnf1KfSXy4vAC0a80Dtm8uh3gGny00A43PO0OvaQE7a5uKqcWZcM91mO+MH3ZxT1A0tYznplzutLz/4GJ3Cyt2EAtUXEFIBy+ZpLzWRcuNQ/3NIxAQAJ/PwjHwcvhN/UxxoUl43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Y5q/kekg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Y5q/kekg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6672328;
	Mon, 18 May 2026 06:53:09 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BB493F7B4;
	Mon, 18 May 2026 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779112394; bh=f9VAJAVk33CvV3c3BskgiL++l1yOos1V84XA6CDRE/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5q/kekgjz4HNRp5Vc6ajdvOol+jMXdHs4+O0bYIMyroet0jSlkQpvThUgby2+zuE
	 dfHMc19qJ4hKOv54JM1DpxfajiS0MvFSxkQcyQLS+co2i3ig6+0pqjvN3efEge6Gxd
	 gOtw0gOzCW9GC2shh6/DN8Te7nmlL9cbFsugRK/k=
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
Subject: [PATCH v6 11/12] powercap: arm_scmi: Add get_power_uw to synthetic node
Date: Mon, 18 May 2026 14:52:33 +0100
Message-ID: <20260518135234.2953532-12-philip.radford@arm.com>
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

Exposes the current power usage from the immediate children of the synthetic
(root) powercap node. Iterates over pr->spzones and sums per-zone power.

Signed-off-by: Philip Radford <philip.radford@arm.com>
---
V5->V6
- Moved multiple u64 values to the same line
- Reworked logic to walk SCMI zones and filter by parent
- Added to_scmi_powercap_root macro
---
 drivers/powercap/arm_scmi_powercap.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 5e7b7a3b79f2..f1cb25a408bb 100644
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
@@ -273,9 +276,37 @@ static int instance_root_release(struct powercap_zone *pz)
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
+
+	if (!pz || !power_uw)
+		return -EINVAL;
+
+	if (!pr)
+		return -ENODEV;
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
+		ret = scmi_powercap_get_power_uw(&child->zone, &p);
+		if (!ret)
+			acc += p;
+		else
+			dev_dbg(child->dev, "Failed to read child power: %u\n", ret);
+	}
+
+	*power_uw = acc;
 	return 0;
 }
 
-- 
2.47.3

