From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/4] i2c: core: Allow drivers to specify index for irq
 to get from of / ACPI
Date: Thu, 30 Mar 2017 22:39:54 +0200
Message-ID: <20170330203954.GA1452@katana>
References: <20170325135550.22509-1-hdegoede@redhat.com>
 <20170325135550.22509-4-hdegoede@redhat.com>
 <1490530535.21738.31.camel@linux.intel.com>
 <1935239d-fdd8-3917-9865-de389e6728e8@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:38982 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754586AbdC3Uj6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Mar 2017 16:39:58 -0400
Content-Disposition: inline
In-Reply-To: <1935239d-fdd8-3917-9865-de389e6728e8@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

> Sorry for doing this in the middle of the thread, but this is the only
> mail I could find in my archives (I guess I delete mail to aggressively).

I use patchwork to track patches (which is mentioned in MAINTAINERS).
And patchwork has the nice feature to download patches or series of
patches as mbox. And from there you can reply directly, or bounce to
yourself first, etc. That's what I do when I lost a mail.

> Anyways self-nack for this series, there are multiple issues with it:
>=20
> 1) In hindsight the irq_index is a bad idea and instead we need a noirq
> flag in i2c_driver

What do you mean by that? No IRQ assigned? In Linux, 0 is no irq. I
guess you mean something else...

Thanks for the heads up,

   Wolfram


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJY3W0aAAoJEBQN5MwUoCm2OlwQAIkKbDq0/crq2N1aoWERoxAz
1tIM+iWhQ+bNyXt34qPTU3JXZC1KkaZ2YO6qo2VBbu2SKdFF4yweWxKfUB4SboPU
/4CHO7xspm3ES/z6sLGEbjcHeoPV2NC2ol67uKI1KTvV63Yz0zjrrE7pMPGlf8PW
PpA+yAmMVSsXM7iTEn5bKBdrxo6R4oKhPKC0gxAGlHfMNXJY1meLWrEwmjycOwrV
uJjeQyze5NTsXlw/C0+cMXp6pNa0cmsMEKcSpYQCQl/09VPW+aTmSmic6wEhMhiv
kpecnx7ltFg/k/Sx9WKj5zfx3CoH+UUY4zd8/bLwNILrG1pMYFOLlZNFOl5ib1dF
6f7mUKUJ16sLgf7+U+oRB80NWI9a4dvvEfLhqJvi691pB8vY3sfV1WbxAB6OkPCH
dtQbDTz30jcBPllQo5tsnFAlwHCCnKv13sDJ3XNpCNSCj68hy5wRZqV38JwAuYs1
u5gqXki3/XKHtEghyFRmFD/ZIsgt6wgJdowPDj+mZwNhDxqB2p4qZgiHVlsGXEnw
U+JOBZxCwWCVFjYyO3w8p8ss1GI44bygpkYe0IdjxzaAKiQCO1zQ4WvJVeHhKmaj
GQl1/krA1az+hMK6snC9iUpWGtmJBjAXsVO+LF1oBlUUjFAAzP6rz4TOG0gdBHGJ
Od52qNRye6pkp4el80HT
=NH87
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
