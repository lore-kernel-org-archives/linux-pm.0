From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during	suspend-resume
Date: Mon, 23 Feb 2009 07:52:59 -0800
Message-ID: <1235404380.4455.13.camel__18135.3003289134$1235404709$gmane$org@johannes.local>
References: <200902221837.49396.rjw@sisk.pl>
	<200902230048.33635.rjw@sisk.pl> <20090223083645.GA9582@elte.hu>
	<200902231229.58743.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5868596265315533637=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902231229.58743.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============5868596265315533637==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WLDOjTgt0bnjj6pp3LN6"


--=-WLDOjTgt0bnjj6pp3LN6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-02-23 at 12:29 +0100, Rafael J. Wysocki wrote:

> > > +     arch_suspend_disable_irqs();
> > > +     BUG_ON(!irqs_disabled());
> >=20
> > Please. We just disabled all devices - a BUG_ON() is a very=20
> > counter-productive thing to do here - chances are the user will=20
> > never see anything but a hang. So please turn this into a nice=20
> > WARN_ONCE().
>=20
> This is just moving code.  Also, the BUG_ON() can only affect powerpc and=
 it's
> there on purpose AFAICS (Johannes?).  Anyway, changing that would be a se=
parate
> patch.

It can affect any platform that overrides the weak symbol
arch_suspend_disable_irqs(), and I think that if you're writing this
low-level code you better have a way to debug. As such, I don't think it
needs changing, because you can only ever see that while implementing
arch_suspend_disable_irqs(). OTOH, since it can only trigger then, a
WARN_ON is probably fine as well since you'll be getting your machine
into inconsistent states all the time while implementing this ;)

johannes

--=-WLDOjTgt0bnjj6pp3LN6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJosZZAAoJEKVg1VMiehFY0vsP/1ZYOLqdIHKoeabMGn7grIrI
PMxZQ3n5o+NgxU15eSrJllCMh4Dy5srkMYZgddt5Fz+TT7QPiGPlK60MNkhUl66/
Nj3jJpgqTyjfLm4Da2VWpNRTbJ+sKIW9qX+vcabkU77CpH5PwQ4LinrkgSfO2LGV
49rPoFJ5lcoj2xXL52i98gdeqesbSlt+EbFl0WcKtDi8m28sGoch4IprnbYEOVLD
pB79qK8BhV3W9d8RVX1JmxycvvxkaaGW7Zp1nn9xQC8DPrH+uyR5NApt/SZvbeYs
KIknVn8tJOYWSpaK7DbAAmmI/fLfSowXO9oTbwOSe4z4vKypej0FTPVHmjMa2C/x
f6zWIOJFhtppk1FtV/4459Rp6WBT/7P4DmOC4ge2rorHvi9ZAd699kdty/J/wY9g
I+lh+BSSV6i6EsKYGg9Be3iivVEIfpJMmIdCctaeTRXzcJpPLSDTiClsB2OYbPxO
HLf91avps4G9d3bCWIsbMAwBIdGxhsrj9NBXy7cx/C3cDACb5Bx7caA7OVB62ySB
O27qSnm6mHbfk2b8/oqsxJpyvPehHbTPCsD2i7g1rvaObNXFv+BWxMMvVjxAtlim
kGF2VE2wxNws5GR0HqzXZn4KO5D4HLnCNOPZ/oKLbsb3uYrkKbnINtIiSmVooll0
dtLkxohp5ukFcHF024DT
=X+WV
-----END PGP SIGNATURE-----

--=-WLDOjTgt0bnjj6pp3LN6--


--===============5868596265315533637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5868596265315533637==--
