Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC9239934A;
	Mon, 20 Apr 2026 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721634; cv=none; b=VMCdvyB5SsBuwkbObupZjFPf0hgoSkFeBeMdSHhvUVK2pfoAJmGuzfhtE1uQklxmt9UT7xkq6UIb3tF77INnlF7NPF3HSpjRtQB7n+M0pMABloJdVXn2zqwF/rls35FQjCMsfKk2g040oSSAy/2L1XxHsvCVsZa63R8gU5nFtsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721634; c=relaxed/simple;
	bh=CLLSksC9+qDIWHIyI4I9YQ5LoX/FB7wYqB2vmAruL5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqplI6I5IJZ7uUbloz5ax59A0r2AhzVBHQBBCjX9MvNvDNaf740Fus2Au+yPeIUyhQXKeSe6E6hIbK+132nhtHnr2djXxXMNHxz3Q1+owZDpOL6gZuxJsvSPTd1NvGsZzN2Om5Vrz/7ktHWG8rV2+uPUncEvrUvTdLSGDxhuX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=HtBKX5/I; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="HtBKX5/I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=7vNfyFBOnLNbtekuQiXkiG2gtWPCS+o1h1We+Flr9lo=; b=HtBKX5/Il95oqVlLVCfX19riBr
	g776peq+rh+OfYNsix46NL1UtKwuYZnaex5rnrF3cuzaIE7k8S6rNIK55Iolw5b08FauIzm73h9c0
	/Ob57V+UtL6X3lmx1DkjhQR2MQawjHwjB1K9zY8wsAU4NeowmqR+xYBkE2z4EMb1gKhtbpWJbCuFt
	zYbeSYp+4G0jdoLOLgNweuBIs0lOZDVDYAH3auT23Qx8R04lWxFwzWMD0onNH10sL9YC1GVYt+HYu
	+gNxIKE6cZVQSKRXCTTXutKBm59tMW/ltoJawkhhqZNpj3iR3hIM1VhVVktrXIOGOBK/Cq1JrhqEX
	wUh1pfvA==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1wEvyu-0000000DyKx-2dhQ;
	Mon, 20 Apr 2026 23:16:36 +0200
Date: Mon, 20 Apr 2026 23:16:35 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shuwei Wu <shuwei.wu@mailbox.org>,
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
Message-ID: <aeaXszeaE62rM6BJ@aurel32.net>
Mail-Followup-To: Anand Moon <linux.amoon@gmail.com>,
	Shuwei Wu <shuwei.wu@mailbox.org>,
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
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANAwSgRt5-t_ah=phGc+CQYHG-CdWJuOX-2VTW6xE7n7EnVsFw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi Anand,

On 2026-04-16 17:07, Anand Moon wrote:
> After reviewing the Banana Pi F3 schematics, I confirmed that Buck1 and B=
uck2
> Both supply the CORE_0V9 with 0.9V=C2=B11% rail. To resolve the restricti=
on errors,
> I expanded the voltage range in the DTS to 500,000=E2=80=93950,000 =C2=B5=
V.
>=20
> Additionally, I updated the DTS to map the second CPU cluster (cores 4=E2=
=80=937)
> to Buck2 to better align with the hardware's power distribution.

Actually the output of Buck1 and Buck2 are connected together, so they=20
should always be configured with the same output voltage. And both=20
clusters should be mapped to both outputs.

I also wonder why in the original patch the buck1 regulator is named=20
buck1_3v45, from the schematics, it should rather be called buck1_0v9.

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
