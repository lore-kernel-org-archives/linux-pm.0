From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH RFC 02/12] Documentation: thermal docbook: add glossary
Date: Mon, 16 Feb 2015 23:27:31 -0400
Message-ID: <20150217032729.GB4000@developer.amazonguestwifi.org>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
 <1423517653-11359-3-git-send-email-edubezval@gmail.com>
 <20150218115221.GD2990@e104805>
 <1424278698.23187.39.camel@spandruv-DESK3.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:40459 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbbBRUsb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Feb 2015 15:48:31 -0500
Content-Disposition: inline
In-Reply-To: <1424278698.23187.39.camel@spandruv-DESK3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Javi Merino <javi.merino@arm.com>, Rui Zhang <rui.zhang@intel.com>, "ezequiel.garcia@free-electrons.com" <ezequiel.garcia@free-electrons.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "amit.daniel@samsung.com" <amit.daniel@samsung.com>, "hongbo.zhang@linaro.com" <hongbo.zhang@linaro.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "peter@piie.net" <peter@piie.net>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "aaron.lu@intel.com" <aaron.lu@intel.com>, "caesar.wang@rock-chips.com" <caesar.wang@rock-chips.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "vincenzo.frascino@st.com" <vincenzo.frascino@st.com>, "mperttunen@nvidia.com" <mperttunen@nvidia.com>, "mikko.perttunen@kapsi.fi" <mikko.perttunen@k>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2015 at 08:58:18AM -0800, Srinivas Pandruvada wrote:
> On Wed, 2015-02-18 at 11:52 +0000, Javi Merino wrote:=20
> > Hi Eduardo,
> >=20
> > On Mon, Feb 09, 2015 at 09:34:03PM +0000, Eduardo Valentin wrote:
> > > This change introduces a section in the Introduction Chapter to
> > > list concepts used by the Thermal Framework.
> > >=20
> > > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > > ---
> > >  Documentation/DocBook/thermal.tmpl | 129 +++++++++++++++++++++++++++=
+++++++++-
> > >  1 file changed, 128 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/DocBook/thermal.tmpl b/Documentation/DocBo=
ok/thermal.tmpl
> > > index f8fb8a2..66efed3 100644
> > > --- a/Documentation/DocBook/thermal.tmpl
> > > +++ b/Documentation/DocBook/thermal.tmpl
> > > @@ -84,5 +84,132 @@
> > >  		devices.
> > >  		</para>
> > > =20
> > > -  </chapter>
> > > +		<sect1 id=3D"glossary">
> > > +			<title>Glossary</title>
> > > +			<para>The Linux Kernel Thermal Framework  uses a
> > > +			specific terminology to represent the entities involved
> > > +			in thermal constrained environments. This section
> > > +			summaries the terminology as dictionary. These terms are
> > > +			in use within the present document and in the source
> > > +			code of the Linux Kernel Thermal Framework.
> > > +			</para>
> > > +			<glossary>
> > > +				<glossentry>
> > > +					<glossterm>Thermal Zone</glossterm>
> > > +					<glossdef>
> > > +						<para>Thermal zones represent
> > > +						what is the current status of a
> > > +						thermal constrained zone in the
> > > +						hardware. The zone usually is a
> > > +						device or component. The status
> > > +						of a thermal zone is mainly with
> > > +						respect to temperature.
> > > +						Currently, the Linux Kernel
> > > +						Thermal Framework represents
> > > +						temperature in miliCelsius. The
> > > +						current abstraction covers for
> > > +						non negative temperatures and
> > > +						constraints.
> > > +						</para>
> >=20
> > Shall we point out that a thermal zone doesn't necessarily imply a
> > thermal sensor?  I find it very common to assume that if you have 10
> > sensors, you should have 10 thermal zones.  From my point of view, a
> > thermal zone is an area that has similar thermal characteristics.
> > Therefore, the temperature of the thermal zone doesn't necessarily
> > have to come from on sensor, and can be defined as a combination of
> > the input from multiple thermal sensors.

Yes, I agree that here we should mention that we are talking about an
area/zone in hardware.

>=20
> Currently since you can have one temperature input per zone
> (irrespective of whether the temperature is combination of many sensors
> or virtual sensor), so separating thermal sensor and zone can be more
> confusing IMO from a user space perspective.

I believe we should make it clear in the documentation what is the
relation between each entity. I will add a section about the relations,
clarifying from concept perspective, implementation wise, and from
userspace perspective.

>=20
> This was a feature proposed and submitted for thermal sysfs 2.0 (or next
> version), where sensors and zones are separated. I think there was some
> plan to adopt this. Rui Zhang can comment more.

Yes, I agree. However, the sysfs 2.0 never made upstream. The current
documentation project targets what is in the kernel tree.

>=20
> Thanks,
> Srinivas
>=20
>=20
> >=20
> > I don't know how to put this in proper words for the documentation,
> > but I think it's worth hinting it here.
> >=20
> > Cheers,
> > Javi
>=20
>=20

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU4rUHAAoJEMLUO4d9pOJWriEH/ifmvrmXTEnaHKsejZnm6JmT
9YUR5aq1YIPn6d+v7PTSdA7BzTf9qPRC19bncKWI68Hom0+Pcp7LdXRrjqP0HfGT
ED8gWcD0Znc9kV+s1SEEYpD6k1hNa9rgMPcL9mQaHLUqHirCpAKq5TZ/Tc4c0FFU
0yPDQEJrSKjrUcPM/t4PwROXLVbIwsdoI402Ls6+wO0Kr9YZSIkw+x5Y5Ikb9L3a
D1U5Iroo01jITJHdogCkr6hat27x3l9JpS6X0PzFRm9MFUss+YKfKILrVDE2a52X
tRan605fd00k0ZUSkX7kXZcyocNaXOJ52N45XaEdxgzi3iMISZ9gGwByxmKwSFs=
=4k83
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
