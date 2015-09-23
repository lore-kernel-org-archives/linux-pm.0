From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 09/11] power: bq24257: Allow input current limit sysfs
 access
Date: Wed, 23 Sep 2015 20:53:59 +0200
Message-ID: <20150923185358.GA4024@earth>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-10-git-send-email-dannenberg@ti.com>
 <20150922191649.GA9949@earth>
 <20150922221044.GB30297@beast>
 <20150923002906.GA4359@earth>
 <20150923141146.GA6289@borg>
 <20150923150228.GA5254@earth>
 <20150923183254.GA26441@beast>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37755 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754446AbbIWSyK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 23 Sep 2015 14:54:10 -0400
Content-Disposition: inline
In-Reply-To: <20150923183254.GA26441@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 23, 2015 at 01:32:58PM -0500, Andreas Dannenberg wrote:
> On Wed, Sep 23, 2015 at 05:02:28PM +0200, Sebastian Reichel wrote:
> > On Wed, Sep 23, 2015 at 09:11:46AM -0500, Andreas Dannenberg wrote:
> > > Ok. So how should we best go about extending the usage of the
> > > 'input_current_limit' sysfs node for this charger? You mentioned
> > > writing 'auto' into it should enable the auto-detection mode. I suppo=
se
> > > writing a fixed current value will disable it. But how to indicate to
> > > the user when reading 'input_current_limit' whether auto mode is enab=
led
> > > or not (I think this is something we should do).
> >=20
> > Right, I haven't thought of this.
> >=20
> > > Can we return a mixed number/string like this?
> > >=20
> > > # Example: charger auto detection mode is disabled, and input current
> > > # limit is configured as 500mA.
> > >=20
> > > $ cat input_current_limit
> > > 500000
> > >=20
> > > # Example: charger auto detection mode is enabled, and a charger
> > > # supporting 1A was detected (note the mixed number/string thats
> > > # returned)
> > >=20
> > > $ cat input_current_limit
> > > 1000000 (auto)
> > >=20
> > > Would that work?
> >=20
> > No. sysfs nodes should only contain one value per file.
> >=20
> > > Or should we introduce a new sysfs property?
> >=20
> > So maybe keep this patch as is (disallow setting the limit in auto
> > mode) and create another file for setting (and getting) the mode.
>=20
> Thanks for the continued feedback. Will look into this and add a new
> property.
> =20
> > Also it might be a good idea to return to safe defaults when the
> > charger is disconnected (-> reset to DT specified values).
>=20
> It already does this when the charger type auto-detection is enabled.
> When configured for manually setting the input current limit the use
> case is a bit more complex and I do not recommend resetting the limit to
> 500mA. Let me explain why:
>
> 1) Using USB chargers is only one of the ways the bq2525x devices can be
> used in a system. Imagine a shipping product that comes with its own
> proprietary wall power (or built-in) supply that let's say cranks out
> 2A.  As a vendor you want to configure your system (meaning, the bq2425x
> via DT) to a fixed value of 2A. The user un-plugging and re-plugging the
> power supply should not arbitrarily change that pre-configured limit

I did not write, that it should reset to 500mA, but that it should
reset to DT specified values. So e.g. if the device is confiured to
be in auto mode in DT, then configured to use fixed 1000mA, then it
should return to auto mode on unplug. OTOH if DT specifies 500mA
fixed and user sets 1000mA, then it should return to 500mA fixes.
So re-plugging returns to pre-configured limits.

> 2) Even in case of USB chargers, userspace could detect the power
> un-plug event, and re-configure the limit to something else.  So I think
> it's really policy that should not be implemented in the Kernel driver.

I think it should be done exactly the opposite way. Userspace should
set the custom value again. My main motivation is, that DT values
should be safe for all attachable power supplies, while the user
supplied value may only be safe with the currently connected power
supply.

-- Sebastian

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAvVEAAoJENju1/PIO/qaBi4QAKecDhktSlWrzEd7A44sH+F4
5wMnJmkKRGxzM8zlAJsvrRGYLGOUKSHXRY6FpJ1Nraw16Yh5gBc14wyBpT9YVUVp
8kpjKLzYplWIs5Gef1JzuxvP2QxNLMDDZwXvLWrY2pvCFn5Wm7y2gKx5hmHP6CAX
X27Vb4Jr7b87yx2osAkNEMJr2QTMKRvOyU6AnFHowP0PyIOFM45Yxg6yEH5piZ45
HexWPKNbe4yOoBzxiD6NAaeYDDYl0Y0oXAnAEucp/K3D0BEggaoMXUberHBl0IGx
VujDmBam1va+BnoCPoZRhK7BpQ5h3p8kqDVfKlTppa+SwithDKjlNo5KfSe59qEZ
7vsUd9pZJH85a3YsmcFTztbYvjaZ3rvpqQWzmTGzIjoOmtnB+5ul5VnXqTYmMt/E
z8qoZjTbeR+wDrDwFqjfQbNvecTduZmzYOB9Cenn6tOj2OtgZ+Xo/sPay54pwjoA
88lN1GJSNnjWpAJjZs/kJ0gIP966H8MMJt8YJNCS3i9UglW+kwMQY2/mmpzsb0X8
tQHqHVNf3/HevWsYsPOaRqicAgb1akYq4piZm2CK7hf9ry4MoQKd9eA12SdIV+Ib
GJRMSVZzMBy4keGO6RM4Ssk9IPga6/wzfTeRxmaVL+hZwpH3KnqPIzM/rr07xG1L
ANieV5GRYa9eu+LqsMC7
=o7gI
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
