Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831A490BF3;
	Wed, 12 Aug 2026 22:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573436; cv=none; b=rl/JQrIk6qkFNE78jrFL3S/p8G8qnvHp8KZh2ZkqHg++bD2WLO63MN1dlj42Kr9EktGKfxJVHU3gAZgzUzqnO1B5NgvYP4G9Y2cMYKiVZkPxw/gls1Y8G8QkUH/2cHo1Ty4La/YnDXTBegHzdq5A7nWjuC8amfu8U9pbXc2j1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573436; c=relaxed/simple;
	bh=H0iO3BbTmsaEUVQqmclqhJy6reajrRzBv2PelkDRQO4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jQPnWam3vXyn02MW6c+y9e7ZOim7zaIqRSPLd7fbI03Rl52KF1tLI8ad2n5HZGx8S0z2gyz/8mo9kbpcEAzEKtqsET7q1ZJ2qDP21NLWMg0sH58bEXUgjnff/dhMrhJoqeO4wN25dP6hjYnQxXj3V5VYrKOjjz8ecwbaWI16IsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7B21F000E9;
	Wed, 12 Aug 2026 22:23:54 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id B025B1830B6; Thu, 13 Aug 2026 00:23:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 "Andrew F. Davis" <afd@ti.com>, Chris Lapa <chris@lapa.com.au>, 
 Dan Murphy <dmurphy@ti.com>, Henrik Grimler <henrik.grimler@axis.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
References: <20260811-bq27z746-v1-0-3a4fa38205cc@axis.com>
Subject: Re: (subset) [PATCH 0/5] power: supply: bq27xxx: add bq27z746, and
 fix some regs
Message-Id: <178657343070.347615.1954029174145037148.b4-ty@b4>
Date: Thu, 13 Aug 2026 00:23:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 11 Aug 2026 13:47:42 +0200, Henrik Grimler wrote:
> bq27z746 is similar to bq27z561 but with additional protection
> functionality. The standard register set is identical, but the
> extended registers accessed through AltManufacturerAccess has
> differences.
> 
> While working with bq27z746 I looked at some of the technical
> reference manuals for the other bq27xxx devices, and noticed some
> discrepancies with the driver. Fix these issues while we are at it.
> 
> [...]

Applied, thanks!

[3/5] power: supply: bq27xxx: bq27520g4: fix REG_TTES address
      commit: c774a623c821a173c950e1297f8e8c85a89455be
[4/5] power: supply: bq27xxx: bq28z610: fix invalid AverageEnergy address
      commit: e9387e9ab5121f330d313afb90430c02200f9782
[5/5] power: supply: bq27xxx: bq27z561: fix invalid AverageEnergy address
      (no commit info)

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

