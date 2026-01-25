Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53841255F5E;
	Sun, 25 Jan 2026 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769346335; cv=none; b=dMjz88H0McaeDV5hByT7fe7+uxuEtUn2kXi1Y90TEqH0MuKqALHIQwsJDYfv7jpDfpE/41jWNQEmHSMfzTOqnQwzDCT2zaI1vziYpS2+rwA8amwMy+wOzpTwA4CnPlTrespiHLKHMKalKqNwwFP2S9+05rxbX+vP2JFJKwyMjss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769346335; c=relaxed/simple;
	bh=4qeRI0/8CXPNVIq8qwuTcyMxP3YlJM0KAF+LDIonx7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgKbfTADG+836TVJW/QX+AW30yhzqROPT87DTWggWbaAe/CQMVoJRvrZ4Ul6fHySYROKM6CYvB0/0YEKfXAahD0qBTGqNBo2DIY/8a8y+b4ZstC6ibDf8LILnNJAJiaR6URhGQZ6yUdl8GyS4X1ow5RL3r8h4unSMm076LkP7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiSfkLT+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiSfkLT+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BEA7C2BC86;
	Sun, 25 Jan 2026 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769346335;
	bh=4qeRI0/8CXPNVIq8qwuTcyMxP3YlJM0KAF+LDIonx7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OiSfkLT+6+odI5VsqJnqLdpxo2/67htY0AO5RcpeYD0a67FEnD1GjCVZoIc9DpxQn
	 X9UkI/QvxV+mcnZYmDEeciFlYJ+sNDuSzhHzQCosSSoXIwj/mbMTlU6ibhqUweoWVP
	 I3GoHOp3CjyFsDcDcLpXO0UYFayJyLljnPZyHIbP0sHZCGh37uuB5Ex7s98OICiEU3
	 Tqt43B0w5XBlfYHLmO6mICQLr3ge2OvEuwWtd7qLiryJLcgBVRVSSMryr04nXjnoK6
	 wfZ18etaENLfV95f9gSX+lgXV3DtcRrCov0/ekkpSMeK4IGgxuH0wwdLY7cKrrQTny
	 OW3kRjif60COQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044ADE63CA6;
	Sun, 25 Jan 2026 13:05:35 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Mon, 26 Jan 2026 00:05:21 +1100
Subject: [PATCH v4 2/2] mfd: macsmc: Wire up Apple SMC power driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-b4-macsmc-power-v4-2-aa2a682ca650@gmail.com>
References: <20260126-b4-macsmc-power-v4-0-aa2a682ca650@gmail.com>
In-Reply-To: <20260126-b4-macsmc-power-v4-0-aa2a682ca650@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769346333; l=861;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=l66XKVNJtI8aTWFc0QpUQyQBnqT+6mvF4xxxt3DtiJc=;
 b=hiejlI53JVcrXBxGu4B0I6yvPiqxWmipjmSnMXBPkeuF8w8OefJznHb7M6GGIWZNP+aQQBOSy
 aYoUSsJW7L6Af45Ms6SoNa94s4fc4VEm4/11fwDIl4W8evFJiMccFM3
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=QIrgWBGCm3LG0YYc6MLCDkwuVXLTGGooVBdWX/KhSiU=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20260105
 with auth_id=591
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Hector Martin <marcan@marcan.st>

Add the cell for the macsmc-power driver so it is probed by the
MFD core.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 drivers/mfd/macsmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index 1b7e7b3e785f..358feec2d088 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -46,6 +46,7 @@
 
 static const struct mfd_cell apple_smc_devs[] = {
 	MFD_CELL_NAME("macsmc-input"),
+	MFD_CELL_NAME("macsmc-power"),
 	MFD_CELL_OF("macsmc-gpio", NULL, NULL, 0, 0, "apple,smc-gpio"),
 	MFD_CELL_OF("macsmc-hwmon", NULL, NULL, 0, 0, "apple,smc-hwmon"),
 	MFD_CELL_OF("macsmc-reboot", NULL, NULL, 0, 0, "apple,smc-reboot"),

-- 
2.51.2


