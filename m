Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB4225F7A9;
	Sun,  4 Oct 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791142318; cv=pass; b=c/9P8IKzmF/XdCAzwQNlHe9EIjjtB/mFa01FLDZNcmtBErRmttj+vJ/PoiIaxYcZ7zu1eWsManW982iviqHa+aPvtFbeYyC2AjOm7OW43EMvtLCPnIdoIlRC5fuPyF4CPdBGrL4LIxQ7qlAcWMLabD3+9sfSNwu1W8cgJvuxuco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791142318; c=relaxed/simple;
	bh=npAFeNbnUiqL5FuCr3iRamjVN1PG0m2FhKEnJ4LpgTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcMhbY1DX0LUxs/vU9iEB/XJrYyVvXXtOW44l2dKFuhJiuxsP6aAC142Oc6O1gdhgkszgtFRDGJKXQXoWmgScrFF75W2q14kaunE0OVunsopG48hnoe1rcLUWeTdGsjjDUKZpaHSDqcP/Cvz3MdnRcM6vSXySODQQg5gbQsKgGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=J1UyGq/U; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="J1UyGq/U"
ARC-Seal: i=1; a=rsa-sha256; t=1791142201; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Pi/oisytCHp2YKwOVmo7zZbbepwwmwkZDZCb1EC5JWzrkyCXLlwySINedWLlGCwPVbtbBb6srsQLcQSqNUC2Uo5mLGdil22SWH4H7E58k8Gpzbi4tS8ClBLBRqLqAR5Ua012yyz7z5qq1VuA/9kj+EUicoIrWMBpZGj/l7srmk4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791142201; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JFR/y46AuH5zhc0c/R6tAYo9y5d3NyankY+Jgutk2ow=; 
	b=TuepGGdR63PBpIwOlizgrHrTZyvU9DjrLKxJ6aWCpbHOwB/5lUucSX7Bbxbl0vW1pgqKy1nEIaI3Wsxs4/GR+aqEhUPYt5NoQeW/dXZ73tc9FDBCvMPXgefKmwd2JacszF2tJgElI6YAggvcEHvetpfGIwgxyTYvKkC6Ym/aQDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791142201;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=JFR/y46AuH5zhc0c/R6tAYo9y5d3NyankY+Jgutk2ow=;
	b=J1UyGq/UqBJBipmNwosM7o6xXgF20Kwd4Rrkfb/eAkbWvoL9/zgYXdnNxwiMf1Tt
	/uaqa8ChNMu/M5250emqUgG861Ht8mDqzroZyf3SgAQHla9DvzBAQ1bzq1Hmh/DZ/e+
	Pkl3f6MLkWlDs4Mu6l8x9VbQ06IJ3gP4gKGlXQx0=
Received: by smtp.zohomail.com with SMTPS id 1791142198422180.87438797751383;
	Sun, 4 Oct 2026 12:29:58 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 092E2180951; Sun, 04 Oct 2026 21:29:35 +0200 (CEST)
Date: Sun, 4 Oct 2026 21:29:35 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jordan Brough <jordan@brough.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
	Denis Benato <denis.benato@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Antheas Kapenekakis <lkml@antheas.dev>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Armin Wolf <W_Armin@gmx.de>, Jonathan Woithe <jwoithe@just42.net>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Ike Panhc <ikepanhc@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
	Matan Ziv-Av <matan@svgalib.org>, Nikita Kravets <teackot@gmail.com>, 
	=?utf-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>, Joshua Grisham <josh@joshuagrisham.com>, 
	Jeremy Soller <jeremy@system76.com>, System76 Product Development <productdev@system76.com>, 
	Azael Avalos <coproscefalo@gmail.com>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ACPI: battery: add acpi_ prefix to the battery
 hook API
Message-ID: <asKowO4nqSiCC58T@venus>
References: <20260930222650.1883805-1-jordan@brough.org>
 <20260930222650.1883805-2-jordan@brough.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="62rwvd636wwykjor"
Content-Disposition: inline
In-Reply-To: <20260930222650.1883805-2-jordan@brough.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.133.86
X-ZohoMailClient: External


