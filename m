From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Thu, 10 Dec 2015 15:30:04 +0000
Message-ID: <20151210153004.GA26758@sirena.org.uk>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151124020631.GA15165@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2015 at 08:06:31PM -0600, Rob Herring wrote:

> I think you need something absolute and probably per MHz (like=20
> dynamic-power-coefficient property). Perhaps the IPC (instructions per=20
> clock) value?

> In other words, I want to see these numbers have a defined method=20
> of determining them and don't want to see random values from every=20
> vendor. ARM, Ltd. says core X has a value of Y would be good enough for=
=20
> me. Vendor X's A57 having a value of 2 and Vendor Y's A57 having a=20
> value of 1024 is not what I want to see. Of course things like cache=20
> sizes can vary the performance, but is a baseline value good enough?=20

> However, no vendor will want to publish their values if these are=20
> absolute values relative to other vendors.

> If you expect these to need frequent tuning, then don't put them in DT.

I agree strongly.  Putting what are essentially tuning numbers for the
system into the ABI is going to lead us into a mess long term since if
we change anything related to the performance of the system the numbers
may become invalid and we've no real way of recovering sensible
information.

There is of course also the issue where people are getting the numbers
=66rom in the first place - were the numbers picked for some particular
use case or to optimise some particular benchmark, what other conditions
existed at the time (cpufreq setup for example), what tuning goals did
the people picking the numbers have and do any of those things
correspond to what a given user wants?  If detailed tuning the numbers
for specific systems matters much will we get competing users patching
the in kernel DTs over and over, and what do we do about ACPI systems?
Having an absolute definition doesn't really help with this since the
concrete effect DT authors see is that these are tuning numbers.

It would be better to have the DT describe concrete physical properties
of the system which we can then map onto numbers we like, that way if we
get better information in future or just decide that completely
different metrics are appropriate for tuning we can just do that without
having to worry about translating the old metrics into new ones.  We can
then expose the tuning knobs to userspace for override if that's needed.
If doing system specific tuning on vertically integrated systems really
is terribly important it's not going to matter too much where the tuning
is but we also have to consider more general purpose systems.

We're not going to get out of having to pick numbers at some point,
pushing them into DT doesn't get us out of that but it does make the
situation harder to manage long term and makes the performance for the
general user less relaible.  It's also just more work all round,
everyone doing the DT for a SoC is going to have to do some combination
of cargo culting or repeating the callibration.

I remember Peter remarking at one of the LPC discussions of this idea
that there had been some bad experiences with getting numbers from=20
firmware on other systems.

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWaZp7AAoJECTWi3JdVIfQfJMIAIZMYd+LY0Mk6ts6qB+ndE4D
VCthS4iAzrD80rwQzywyz7BdoAzRbQzFqrvyMVB6IM2llEgzmtNCrbyHiL2RH5jH
3x9ToK6hBI6OLC55hrp4KRJuDqce63Y9LBIcd3UwxTLIp5WXpQhVH5nlh0GLpErB
5SuqnE0eBIzgwG8PjA16pNsJWNUYjufrxsM96iSzW/TtzVouXxOxAhigYd0zdJpT
6yGqsY9Nsfj9OpbiRG/JAY7tKucg26UCSQ893X/yTVsG9a3bWZdYIy62DZpF8rGl
P3t9675UNhJG9WtzgaogNudsYeAso0ObV+XIDE8rE+zEe6E/QNacDTktUY9gGWM=
=8hFr
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
