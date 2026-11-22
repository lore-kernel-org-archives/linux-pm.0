Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795375229;
	b=sdO5by8gryloMZk00fD1D+6PE0Y/l7AwsaF50yJTK4JYwrXb0agM/LCa4jhxpicBmhB0
	 VSwyEbCchuscvXgOVsO/9T8Rd0mNmaBUg//LvHBL29UO/yJn3iEAff5DBgKrZmvGMlaBK
	 z3ZTet6ohyZfWffK0cdn5n/Fge/cpBLn82sj/X1mQtFdjzoo8sLDn/fC9kvLLqmT+oF0r
	 o56iFKJw17CTCiyUtTvFFeI+7CbOrD2HHOfx6jU1r1xg9u+44WgBJI1Z2UfUuBKcSA91y
	 9xSSapkuOF7RfGcMZ1vPRRi8zE2H8SRndNevFAk8trL9wdytXhYIgK9kE9KT6DUonMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375229;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DCcUMNQ22RzezUL1nxZOUlYRInjrH4T/ciWlHj+toKc=;
	b=B2r2KRdHqkuSxSK0fikQJWvwNoJV8tgVmrompZ0odHuKTKdfddIDoRPuVg+YEwsBwYV/
	 6pzZzDNRb4Thsuuiq7/uVZDCOahc8s3OsmFgOS5r+LivNyS75yup1UN2FYB0+7GrDb1rr
	 EaS0N7QzN052SDZhcquJ6PKOMtTmJvkl36b61Max0FGTgkRL4Ia5lfypFozz/Yi5WSSnb
	 sCOqcTP4dtJSd5BHa8p3tH/3OvyXeGnJn8Gg/2tha7nT0OVP7Oxaq8a2cscYJ+IYHIZFE
	 uV7215GNXBwErJZZgts68+tdnUk8VOjwVkwitijN8cRk6ybNIo7I++3GB2djae5bqCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRsXAMAQ;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278E3606A335;
	Sun, 22 Nov 2026 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRsXAMAQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795375228;
	b=g3ZZ0ADlTLs95GpE8skOMtrrhzbdyU2QJgfvuoGkNOp9/+ZKX/CTns6H+Z0Ai0cJ/eLg
	 hCU5e2oinBteN2Mc4HjPFfhhJ9wfus0W4rCpKff97H10BK59Z886Wp0pjpz5l5zr5Dz7A
	 TFkwmth9SkMaxMVPrIyHosq5dPBTk/TqpBvXgYkeL5jBRplSp/O6P0Hia9F6t6F9vCg87
	 0bZtu0SxJUL2s2yrXZMLiIXvmNWbSKswLZK2A/LorrAdxYaCt7VqwDjTy4Mcps94Mn54a
	 60z3PlDyQ7d1KyQaokyonoXJuoXejsQAN66/nQ8gDyWrwaYTghI6h4sSKx7ZyLXmaBA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795375228;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DCcUMNQ22RzezUL1nxZOUlYRInjrH4T/ciWlHj+toKc=;
	b=yxNEvRyW32XNK80sEvrAqea5bhuCFKgeJ8CZ9Yg0dUpw0dVnijFbGgnbR0vql4P4sz1J
	 +AaB0qdY3EZqsOuz5D/Vas8doHPtsIDrS24IqVMkzCZvLCdEDCNvLP5mKdFA+p1K4WPL4
	 Vl1eughjhtQQCXF++yQEruNQPwyQc/vrWMMGum4S4j7QEeKoyWJKQbxE8Qf2UzbpuNGPN
	 Tt2XLLaGxw0A0F2TVncTLAlo5zG2D2FMagrhllm8Bdv83AMJ436dWmx9mC0R0FqgFW0Xo
	 cajXhX08lZbD1b7hp8g4lnFv9bBnwkgjMyR8TvIFTkLqzkli7Uk5EPaOZQ5DB7UePJQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CC3F31F000CF;
	Sun, 22 Nov 2026 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795375228;
	bh=DCcUMNQ22RzezUL1nxZOUlYRInjrH4T/ciWlHj+toKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KRsXAMAQWPNEXuq4jOBIhBH8kKs6ufFdTYlGZ8/3Is8VGqF1nl9UubM4wxKraR1i0
	 cn8098deu8sywM02mah3Mn7g+a/Mm94fXYgX9TV7VzslPJUoTgncz/bgegsItGgPKJ
	 63FmlB25pkfKrTR1P3iG5ECYdvevEMgdxxoUe4Hz24dqK6qM5J1ZEbniXkpcuMqckO
	 iGtaQXfN4PiCG+xwft8TTnVX7bvh+hkzRCudkbBpQiMNolfjdtVyIQirs6Syzob6Pn
	 UMP/uP9DyHhcZumR5WWuCQ+FHuC4XJXN1b6kufxmOGvgQ2wqcPg1D3YhX0QDZdt3n5
	 mD5rAGZ9CpusA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5C31D4C1D9;
	Sun, 22 Nov 2026 19:20:15 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 23 Nov 2026 00:50:15 +0530
Subject: [PATCH v2 1/2] power: supply: qcom_battmgr: Apply a USB input
 current limit set early
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
Message-Id: <20261123-vantage-battmgr-v2-1-03a419078d0a@yahoo.com>
References: <20261123-vantage-battmgr-v2-0-03a419078d0a@yahoo.com>
In-Reply-To: <20261123-vantage-battmgr-v2-0-03a419078d0a@yahoo.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joonhoe Kim <26rote@gmail.com>, 
 phone-devel@vger.kernel.org, Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795375214; l=3188;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=QRPbpgdZl24zY0fmfpUSTMdKKg7OmwkB9BBBvw6YdvI=;
 b=VDeQLu0wy3u3s42wJ7fJa3Pj37p5X9E1hoNLrrvZYhLt0Wz3ATphqRBFDYARjA+2RuSq8h7Om
 WKxQ5/d/IzBCpt0I0KTB2Th7jpEwHMcmWxDxeXX2yn2YeiXy9tDJxKY
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
2.56.1


