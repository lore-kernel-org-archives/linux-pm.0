Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF775286A8;
	Tue, 17 Feb 2026 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325264; cv=none; b=CyPxIyrOcy/uCoNcw23prL0kFOBOD/GGoOkE0xk7q6PrCEPu6jbcItRxRR2lVG0O5lG1PJ3nnRszxQgg2IBb0KIm0KHJjgAlbvNthh0LmUg1x3WbYGK3w6K/Pb0wzYPaNHw78OpOH9IkePazfgBcm6WdXpTayO7AdDionot0xMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325264; c=relaxed/simple;
	bh=4qeRI0/8CXPNVIq8qwuTcyMxP3YlJM0KAF+LDIonx7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYawKHkVew61lPk9euA/5BgThH+SciZpi1oHwT1Dt58mBrELxt6e+cAV+lWE1rEZ/s1kpSbOfpjU6OBRz8pgsudWkWsiG0xD/4Wz5bhrdQg+iG64lQ46dPW+s6OVXIUIbVEnUVxAdEhm60ZNV0iJoFAScF5oW9nTmSzed7zCzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azF1KACw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azF1KACw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1784C2BC9E;
	Tue, 17 Feb 2026 10:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771325264;
	bh=4qeRI0/8CXPNVIq8qwuTcyMxP3YlJM0KAF+LDIonx7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=azF1KACwtA56/EPO+o9Fn0yLOtN7cln10uB86vzzldGGf+d8uvrskAPnzZ4K2iKGn
	 SH4BwhIwvt6gI1QVBcbFpOD5VMNjzCTm3Eb1qPgvCgHl2cEow9JD3rZtvEqVdBrfGO
	 tvCVjNNyr7GoacXbxby45CdP7GuD+MV5hv2jQzNY1t8bp/xCmyol7/VnECfBLshHZ3
	 Us3wdaCpMjVDHeZCDvCgvyRVoeeNcjPauEK4+SrJJhFBZGyoEiXhwTuttPRrhBdLBg
	 cIfvCOAWNB8gQKfRFMjHu1iuxcqc45n/wSQGcwD5oJ4TzJ9Nw57F792hPFV9/K/wEj
	 XXsT4N9xjgAJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F93E68169;
	Tue, 17 Feb 2026 10:47:44 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Tue, 17 Feb 2026 21:47:26 +1100
Subject: [PATCH RESEND v7 2/2] mfd: macsmc: Wire up Apple SMC power driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-b4-macsmc-power-v7-2-4a4d63664362@gmail.com>
References: <20260217-b4-macsmc-power-v7-0-4a4d63664362@gmail.com>
In-Reply-To: <20260217-b4-macsmc-power-v7-0-4a4d63664362@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771325263; l=861;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=l66XKVNJtI8aTWFc0QpUQyQBnqT+6mvF4xxxt3DtiJc=;
 b=O5DrsNZjj7AQHtiSyJhrCEipvmsjzpNLsu8tVVjtdN0gZqcGXsIQ+E/FabemxZW9l1pwcKda1
 GlfokenYGuoAxm9VnDWwJ8v42ILtiTV5JN8xOscvmfW5Abt/jLOaVvM
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


