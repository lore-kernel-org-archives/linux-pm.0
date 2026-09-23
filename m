Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785E3A4F58;
	Wed, 23 Sep 2026 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162008; cv=none; b=jmFonlyirtzbK9eyHtbRvQmyIJgH0TC5fRc9Pa7/hzvz0MzoMh6rzN8RDI0Ut2aORvtjGSbQx0L9n3HnVnyz46c5yt9IOII+HgzE0bS3yIHUdL613reUY/KKciU9okeSU94VSQAEOUBVXjMIOQSUDOrb1FB98KpVLc4JVBDsEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162008; c=relaxed/simple;
	bh=y4mAh4QRCnmU31ygKAPUR/tNyPpFdvNtOoRLdlbia/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Olu1MQljZpTkS7dDAWQdZCcl4OVFOI5wQDFXIfBsRt89Ehe6BsHDwK+7tMqhLsRT3AJDVDa7xfiMoI4lFCrslu44ptPV8qV7lRqN0Bh2ilG0kNfn9zMYox0vsF42pGgIs1c2Fc2PXYrvcVE0r04AgoKG2r7n7UKfoc1PApF2mJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f255DHjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f255DHjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E821F000FF;
	Wed, 23 Sep 2026 11:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790162006;
	bh=6OWssQdGeKsyE+yPPzL9NID088rXE6n1NT7d9aLNuLU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f255DHjPL7qcmuNQwMipvzvnDX+7hQ2EPoy15lFc3RlpueYEfKHfvnoUqEYqM1sNb
	 NWBIafoReygqiJurrwkepfMrWtm4dmdciZcGPHZj/UXcGVhT/gUEj9o7ycAyOsvv1H
	 VqqSVjZjXHtHcvciU24arw2rlEWeASuZ4V6Pee7xW62cur2hfF2P1a2knuHbqR+q42
	 gMBblt0TMmXcHqNunum5Arm0/pdXZWQDgCJyQiuCPlGnyePwTCIA4Udngv9vfkhOae
	 NuuKuLY3Qe+HkhbVscCeNe2wrBS53RY93ZrUlKLi0/K3QG2Yu63tslB35MvSjcWKk7
	 qFkKtFqTPodkg==
From: Lee Jones <lee@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 mfd@lists.linux.dev
In-Reply-To: <20260917-add-mcu-fan-khadas-vim4-v12-0-497cd543a148@aliel.fr>
References: <20260917-add-mcu-fan-khadas-vim4-v12-0-497cd543a148@aliel.fr>
Subject: Re: (subset) [PATCH v12 0/6] Add VIM4 MCU/FAN support
Message-Id: <179016200216.3991538.9729498500468458301.b4-ty@b4>
Date: Wed, 23 Sep 2026 12:13:22 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 17 Sep 2026 09:58:59 +0200, Ronald Claveau wrote:
> The Khadas VIM4 board features a different MCU variant compared to
> previous VIM boards.
> While it shares the same I2C-based communication model,
> it differs in some ways:
> 
>   - A distinct register map with its own volatile/writeable register set
>   - A fan control with 0–100 levels instead of the 0–3 levels previously
>   - A fan power supply gated through a regulator
> 
> [...]

Applied, thanks!

[1/6] mfd: khadas-mcu: Add per-variant configuration infrastructure and VIM4 support
      commit: 6277c3cd74f54c26bf4d5e88182a378ee7190d90
[2/6] mfd: khadas-mcu: Use MFD_CELL_* macros for cell declarations
      commit: f9f61c21b942ac387acd7fb3ef1f950cba59755f
[3/6] mfd: khadas-mcu: Add support for VIM4 MCU variant
      commit: c94c97f8c97e684d44ef5483d7f2ad6b3dfa55ac
[4/6] thermal: khadas-mcu-fan: Add fan config from platform data Add regulator support
      commit: dad6f7897a93b4e1614664dbbcae0f61e57d1ac0

--
Lee Jones [李琼斯]

