Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C058392C48;
	Fri, 24 Jul 2026 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877014; cv=none; b=SFiCHArJuQvDJpv72a10qGPKFncCFy4WjACrImdP4Ikx5BOxUpZO+A26drUAEEm1myEcrK8ika2tKmcxM2CGrVaS1fwt/yPS1fvSNxL3FQMPEzQWAhVMEBv3NjuBZeO6HOCfC6etegOFtJql+D2TXa2T+Qp84m3yU294JkIHjzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877014; c=relaxed/simple;
	bh=wdhaeJqfbS7XTi7Yh7qXJU0hfpdJW1G4IDZCyJB+Plw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxDsU3q0i7nEOOsvza4JZPYrUf8Lcj9eeI4BSrlPQICt7WjrlPd2BL0/iGdVafuDOdg5eGjk5vUUhqckzHrZEEgetxdrc7wHToVAEoI4Zwy/ARdQAIlREXsg8TGX4bKr8PLe4YzGL92xMLyh9mbs6l3EAW5A0wsM8GIcrUbl/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiAGAq/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiAGAq/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048DA1F00A3A;
	Fri, 24 Jul 2026 07:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784877013;
	bh=wdhaeJqfbS7XTi7Yh7qXJU0hfpdJW1G4IDZCyJB+Plw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SiAGAq/VS8R1Vjv74wc9t91LlHRev9LO02zppziwhtPzWTTRlIIOlZ1Tb0ODKwVB6
	 hwaMY+dJUXVDE77UEr5Ao0LpKCQqaNh/R3svqCD1f7FiprBmlYgjjtkfgBjf3HVu8V
	 oAmXATGOORyantt0coXMrbSX4qu+v2dHSe1kLGBMsBHR2WZ8M+fiSuJbuYgkU+/Gxc
	 Q4z6Pff6M6Ip2g+jpd/PXZPp2EQhZ/ek8STpnFY4pxITjtyDxUilL1ghJII3ggbrms
	 Og1w0OPHhlbBycFQx83N6CxMXNNfcCX0Dg7x1Fvmn2uAsxaZSqOfkgFEevA1LBqxqu
	 kTj3OILRSbYmA==
Date: Fri, 24 Jul 2026 09:10:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?U8O2cmVu?= Hantel <fugininsane@gmail.com>
Cc: linux-pm@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>, 
	Yangtao Li <tiny.windzz@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Rossak <embed3d@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	FuginInsanE <FuginInsanE@googlemail.com>
Subject: Re: [PATCH v2 0/3] thermal/drivers/sun8i: Add support for the
 Allwinner A80 thermal sensor
Message-ID: <20260724-rigorous-ambitious-dachshund-dfaddc@quoll>
References: <20260722203341.2917852-1-fugininsane@googlemail.com>
 <20260722210046.2932498-1-fugininsane@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260722210046.2932498-1-fugininsane@googlemail.com>

On Wed, Jul 22, 2026 at 11:00:43PM +0200, S=C3=B6ren Hantel wrote:
> From: FuginInsanE <FuginInsanE@googlemail.com>
>=20
> This series adds support for the thermal sensor of the Allwinner A80
> (sun9i), the last SoC of the family with an in-tree DT but no THS
> support.

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/sub=
mitting-patches.rst#L830

Best regards,
Krzysztof

