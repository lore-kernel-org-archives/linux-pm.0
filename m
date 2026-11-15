Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794808996;
	b=3Cq07NrEPoEOPPJhQkecVBl/z1qeUMcdCbPPjygA8sUMBPZUkmVqp22Y4udNlebPu4EJ
	 iGXm1zCznAJBWOw6mHE36l6D8nbmJIqFj1ViZ1G+xwmzsWU0xEj1eoj6ZZm4JGzy6x64Q
	 2XdHAPHmE7qFss6Wq1jNzhw++CAsW3NnJs6ZfpZTnnNMFYKi/TFlMOK/mw8+7c5PsAp45
	 8V/GflPWozxZjoePyhY/l0kbEXcuJr+/U+FED54IkX4l8+CItrP/9otXvcByNW0I6dIHK
	 a+JXmEuz75xYSUR/oVioyYW1GoVZQzvBEwttm4Qz4N/2UEH+VDLcYmO5fadUOPGJgtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808996;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=ogT/koYnptNR6Kgjq6wLsvdMw/b7dTQfwDW9ZNvLnhY=;
	b=0BmefWETAK+y0EKl3ZPftX4d8ueCqbNIEaunwfwSFXf7+yOgLWwE8Ndocpl6P5RbW9HG
	 zVvRTfwI3dxH1TxK+z96mULZpT6HDHR5XMQY1EZs9IEg8X0AUjv6bQSsr0BeQuSE97zGk
	 +tdZe/lVjLd9ttr1FjgFvyEtTftrSRaGh2+Kave+rg49kkZOoNiRIx30ZfCvmJHeNhMSU
	 8mA82RCqNZIIjoFkhR7hdkraaZFzZ76APFXuSPFATDmDZF91iPCuBM7dLmiDueeKQ0Mbl
	 iIldv3YBzbbciZwHtLe+nK6eAKB+9KooLRuSM6SwI4U+rnvz/yO7IqteuL8IcvbBFZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=RIIPT8Lc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED636606A88F;
	Mon, 16 Nov 2026 06:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED636606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=RIIPT8Lc
ARC-Seal: i=1; a=rsa-sha256; t=1794808971; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rs+3oELz3PROgS5wZoqZ51BnRg6NpI/g+yYUp5PT5KDVY+XUt3gsHt88aE/r/8rnSbQ5IkptRbS0sPLY3dh/llRzfZ5MS5eVwPfPgO/t1IxFwaZrsiAZPTCcMd+VwIAV2VWc82LuHr8QBkTYA+c35UGuMBwVzizaj+HNS6e+8iQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794808971; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ogT/koYnptNR6Kgjq6wLsvdMw/b7dTQfwDW9ZNvLnhY=; 
	b=DrO7wrN1N95n460j7GE9PGMqz7Ge1BOze2Sbo5WIoqjKe48Kfu1tAGbRnJUXFpC9/MT+O/ESDZCiMaNuSBmuuWUHHwDLzIwyPW5YsAyUThyCG4nJymts6mv9KSvBR8E2UlLMn+crNoGPBKaTYL94ZxT0PkkvcJH+fgAxa2a7qgA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=RIIPT8LcMNhzbj76dYxqP/YQc0phhKlWYdt+/lCVmlfCavYlPeFgSK7rW1zwzGMnKTG/ZUTI7hGBJV27dIO0WBkfaumUgnQiy8dRNY6MmG5YoN1j+OvT3/5KpzAVm7IogUvVnLLq09CzVytVB2wco2rc88kaU5rep6wshznu2QU=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=ogT/koYnptNR6Kgjq6wLsvdMw/b7dTQfwDW9ZNvLnhY=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794808969592150.2975159085987;
	Sun, 15 Nov 2026 22:02:49 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 5213E1817E8; Mon, 16 Nov 2026 00:14:34 +0100 (CET)
Date: Mon, 16 Nov 2026 00:14:34 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	John Stultz <john.stultz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, Abel Vesa <abelvesa@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Andy Yan <andyshrk@163.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	Srinivas Kandagatla <srini@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Song Xue <quic_songxue@quicinc.com>
Subject: Re: [PATCH v27 00/10] Implement PSCI reboot mode driver for PSCI
 resets
Message-ID: <avo8wrWBjsk0RU6s@venus>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <CAPx+jO-WLCnVecquKbVaCcErbhuFt6OHFUmzbgNHjixx0r-wMw@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bkecdtnjrzz7cqsu"
Content-Disposition: inline
In-Reply-To: <CAPx+jO-WLCnVecquKbVaCcErbhuFt6OHFUmzbgNHjixx0r-wMw@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.637.76
X-ZohoMailClient: External


