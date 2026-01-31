Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924B12B94;
	Sat, 31 Jan 2026 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769831342; cv=none; b=mNEWcdiuDlFkN3BRYq54avlM7pqPOuAuUNKqemHwQJXpjAsuqyDOHHpLzcUESfLHaz7WC4TwCHVq6+uh/0VsOWRLHQ/RIHUhovUvS1a0r//VAuXuju99yv3SmB1D3PP3AOnJx2QchGAy6+Nz3vRjcO2L8mQ7klDD0e3thqxCQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769831342; c=relaxed/simple;
	bh=4qeRI0/8CXPNVIq8qwuTcyMxP3YlJM0KAF+LDIonx7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TvtNuufv/ilGQxJHcbAEsS9IUsGtdvqpnEahZOOIRHibxvn9niyPHKHtwpoAbTJptKZ2yfpSmGm3+9ZDoO6CcLdPcp0sl7q5l72/92yM+g+zZOVVJ4e5VmUwBt7fuSiWuO4oWB0xZ18r9aFMwTQrfOUUj1m6W/wGEjnpzndyXms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLX6M264; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLX6M264"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED7F1C116D0;
	Sat, 31 Jan 2026 03:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769831342;
	bh=4qeRI0/8CXPNVIq8qwuTcyMxP3YlJM0KAF+LDIonx7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HLX6M264pvYoqSDxaaPAVUCcR4nK0lh9bodjNLg2N46Lg5AC9yTjQey/R9eF31gQm
	 phCCRhmYokSNrsp/dtzaNaTBZDnSeV3KjPCR+lc/0NMjQNs7RfyCY35GRl+oVQBSkV
	 OfSm/iPcfXMlUTONLxca1Z+49EqY9r25//dNI2q2E6EKkLk9EzSumyi8a3NPSZLCN2
	 jzKfb3OVMGaVXlHMnz1LfbOwWo1oRbHFP29qsvXwRqjoS5iYWh/bFq41empAJyBFtD
	 q/D1I+oljgTAcSGEmm2Et/i+R+hBFgsSm8sSxtjI4jMX8Kiz4N0O0Zz5R5UJUJYtBZ
	 Bhs29LcA/c6HA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE13ED73EB9;
	Sat, 31 Jan 2026 03:49:01 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Sat, 31 Jan 2026 14:48:57 +1100
Subject: [PATCH v7 2/2] mfd: macsmc: Wire up Apple SMC power driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260131-b4-macsmc-power-v7-2-0e3a2da69948@gmail.com>
References: <20260131-b4-macsmc-power-v7-0-0e3a2da69948@gmail.com>
In-Reply-To: <20260131-b4-macsmc-power-v7-0-0e3a2da69948@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769831340; l=861;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=l66XKVNJtI8aTWFc0QpUQyQBnqT+6mvF4xxxt3DtiJc=;
 b=VRbZEsFuHG6PoAQ0NYRkJXNz+nGfw6IC9Kb/MSR+DI1O9I0BaJAfS1VJBD0hI4F6PjffTRTEQ
 ZuwAYuvPmoXCYjBOh6SkvKm0w14kjp44wS7bGvue/TLtMU6o5LlgbEb
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


