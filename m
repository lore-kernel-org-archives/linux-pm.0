Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C834482EB;
	Sun, 25 Jan 2026 23:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769383019; cv=none; b=Sax9oKXhx0pgpJ9qhcAa794JegRKDzHOISvGRMX7kEooEGsBo7INe1CVfN92r5sLT3r3KTGKLejLjH7XtwqUJtVqZ1NU/v+QfbtdhNNvWVJEaK+rW/jJki6bbUuSir7C1UkMa1YPur9k7h2+oZSBhMyT4lCIIuj95R67ckpJMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769383019; c=relaxed/simple;
	bh=4qeRI0/8CXPNVIq8qwuTcyMxP3YlJM0KAF+LDIonx7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HbLEuI/fHLMuQdvBFk8GO8xS9E/ye72qixVq5nYjUYCzUKEleRYjtvnz3AypLrK0o+KuUybcN903I6PQpTegdyH9RuMoRPOCusQT0f62+97M15Hnzdk9GwEtn7ExSycdjchJTl1DqvjTH26EKzahOEVKIli29dYJ5t61ujFJyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqIdgHmj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqIdgHmj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E67D9C2BC86;
	Sun, 25 Jan 2026 23:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769383019;
	bh=4qeRI0/8CXPNVIq8qwuTcyMxP3YlJM0KAF+LDIonx7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gqIdgHmjdBFkgtT5D2Djd/W2fkSewxlSD3/dnNhgvuyg8AdEFjoYC6qr8gEJyN7Xk
	 g1LzupgczcTS7p35mjBhPktGyRvxVBZOkj0KYwNuUsdd6JUPlsUEHVc9ZC6Aqbx+ZR
	 Bp8MXsx6D2SrDTNQavq7swTHyP0/Tg5wKyOa4QkH2Zc96puvgcEFxHoafKQNoP896k
	 hSsTeN7ASvbAvf9wjsuZS1GkpGM4eMPGA7nGR3iNNFKMMsfUfZJuesBuPz08FAY/sR
	 JYOoBXlt7p6g5YflApL3mEsTxvPde4lOr9IpC5kvFIyEtHfDRl48rk03+6iTzjlVTV
	 +UWMS9lDHiCIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE03DD7237C;
	Sun, 25 Jan 2026 23:16:58 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Mon, 26 Jan 2026 10:16:57 +1100
Subject: [PATCH v6 2/2] mfd: macsmc: Wire up Apple SMC power driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-b4-macsmc-power-v6-2-9861d4070f92@gmail.com>
References: <20260126-b4-macsmc-power-v6-0-9861d4070f92@gmail.com>
In-Reply-To: <20260126-b4-macsmc-power-v6-0-9861d4070f92@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769383017; l=861;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=l66XKVNJtI8aTWFc0QpUQyQBnqT+6mvF4xxxt3DtiJc=;
 b=uoSznPSEabJ5NZFxdWcbenM4QaBiXh3TI2kzBru0/M+Wn6q0ZRaOdIO3890UXGmEGQ9/PFuwT
 WaqNCDqEPUwD+q9/lwiRGfIa2lX/B6l9xIxzEkvKsie9OzFnrGTFCGU
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


