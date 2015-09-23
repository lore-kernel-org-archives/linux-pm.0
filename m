From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 09/11] power: bq24257: Allow input current limit sysfs
 access
Date: Wed, 23 Sep 2015 17:02:28 +0200
Message-ID: <20150923150228.GA5254@earth>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-10-git-send-email-dannenberg@ti.com>
 <20150922191649.GA9949@earth>
 <20150922221044.GB30297@beast>
 <20150923002906.GA4359@earth>
 <20150923141146.GA6289@borg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50717 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754944AbbIWPCd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Sep 2015 11:02:33 -0400
Content-Disposition: inline
In-Reply-To: <20150923141146.GA6289@borg>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 23, 2015 at 09:11:46AM -0500, Andreas Dannenberg wrote:
> On Wed, Sep 23, 2015 at 02:29:06AM +0200, Sebastian Reichel wrote:
> > On Tue, Sep 22, 2015 at 05:10:45PM -0500, Andreas Dannenberg wrote:
> > > On Tue, Sep 22, 2015 at 09:16:49PM +0200, Sebastian Reichel wrote:
> > > > On Fri, Sep 18, 2015 at 04:39:57PM -0500, Andreas Dannenberg wrote:
> > > > > This patch allows reading (and writing, if the D+/D- USB signal-b=
ased
> > > > > charger type detection is disabled) of the input current limit th=
rough
> > > > > the power supply's input_current_limit sysfs property. This allows
> > > > > userspace to see what charger was detected and to re-configure the
> > > > > maximum current drawn from the external supply at runtime based on
> > > > > system-level knowledge or user input.
> > > >=20
> > > > Maybe also support writing into input_current_limit in auto mode.
> > > > Just disable auto detection until "auto" is written into sysfs node.
> > >=20
> > > Auto-detection was enabled by default in the original driver so I thi=
nk
> > > that should be left intact. I added the ability to manually override
> > > this via DT with a fixed value, and then configure said fixed value
> > > through sysfs at runtime.
> > >=20
> > > I'm not 100% clear on the usecase of runtime enabling/disabling auto =
so
> > > I'd rather leave the implementation as-is. Either auto mode is enabled
> > > or not -- and this is directly tied to the DT setting. But if someone
> > > has a strong usecase for this I can certainly add it.
> >=20
> > For some usb power supplies auto-detection doesn't work very well,
> > resulting in a 100mA default fallback. Users knowing their hardware
> > could force charging with the correct input current limitation.
>=20
> Ok. So how should we best go about extending the usage of the
> 'input_current_limit' sysfs node for this charger? You mentioned
> writing 'auto' into it should enable the auto-detection mode. I suppose
> writing a fixed current value will disable it. But how to indicate to
> the user when reading 'input_current_limit' whether auto mode is enabled
> or not (I think this is something we should do).

Right, I haven't thought of this.

> Can we return a mixed number/string like this?
>=20
> # Example: charger auto detection mode is disabled, and input current
> # limit is configured as 500mA.
>=20
> $ cat input_current_limit
> 500000
>=20
> # Example: charger auto detection mode is enabled, and a charger
> # supporting 1A was detected (note the mixed number/string thats
> # returned)
>=20
> $ cat input_current_limit
> 1000000 (auto)
>=20
> Would that work?

No. sysfs nodes should only contain one value per file.

> Or should we introduce a new sysfs property?

So maybe keep this patch as is (disallow setting the limit in auto
mode) and create another file for setting (and getting) the mode.

Also it might be a good idea to return to safe defaults when the
charger is disconnected (-> reset to DT specified values).

-- Sebastian

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAr8AAAoJENju1/PIO/qaI2sP/jgdxRw2VL/3Xhvyb8RC6zSk
oTv2eDSMSekrzoTiMMNNroMf7x8hU+fmBGqmXvjkn14h1GwpOYNcQ9/Bb2EG7v+L
kVYYCfOANyQkIxw9sA9Xa+QmqYFLfzHLB7pdupkfOHvkJQnvnS1m/uOIkIkL8XyQ
EKCb+6kTS2a66Kb4TYJd+Xt6IGipTDKBugrHVRr3WYTgUpc9qgHsLBuDZb5okGDL
zB+NSQzsCGLqbDpU6PBEz/TB7aw3XvPBqovLJfP3VjAMOW60wlLJQwxwG+Z9O08I
9cdILtzyg7LQgW9IAzOPgYogDOZDFldDNW16Z5fB8PTSb548U9foAhTwyHKM4yVD
y11dbArCorhOc7aaWcXO0ckeYRUVByYXEGKZnpOyvtm1mlvQhKORJ+1IKJHO6LAR
SSmSwuotTcCJv3RrmYwuH73wH6kqLPO9lHrSZc3+BOFmL9gEmFP3I0nP5kCRedI7
xVP73BQcUx4FEQEdahJEZzVpdUX9ymTZEcoXWPfDEQEhzx6e+g4tR+pFJbXF3C40
KdguD0RY4RIHXgjE+T1E2rDq9feebDsfEJgqPmd6YbQ8ZZrjXHeNrQfNEHbcZ0yK
ob9oLlFrkwgrbhMyiDa+OLZDnxvjj2zfkfl5SAwqYcfiMyiTaKr0r6Yr5Xs7BItu
KTRh1tLP1LSfxcAwvCzD
=Ifty
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
