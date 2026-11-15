Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794774033;
	b=QKkqEU4olkWEdQoFhmkzor/9DIpr4yWXGMx7O6nd2dkFP3ZYdFCuGJFE34eXVLz2Pqr8
	 3uuCmAKZZNuU5aZdSG1blf2SRRBzQqpBu069VoJTFLujxFFOBgXDBq+5Oa/fKQBuwNH3U
	 pS4nF/CNW6Kb7xyRjtU1EXfpvWngOnVy3VSbfeDEwZzNGhlCQgi/idBev52q2pnXsQBZ0
	 2ejGvyHjRe5JJNkKT74EZRooC7+6YGQFQPWkqsQO/0ZfdXVXywdoxGsOSp3srmzZU9IOh
	 G3BzuGFTB9vxl0SuW4yyoWj7wOkbcsciUjDlpxoRyD340GiQ2s+vdW+lKwqN21ZnPHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774033;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XsjA0jgUsvZUbNayLPJP6t8nTY2ZgvOUJkYyj0pEjCk=;
	b=oyCV/YlPxRC3LnP9UyyFOfewNUD8aHttElsdL5I9kPpv3JPMYn8fwW89LFOXtzow4nC1
	 WTGCBkEmEOT3GuGE6WiaUAwrsfbrD7MJekI8QW+0mq0ZwbhfyaGuzkHp1bnX4JKdiB7Vv
	 qt2wmdCWRkpH+SjzX36wdkiAzmruedtKkiif4CGZdNnOgqzOV1N3Y9C/4Qm4g5Lt0PE/r
	 bJPPkraQfm5wyvpgaRMgl9VVx9TejVRDgD2W0cdcN5mBih0uT0fv2Z/o6Z2MRi1ztPcWd
	 3qfJEV5G7dCLG53RGZeEae/C+0Ux0Idf7fnkr3KLI/R4j09liDrPXO4suuFm27BPD9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNBJ1ThS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5524E606B071;
	Sun, 15 Nov 2026 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PNBJ1ThS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794774033;
	b=K3mB3lASCRnocydB202wqV858bVZq0r0GVRH068pakfhjbs2oR37l4/n4SuuutS7ToUF
	 VLwSyrhw7k4oVHEzSH1RoDUga1ahCN3DNMg6T3vgz0KA1GpUB2bZF72+82QNWk2tqUVfV
	 7eZjvOIyOWcKRt5hmlsT9F0viSwa07Qcd3WEe7x/iPsf11nY9KxaBTSvIfoBrHHcYCI7N
	 vQbUfEJm29GnN24JBMJW0uDftEhab7b97UQGNmKZf/Er9xuDeHL5JVSOFuO5XwTclM3pQ
	 wjJ62iMikI8iJPBQ87ylMWPI9X32459E0EZVTQH6bdjGmlJNYIto9YFPsc35Kf1Q3pA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794774033;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XsjA0jgUsvZUbNayLPJP6t8nTY2ZgvOUJkYyj0pEjCk=;
	b=ihFjP0gzeMMDm+KAIlXrsDtvfUtprKqzpJaHIDSIB1/DUInYe/ZGo9p3T0ZBAMxnHBxm
	 JBBf7rzBjnXAdt6n6CkZAo0hI8fsVL5FgN6zX3Qyc84jDJIt1Ri9HWA2NcAHFBdpZ9esC
	 qpZnT/5ycQrTXYHH8irrfo+jbBFb5uMvch4F7UvhvoShg5KdnXXJf6he0ZbDCwvrCH1H4
	 cQtfT6LHNF9+LZyf+sVZZ3F4322cdV2D2Picc4nW11QScPthjZWdgmEsQJtHJOgrJ9LnJ
	 2FLn/raRjPEoyFPcg16gWsQZ0EvzJ5avzbyBldgccjjeJgwT8yvXo9LIcNqUXgSoPHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 74C2C1F02819;
	Sun, 15 Nov 2026 20:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774033;
	bh=XsjA0jgUsvZUbNayLPJP6t8nTY2ZgvOUJkYyj0pEjCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PNBJ1ThSpLk/MnfNYYeWud/umC88lL7M2eYp1fkRleMzrQVitQv56IGoLsPs5wiwg
	 zo+OKlt64ZuxlZB03Fv8VCjfCxK1eR+8JKR9GD7fkVgy2RD+9L971H41yH2KI4QEsc
	 OI4BDNM1JakRhpwrtEojOLMssJzdUCso9KeS9O9Di4neXqOPzdtFPc1doC5Mn/rKGW
	 vl3u+5UmoPusp2XDOrfgkCB7/FLJOC4oC6U2cyj/6Vva2P35+7d9LK7m7Mh7a8Kein
	 eydyLgcUe1F5OBCAvTN0ELXRhWEoRScDlbJHQEFlzD5TGZ+utKoFfiKoYLtDqAf3a/
	 QBWs9xkX4It1Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 06B5F4A1E8;
	Sun, 15 Nov 2026 20:20:32 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 16 Nov 2026 01:50:32 +0530
