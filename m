From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/18] staging: typec: fusb302: Add support for
 fcs,vbus-regulator-name device-property
Date: Mon, 7 Aug 2017 12:10:54 +0100
Message-ID: <20170807111054.4lp5rgc5vpnsmhim@sirena.org.uk>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-11-hdegoede@redhat.com>
 <2d04e538-0594-0073-939e-feb6c1a66cdf@roeck-us.net>
 <85c668d5-c6f0-a94c-4dd5-1b425cdff339@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4vndrefazbw6nphr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <85c668d5-c6f0-a94c-4dd5-1b425cdff339@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org


--4vndrefazbw6nphr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 06, 2017 at 05:44:36PM +0200, Hans de Goede wrote:
> On 06-08-17 16:30, Guenter Roeck wrote:
> > On 08/06/2017 05:35 AM, Hans de Goede wrote:

> > > On ACPI platforms, there are no phandles and we need to get the vbus by a
> > > system wide unique name. Add support for a new "fcs,vbus-regulator-name"
> > > device-property which ACPI platform code can set to pass the name.

> > Another property to be documented and approved.

> Again this is for kernel internal use on non-dt platforms only, so documenting
> it in the devicetree bindings is not necessary.

However it *is* for use on ACPI platforms and is impacting power
management (which is something ACPI definitely models) so should be
being documented in an ASWG spec.  We don't want Linux systems to start
breaking the ACPI power management model with uncontrolled extensions,
it's fine to add new bindings for things where there's just no ACPI
specification at all but power management isn't one of those areas.

> TL;DR: It seems that on x86, at least for existing devices where we cannot
> control the ACPI tables that getting things by name is the thing to do.

The idiomatic thing to do on an ACPI system at present appears to be to
have a big DMI quirk table somewhere that instantiates the regulators
and mappings required for them based on the machine's DMI data.  Or if
it's a self contained PCI device or something with both regulator and
consumer do it as part of the subfunction instantiation there.

--4vndrefazbw6nphr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmISr0ACgkQJNaLcl1U
h9CGZAf/TFk1ihl5o/RspGSbmW1K/G41OstaZTmKWAUbfmCh4dvIH8I7wHnWoPbT
8v6WW5M4yQsd0GogUJ7qVlXh9fQ+8Xt3Wsm0CYwhkbrz7RFNX0Mb5M7DRvPBwzUv
vXwtkqDAlcMJAJNyXAm1zjojTbNFDvjiE+cN8qb/5gESiVkVLVWjhvuhO3rlZqf5
fTq971o4zJEDtLmc/ddaANeUmJy1y4XjrkM9O4NGl7YeeJGxQ11EuRtMuE/NahLe
905YZcntUIpBoAMCNQALrhAu1F/1bexGuRb7hiehDT7veKC5eIbrrZvu5AHpKw5R
gOHqSsI+3ZldCIwB8DflWnV396mwqQ==
=feVa
-----END PGP SIGNATURE-----

--4vndrefazbw6nphr--
