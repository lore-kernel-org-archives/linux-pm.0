Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B83270575;
	Fri, 24 Jul 2026 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877048; cv=none; b=JLYxPqveGpGHAePHUb85AWYsfYWqKVu/wkNi9Z9VMxgCWXsNCat6AZ1KLZc6091inMoHtaURynIRxrMQh4osFBX5mCxAXAXtG/j1MZIKav9L2DSt+iIfQZsstc2GBQsaf5OtF7S53cGURWIwqzn8IFlYBRXiSUG1UFyXveEFI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877048; c=relaxed/simple;
	bh=wlB2rHbkyocBl2DyyirfIuC5sUNXkf3WFZtNn8yWboU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsyF99o2KP2qi1fa+qZhNqQRUEpCx7gpNEkxgGM6QKWAzs7YJUt3dUVavlO1wLz60W+PuE+Q/SYRaJfaCrjQutobElqYoIdYCK7ahag2JFQHzkAoqB0nyy7GbM/W/8V0dJ/obPL8IgJykYk/phvkd9E1wYUoUVP6w3fpLzWYsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTDE9oGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTDE9oGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B591F00A3A;
	Fri, 24 Jul 2026 07:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784877046;
	bh=wlB2rHbkyocBl2DyyirfIuC5sUNXkf3WFZtNn8yWboU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fTDE9oGeOmKus3fdDEuPk4jMyBN0V6r/AOl59/k3g3zDTBGxjKml3NnXxhtUNXXiX
	 M+BwrPOcWJFZIJ2rJGILvAXBxw+LXnukCro9MnC1t7ncjT7crWcIO0JTpiTLWH0HYb
	 JYUQmyMUbSp6xd5iFcW46kjlrMfLzNL7h3uzIA0NshKzjQjYa7ilPzPmJuGHzFTBMa
	 f0ZD3i79zkfjQ+/1ueQ1UG2Fb2noxJNcRXAE2xlZDPkNCZ6wF3y/E4ap/8FCUBZOrS
	 D6Vrn0ePIQClOVqqckTxXTBU/AFcqnca7lbPZBx4OGH2GAVrKAPp7H/D2A9F5C93Do
	 0GXlX1YGUcZfA==
Date: Fri, 24 Jul 2026 09:10:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?U8O2cmVu?= Hantel <fugininsane@gmail.com>
Cc: linux-pm@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>, 
	Yangtao Li <tiny.windzz@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Rossak <embed3d@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	=?utf-8?B?U8O2cmVu?= Hantel <fugininsane@googlemail.com>, Claude Fable 5 <noreply@anthropic.com>
Subject: Re: [PATCH v2 2/3] thermal/drivers/sun8i: Add support for the A80 THS
Message-ID: <20260724-independent-humble-lion-931e6a@quoll>
References: <20260722203341.2917852-1-fugininsane@googlemail.com>
 <20260722210046.2932498-1-fugininsane@googlemail.com>
 <20260722210046.2932498-3-fugininsane@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260722210046.2932498-3-fugininsane@googlemail.com>

On Wed, Jul 22, 2026 at 11:00:45PM +0200, S=C3=B6ren Hantel wrote:
> The Allwinner A80 thermal sensor is an early relative of the THS found
> in the A83T and later SoCs. It shares its register block, bus gate,
> 4 MHz module clock and reset line with the GPADC; the THS registers
> live at offset 0x40 of the shared block, with four data registers for
> the four sensors (0: big cluster, 1: DRAM, 2: GPU, 3: little cluster).
>=20
> Register layout, initialization values and the temperature formula
> (T =3D 190 - raw * 1000 / 14543, i.e. offset 190000 / scale 688 in this
> driver's convention) are taken from the vendor BSP kernel. The init
> sequence also programs the hardware alarm (~90 degC) and emergency
> shutdown (~105 degC) thresholds the BSP uses, since their reset
> defaults are undefined.
>=20
> Unlike on later SoCs the data-ready interrupt fires at the conversion
> rate (tens of kHz), and the level triggered alarm interrupt would
> retrigger for as long as an over-temperature condition persists, so
> both stay disabled and the thermal core polls the sensors; only the
> emergency shutdown event keeps its interrupt enabled.
>=20
> Since the A80 chip description has no calibrate callback, guard the
> callback invocation in sun8i_ths_calibrate(); the A80 SID is not yet
> supported by the sunxi nvmem driver anyway, so calibration data is
> currently unavailable and the driver falls back to the defaults,
> which yield plausible results (idle temperatures around 40 degC,
> full-load peaks in the mid 50s on a Cubieboard4).
>=20
> Tested on a Cubietech Cubieboard4: all four zones report load-reactive
> temperatures via polling.
>=20
> Co-authored-by: Claude Fable 5 <noreply@anthropic.com>

Same as for binding: nope. Claude is not a person.

Best regards,
Krzysztof

