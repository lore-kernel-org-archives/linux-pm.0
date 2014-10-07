From: Mark Brown <broonie@kernel.org>
Subject: Re: Potential cpufreq backports for v3.10 LTS
Date: Tue, 7 Oct 2014 21:45:05 +0100
Message-ID: <20141007204505.GL4609@sirena.org.uk>
References: <20141007114844.GT4609@sirena.org.uk>
 <20141007164643.GA3748@kroah.com>
 <20141007170800.GL4609@sirena.org.uk>
 <20141007200458.GA12028@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ARfeEU66NqbnwsW"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141007200458.GA12028@kroah.com>
Sender: cpufreq-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Xiaoguang Chen <chenxg@marvell.com>, Stratos Karafotis <stratosk@semaphore.gr>, Andreas Schwab <schwab@linux-m68k.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Amit Kucheria <amit.kucheria@linaro.org>, stable@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--7ARfeEU66NqbnwsW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 01:04:58PM -0700, Greg Kroah-Hartman wrote:
> On Tue, Oct 07, 2014 at 06:08:00PM +0100, Mark Brown wrote:

> > > >  - 59a6342203a7a cpufreq: Fix governor start/stop race condition

> > > >    This looks like a straight race condition fix.

> > > That is not a commit id in Linus's tree :(

> > Interesting, I was able to cherry-pick it...  looks like the upstream
> > version is 95731eb.  In any case at roughly the same time you sent your
> > mail it's been drawn to my attention off-list that this was subsequently
> > reverted so please ignore this one.  The others should be fine though.

> Ok, I've queued the others up now.

Actually I thinkoed here, as I said in reply to the stable mail the
problematic patch was "19c763031acb8 cpufreq: serialize calls to
__cpufreq_governor()" which was reverted in "56d07db cpufreq: Remove
temporary fix for race between CPU hotplug and sysfs-writes".  The above
commit ID (95731eb) should be good.

Sorry about the confusion here.

--7ARfeEU66NqbnwsW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNFDQAAoJECTWi3JdVIfQAIsH/1UwKgGNblfPb1ZXzUbk2ysM
gxPVaRFl46kw8/bKapuUV07N2L0GXO6DyLobcSUtS31Obp55UX+CueODPoL5u4dM
z3ODFo2u5Dyal1HrFOz+qpGhovWNlaEPIBXwX7tvYpHQC6sQ925urNhE1ZzTglYB
Tlzw/rEDhs9jWK7s+RCXqV78Krtaic61jq+QxqBh/snfm/9+XkNIdY58SUHVdDkD
83SIJxBuJHFIlADqsFQ8pSZYeRagpie/FF1F/aoXwv3YgZ3kU7H1SSXYYO9DTyQ6
MehjmCEEJ90FiinJ9mzmrY40P7GR9Hzy48GiYOrY/8f1VP0OmguqC6mPF3iVNAs=
=fXvQ
-----END PGP SIGNATURE-----

--7ARfeEU66NqbnwsW--
