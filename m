Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF3F3E8C78;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919099; cv=none; b=KkqlOzYzkW+ahEghFwwtaNlhiufYb9LQD8OoELA0g9BqS/34wIF727ZE+BfTq2XsdqeGlzuIGwdQe6CO3wfddKwku/+c/FfnmC6vmRw1RgGUN+4tvxoZLviNGitQoyRRjJRsoqGuXQHG1uL3x1JLjSJVjsTK6QkxMr7WYVDMIMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919099; c=relaxed/simple;
	bh=WDFhxjJb9z+ifSIY6a5Dfa4xTAgGcmZYrk7QDVq6rdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hjp4iHCS94/NbjZm8kTt+j1L5VPx586jKIT13JclY8FzIMKRJiNP0Zi4y8EKWBvzfxzayMv7+ode/yJq5E1D/bHZPnDtNgci1l1k9V7fxGRNPjFtnFC793vP9KKRZC7mo8T3nvs6jlnls3OQMKqsZaBnry7B3i6WOfQYn1It2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ1yVBTX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ1yVBTX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10564C2BCF5;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777919099;
	bh=WDFhxjJb9z+ifSIY6a5Dfa4xTAgGcmZYrk7QDVq6rdw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iQ1yVBTXJiCZTxeXqFTfDys3JxsA1Pw59lZyiDiS5yQ71zemGW+Nk3GyMsfc8EOwu
	 gfz9rZnZvJRb2BjwkkE9VQ9ebmxLkYgD/FLxqqpMYXChOQUqgcyZ9EnO5JvK2t+f8E
	 dBtHg4/IbOEC8zWgvHXwfFf6mcnKbJhEFSoWkkYLTSqRePYSI8PTsui9PowoLX4JXk
	 rbKEhmDTlUpZ58itFdV8uW8Td5pbXCiSCDu1DOmyH9Kyp7jhgxQJpOh/smehWmw2Hw
	 TiKnXjfnbqgUHK3X75NTVpYbADsQZAwMrAFfK9oG6Yc1A3+Ug0v3v1xrsSFvSdq/31
	 llLaiNjmTPSZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D67CD3430;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 04 May 2026 21:25:00 +0300
Subject: [PATCH 08/13] mfd: mt6397-core: add support for mt6323 efuse
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-mt6323-v1-8-799b58b355ff@protonmail.com>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
In-Reply-To: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777919095; l=882;
 i=rva333@protonmail.com; s=20260325; h=from:subject:message-id;
 bh=KHZcH06TkyVO2TQwIZCbwT+DwvWV7qLrxAW86+Uky0E=;
 b=aHVrflr5+/NWv4HshdZg/E1DtkavRTPohIu568wUne7D2WRSQLE/Wpo2rHBief8PxE2fLxMSf
 3r0EjqDGRw4AmxaZ/tU/z4ItF2gRc7OdTVaeoeyRS5blCnvcu5unomK
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=euuVBZGtA2Cqb8Dju84qpQPhvwxyUirJlXpqEPQWKBM=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260325 with
 auth_id=695
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

The mt6323 PMIC includes an EFUSE. Register the EFUSE in the mt6323
devices array to allow the corresponding driver to probe using compatible
string.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/mfd/mt6397-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 013b0857fb54..2d9419b80a5c 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -127,6 +127,9 @@ static const struct mfd_cell mt6323_devs[] = {
 	{
 		.name = "mt6323-auxadc",
 		.of_compatible = "mediatek,mt6323-auxadc",
+	}, {
+		.name = "mt6323-efuse",
+		.of_compatible = "mediatek,mt6323-efuse",
 	}, {
 		.name = "mt6323-rtc",
 		.num_resources = ARRAY_SIZE(mt6323_rtc_resources),

-- 
2.53.0


