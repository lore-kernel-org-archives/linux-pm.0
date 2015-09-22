From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: max17042_battery: Convert to using managed
 resources
Date: Tue, 22 Sep 2015 17:15:11 +0200
Message-ID: <20150922151511.GC2533@earth>
References: <20150917125752.GA26658@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43926 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754464AbbIVPPP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 11:15:15 -0400
Content-Disposition: inline
In-Reply-To: <20150917125752.GA26658@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 17, 2015 at 06:27:52PM +0530, Vaishali Thakkar wrote:
> Use managed resource functions devm_request_threaded_irq and
> devm_power_supply_register to simplify error handling.
>=20
> Also, remove max17042_remove as it is now redundant.

Thanks, queued for 4.4.

-- Sebastian

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAXB+AAoJENju1/PIO/qaLLcP/Roo+E2Eptaml+fx20BEzKuH
7xvzNQ3LzUIXAmj4URbnJPvNSRwrTb9LgtzTCJP0Hmx1G8J6O+fjDoseyvqgthj0
/IwLvihkdWc131IrQV88NmaelO8xvfII8PI9e8Ilu+ylYw7y4BW1DmMi0XNMY7lE
xwoMf+iyYajfL13uI8XIK+BAvL6kKE/KD1SEAStzU5HYlL7hlZnUGcb0f/E8sFXj
QKdteIqVGngLc5vz31afaxR/Hc2+P5/l1McrSJTH1uPznhNwtFsUFuK9vimZe9vA
APFAW//ruiNamlQnABNaGBAYZOG8bnp1czftI1SfUrGMxwSn4+o2EscG1WsC20ld
EXk6Yu4cmpbIqsh13rNicD7HL/6DgxJxDzkVp9vasTRCMdfcY3eULDx6xOszJcgG
rueiIHDrcbiY0seB4lJP0WWGXbC8j7t3eqqQdn8rRWDMV2n1dbWpVHMndMhDvYKm
BI2elZjT2VYerxEn8ZfWeem30lDTE1G8E5UUvjyfWLHUpC47+YQ8QXJRfbn8dA8V
2XYldvN9TN3N/5R9GFz7ZCYCzvTgxr/Q46VZahLVOu4OD/f9FBAgtsx8P5keXUBs
tvBd0x/zJYgaV7vH2VXFa2vy9irNid6ZHRF24bHME83aJV8KggOa2MC5Vypo6p+M
vfhOM+Mn4oFKVEDEDcwB
=/5Zl
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
