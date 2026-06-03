Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F969325701;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519623; cv=none; b=sMMSQtHyLsgzyO8YE+AVKWNPIQJke3RJUaDm+QbxW2hQrxxXVBi/CFkSaxudTN/MyIWdO9FtrIaOS5LX7r68LTD3PqlI90YT8JQYAAtd/3sxhLAc9fhan/NURbyKX2qgfvJnn6krk4D3fNm+HDxd3GcriSPvH3kzz1D8chGIFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519623; c=relaxed/simple;
	bh=29MCDtinOnbJzWYEVVZoMaJT+rK9yT6ne6Y6YbJz5Ak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nH92pVgaH/BIrUyvRCRFMrIFiisp75Hg2+x4R2E3LUtf/hhTPRXHOXwr7J6Rv0+2bYOOf5+ROzwd50RnGMFzFqvCnWLEk+u8vbQMsyOy3ApsccWhKWp7nbSrygTD57FVfTOW8XvN1ECpTnC2Jda2aRI8WOTb6cxrdyzkTiijOew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470E71F00893;
	Wed,  3 Jun 2026 20:47:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id BDB17180C6E; Wed, 03 Jun 2026 22:46:59 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Hans de Goede <hansg@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Yixun Lan <dlan@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, Sven Peter <sven@kernel.org>, 
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Amit Sunil Dhamne <amitsd@google.com>, Samuel Kayode <samkay014@gmail.com>, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 asahi@lists.linux.dev, imx@lists.linux.dev, Chen-Yu Tsai <wens@kernel.org>
In-Reply-To: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
Subject: Re: (subset) [PATCH v1 0/6] power: Use named initializers for
 platform_device_id arrays
Message-Id: <178051961974.2666348.7125017575893735399.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 22:46:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Fri, 29 May 2026 12:18:15 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> this series targets to use named initializers for platform_device_id
> arrays. In general these are better readable for humans and more robust
> to changes in the respective struct definition.
> 
> This robustness is needed as I want to do
> 
> 	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> 	--- a/include/linux/mod_devicetable.h
> 	+++ b/include/linux/mod_devicetable.h
> 	@@ -610,4 +610,7 @@ struct dmi_system_id {
> 	 struct platform_device_id {
> 		char name[PLATFORM_NAME_SIZE];
> 	-	kernel_ulong_t driver_data;
> 	+	union {
> 	+		kernel_ulong_t driver_data;
> 	+		const void *driver_data_ptr;
> 	+	};
> 	 };
> 
> [...]

Applied, thanks!

[1/6] power: Drop unused assignment of platform_device_id driver data
      commit: 75a0e1e0b86078687c3c6a05107a98c7e59a65a8
[2/6] power: supply: max14577: Drop driver data in of and platform device id arrays
      commit: 37258ad1f3a52ea442c32b3c92ad7146e74050c7
[4/6] power: Use named initializers for platform_device_id arrays
      commit: e28f7498dd819878b8acacb89c4c073a646feea0
[5/6] power: supply: mt6360_charger: Use of match table unconditionally
      commit: eb7ed650e5960fc303130704d1e29d18a7d0e1df
[6/6] power: Unify code style for platform_device_id arrays
      commit: e3f669bed32287ae72c05a4ddab4a6687b0e62ca

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