Subject: [PATCH 1/2] power: supply: qcom_battmgr: Apply a USB input current
 limit set early
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-vantage-battmgr-v1-1-7b59157377b7@yahoo.com>
References: <20261116-vantage-battmgr-v1-0-7b59157377b7@yahoo.com>
In-Reply-To: <20261116-vantage-battmgr-v1-0-7b59157377b7@yahoo.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joonhoe Kim <26rote@gmail.com>, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794774031; l=3206;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=X+AIq+fbPAzYnRwecAS8d+FO3Yj8+xtS8ZnJK+o2XnM=;
 b=1cTGhpH/zgCODx/8HqAWHqYqLH69ys6ZdUEfiixrF1PWjYy+WsI+Q9SISk7skES9t+ieJEHRQ
 iwP5BdEMykZBwQFtmS/iygkGCCA4LgVyYKbzN09s7gLuk8hRjm0Up9t
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Reply-To: venkat.yadlapati@yahoo.com
Content-Transfer-Encoding: 7bit

From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

The USB controller can report the current a USB host grants, e.g. with
the usb-psy-name property of dwc3, before the battery manager service
is up. The input current limit is then rejected with -EAGAIN and the
firmware keeps the 100 mA allowed before enumeration, so a phone that is
in use discharges while it is connected to a computer.

Remember the limit while the service is down and send it once the
service comes up.

Assisted-by: LLM
Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
---
 drivers/power/supply/qcom_battmgr.c | 45 +++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 431a35bcac80..fde9704d0acd 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -329,6 +329,10 @@ struct qcom_battmgr {
 
 	bool service_up;
 
+	/* USB input current limit set before the service was up, in uA */
+	bool usb_icl_pending;
+	u32 usb_icl;
+
 	struct qcom_battmgr_info info;
 	struct qcom_battmgr_status status;
 	struct qcom_battmgr_ac ac;
@@ -1144,25 +1148,40 @@ static const struct power_supply_desc sc8280xp_usb_psy_desc = {
 		     BIT(POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID),
 };
 
+static int qcom_battmgr_usb_set_icl(struct qcom_battmgr *battmgr, u32 icl)
+{
+	int ret;
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_request_property(battmgr, BATTMGR_USB_PROPERTY_SET,
+					    USB_INPUT_CURR_LIMIT, icl);
+	mutex_unlock(&battmgr->lock);
+
+	return ret;
+}
+
 static int qcom_battmgr_usb_set_property(struct power_supply *psy,
 					 enum power_supply_property psp,
 					 const union power_supply_propval *pval)
 {
 	struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
-	int ret;
-
-	if (!battmgr->service_up)
-		return -EAGAIN;
 
 	if (psp != POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT || pval->intval < 0)
 		return -EINVAL;
 
-	mutex_lock(&battmgr->lock);
-	ret = qcom_battmgr_request_property(battmgr, BATTMGR_USB_PROPERTY_SET,
-					    USB_INPUT_CURR_LIMIT, pval->intval);
-	mutex_unlock(&battmgr->lock);
+	/*
+	 * The USB controller can report the current a host grants before the
+	 * firmware service is up, apply it once the service comes up.
+	 */
+	if (!battmgr->service_up) {
+		battmgr->usb_icl = pval->intval;
+		battmgr->usb_icl_pending = true;
+		return 0;
+	}
 
-	return ret;
+	battmgr->usb_icl_pending = false;
+
+	return qcom_battmgr_usb_set_icl(battmgr, pval->intval);
 }
 
 static int qcom_battmgr_usb_is_writeable(struct power_supply *psy,
@@ -1742,6 +1761,14 @@ static void qcom_battmgr_enable_worker(struct work_struct *work)
 	ret = qcom_battmgr_request(battmgr, &req, sizeof(req));
 	if (ret)
 		dev_err(battmgr->dev, "failed to request power notifications\n");
+
+	if (battmgr->usb_icl_pending) {
+		battmgr->usb_icl_pending = false;
+		ret = qcom_battmgr_usb_set_icl(battmgr, battmgr->usb_icl);
+		if (ret)
+			dev_warn(battmgr->dev,
+				 "failed to set the USB input current limit: %d\n", ret);
+	}
 }
 
 static void qcom_battmgr_pdr_notify(void *priv, int state)

-- 
2.56.0


