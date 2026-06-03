Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A537756A;
	Wed,  3 Jun 2026 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780521296; cv=none; b=cQPeYMFzapH0Gi0Ljz0uexAvWBFbNnUYUW1uky7LA+B9RXmW/UYmhZTbQtlbaq4OSK9Ce7aFC5pOLnQqZKLcu2osdic+1Tk357Ata2VDM6PfAK6XGX8PxeJGv8mGWt850AN11JxwaTDM5HkWjhOQSNqbE79Qq0PAM9ehNliE0yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780521296; c=relaxed/simple;
	bh=GVv8ZcL6jjeFA5vSkuK/ObD6DfV1EI4ydCaj7ltfEPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EepqS0IB10KHbDb+ivf0GgovwFCyVkf3tHCtsUlnKYPoubQieKBNrX/RpnltghkArmxYgoduDsAlGkV95x3xfgSRbOKN09MdmBSMSgVd7epEW/Bsx/5VmtDUBi1T6jm8FYtoyopUZQfc8rERVatO7JmJmYNmhP8laZpXad5lDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393A01F00898;
	Wed,  3 Jun 2026 21:14:55 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3258B18261A; Wed, 03 Jun 2026 23:14:53 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Tobias Schrammm <t.schramm@manjaro.org>, Iskren Chernev <me@iskren.info>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Matheus Castello <matheus@castello.eng.br>, 
 Hans de Goede <hansg@kernel.org>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, 
 Bhavin Sharma <bhavin.sharma@siliconsignals.io>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260515101629.4132270-2-u.kleine-koenig@baylibre.com>
References: <20260515101629.4132270-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] power: supply: Use named initializers for arrays of
 i2c_device_data
Message-Id: <178052129318.2671410.4352175234865902954.b4-ty@collabora.com>
Date: Wed, 03 Jun 2026 23:14:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Fri, 15 May 2026 12:16:28 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
> 
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
> 
> [...]

Applied, thanks!

[1/1] power: supply: Use named initializers for arrays of i2c_device_data
      commit: 347fcfcc0758cc7523f440f47594f9a5037c50c0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

