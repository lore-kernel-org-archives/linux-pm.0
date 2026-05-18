Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D91F4921B3;
	Mon, 18 May 2026 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112389; cv=none; b=bG1STwpevCcf2v0J3QpeVX5v8xOn7xyqBK0+IF+W52DvUiPkQthFyVbaepWl8LRAX8YIUO59tn3Woh1EvURr8gxU7RB5pJNrF/lZuyEHQG5ECVOpZdhw0Usdyl2sWsEJ4EzvWLcpepHVhqPM1iEKg9kThS0TwKlN056c0apTsAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112389; c=relaxed/simple;
	bh=8lUyUOq00JGsWx3czpAN4XQFBIjun29IuQSs3tMDFHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/UjZiGbA8EP38qlhUiPR2gNMb7nkkOo52s6YZP+XM/ipkIzZ8vICnMtUQuUSirE+z3E1sr4yMlA49rCYOD+MhLorU2YGfCnymNMKRC+vN5KIZT7b8GN01+QyKJL/JCmJWCgXAL+i+l8JTY+1fETp05uekzcsk7HAXgFz4OqnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PTcOZDq1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PTcOZDq1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87FC21D6F;
	Mon, 18 May 2026 06:53:02 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D09A3F7B4;
	Mon, 18 May 2026 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779112387; bh=8lUyUOq00JGsWx3czpAN4XQFBIjun29IuQSs3tMDFHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTcOZDq1pZ2MjRLv59GilrQjLSZAxueC2caOY95tzlis/CfyW9QRaEk2LXLij1SHM
	 P+R+h9xIGwo+sPl5zHr19Lp/BY/+erp9ZaWcQWxeInE+eKwGUsPEOqin9GPq09IT/7
	 kXHYVArCvjad3DiX43kMueThkzxTC+dRSqeq1Hz8=
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
Subject: [PATCH v6 08/12] powercap: arm_scmi: Enable multiple constraints support
Date: Mon, 18 May 2026 14:52:30 +0100
Message-ID: <20260518135234.2953532-9-philip.radford@arm.com>
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
 drivers/powercap/arm_scmi_powercap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index be3007206a74..7f2bb162f96c 100644
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
@@ -311,7 +311,7 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
 
 	z = powercap_register_zone(&spz->zone, scmi_top_pcntrl, spz->info->name,
 				   parent ? &parent->zone : NULL,
-				   &zone_ops, 1, &constraint_ops);
+				   &zone_ops, spz->info->num_cpli, &constraint_ops);
 	if (!IS_ERR(z)) {
 		spz->height = scmi_powercap_get_zone_height(spz);
 		spz->registered = true;
-- 
2.47.3

