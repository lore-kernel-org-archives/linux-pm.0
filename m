From: Mark Brown <broonie@kernel.org>
Subject: Re: Potential cpufreq backports for v3.10 LTS
Date: Tue, 7 Oct 2014 23:50:06 +0100
Message-ID: <20141007225006.GM4609@sirena.org.uk>
References: <20141007114844.GT4609@sirena.org.uk>
 <20141007164643.GA3748@kroah.com>
 <20141007170800.GL4609@sirena.org.uk>
 <20141007200458.GA12028@kroah.com>
 <20141007204505.GL4609@sirena.org.uk>
 <20141007215807.GA29188@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="43A0Eiy/SPt9g0V5"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141007215807.GA29188@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Xiaoguang Chen <chenxg@marvell.com>, Stratos Karafotis <stratosk@semaphore.gr>, Andreas Schwab <schwab@linux-m68k.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Amit Kucheria <amit.kucheria@linaro.org>, stable@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--43A0Eiy/SPt9g0V5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 02:58:07PM -0700, Greg Kroah-Hartman wrote:
> On Tue, Oct 07, 2014 at 09:45:05PM +0100, Mark Brown wrote:

> > Actually I thinkoed here, as I said in reply to the stable mail the
> > problematic patch was "19c763031acb8 cpufreq: serialize calls to
> > __cpufreq_governor()" which was reverted in "56d07db cpufreq: Remove
> > temporary fix for race between CPU hotplug and sysfs-writes".  The above
> > commit ID (95731eb) should be good.

> > Sorry about the confusion here.

> Ok, I'm still confused.  I've applied 3 patches to the 3.10-stable
> queue, in this order:

To the best of my ability to assess:

> 	19c763031acb831a5ab9c1a701b7fedda073eb3f	cpufreq: serialize calls to __cpufreq_governor()

This one is bad.

> 	a857c0b9e24e39fe5be82451b65377795f9538d8	cpufreq: Fix wrong time unit conversion
> 	dfa5bb622555d9da0df21b50f46ebdeef390041b	cpufreq: ondemand: Change the calculation of target frequency

These two should be good.

> Are those correct?  Is there anything else I need to apply?

> Note, 95731eb does not apply to 3.10-stable as it is already in there,
> it showed up in 3.10.37.

Ah, good - I think whatever made my cut'n'paste of the commit ID go
wrong will have been responsible for making my search for it fail.

--43A0Eiy/SPt9g0V5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNG4eAAoJECTWi3JdVIfQ2QIIAIMp+DedDHS+WY3/Gi9pG9n6
hPLV6M38gyuLECIWMyZFSFP3kpYh2kNzoA7TbVLLzbLlCfjFCRgLFO6WQs1ZfR86
CxB/Ez/Q3x5912rT+uCjjyFkyk6Dtf1PxMmWB1wgtddFXG0UlKVA3DTPq79oHPe/
YEBZRRx1n3aE7BWLkCXoTCGrNZYvZB78YetCzrCw+2Rcc0gAW/+4hKxL0H049zrZ
KpJLOdiZVVBWoRlxlYv8AsltmWR7FiqSqFEMUzNs9nyo0BpxitGp9cB5zeSFBQhd
rM+m/f4GXs4siHzH+ZEhPH+MTrkcXwIJfBI1RKYntYr8E1/Nrk68rczYL7bFLGc=
=w367
-----END PGP SIGNATURE-----

--43A0Eiy/SPt9g0V5--
