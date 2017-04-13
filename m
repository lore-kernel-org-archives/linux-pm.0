From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 1/2] power: supply: bq24190_charger: Use new
 extcon_register_notifier_all()
Date: Fri, 14 Apr 2017 01:44:48 +0200
Message-ID: <20170413234448.stxmxvnemldzjyq3@earth>
References: <20170413120412.12773-1-hdegoede@redhat.com>
 <20170413120412.12773-2-hdegoede@redhat.com>
 <20170413233526.ebtytz54d3ux2oze@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="snsx3ck2qaekxveb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752822AbdDMXox (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Apr 2017 19:44:53 -0400
Content-Disposition: inline
In-Reply-To: <20170413233526.ebtytz54d3ux2oze@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org


--snsx3ck2qaekxveb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 01:35:26AM +0200, Sebastian Reichel wrote:
> Hi,
>=20
> On Thu, Apr 13, 2017 at 02:04:11PM +0200, Hans de Goede wrote:
> > When I submitted the extcon handling I had a patch pending for the
> > extcon sub-system for extcon_register_notifier to take -1 as cable id
> > for listening for all type cable events on an extcon with a single
> > notifier.
> >=20
> > In the end it was decided to instead add a new
> > extcon_register_notifier_all function for this, switch to using this.
> >=20
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > Acked-by: Liam Breck <kernel@networkimprov.net>
>=20
> With extcon_register_notifier_all() being new and not available
> in my tree I can't simply queue this patch. Also it can't simply
> go through the extcon subsystem, since it depends on changes in
> the power-supply subsystem and results in non-trivial merge conflict.
> I see three merge solutions:
>=20
>  1. Defer to 4.13 (since we are already quite near the merge window)
>  2. I need a immutable branch with extcon_register_notifier_all()
>     from the extcon subsystem
>  3. It may count as Fix and could be queued during the 4.12-rc
>     phase based von 4.12-rc1

Sorry for the noise, I just saw the immutable branch in the cover
mail. I will queue this now. Unfortunately it means rebasing the
power-supply tree to 4.11-rc4 (or ugly merge, which is annoying
in the pull-request). Chanwoo, please try to use -rc1 as base for
immutable branches in the future.

-- Sebastian

--snsx3ck2qaekxveb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljwDXAACgkQ2O7X88g7
+prBjA/+IHqjRTqrfCBxRAiQ+skMpEia34ClAK2++P29t+jIlIMSoAHTmfhUj9xX
H9iW1ckm0TJTb6Qcayn9lmyIJPF/RO+J69kGdIY6lbCPXhSOrsXSwXuv+8ItxCd+
r4QjuuXM46UalNoGJa7V/cT5GGgLpPHHYkbZ8Pjck8LpXjDdnsWFEleHO5ZKtt+/
pBKh2089CSefcXZnjWMK7sODE6peQxOgIMJb37Fh8y/tCd91JQpftl/XHWaBMBIt
3xZTQSdiFJ2yHQPQSLYhH97NSTgjwu+XF8vja1PFqqdlLnaIEty7zguWD8beMamX
GVvsrgVSeIJC3fcOdcP2+3O1OWqX/AqrIm/yGPZBf2x5LCvESocA7HMhBpeM5dvM
pkMH5wzDQmWIX5hVMMqlwGX4npu+sGM4+E6+gcIW5dCeVouXlraxPvyQfsW9SAzt
62UflNKdMhjqYrymPGrqIjDIEku5sZl5nm2x4tBR+OEm3y8/yzpVWDoztdBDscHX
P/DPOqy6QBeHEjolmEfm9aRqteiGj61wbP2/++Kdniuz7aIyl0AYn8OcJmx2+uwG
H90J0f0ZHuZdRf8VhItcjW/HSHo/NKVceYmkduBDH6lUMtSW3solTPybX2nqH4EX
P5gG1mwXhD92DBP3AW0zA2aIFhBgCU07MVlSNnG/9weXdMY3t+4=
=Ai/Y
-----END PGP SIGNATURE-----

--snsx3ck2qaekxveb--
