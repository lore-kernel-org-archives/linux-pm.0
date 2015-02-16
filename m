From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH RFC 02/12] Documentation: thermal docbook: add glossary
Date: Mon, 16 Feb 2015 11:19:09 -0400
Message-ID: <20150216151907.GD8648@developer.hsd1.ca.comcast.net>
References: <1423517653-11359-1-git-send-email-edubezval@gmail.com>
 <1423517653-11359-3-git-send-email-edubezval@gmail.com>
 <54DA8B47.80808@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54DA8B47.80808@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Rui Zhang <rui.zhang@intel.com>, ezequiel.garcia@free-electrons.com, amit.kachhap@linaro.org, viresh.kumar@linaro.org, amit.daniel@samsung.com, hongbo.zhang@linaro.com, andrew@lunn.ch, durgadoss.r@intel.com, peter@piie.net, shawn.guo@linaro.org, aaron.lu@intel.com, caesar.wang@rock-chips.com, b.zolnierkie@samsung.com, l.majewski@samsung.com, vincenzo.frascino@st.com, mperttunen@nvidia.com, mikko.perttunen@kapsi.fi, srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com, bcousson@baylibre.com, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Randy

On Tue, Feb 10, 2015 at 02:50:47PM -0800, Randy Dunlap wrote:
> On 02/09/15 13:34, Eduardo Valentin wrote:
> > This change introduces a section in the Introduction Chapter to
> > list concepts used by the Thermal Framework.
> >=20
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> >  Documentation/DocBook/thermal.tmpl | 129 +++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 128 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/DocBook/thermal.tmpl b/Documentation/DocBook=
/thermal.tmpl
> > index f8fb8a2..66efed3 100644
> > --- a/Documentation/DocBook/thermal.tmpl
> > +++ b/Documentation/DocBook/thermal.tmpl
> > @@ -84,5 +84,132 @@
> >  		devices.
> >  		</para>
> > =20
> > -  </chapter>
> > +		<sect1 id=3D"glossary">
> > +			<title>Glossary</title>
> > +			<para>The Linux Kernel Thermal Framework  uses a
> > +			specific terminology to represent the entities involved
> > +			in thermal constrained environments. This section
> > +			summaries the terminology as dictionary. These terms are
>=20
> 			summarizes
>=20
> > +			in use within the present document and in the source
> > +			code of the Linux Kernel Thermal Framework.
> > +			</para>
> > +			<glossary>
> > +				<glossentry>
> > +					<glossterm>Thermal Zone</glossterm>
> > +					<glossdef>
> > +						<para>Thermal zones represent
> > +						what is the current status of a
> > +						thermal constrained zone in the
> > +						hardware. The zone usually is a
> > +						device or component. The status
> > +						of a thermal zone is mainly with
> > +						respect to temperature.
> > +						Currently, the Linux Kernel
> > +						Thermal Framework represents
> > +						temperature in miliCelsius. The
> > +						current abstraction covers for
> > +						non negative temperatures and
>=20
> 						non-negative
>=20
> > +						constraints.
> > +						</para>
> > +					</glossdef>
> > +				</glossentry>
> > +				<glossentry>
> > +					<glossterm>Thermal Sensors</glossterm>
> > +					<glossdef>
> > +						<para>Thermal sensors provide
> > +						temperature sensing capabilities
> > +						on thermal zones. Typical
> > +						devices are I2C ADC converters
> > +						and bandgaps. These are nodes
> > +						providing temperature data to
> > +						thermal zones. Thermal sensor
> > +						devices may control one or more
> > +						internal sensors.
> > +						</para>
> > +					</glossdef>
> > +				</glossentry>
> > +				<glossentry>
> > +					<glossterm>Trips Points</glossterm>
>=20
> 					           Trip Points
>=20
> > +					<glossdef>
> > +						<para>The trip node describes a
> > +						point in the temperature domain
> > +						in which the system takes an
> > +						action. This item describes just
> > +						the point, not the action. Trip
> > +						points are represented as
> > +						temperature in miliCelsius. The
> > +						current abstraction covers for
> > +						non negative temperatures.
>=20
> 						non-negative
>=20
> > +						</para>
> > +					</glossdef>
> > +				</glossentry>
> > +				<glossentry>
> > +					<glossterm>Thermal Governor</glossterm>
> > +					<glossdef>
> > +						<para>Thermal Governors
> > +						represent a policy to manage the
> > +						thermal zone device temperature.
> > +						The governor targets to keep
> > +						temperature in an acceptable
> > +						range which correlates to the
> > +						power budget, while maximizing
> > +						the performance. Governors can
> > +						be implemented in Kernel Space
> > +						or in User Space.
> > +						</para>
> > +					</glossdef>
> > +				</glossentry>
> > +				<glossentry>
> > +					<glossterm>Thermal Cooling Device</glossterm>
> > +					<glossdef>
> > +						<para>Cooling devices provide
> > +						control on power dissipation.
> > +						There are essentially two ways
> > +						to provide control on power
> > +						dissipation. First is by means
> > +						of regulating device
> > +						performance, which is known as
> > +						passive cooling. A typical
> > +						passive cooling is a CPU that
> > +						has dynamic voltage and
> > +						frequency scaling (DVFS), and
> > +						uses lower frequencies as
> > +						cooling states. Second is by
> > +						means of activating devices in
> > +						order to remove the dissipated
> > +						heat, which is known as active
> > +						cooling, e.g. regulating fan
> > +						speeds. In both cases, cooling
> > +						devices shall have a way to
> > +						determine the state of cooling
> > +						in which the device is.
> > +				</para>
> > +					</glossdef>
> > +				</glossentry>
> > +				<glossentry>
> > +					<glossterm>Cooling State</glossterm>
> > +					<glossdef>
> > +						<para>Any cooling device has a
> > +						range of cooling states (i.e.
> > +						different levels of heat
> > +						dissipation). For example a
> > +						fan's cooling states correspond
> > +						to the different fan speeds
> > +						possible. Cooling states are
> > +						referred to by single unsigned
> > +						integers, where larger numbers
> > +						mean greater heat dissipation.
> > +						The precise set of cooling
> > +						states associated with a device
> > +						(as referred to be the
> > +						cooling-min-state and
> > +						cooling-max-state properties)
> > +						should be defined in a
> > +						particular device's binding.
> > +						</para>
> > +					</glossdef>
> > +				</glossentry>
> > +			</glossary>
> > +		</sect1>
> > +	</chapter>
> >  </book>
> >=20
>=20
>=20
> --=20
> ~Randy


Fixing all the above in next version.

Thanks,

Eduardo Valentin

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU4gpAAAoJEMLUO4d9pOJWI7wH/2mpi0VCnKetHW4lHTsVUZtL
zJAR7VaXH8LqmDDClurZXdFAXr+OCrG85EN4z3cN8q8xO+3O05KJnBTL2S1ruMTL
rNunr+H9NcPa+ZBBBY6nNs7oUSGoZ9tMyj67Uv9dZ5UjHCoGQQMlTUPnRdAaG/eN
9JDbe3N+dfOWyacNLWUpxyXyTfnNGBB+X5GGqlPlXV7GHeK5Mv0X0JXkhbIMt+hI
gIhoVZ5GbgXp2aPliPqgEM/FtlDwz/8F+EuCsN+aro+DKJPlNjo3cbSrnA7Uwx+0
WAE6vBtjI5MXEFF8SvryFIZmlmpkS6bUKjbX/3WmPeCIvG1mTGqWCOrymycl4kY=
=DIWj
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
