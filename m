Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0E31B100;
	Sun, 25 Jan 2026 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769346857; cv=none; b=EPMS0Sa21oBZhAcfRyFZNdfqq3vQ71ZlKgkCUAor6NPAzGJtlj5C/4Qz5fde74rN6lFR5Xm7McOvS83XJ0KZQeT/QWcrYci9UeO5F5ZvFQSQzfNa6xlpbBgtx3stPpj7/XSiNp9e7a1p9TEuZ0XeB1gGvospNKNwazpPLkN+QoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769346857; c=relaxed/simple;
	bh=4qeRI0/8CXPNVIq8qwuTcyMxP3YlJM0KAF+LDIonx7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=skEXTvoXqNZyZL94NcLGp00kP0eGoBqaIg5aHYHqJyYIoqXhkv0w+aBCaPY8KCTS9vc65HZCrfiB6HAbJvFgkEKSTIGQXkfWtby3l1ChZp1ABlKy9QpsKtzpsjDfuUHBZf1o0mXfTyTgUmIqhB7MBruGVH0NuEz5xLil7A/PJlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phIHFM/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phIHFM/T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2163FC19421;
	Sun, 25 Jan 2026 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769346857;
	bh=4qeRI0/8CXPNVIq8qwuTcyMxP3YlJM0KAF+LDIonx7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=phIHFM/TZycq0bBuebQOAvfWZRLjr5O2Q1pvxCAXag/B2zAAAU3EsuQhJgeLo2pl1
	 sBeH1o2qkvrkzIjDQNJuLxtA6POhycud/EsxUwTG8CQgpoG0Ib0xFkuOTh3MDP5eIl
	 rUWMpFNrOG1+Ulz28NpaY6pCYstTtpKf3aM+qJdIc0U2KSKGzLcIycOhh0U0Zc17/V
	 CY+Oo5Wie/nGea5rVQBvrwtbWcsn37JLkgzYvU6dWy2qN8Af1vtrJp+7OJ3KAIqERG
	 Ue77UDLByHy3sLsf/oSzqTriroYHimayzDEKBKkqVndEO9526Ls+JHkxz6uNcKlvrM
	 mUVlwqzqfO5yA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190F8E63CA6;
	Sun, 25 Jan 2026 13:14:17 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Mon, 26 Jan 2026 00:14:12 +1100
Subject: [PATCH v5 2/2] mfd: macsmc: Wire up Apple SMC power driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-b4-macsmc-power-v5-2-302462673b18@gmail.com>
References: <20260126-b4-macsmc-power-v5-0-302462673b18@gmail.com>
In-Reply-To: <20260126-b4-macsmc-power-v5-0-302462673b18@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769346855; l=861;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=l66XKVNJtI8aTWFc0QpUQyQBnqT+6mvF4xxxt3DtiJc=;
 b=mAiJPj7JoEQiRxVrmZOGA5lsT+1h5EHMSlS24t3OZFIp8C/24RLl14QauMr4mwcMN7baB6bLg
 NGQjmQbOZkgANchr7FeZ26sU/ht/OdWNbq2LnUaVurk9t22TLORn4n7
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


