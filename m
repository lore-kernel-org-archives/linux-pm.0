Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8425B33F8B4;
	Tue, 21 Apr 2026 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791480; cv=none; b=ak8OlrjTkT6+jbxWJZDSLNbtW1Ti29H2GwYOkITF/CrDdn2y3DMFO0QW5N7F9C0ZIqMgy3BtWUZMEMhH31Da72UAQA2cWZZj9wBhZV0MtXlJgiDEq9exJAfl8exgzIE2+XmEHEeh5Lt2XrHlLC0dEZ7qg7sZxplRKFoUInWCTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791480; c=relaxed/simple;
	bh=zMNU29+wUjgpn9Ja3lorEBJU6chv56zxhp13d5Ny4L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LF5RWTwUQr9RmXrLz8ocjDEH0uYs6R5utIOmeRf5Svyea03OLRiqxB54msIH4zyFtt+hiI/ZuhGz4AQiGrdxumO6qjvYBHvMPJ9km9F0GvYpmM3/BwoAPtAb52kN5nwV+56d0vLfBP6t8YPCRugcTKS8VBA7ZfBJO8R9P1A+ebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=T4HGdHmr; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="T4HGdHmr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=VjnkFdeZK7rty5DMcJ7z5EdKxdECkqDgYWJysUP63zQ=; b=T4HGdHmrOrluO2Ljr/dWivyZ/q
	XEz+F6FFQV9KvN5chUsSMn/90jdUnWIRsl/TcM44S7Dy3dHV6YnkEsuXRIbsP6jk20vj9RHQOoH2O
	nDN+cdpnUSHl/lZ6RNkDb0eMfHZTOYkqfQbqM2xQfpO06tvvZoUkHJStS8a0CeFISAafOB8YL2qbY
	osxvAtbGVH7N5b8i/b9nP8mtQgaIYf+4vLO5KvWnEvRmgEvab04CU48qkdvM+WCvnvapYtMWsc2Sc
	Sq0YXHS/X8f0Iq7bioDgo+IV/lWNUJno4kCUM0K7wsA4JqFa04aGtX2Wvt5YbNzHckZIp6OEroajD
	Alw1SLTA==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1wFEcx-0000000F5X7-3F74;
	Tue, 21 Apr 2026 19:11:11 +0200
Date: Tue, 21 Apr 2026 19:11:11 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Shuwei Wu <shuwei.wu@mailbox.org>
Cc: Anand Moon <linux.amoon@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
Message-ID: <aeevr6Zj3Pwm9wux@aurel32.net>
Mail-Followup-To: Shuwei Wu <shuwei.wu@mailbox.org>,
	Anand Moon <linux.amoon@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
References: <20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org>
 <20260410-shadow-deps-v2-2-4e16b8c0f60e@mailbox.org>
 <CANAwSgSNHO3MNewNzpYbhuj4K3NTdfzDC9KPoUHbFH97P4M_UQ@mail.gmail.com>
 <DHUCL24GMX7D.369IWK9DLPZPX@mailbox.org>
 <CANAwSgRt5-t_ah=phGc+CQYHG-CdWJuOX-2VTW6xE7n7EnVsFw@mail.gmail.com>
 <aeaXszeaE62rM6BJ@aurel32.net>
 <DHYOIIFMGH7J.228ISQ7XYFGKE@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DHYOIIFMGH7J.228ISQ7XYFGKE@mailbox.org>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi,

On 2026-04-21 16:10, Shuwei Wu wrote:
> Hi Aurelien,
>=20
> Thanks for your addition.
>=20
> On Tue Apr 21, 2026 at 5:16 AM CST, Aurelien Jarno wrote:
> > Hi Anand,
> >
> > On 2026-04-16 17:07, Anand Moon wrote:
> >> After reviewing the Banana Pi F3 schematics, I confirmed that Buck1 an=
d Buck2
> >> Both supply the CORE_0V9 with 0.9V=C2=B11% rail. To resolve the restri=
ction errors,
> >> I expanded the voltage range in the DTS to 500,000=E2=80=93950,000 =C2=
=B5V.
> >>=20
> >> Additionally, I updated the DTS to map the second CPU cluster (cores 4=
=E2=80=937)
> >> to Buck2 to better align with the hardware's power distribution.
> >
> > Actually the output of Buck1 and Buck2 are connected together, so they=
=20
> > should always be configured with the same output voltage. And both=20
> > clusters should be mapped to both outputs.
>=20
> You are right, I received the same response from the official developers.
>=20
> Therefore, I'm wondering if an additional regulator-coupled-with: property
> definition is also needed here?

Yes, I think this is the way to go. I even wonder if this shouldn't be a=20
fix with Cc: stable. This also has to be done for the Milk-V Jupiter=20
board, I haven't checked the other boards yet, but I guess they all use=20
the same schematics at that the PMIC level.

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
