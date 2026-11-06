Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954905;
	b=Tl51UBI0+wiEeILf/yqn3Q01Xjsu41kWjUZdTt08t4vteEg5DzIKsqeuHETYK1bKFsh1
	 SFuO9EnmykU1lfo+dkRYaW/rwj3M6NWVdXQfJfsQLD5SvODqsYZi2aHLiSAKO+MKZwo4o
	 /Tv2L9BOs0YHGwWS+WjX+jFqaFma2sVupsPcchIZquNi0KmM68pIoiJf82eJHa3Jepiq+
	 EuiFLqhrInLhzC3q+e/mB6AglM9sFPYNmUnRxTjgp7qVQ3IiTn7SKyf3UAeYhNDs0FTYg
	 3Ve7MahsuHv9DjWkqhtBJAJBq/I0i/M/Kl8xY3dzheiOK/QU1+HwYwtqw++yf98hB4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954905;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=mQOx6HS8CU3hpibYskJJDo+5DsA8upMR3dJoAyYpTE0=;
	b=QX+NPT478SHWDZOIbwpMOm7muOlVQu+tiOsndrhoYJlKTyfUe+mAmke0IpIazDy3Yz93
	 FoWjkiGYWviVSsN9Sxj5zmcSma2B5mpUZdUQbLpXwPfOTHm8vwiGlkXC3U2zhNayNzkFh
	 n2S8dpNyrjbUTjW8x2JZ/quAlqroOamm5T/HdsbZ5jUyTgvY5Pqa+YKcRtAfq9GOqBnti
	 DJhBcBuGDKpAGFPoVDlc2vFYJUkLgUZxq39GKtzmX1aGCDu+Cm4ebRIfFsR6bL+0wCrJi
	 RL+5MoZzN+D35tjh+qp6vXuc5RJCIaSWPZJbv5PE25kxDspU4/AmdatoHpgTFdQrdyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpA9gJyo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD2606A326
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpA9gJyo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F91B1F0089F;
	Fri,  6 Nov 2026 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793954904;
	bh=mQOx6HS8CU3hpibYskJJDo+5DsA8upMR3dJoAyYpTE0=;
	h=From:Date:Subject:To:Cc;
	b=JpA9gJyoaq2fhn37Ehwes6wNKqHiDeHmO9T+HIUdNqn5Jn9+28wls/1ii3LRLgnrP
	 XnUqG+R9wRkRecC3WDBsa797KxitZqLANFycq+xhlbwUxjlttqCs3NyftjExPGUlSV
	 cN/IfhStJevgDyXsCYLklCRuPDN9TWtsBNU6H33cWBPMnjMtbwkYNmKqa0Tbp4N6ik
	 SwlvLrtL2jTApPEFyKUtRWIImnKPiqBNOEJVCHJq9FHwL7UsOwX2yRwxNOLjd4pty+
	 YYyyJ9nF67rUBJKrjbwjSF4feKnUFxBQ5hdt70xelYm4zP8sismfRvWQQ7M95Ny4BV
	 08j16/vEPe28g==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 06 Nov 2026 09:48:21 +0100
Subject: [PATCH] arm64: defconfig: Enable the TEO cpuidle governor
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-b4-arm64-teo-defconfig-v1-1-5e3763385f89@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQqEMAwAwK+EnA2YUgL2K7KHalPNwVbaZVkQ/
 y44D5gLuzbTjgEubPqzbrVgAB4A1z2WTckSBkA3OmEehRZPsR3i6auVkua1lmwbLSwsMUef3IQ
 D4Nk02/+N5899P8m/QI9oAAAA
X-Change-ID: 20261106-b4-arm64-teo-defconfig-b1616afa4d29
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0

The TEO governor introduced in commit b26bf6ab716f ("cpuidle: New
timer events oriented governor for tickless systems") takes a different
approach to idle-state prediction from menu. The governor gives a
better behaviour than the current default for tickless idle systems,
and for the multi-platform configs that enable tickless idle, this
should be the default governor.

The arm64 defconfig enables NO_HZ_IDLE and ACPI, which enables
CPU_IDLE. Selecting CPU_IDLE_GOV_TEO suppresses Kconfig's automatic
menu selection, making TEO the default governor for this tickless
configuration.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Prepared with OpenAI Codex assistance.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7b4985b29b21..fa99d62cda0f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -93,6 +93,7 @@ CONFIG_RANDOMIZE_BASE=y
 CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
 CONFIG_ENERGY_MODEL=y
+CONFIG_CPU_IDLE_GOV_TEO=y
 CONFIG_ARM_PSCI_CPUIDLE=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT=y

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261106-b4-arm64-teo-defconfig-b1616afa4d29

Best regards,
--  
Linus Walleij <linusw@kernel.org>

