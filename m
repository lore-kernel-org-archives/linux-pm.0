Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795375229;
	b=3Il9z5HgKji6Vv1yjHkOfULRDNQNP3MCLTZ8B50xFDWBVePmYIT8JWzA1Qx5PALjoEfq
	 8LQckbACrzPHIocKw32a5E/dJmf1ieihQEqMSnIWuoKHl4jD97UITM8ASIq/7s8i4wS4Z
	 VimC4Wc2ASLOTkkHN4iYNXJ7v4nIVDHoFxHoyWVpksQbUXNsQ6MJIf5048ACnTAo78Y7T
	 PgRNYu4SjAYzfdsHAryicrSAkPAJVqnE0VYd9TbrVYgNfbDY9ZB9dZVdWlC+32LQIUeyc
	 4cBMgP/uLV0d4B2e63ZxkiN87WneLWuHr5eZPsn71cX0NiX0ImUm17NOX4nFrD9evEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375229;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kj+VAGoL2xvIZkBxW6WgEhnADQuyPv28PwMBUs/3KdM=;
	b=iX9VnC0J2SI35SkZIUA1VB1gRAWsKhtvRwpn88xxDwO4GVo4/3RKmJCXuYpypEUFu1o2
	 oRRHUTot+z4qZIEwqT6hFSzA6OItND27Ax3ebI5jWRa2Ngu2um/F6I1U1FzKraVRDSj9H
	 8ZEzCgv/kcBSbMFz6Je2EbxzuLtU1QD2pVWho5r0PMGx4oGsOg/8wL1hmGaaQcmg93JYh
	 GmxyQujyHc47qc/4haaiZoIrixgr5XguWvW2CcoGMkjIA7XidIPVTiL9PY0Bmw3cLbFnW
	 vF2AcpjnPQc7iwhLrO0mGo6VXX0ySd0W+LW7NpFCA3TDkSoJISXOvHS218lHCcfyepw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hebLZs2G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278C5606A333;
	Sun, 22 Nov 2026 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hebLZs2G
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795375228;
	b=tLLV4XmCMqEvmQacudwSFq7tiPSPWlrDECVOzJDZoqNjwt5oPZmztCrLyEXHSH/+7R6c
	 W/gAtdDoPTcYT6xhca2FilQNxG3B1a3UQkPfrvrWtH1ZwSb33r4NSj3UjpFVo6K+cO2YZ
	 DU5mqBnaNvROfKe4+AbcvZt2McsDt6uu/a8p2W3GRcPJ0qNFH9GmYEy63c/tmA4qFSCDh
	 qCfHW0YpjA40rhswyi98n/gFQgOShuYv8SJGVpafJTTjQMQVqzojfXx7AFfL0nSxdF85P
	 pzjqIKT9beymHBdZds/JokS8KCLuEy+XnQes2MAjKXvyGs088KBTpRgdtT5kOypnQrQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795375228;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=kj+VAGoL2xvIZkBxW6WgEhnADQuyPv28PwMBUs/3KdM=;
	b=hziJdL751XCUXv6MlFE8orMN9ZoCQ6epVx6NHk8q+sJV930fsaAn8/IRq53J5aXICugT
	 Wv3aWmQNVHEgQOYjcovAIbpX2qiLYPfpQ/up2OfTibvIj1pdcPWKjfYlTs46BHlXwIaPC
	 RVx40drqodHoNYLZxPvsAZcOFjqGWY9D/KnP5vI0MINwfcff23FizxOgbuBTaI4YX7muI
	 IzfsYqDVcYlYfaF9eNEMIbnkYVAbQKiTOKLueemkfn5nlb9tIwBd1D+f6UqA4NzL2eDdj
	 P0xwqsULfr1IUnL8TpXQ4CGvi7p09lDVpppT1e3hu7DnvSMPYPw5cJzwjhmAY8o845A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E41921F000D0;
	Sun, 22 Nov 2026 19:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795375228;
	bh=kj+VAGoL2xvIZkBxW6WgEhnADQuyPv28PwMBUs/3KdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hebLZs2GapuH90LUlqhGGJSzJQBF4w/lGY46G3uDTdzY0S/naLLb0Rc98he2EjdU9
	 10RNNSGljWWiFzaNT6OZSc/dvA2oFk7r1XkHG8mr7IhvDjOxdxWR3y39egwbJBgXlP
	 pCYhDWyc2DTd6spvDHwlW80DBYiS/4OTnRc8i2+RvTi31SZhwrG9814OJr8qJfqKya
	 ZnVH7HndfMRo5DecAbUBYgk8mJnJb3NCcZlcVdAmaUGtKetZNTUhQWQikg3rtZbeTv
	 1DoruB2z2p78Fqn6ox3s7Gg6Y2jNIE8gyB0YFqKnohpzR8SjOEKqWNaPxrxOMSImMg
	 q0ICOCznwvx6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 74FA14C1DD;
	Sun, 22 Nov 2026 19:20:15 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 23 Nov 2026 00:50:16 +0530
Subject: [PATCH v2 2/2] power: supply: qcom_battmgr: Don't limit the input
 current of chargers
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
Message-Id: <20261123-vantage-battmgr-v2-2-03a419078d0a@yahoo.com>
References: <20261123-vantage-battmgr-v2-0-03a419078d0a@yahoo.com>
In-Reply-To: <20261123-vantage-battmgr-v2-0-03a419078d0a@yahoo.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joonhoe Kim <26rote@gmail.com>, 
 phone-devel@vger.kernel.org, Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795375214; l=1411;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=D6CkSLFvs+RdQcscVKpLSyfkBgPa5oeQD51e9q+TG1A=;
 b=HyjNF2dtjBqfc9Ee4iDAPpNooLR6+P9ZUCD6obL1CYuN8Y6xPxkZwKW6MrNvVfT+8Rghzj7Ha
 Vm51iVQ488OCJ5g8bYuDAqpDq5E5+Wpn2sjhfiW3HVOcsXS1wn40Hmw
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Reply-To: venkat.yadlapati@yahoo.com
Content-Transfer-Encoding: 7bit

From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

The input current limit of the USB power supply is meant for the current
a USB host grants, e.g. after enumeration. Like the downstream driver,
only apply it to SDP, CDP and USB PD ports, so that a dedicated charger
is never throttled to what a USB controller reports.

Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
---
 drivers/power/supply/qcom_battmgr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index fde9704d0acd..db117cb64a17 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1152,6 +1152,24 @@ static int qcom_battmgr_usb_set_icl(struct qcom_battmgr *battmgr, u32 icl)
 {
 	int ret;
 
+	ret = qcom_battmgr_usb_sm8350_update(battmgr, POWER_SUPPLY_PROP_USB_TYPE);
+	if (ret)
+		return ret;
+
+	/*
+	 * The limit is meant for the current a USB host grants, e.g. after
+	 * enumeration, like the downstream driver don't let it throttle
+	 * dedicated chargers.
+	 */
+	switch (battmgr->usb.usb_type) {
+	case POWER_SUPPLY_USB_TYPE_SDP:
+	case POWER_SUPPLY_USB_TYPE_CDP:
+	case POWER_SUPPLY_USB_TYPE_PD:
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	mutex_lock(&battmgr->lock);
 	ret = qcom_battmgr_request_property(battmgr, BATTMGR_USB_PROPERTY_SET,
 					    USB_INPUT_CURR_LIMIT, icl);

-- 
2.56.1


