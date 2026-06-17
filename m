Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C84F3E3D86;
	Wed, 17 Jun 2026 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690404; cv=none; b=KXjj3egYxk6CKerEcoxjdGU9s9N8+iJFyiuq7oyDAAm2d7KuHSgXwNMhv6JdYGNAs5NXEejJymYPU0MOTJbMxaf/cR+VP4DCC4foEt33FRZPSWOr1gkI/UiHn1QWI6uL8ZnCLFd2F6QPbQ54LoKzNzmo7cr/UQTV6qDsRqezUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690404; c=relaxed/simple;
	bh=ysAvUv+uQKD7SvxfHb5LUEwIT9/VWVtRXW6Ysv0mpjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+i65xNS5fVbt5oIQKK1ThTllELejPTKMaqpXUDesFuM9Z3VKoWTCQFc0VJOoOTQlGXCBgr6/6Rdk7kcjnLa0Uuka/ogOoa4IKYrCNXYFbp2bnZrZM6GpZS8yDJ1gYHVadpbB6YYXerW76qOikdQj79XgX1hERSZdTNB6Y4XmUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XBaCmaZH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XBaCmaZH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7C1B2E8E;
	Wed, 17 Jun 2026 02:59:57 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1511E3F915;
	Wed, 17 Jun 2026 02:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781690402; bh=ysAvUv+uQKD7SvxfHb5LUEwIT9/VWVtRXW6Ysv0mpjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBaCmaZHYV/1Vq+XaHmiTF7v+sLjlJed8tDn3PmgDLPVjLmboaRsxR3PdwzgOgoxJ
	 18r1ZNOu5Yh1oALXt7Kwxd2kpwFzKm9F+2VH0iOkNYkDUMJlP704J2jwHaZV/XROXk
	 I3H6rYvqa6I8YXINDWyKIvx9ydyrqp0x1gxmAOS4=
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
Subject: [PATCH v7 13/13] powercap: arm_scmi: Synthetic zone enable/disable
Date: Wed, 17 Jun 2026 10:59:10 +0100
Message-ID: <20260617095910.1963578-14-philip.radford@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617095910.1963578-1-philip.radford@arm.com>
References: <20260617095910.1963578-1-philip.radford@arm.com>
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
V6->V7
- Re-factored due to new control-type enable disable patch at the beginning
  of the series
- Prevent instance_root_get_enable() reporting a stale state
V5->V6
- Added use of to_scmi_powercap_root macro
- Changed instance_root_set_)enable_state to bail out on any error
- Changed logic in instance_root_get_enable to not check child states
---
 drivers/powercap/arm_scmi_powercap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index e1bad4b19990..23708f9934d4 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -458,10 +458,34 @@ static int instance_root_get_constraint(struct powercap_zone *pz, int cid, u64 *
 	return -EOPNOTSUPP;
 }
 
+static int instance_root_set_enable(struct powercap_zone *pz, bool mode)
+{
+	struct scmi_powercap_root *pr = to_scmi_powercap_root(pz);
+
+	return scmi_powercap_set_root_children_enable_state(pr, mode);
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
+	ret = scmi_powercap_read_root_children_enable_state(pr, mode);
+	if (!ret)
+		pr->enabled = *mode;
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
2.47.3

