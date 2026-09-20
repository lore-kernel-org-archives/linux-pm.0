Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367473947B5;
	Sun, 20 Sep 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925995; cv=none; b=jIEJ3A81OCJ2dUxNGu41Pigsl7LBNxi/rSoP2gFaMIU+c+LmB3Q6Ii7gQK+NgeARlK8HE3SaAjacVYDp/xmuAQBv97r5JiEMlwSo5XwYmZcry4+qAqHWozduQGmG72gN5TQx01yCzPe57AErGt/3DT/GOn8RHxiqySCuc8Wc6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925995; c=relaxed/simple;
	bh=JxZ9Fc4W/9nQ/N53HRq7Av02MrAuO1PFAQ6ON++hSnA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=D7DefQNQ7rvZxvHH06g3HivekIyRWBcc/+1Lx2T4Zk/CWHENBYUFFDuUHUxZrILVaGWPQijKJbW1MuoFUP/oDMb9hxE/4Yx7Q2wJdg4tSwFBd1e61rodNFBcIHMHVCzEBn9tuYRoOeASknJ1b303c3RJ4bLe5lipduev2RcnrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Utx/GqFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Utx/GqFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F1E1F000FF;
	Sun, 20 Sep 2026 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789925993;
	bh=0vFaqoRKYH1KRQEdWXLRYoZO04CVbzG/HlC8E7fvrGw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Utx/GqFMENqGOsm1Tt/9O+Mupz6zhJtcNcBWdFhQ3PgUdHlEThLdVIWrS6V9Ck0py
	 YhUXkTfk/WjAnEEpnTPczJUlRcp6G1BAzRlKAohOBdOYBTZb3l9JI6c0muWhy0ercl
	 S2wSmmH3wGTwyNODxjMi180fkv9s+gLFGKNGYfVdK+g2cFpStzH9IULVh1I2+6SNC1
	 TFduAhvm2u7e10yuktKBW29k0k6DrlGUmJuAKrTcQQ6Kgs9lyCsrEveYlS4RKlrNYd
	 QthVuv8efsG65KgM1PWiIsTYlS0MDbm0RipBPMhvZQ59rozWcWqFvxDNj18PGb1cTg
	 e8UoJ7sIj6kBw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: r9a08g045-tsu: Document
 RZ/G3L TSU
From: Jonathan Cameron <jic23@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 Chris Paterson <Chris.Paterson2@renesas.com>, 
 Biju Das <biju.das@bp.renesas.com>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260918150730.122056-3-biju.das.jz@bp.renesas.com>
References: <20260918150730.122056-1-biju.das.jz@bp.renesas.com>
 <20260918150730.122056-3-biju.das.jz@bp.renesas.com>
Date: Sun, 20 Sep 2026 18:39:26 +0100
Message-Id: <178992596601.706584.2518586011771041497.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=649;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=JxZ9Fc4W/9nQ/N53HRq7Av02MrAuO1PFAQ6ON++hSnA=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsBpQOOIXXOjY4ZM6Uhe8GP5s0Ei++Tp2YV9qq
 1Ynti/D3gyJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarAaUBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiPSmEACGZeqkw0jTFS/3LDDEJA/BazZA09NcKytrEKw1kUo889S
 V0ardav+Uu6+G6PcLlE3T0G1Y4Gfw1jEPV3MsAD6+ebTKTtXJl1INiEDQA+SW7K0pb8rZ4aEPJm
 ry11A85j2J7s4umJ60cAKFrhaxF+dYe/ugkMC7EihurIRWJwK+QiUYmKdaQqYpg2KOhv+T5/7jU
 MC35HA3VvToq+pMkNRfSlYVfF8ydhlWe+Jr91uT82BZQOGTChwjZIT3fYkkIeU5zrLP54jC3H5m
 +cZ9L85ClkGc5jFScYfUoTjjxzP9KBTts/YaLgjK83oVwMHn1SBRTOhQezgTosQsKimRuIT5xo4
 jn78qpJ5HL+cDHcih/mUd07P8viHuhZA4JtFgWxwvZBhCiinMCNbR5VVDa6Hg1Xzvi+6tZeBriK
 O7lDTEga9Fg+++/DPvx+0Hi0/IEaTQ1/AU2/hWk+cOYUDGGIMxorb7Hx6rdyWbHzPc0tb7ncYoD
 150ZcSngDFLV4KejS7kvZXCRvA1y096+3JU2WZeoxKs3/CI+TmX33cGrVnvNJbYznZ/p+nR+gMB
 QEH551VmptyKP9BmeMhV8r5j1nCEpP3mO0xG50zsG4OsSXVhl2CJ3PToWflfZNLIzVBdNK5mOga
 hI+Sj/xD+uJkV2oQCygTPN9WLr7ZNz8cBYLGgSw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Move the default (software) calibration values SW_CALIB0_VAL and
> SW_CALIB1_VAL, used when FUSE values are missing, into a new
> struct rzg3s_thermal_info retrieved via of_device_get_match_data().
> 
> This allows different SoCs sharing this driver to provide their own
> default calibration constants, which is needed as RZ/G3L uses
> different values than RZ/G3S.
> 
> No functional change intended for RZ/G3S.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
FWIW simple change and looks fine.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
