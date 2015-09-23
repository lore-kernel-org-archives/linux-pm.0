From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 09/11] power: bq24257: Allow input current limit sysfs
 access
Date: Wed, 23 Sep 2015 02:29:06 +0200
Message-ID: <20150923002906.GA4359@earth>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-10-git-send-email-dannenberg@ti.com>
 <20150922191649.GA9949@earth>
 <20150922221044.GB30297@beast>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33444 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758219AbbIWA3L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 20:29:11 -0400
Content-Disposition: inline
In-Reply-To: <20150922221044.GB30297@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2015 at 05:10:45PM -0500, Andreas Dannenberg wrote:
> On Tue, Sep 22, 2015 at 09:16:49PM +0200, Sebastian Reichel wrote:
> > On Fri, Sep 18, 2015 at 04:39:57PM -0500, Andreas Dannenberg wrote:
> > > This patch allows reading (and writing, if the D+/D- USB signal-based
> > > charger type detection is disabled) of the input current limit through
> > > the power supply's input_current_limit sysfs property. This allows
> > > userspace to see what charger was detected and to re-configure the
> > > maximum current drawn from the external supply at runtime based on
> > > system-level knowledge or user input.
> >=20
> > Maybe also support writing into input_current_limit in auto mode.
> > Just disable auto detection until "auto" is written into sysfs node.
>=20
> Auto-detection was enabled by default in the original driver so I think
> that should be left intact. I added the ability to manually override
> this via DT with a fixed value, and then configure said fixed value
> through sysfs at runtime.
>=20
> I'm not 100% clear on the usecase of runtime enabling/disabling auto so
> I'd rather leave the implementation as-is. Either auto mode is enabled
> or not -- and this is directly tied to the DT setting. But if someone
> has a strong usecase for this I can certainly add it.

For some usb power supplies auto-detection doesn't work very well,
resulting in a 100mA default fallback. Users knowing their hardware
could force charging with the correct input current limitation.

-- Sebastian

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAfJPAAoJENju1/PIO/qaEGYP/2Ykr5YV0PNzJiEXw81Fec5N
xeOAs67S2JJW66qx4GuVt5LtEX+fLsH6wP19fJe/1ATNWVtH49OTpms0PSyYZc9m
WCQY/MIrGpgNRc/kPxCINm6Kw0HH3JArOnOGb0Af0EpVbcpmkGYoBbiSiFJ4J5O3
3peLqkffpAnF5n4wH8V70YmJEE/qbvXGV57imMnMAXp41N5ZUC8jJ4rrXKr6wT6y
C5A07e6FtUzJ6dIJlTJ2xMb0KGxTL78gUpykpRhUDaoBJ9ieH4RYjVuk/+iuyw7r
mvz9NuGbAZnHSUgsz7qV50wGgEezImx8nhDNqEUMdE+wO9a912v19XvxWx9LM8B7
TLybaoNBv1Lor5OIPx4QGWRyNoJIu0TLI5zQS7WgeYIhiVu6OkIZBK8cOhesrJp5
KMAfWca8yW3IYs48CgghG1nn0vN9G1J2aR1QUX/KfbPDp1rD7fkdgTnwBjvYGk6x
SydL9CJprajs0YOCiFCKT6xGtchaO3lwvcCHyoG3mNa94MSV52354t/EvMFApjdr
hWtrTrobciZBl/n9CUjPxEg3zw0jiWjLNVTHSzM1P7W5Sm/rIoI2Tdtkjjn1Dm3I
Z196W40X4OJO0ibkePqxiEYVRaQtag3TFNO3zQ/HSswlr+AHOdsGDSyYqaGMGM7+
bfzPP8MR6qM/DhX0cWwW
=3rwV
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
