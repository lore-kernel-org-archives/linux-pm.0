From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/4] power: axp20x_usb: Add support for usb
 power-supply on axp22x pmics
Date: Fri, 10 Jun 2016 03:37:28 +0200
Message-ID: <20160610013728.GB5848@earth>
References: <1464887936-17020-1-git-send-email-hdegoede@redhat.com>
 <20160604140154.GB31801@earth>
 <953cdbf8-fa75-cc61-edd3-1fe31545ab6d@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44772 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbcFJBhd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Jun 2016 21:37:33 -0400
Content-Disposition: inline
In-Reply-To: <953cdbf8-fa75-cc61-edd3-1fe31545ab6d@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 04, 2016 at 04:09:53PM +0200, Hans de Goede wrote:
> On 04-06-16 16:01, Sebastian Reichel wrote:
> > On Thu, Jun 02, 2016 at 07:18:53PM +0200, Hans de Goede wrote:
> > > The usb power-supply on the axp22x pmics is mostly identical to the
> > > one on the axp20x pmics. One significant difference is that it cannot
> > > measure / monitor the usb voltage / current.
> >=20
> > Acked-By: Sebastian Reichel <sre@kernel.org>
> >=20
> > What's the merge strategy for this patchset?
>=20
> All of the separate bits can be merged separately without
> problems, [...]

OK, I queued the first patch with Rob's Acked-By.

-- Sebastian

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXWhnYAAoJENju1/PIO/qabLcP/0TBcJtFrNRf0niqE9Yess+f
w5hhL8Z3MwGN3x4nQe4KJQCVRZt4i+LATKiqndWX8sAisQa21InLatIEEr5imB7U
19hkxTZ7h19beP65IjTe0jeNncDOrq2D2BuHe7dPy463PdgaR5Ve3OTkmD8UZOXZ
FHozsVM46w46B+13Tf+CGSzNxs0jr02AxQ3xFSAwWOTCY59QeOP6f/F5H8k8Jjlq
pfZ89/79LfbvYbl+cJKJjCaKYy/mk839l7oaUQsKOLM3YC9AsKaZAuO+Baa/B3pJ
q8KGEBwn7Zxr8MCmaGeFhGzuvGM26Fjl53GcdXlj/uinsnMKvdrj+qlaeF7UR11L
zIj/1/PK0FoB5TNjnrH7UuEJT9e+1dcn2tLl+oHrjt8GAZ1H3O0m0yxo+Sjz/jNd
ZYjVBuj1HK2RybwZ28ltj52S/whTqtCObQddrn/Ybe7PDF2ajyTMFHSadS1eeBGq
Kp7t7Pg8nBHA9ZhgaPCbl09qQoNdAUUmFHOXNCgL211GVYmZqzAuN/KjSJ5prwju
bYBRwJWFZTCAdTOxfxTHuEaG0CEbkg6TbUwxnb60AaCrxqAqbpi2iWfKTGKu9D0/
rP6nMQxf/dSvPVhjFC0tyDd9ym9u7XJnFhI2PyW2F17AVe4x5daBd64h9plcBNMq
NPgzbkWbgeQHWq97HQVj
=OaC8
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
