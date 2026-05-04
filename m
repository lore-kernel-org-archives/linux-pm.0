Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85E3E92BF;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919099; cv=none; b=DTZoa0HknDdSoK9NtXmZU+rpkCJREmeWIx/08Z6w3LaSz4IlBXlvkqmP39uR+FThLCNAaJ3wababHIZB9k7yEKg43Rf/SAYLPdRwlPzvNjsbr8Jt0ACf0ncXkZ0UkcLe4e/Zh0qfOmfChFwMwdDJr7Zl5a9Gu9WkUfs6sDjnJ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919099; c=relaxed/simple;
	bh=wMsaPJTluTOvZFL0m5jH60KdVathnpyRBOWpiXT7BKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJpUMCEMnCmGpTO1sQrMU1KcxfJ8YsHDiJksw5ElLkwS4FC4ARN2sL93CdaNKzY1mDlMioOuF5y/pqE/hQNFaW+anF25whw6ck41axQ7V6Xds1Oir3sRs89YuI0TEKlainclJlsXeMyzhAhcihjAO/sQW4NS97bSFsgcTj5uKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCnLNbmm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCnLNbmm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 204ACC2BCC4;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777919099;
	bh=wMsaPJTluTOvZFL0m5jH60KdVathnpyRBOWpiXT7BKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QCnLNbmmWof8Rok38vimSq3yfhpYRhsZAPXK4G23WrDHwrY68/ebOnrMabSFzDzp3
	 TwwljkP+gXxfWiqepRdkBst5Bz4qom16o58qb+152eoRQtwGOsyWfo3WqALmO8mSvs
	 G9kqgErY5FJmte1VBF3M+ObKj+NyulqOghKx8oSoSDyjpAOigJnQeiz70wPL+OxXVp
	 0hAwZeq7vzl7lXjGyh9haqdAjgG68dMJW0JDgOjirY/fnbnnmOegEXWiwvMprUb7RM
	 5ipOMAIPb0pfYdzJ+GsnVp94xH4NP7Z5/Tnde1wwA2XZ1yHCRb9MBQQGcOlmQWpePC
	 /Q8llwSLUxRQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176F9CD3427;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 04 May 2026 21:25:01 +0300
Subject: [PATCH 09/13] mfd: mt6397-core: add support for mt6323 thermal
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-mt6323-v1-9-799b58b355ff@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777919095; l=903;
 i=rva333@protonmail.com; s=20260325; h=from:subject:message-id;
 bh=1GBl1TpFBcVXYGizGdKi1F7hlRKLPxUy3Qzy4DpQjMM=;
 b=8nyO1z82QxMlj6H0WEVe86aCBbZcH4auRH3dTb7ryxt+R5BbJ1NJpZ0rlhv416KiWWfCYbyhM
 VaAhTEw+tP3ChoTAZAIFSwzFtWpJxazwDOCBgmDQ680MNhJw61JUEO0
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=euuVBZGtA2Cqb8Dju84qpQPhvwxyUirJlXpqEPQWKBM=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260325 with
 auth_id=695
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

The mt6323 PMIC temperature can be measured using AUXADC channel.
Register the thermal in the mt6323 devices array to allow the
corresponding driver to probe using compatible string.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/mfd/mt6397-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 2d9419b80a5c..061ac242f1f8 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -151,6 +151,9 @@ static const struct mfd_cell mt6323_devs[] = {
 		.num_resources = ARRAY_SIZE(mt6323_pwrc_resources),
 		.resources = mt6323_pwrc_resources,
 		.of_compatible = "mediatek,mt6323-pwrc"
+	}, {
+		.name = "mt6323-thermal",
+		.of_compatible = "mediatek,mt6323-thermal",
 	},
 };
 

-- 
2.53.0


