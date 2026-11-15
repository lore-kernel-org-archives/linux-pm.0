Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794740929;
	b=wEBXpfBPiCgKNVU2vqW/+mkTVt8++2nMrX6t0Dr4dgKtCsiTunvyIwGz8n9Y/2i4IOK3
	 HJUjnrJ1USKIGC/tS3ELMqKADft+hDx5utYU4AKhiwJaJeb/+EF82u9512pHaoQ735JD0
	 uz+ynjmNIXXtcVz5kEihNv15ancbPYGpA5ECYmegEy9hJveyDTHA23xH2qM6xXkr93QsY
	 yEjO1g6TAaqD8688SbBNY+x5MgXVPTalZFM3ZoDmW0JPKGz4q3Ag8PS5xieVMxu7hOTMo
	 +McSYnLQt1jPvIBujejjbuhLidsUH6vq2dlG0U2r6wwjGlNevbqMaxXOCpPkd9DGqPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794740929;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aY1FUVzzYUMqybTrHy9jtFlDRFG7VeirsrOfiyiEqu4=;
	b=wzK7fqujiBCbPGMtzaTJOyOi0OFEnIGEC8ZqSrDRn0HDIYi3hLYHM8UctY2lq8PKloHH
	 8807CgB3sfMtAMShZRleruA1N3iO9zMazMCr3SWyQhmm2BYvPcqyK5Mo/Pf7VfTJfZYrJ
	 lGhk3YRsATSDWUe5Xicrp9a0s0AtAoBYc0pRcygca6YOcoOwaP0odvSnWOXAGJAu9J/Il
	 p+cSaXAE6EBwtP0/TyrJvborEsy84cZsg7SHz1MnGOTGqC89hNrI/2CUSBtSB4V6z0fKw
	 +Xb8nU5P5XTA60Yy5aI+uTSgLVNrR7a+7braEyCDvhi78TWl11Hi6ls/lqBPN2B7i8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=maYAFS7L;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13CE606A337;
	Sun, 15 Nov 2026 11:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F13CE606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=maYAFS7L
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85B911576;
	Sun, 15 Nov 2026 03:08:45 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D5BD3F632;
	Sun, 15 Nov 2026 03:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794740928; bh=8XYAIqtuEIboOHoTpgs3rKIeXDomMa1zPXW7EouXHw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maYAFS7LKNSu9ZvS5gAJjVprCUwxmdczl1rZA/MGPT8Vw37dJhphmswHpCfvc6zjY
	 uhEe8tEuqXrJrbdWyuYXNlBPIuxsTsR5DC7vFdyxKb9rt7IQe7Mqikqr7yQBLdyEbF
	 jc0th20yALxZoMiQgGIH0C4xBml4/5h+uCCZGmTU=
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@kernel.org,
	philip.radford@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 3/3] powercap: arm_scmi: Refactor scmi_zones_register error path
Date: Sun, 15 Nov 2026 11:05:46 +0000
Message-ID: <20261115110546.2344308-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261115110546.2344308-1-cristian.marussi@arm.com>
References: <20261115110546.2344308-1-cristian.marussi@arm.com>
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

Refactor and simplify scmi_zones_register error path by using
cleanup handlers.

No functional change.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index dbc9871fc1e2..6346037c889d 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2022 ARM Ltd.
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/math.h>
 #include <linux/limits.h>
@@ -368,11 +369,12 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
 static int scmi_zones_register(struct device *dev,
 			       struct scmi_powercap_root *pr)
 {
-	int ret = 0;
 	unsigned int sp = 0, reg_zones = 0;
-	struct scmi_powercap_zone *spz, **zones_stack;
+	struct scmi_powercap_zone *spz;
+	int ret = 0;
 
-	zones_stack = kzalloc_objs(spz, pr->num_zones);
+	struct scmi_powercap_zone **zones_stack __free(kfree) =
+		kzalloc_objs(spz, pr->num_zones);
 	if (!zones_stack)
 		return -ENOMEM;
 
@@ -396,9 +398,7 @@ static int scmi_zones_register(struct device *dev,
 					parent->invalid ? "hole" : "cycle",
 					parent->info->id);
 				scmi_powercap_unregister_all_zones(pr);
-				ret = -EINVAL;
-				reg_zones = 0;
-				goto out;
+				return -EINVAL;
 			}
 			zones_stack[sp++] = spz;
 			spz = parent;
@@ -407,16 +407,14 @@ static int scmi_zones_register(struct device *dev,
 			if (!ret) {
 				reg_zones++;
 			} else if (sp) {
-				/* Failed to register a non-leaf zone.
-				 * Bail-out.
-				 */
+				/* Failed to register a non-leaf zone. Bail-out. */
 				dev_err(dev,
 					"Failed to register non-leaf zone ID %u - ret:%d\n",
 					spz->info->id, ret);
 				scmi_powercap_unregister_all_zones(pr);
-				reg_zones = 0;
-				goto out;
+				return ret;
 			}
+
 			/* Pick next zone to process */
 			if (sp)
 				spz = zones_stack[--sp];
@@ -426,13 +424,11 @@ static int scmi_zones_register(struct device *dev,
 							       node);
 		}
 	}
-	ret = 0;
 
-out:
-	kfree(zones_stack);
+	/* If we get here any previous error was on a leaf zone, so ignored */
 	dev_info(dev, "Registered %d SCMI Powercap domains !\n", reg_zones);
 
-	return ret;
+	return 0;
 }
 
 static int scmi_powercap_probe(struct scmi_device *sdev)
-- 
2.54.0

