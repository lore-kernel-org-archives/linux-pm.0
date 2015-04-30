From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/3] power: reset: BCM63xx reboot support
Date: Thu, 30 Apr 2015 17:25:22 +0200
Message-ID: <20150430152522.GB6133@earth>
References: <1427242632-7971-1-git-send-email-f.fainelli@gmail.com>
 <55369C34.5020201@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58635 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbbD3PZ2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Apr 2015 11:25:28 -0400
Content-Disposition: inline
In-Reply-To: <55369C34.5020201@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <fainelli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, jogo@openwrt.org, cernekee@gmail.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 21, 2015 at 11:51:32AM -0700, Florian Fainelli wrote:
> On 24/03/15 17:17, Florian Fainelli wrote:
> > Hi all,
> >=20
> > This patch series adds support for the BCM6328-style software reset har=
dware
> > block commonly found on Broadcom BCM63xx DSL SoCs.
>=20
> Looks like we can utilize the generic syscon reboot driver instead of
> open-coding one, let's do that instead.

Thanks, that's preferred.

-- Sebastian

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVQkliAAoJENju1/PIO/qaDp0P/1kXbw+6oUn9c50YvhKoy/wr
tZ+sGI7oa/igIihcdVT9vyzNK559Rz4XrzZshjiV8bqz9FiVx0USZW5RtjOuz/Aq
wiLA9JaQJED9di/zPhoIqS61GKntXbp40tVsY8PkXOmwAoGJcEOpGqGRN5SUIdi0
cBkyaXDiCwdOr+Byb/tvihRrR0OnoY/ofqnVDMUopxxZAJPT4dtCHY6l4hsZiqex
lo1GAfyE5u0DGAlwq8cDfUXSPktqv0jb4qoDkBWmj6uMlyLKuwmoMeUY/QZ3EalM
mqldJtwC4EgT5HA0bRs+RfOIwNLttUD1CUBTCoCFQ6q8Yh3xVAe2g72MvAgys4Wd
KiirYpJFYuNB9Y1lEgcLNiih3otgY8/TxMcVwGf85DScXSHHStmr0VoWY6OkMt+F
cQViD/sQZFvtPsQ21WlMOLjLEW/Y8xD9MiKXn+7k/l8YwzjhVgFvAcueoL/kw7C3
+YwI3Wg8pRcacVxgDt6MbcOrGZnqO/AHWx0LGgqLLZJdJkXjwYQp+Gzgpv/rdjpS
MISmdgXiQnF1N8xULFqKNijGGkuk/Ad9QEI7fuXybKGDPYQLwP/OfCsa+ka521fd
I7jmdFnRm/bUnBV9mbP2A+VfZpnyEd+KWXcsQ/xzAos8/5h7TWjOt+cFV8VXGbYi
KBQNJZA9UVSWJzeB7YA7
=giSJ
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