--bkecdtnjrzz7cqsu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v27 00/10] Implement PSCI reboot mode driver for PSCI
 resets
MIME-Version: 1.0

Hi,

On Mon, Nov 09, 2026 at 04:47:29PM +0100, Ulf Hansson wrote:
> On Thu, Oct 29, 2026 at 10:01=E2=80=AFAM Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
> >
> > Userspace should be able to initiate device reboots using the various
> > PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
> > patch series introduces psci-reboot-mode driver that will induce
> > command-based resets to psci driver for executing the device reset.
> >
> > The PSCI system reset calls takes two arguments: reset_type and cookie.
> > It defines predefined reset types, such as warm and cold reset, and
> > vendor-specific reset types which are SoC vendor specific. To support
> > these requirements, the reboot-mode framework is enhanced in two key
> > ways:
> > 1. Support upto three 32 bit magic values as arguments. This enables to
> > support for a 32 bit reset_type and a 64 bit cookie).
> > 2. Predefined modes: Add support for predefined reboot modes in the
> > framework.
> >
> > With these enhancements, the patch series enables:
> >  - Arch Warm reset and system reset cold as predefined reboot modes.
> >  - Vendor-specific resets, configurable via the SoC-specific device tre=
e.
> >
> > Together, these changes allow userspace to trigger all above PSCI resets
> > from userspace.
> >
> > Note on introducing psci aux devices:
> > Based on feedback from Bart, Lee and Ufee, PSCI child functionality now
> > uses aux devices instead of an MFD driver, with psci-cpuidle-domain and
> > psci-reboot-mode probed through a common PSCI aux device enumerator.
> > Reference discussions on this:
> > https://lore.kernel.org/all/CAPx+jO9Hi2R_UnCEhsXLwf74c3RTb+RodaJ6SOVXbQ=
X_eHt++A@mail.gmail.com/
> >
> > ---
> > The patch is tested on rb3Gen2, lemans-ride, lemans-evk, monaco-ride,
> > qcs615-ride.
> >
> > Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> >
> > Changes in v27:
> > - Removed unnecessary headers from psci-reboot-mode - By Bart
> > - Rebased onto current linux-next.
> > - Link to v26: https://patch.msgid.link/20260928-arm-psci-system_reset2=
-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com
>=20
> Overall this looks reasonable to me, but I will take a closer look in
> the next few days.
>=20
> When it comes to the merging strategy, it seems like the best way
> would be to funnel this via my pmdomain tree. But I need an ack from
> the relevant maintainers to make sure there are no issues with that.

Works for me.

Greetings,

-- Sebastian

--bkecdtnjrzz7cqsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr6PNkACgkQ2O7X88g7
+pp4WA//ScXkYjx2fyM5OuWtXOCXNPFqaymVSzMvBWj7t8a1tDehexmNzDJtGzRz
AieJj5S96zfsnsOK47xrjJHmWXO7M40VzV+USpbOciHqLhelLgLrgNTAkR/qR3g5
8bdEOdqCuD5x6XMbVzY7qB0WfB3sF3Az5Z6xUWnjU+rKTNDKIprR4G7zO5F6G1Of
UJ/+I/uqe82uiOwTP0F6EOeIPbeUqZAFvFUP6XdZqfNIo0cdPLIKLWdlVnsC7b2X
94EwxTDD8PLe9PzZ7KWO8Kta0jwsQSWUKIzIVdJIdQyVcEtpxxOXZEZOeEyZksN5
B0xu4PZcm/AO3SutpvabV9E4813c387zVv1UECcGen5x6o4KdM97+Z99Qi4WOJJd
y4fTsERdlqO62MeP9BUZhK+bSzBx2DPl4an7w/iT6rj17bQps8/zAk0ZHadadEfi
z9E5Np4Syj07oHi/GZkO013QDi8oYcl1/aiKJb+gOrA3oU4WryQl2oXwR9av951p
0sF5lMKT3cCA0VPl6UgNgOMC+njJfhlk91vNI4NX6EMVk++gS2nq1PgBNdw6bLd9
GrlVoSbbn0kYYDO12rTLuhZN5mgSRHG2sAC/Qzi+RivK0cal4lA0hwphm/PwD0db
6WeTDjaLmbUFs6oYvajVbcdcbCOGt2T2yJugnQsGo2Y7OA/affw=
=Ooso
-----END PGP SIGNATURE-----

--bkecdtnjrzz7cqsu--