--62rwvd636wwykjor
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] ACPI: battery: add acpi_ prefix to the battery
 hook API
MIME-Version: 1.0

Hi,

On Wed, Sep 30, 2026 at 04:26:33PM -0600, Jordan Brough wrote:
> Rename battery_hook_register(), battery_hook_unregister() and
> devm_battery_hook_register() to acpi_battery_hook_register(),
> acpi_battery_hook_unregister() and devm_acpi_battery_hook_register(), so
> that the exported ACPI battery hook API has a consistent namespace, and
> update all in-tree callers.
>=20
> No functional change.
>=20
> Signed-off-by: Jordan Brough <jordan@brough.org>
> ---
>  drivers/acpi/battery.c                       | 30 ++++++++++----------
>  drivers/platform/x86/asus-wmi.c              |  4 +--
>  drivers/platform/x86/ayaneo-ec.c             |  2 +-
>  drivers/platform/x86/dell/dell-laptop.c      |  4 +--
>  drivers/platform/x86/dell/dell-wmi-ddv.c     |  2 +-
>  drivers/platform/x86/fujitsu-laptop.c        |  4 +--
>  drivers/platform/x86/huawei-wmi.c            |  4 +--
>  drivers/platform/x86/lenovo/ideapad-laptop.c |  4 +--
>  drivers/platform/x86/lenovo/thinkpad_acpi.c  |  4 +--
>  drivers/platform/x86/lenovo/wmi-other.c      |  4 +--
>  drivers/platform/x86/lg-laptop.c             |  4 +--
>  drivers/platform/x86/msi-ec.c                |  4 +--
>  drivers/platform/x86/oxpec.c                 |  2 +-
>  drivers/platform/x86/samsung-galaxybook.c    |  3 +-
>  drivers/platform/x86/samsung-laptop.c        |  4 +--
>  drivers/platform/x86/system76_acpi.c         |  4 +--
>  drivers/platform/x86/toshiba_acpi.c          |  4 +--
>  drivers/platform/x86/uniwill/uniwill-acpi.c  |  2 +-
>  drivers/power/supply/cros_charge-control.c   |  2 +-
>  include/acpi/battery.h                       |  7 +++--
>  20 files changed, 50 insertions(+), 48 deletions(-)

I expect this to be merged via other tree:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com> # power-supply

Greetings,

-- Sebastian

--62rwvd636wwykjor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrCqRsACgkQ2O7X88g7
+poiWxAAp/QxZ6RBEAi94THiV6q0/NPtT1zDexJhTXn8VS8LlU/lpCKicyuhrLwu
xb8L+UumNwSbonKI7J6vBgsYc0yulnfdbjgZUQmi3qKfYEX9GD3el84MlNT3OCLF
pxXS+003OV6xbb754fLN7OnszrFpgIRHtP8pfwTEi6ah65CImiNFUWthTUN4mf4h
gsyw2Cok5/VP6mX9vj2Q37+UAq7+68i2/vVIrVF/t79mO8T0J4EzkvP3Et893aBz
s3PXSTDoBD+XizKL2oPzavpY/5w3g1Caf2ZHSiO/WH0WmcJnlr5TftXo8MSlVMxJ
JWoL9cHnqFjx11pOvRUOjYdhbyIVRvWOgZQdw/lOTrCldsH4KDHjQbjGhAOvRvrr
XK4tUDWQj+P+Auiqj8FW535zWUPOktMlzBINyklkuzfsgnv9qjTvHmjGP6XEQE8C
7Y3MgiB+czD5L7+NiWSpRf/7/B4Ln0YeKsQgfs8tYUeY6ukyNgwcnpY/DkQ8DewO
7WzTm3JUa2PL7dvvlhO3WprobdjKE662PWPN8y8lPD4v8sGc28zRD+sQJ0Lss9gx
LCxBdF+D8cvz8tTdIjteH/SljVlzcP8Alcr6Sl2PNHb2XtlKd5kgpcnsNyIh0/BE
SETzWiZDs0b74fY9ls6reAkYRCVXsBVGu6piBJtj5saqeh4om78=
=qtJe
-----END PGP SIGNATURE-----

--62rwvd636wwykjor--
