Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794740928;
	b=lPmEjKyM6r0KNkCWBxLxr75uz3ju7SHZB6B8bZj+uNkfeoqc+8N+M+7PWzi0bXEsFC+E
	 cRHHsjeeezld++w9/vPkmhpHNENQQdQfNsKdspiEo3rxTORwwU95Ks7aXYRmIaEj7Y3Pl
	 3ETPntxd5jwiTTnSDD6uZ30yFyPLhicQn371+bHQQxz1pp+CqvnmJcV7H/abof/7H/OCV
	 SYr633Ib+4H3WFbyw0OEv2iU4gtLNulfUaCxJQKqstH+PwEmzgwkZbhHvXuiO6JlWxgw2
	 TFenuEl4hGB4Pb+7FEe0pu5NqeSW63EeFaUaZ0dwwSuwv+ffoLXINtiPwn49u9KiLvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794740928;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=s8pBft0CdYm72gM2FDBjkmUGraVLk92qFzft6iRlcsc=;
	b=ipsi+kIKQxlEpWxBFPHgFCezvAXvyIihGg3DSspLYZCsk2A8rpy41MR+qxhJADpH50Xu
	 mZDX/yI9SGPzW1Mv40s2PViArjd+JO2uiAsHc33G3xMdEGgJ4wO9We4AwbiVUoim7h6Ph
	 J7ezUuY87Ym8tyDN0sx7P3qoW9CCaou5K3WdIW1Kr9GFiyyiq/E28qlL6Ci3dcgr9QtNh
	 1j1OiRTVQP+3G9Dx6QmzpM612gG2GEkJe2Ig1nsaPHzTu6csd/cvIOUdONESrE/2lzj4J
	 5z4XtbkHAL/Rb5SqEGzQO0auLGt1YZ6QBJ4g7zGzmyKufB+TSQEW3bOmFU0rL/M2Lrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p2fn5iyI;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5469606A339;
	Sun, 15 Nov 2026 11:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5469606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p2fn5iyI
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F21B153B;
	Sun, 15 Nov 2026 03:08:44 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED0BC3F632;
	Sun, 15 Nov 2026 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794740927; bh=dmQn6Bh6dp5f3+dq/JzrJw2D9XEMlAuy1xwcIOAHdWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2fn5iyI/EaJzeJ/7OO8DNYKSn8PfCdxfAK8TIqTT/HdPzlaO879ZqYjWMeKs7zQl
	 Yga/urQEr2c++AKAz4KkOE+pjOWnuk4ocnoN3ZSx3Z+fSceCfMamV1cBCfi7T6LvIQ
	 ZqgXWlvRGuT4riHTSzYuw+vpns17+IA/EbtI3/J4=
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@kernel.org,
	philip.radford@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sashiko <sashiko-bot@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/3] powercap: arm_scmi: Reject zones hierarchy containing cycles or holes
Date: Sun, 15 Nov 2026 11:05:45 +0000
Message-ID: <20261115110546.2344308-3-cristian.marussi@arm.com>
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

While walking the hierarchy of powercap zones received from the SCMI server
bailout with an error if any cycle or hole is detected in the received set
of zones which has to represent a tree or a forest.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-6466cd8d-c2b1-43da-8141-bf8bf49a17b1
Closes: https://sashiko.dev/#/bug/linux-4895c0ac-74f4-4860-a006-9f5ef7b0a012
Fixes: 3e767d6850f8 ("powercap: arm_scmi: Remove recursion while parsing zones")
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index e2270476a98c..dbc9871fc1e2 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -22,6 +22,7 @@ static const struct scmi_powercap_proto_ops *powercap_ops;
 struct scmi_powercap_zone {
 	bool registered;
 	bool invalid;
+	bool visited;
 	unsigned int height;
 	struct device *dev;
 	struct scmi_protocol_handle *ph;
@@ -316,6 +317,7 @@ static int scmi_powercap_register_zone(struct scmi_powercap_root *pr,
 			spz->info->name, parent ? parent->info->name : "ROOT",
 			spz->height);
 	} else {
+		spz->invalid = true;
 		list_del(&spz->node);
 		ret = PTR_ERR(z);
 		dev_err(spz->dev,
@@ -379,8 +381,25 @@ static int scmi_zones_register(struct device *dev,
 	while (spz) {
 		struct scmi_powercap_zone *parent;
 
+		spz->visited = true;
 		parent = scmi_powercap_get_parent_zone(spz);
 		if (parent && !parent->registered) {
+			/*
+			 * An un-registered parent node is never visited twice:
+			 * when that happens it is either a cycle or a hole, i.e.
+			 * the attempt to walk again through a node which was already
+			 * removed from @scmi_zones since it previously failed to
+			 * register.
+			 */
+			if (parent->visited) {
+				dev_err(dev, "Found a %s in zone ID %u\n",
+					parent->invalid ? "hole" : "cycle",
+					parent->info->id);
+				scmi_powercap_unregister_all_zones(pr);
+				ret = -EINVAL;
+				reg_zones = 0;
+				goto out;
+			}
 			zones_stack[sp++] = spz;
 			spz = parent;
 		} else {
@@ -392,8 +411,8 @@ static int scmi_zones_register(struct device *dev,
 				 * Bail-out.
 				 */
 				dev_err(dev,
-					"Failed to register non-leaf zone - ret:%d\n",
-					ret);
+					"Failed to register non-leaf zone ID %u - ret:%d\n",
+					spz->info->id, ret);
 				scmi_powercap_unregister_all_zones(pr);
 				reg_zones = 0;
 				goto out;
-- 
2.54.0

