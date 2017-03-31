From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/4] i2c: core: Allow drivers to specify index for irq
 to get from of / ACPI
Date: Fri, 31 Mar 2017 21:54:07 +0200
Message-ID: <20170331195407.GA1449@katana>
References: <20170325135550.22509-1-hdegoede@redhat.com>
 <20170325135550.22509-4-hdegoede@redhat.com>
 <1490530535.21738.31.camel@linux.intel.com>
 <1935239d-fdd8-3917-9865-de389e6728e8@redhat.com>
 <20170330203954.GA1452@katana>
 <149df3eb-8111-4c91-472e-f6c708302ede@redhat.com>
 <20170331162332.dar3f3mval2ch2uh@ninjato>
 <2b4d002f-9e6b-b193-7dc3-2f4c20a93276@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:55288 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754132AbdCaTyL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 31 Mar 2017 15:54:11 -0400
Content-Disposition: inline
In-Reply-To: <2b4d002f-9e6b-b193-7dc3-2f4c20a93276@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

> The problem here is that the i2c system is somewhat special in that
> it does irq mapping on behalf of the driver and does not even bother
> to call the driver's probe() if the acpi_dev_gpio_irq_get() call
> returns -EPROBE_DEFER.

Yes, the client->irq handling is cruft, I am fully aware of that.

> >Or maybe you simply want to be early and don't want to get deferred? Are
> >we talking then about boot optimizations or necessities?
>=20
> The problem which I'm trying to fix is not having to write a (complex)
> gpio driver for an undocumented PMIC which I (and AFAICT no-one) needs (*)
> just because the i2c-core needs to be "special" and do the acpi_dev_gpio_=
irq_get
> for me even though in this specific driver I don't need the irq at index
> 0 at all. IOW the problem which I'm trying to fix is to get i2c_device_pr=
obe
> to not out-smart me and never call my driver's probe method for
> invalid reasons.

So, it is a necessity because you have an ACPI entry to a PMIC which is
totally undocumented. Point taken.

>=20
> My previous patch for this added an irq_index member to i2c_driver instea=
d,
> because my use-case does actually need an irq, but the one with
> resource-index 1, not the useless one at index 0. Which is yet another
> indication that the naive irq-handling in the i2c-core sometimes get
> somewhat in the way. In my experience many more complex i2c devices have
> more then 1 irq line.

I am aware of this problem as well.

> That previous patch works for me too (and even simplifies my driver somew=
hat),
> if you like it better I can go back to that. But thinking more about this
> I decided that having a "dear i2c-core please don't try to out-smart the
> driver, leave irq handling to me" flag would be better / more generally
> useful.

I agree. The last sentence made me understand that you want to flag
"this driver wants custom irq handling" more than "this driver does not
use irq" what I misinterpreted before. This is a much broader use case
and we can probably help more people with that. I like it. Maybe we
should name the flag something like "custom_irq_handling" to prevent
similar misunderstandings? Just an idea.

Sorry if you got annoyed by my questions, yet with the prospect of
not only adding code to the core but also adding something to
i2c_driver, I really want to make sure it is worth it.

Have a nice weekend,

   Wolfram

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY3rPfAAoJEBQN5MwUoCm2h6IP/3qRAwstM8UEy4x4ybiFAYy5
o4Ar/jvAOZjeWHa7LsjD67BIARtnT1MZANY7OZ1XWS6wlbKQMve2tj9XEY/i1LUA
VRMGkTIfwL8QbeKkESOa31af9LN+Ce+GwBoy6u+trj4r8djv/TTNfpDVOGfAIuh4
rfhk31VjYZZdW6fYvKEdmU4AR9zB/h0X8fn731zxAQx1hSXWXdIO+GTSZ9IJuxom
C1dop90qltUCxA2k0Z9vXnRns40s9p8W45YTKC2NJdFelJdO5tBp/SYNZGeLJ2uy
pRsUGSyE+HeW+3mA0/8u4IIgMP3puaGK/FtOoOLi5WrfnfkUTqND/88Nuup5d0zD
Z6Js08mYQlFyh0lecMwCFR8gS58M44geQJ6Hhd1xxLj23r5+ihRN8c7TfXLJs1BB
jv6xXY3DBc2wDoavwol+d7moKaVM8QjFUO0bDnF8LSf690EldkFCunUepgB8adJ8
BnEzexhrwKLjTsM85za2cUTn/Tw4sLojBfsLrmFtrAKFgCiGv3ZaWTj1yl3CmFTc
Qkkt3Rt40ljIJikufD55KgeG8AvWQMK5myTQX285W2ObFvddeDe9jqtNQ1tFuvdU
qgtHwZBNyH3bG1EAXE4HP+QbM8ZYqXowsD9NelTDiQ8AvQ5Kr1Q+lo6zt/XKBDpX
oNCx5iesOnBlPuXuktTK
=2s6o
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
