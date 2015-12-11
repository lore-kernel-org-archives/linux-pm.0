From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 8/8] arm64: add sysfs cpu_capacity attribute
Date: Fri, 11 Dec 2015 17:54:45 +0000
Message-ID: <20151211175445.GR5727@sirena.org.uk>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-9-git-send-email-juri.lelli@arm.com>
 <566988E8.3010308@arm.com>
 <20151210155940.GN5727@sirena.org.uk>
 <20151210180159.GF14571@e106622-lin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xHTUIiWqaPwZ9IpM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151210180159.GF14571@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org


--xHTUIiWqaPwZ9IpM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2015 at 06:01:59PM +0000, Juri Lelli wrote:
> On 10/12/15 15:59, Mark Brown wrote:
> > On Thu, Dec 10, 2015 at 02:15:04PM +0000, Dietmar Eggemann wrote:
> > > On 23/11/15 14:28, Juri Lelli wrote:

> > > > The new attribute shows up as:

> > > >  /sys/devices/system/cpu/cpu*/cpu_capacity

> > > This sysfs interface is not really needed for arm or arm64. People can
> > > build the dt blob if they want to change the values. Less code to carry
> > > ... Let's focus on the core functionality, which is parsing cpu capacity
> > > from dt file to task scheduler for heterogeneous systems.

> > That does make the tuning process much more cumbersome - users have to
> > rebuild and reboot to tweak the numbers rather than just tweaking the
> > numbers and rerunning the benchmark (which seems like something people
> > would want to automate).

> IMHO, this is not a tuning interface. It is an alternative interface,
> w.r.t. DTs, that we could use to provide default capacity values to the
> kernel. I'm proposing both here as they make both sense to me. Then we
> might dedice for which one to go (or if we need some other way) or to
> keep both for flexibility.

Kind of repeating what I said in the other mail but I'd say that any
interface which provides a mechanism for setting a magic number that
influences system performance is providing tuning.  It's hard to see how
else to describe it to be honest.

--xHTUIiWqaPwZ9IpM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWaw3lAAoJECTWi3JdVIfQ3C8H/RzxQ/C/u1Vcmbwg6IvS0Emp
g7UNshd1XpZI4sQW3ke9SD7k6f+IFiHuOyjuxjnat7Mgo1Vr/OVNEKVSt1cQvZPy
O5OmeIKF2NsMAhDmETeUwqAH9AuVMXYn3soMNJSdaaFrrMR0Gw/y5J3iXnbHJFmZ
ghWevuswglatAySYBtox+C8ClLStpYK7y+BYceENdOWo4z6kPG8hXGM70tGaLV7p
f6CcGeXP0DwqOLQfhEb/HQHkeIouSSKwBi+dvsfL9xiqhr+UFBDeyagsJOs0Bo7b
Oeqsj2djVcRyyH0GnGFndXOXLCRFtdDrMsRUmQKTWe0R4rFS1uwKxidT4iPmP9k=
=BYmU
-----END PGP SIGNATURE-----

--xHTUIiWqaPwZ9IpM--
