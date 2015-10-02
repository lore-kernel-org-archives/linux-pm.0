From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Fri, 2 Oct 2015 17:47:43 +0100
Message-ID: <20151002164743.GR12635@sirena.org.uk>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
 <20151001174308.GL12635@sirena.org.uk>
 <20151001175849.GH4469@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5xr6Gr0irOxp3+3c"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35817 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbbJBQsZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2015 12:48:25 -0400
Content-Disposition: inline
In-Reply-To: <20151001175849.GH4469@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org


--5xr6Gr0irOxp3+3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2015 at 12:58:49PM -0500, Felipe Balbi wrote:
> On Thu, Oct 01, 2015 at 06:43:08PM +0100, Mark Brown wrote:
> > On Thu, Oct 01, 2015 at 12:29:32PM -0500, Felipe Balbi wrote:

> > > Frankly, I wanted all of this to be decided in userland with the
> > > kernel just providing notification and basic safety checks (we don't
> > > want to allow a bogus userspace daemon frying anybody's devices).

> > What's the advantage of pushing this to userspace?  By the time we
> > provide enough discoverability to enable userspace to configure itself
> > it seems like we'd have enough information to do the job anyway.


> you're going to be dealing with a setup where each vendor does one thing
> differently. Some will have it all in the SoC part of a single IP (dwc3 c=
an be
> configured that way), some will push it out to companion IC, some might e=
ven use
> some mostly discrete setup and so on...

Right, and that was exactly what this was supposed to be all about when
I was discussing this originally with Baolin (who's on holiday until
sometime next week BTW, hence me answering).

> We're gonna be dealing with a decision that involves information from mul=
tiple
> subsystems (USB, regulator, hwmon, power supply to name a few).

Sure, that was part of the idea here - provide a central point
representing the logical port where we can aggregate all the information
we get in and distribute it to consumers. =20

> We tried doing it all in the kernel back in N800, N810 and N900/N9 days a=
nd it's
> just plain difficult. To make matters worse, N900 had two USB PHYs, one f=
or
> actual runtime use and another just for detecting the charger type on the=
 other
> end.

Can you elaborate on what the difficulties are and how punting to
userspace helps?  If anything I'd expect punting to userspace to make
things more difficult, if nothing else it means we need to get whatever
userspace component deployed in all relevant userspace stacks with
appropriate configuration in order to do things. =20

We do punt a lot of configuration to userspace for audio because there
are substantial device specific policy elements in the configuration and
it's a far from painless experience getting the code and configuration
deployed where people need it, definitely a not great for users.

> On top of all that, we still need to figure out what to do when a particu=
lar
> configuration gets chosen, and what to do when the bus goes into the diff=
erent
> suspend levels.

> It's going to be a lot of policy getting added to the kernel. On top of a=
ll
> that, when Type C and power delivery is finally a thing, there will an en=
tire
> new stack for USB C commands (using the Type C CC pins or modulated on VB=
US for
> legacy connectors) which we will have to add to the kernel. And different
> devices will support different charging profiles (there are at least 6 of=
 those,
> IIRC).

Yes, USB C was part of the thinking with starting this work - it's going
to make ensuring that the system is paying attention to limits much more
important.  I think there's two things here.  One is working out how the
system is glued together and the other thing is working out what to do
with that system. =20

I think that where we can do it the bit where work out how the various
components are connected and aggregate their functionality together is
definitely a kernel job.  It means that userspace doesn't need to worry
about implementation details of the particular system and instead gets a
consistent, standard view of the device (in this case a USB port and how
much power we can draw from it).

For the policy stuff we do want to have userspace be able to control
things but we need to think about how to do that - for example does the
entire flow need to be in userspace, or can we just expose settings
which userspace can manage?

> With all these different things going on, it's best to do what e.g. NFC f=
olks
> did. Just a small set of hooks in the kernel, but actual implementation d=
one by
> a userspace daemon. This makes it even easier for middleware development =
since
> we can provide a higher level API for middleware to talk to the charging =
daemon.

I'm not sure that the NFC model is working well for everyone - it's OK
if you happen to be running Android but if you aren't you're often left
sitting there working out what to do with an Android HAL.  We can do the
middleware thing without going quite that far, we do already have power
management daemons in userspace even on desktop (GNOME has upowerd for
example).

> Another benefit is that this charging daemon can also give hints to power
> management policy that e.g. we're charging at 10W or 100W and we can e.g.=
 switch
> to performance governor safely even though battery is rather low.

We definitely want userspace to be able to see the current state, even
if it just passes it straight on to the user it's a common part of UIs
on both desktop and mobile operating systems.

> Anyway, there's really a lot that needs to happen and shuving it all in t=
he
> kernel is, IMHO, the wrong decision. I would be much happier with minimal=
 safety
> requirements in the kernel and let a userspace daemon (which we should ce=
rtainly
> provide a reference implementation) figure out what to do. This might be =
better
> for things like Chromebooks and Android phones too which might make compl=
etely
> different decisions given a certain charging profile.

Saying we don't want to have absolutely everything in kernel space
doesn't mean we should have nothing at all there, doing that seems like
going too far in the other direction.

--5xr6Gr0irOxp3+3c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDrUuAAoJECTWi3JdVIfQjv0H/Rkkn21V3ZdCYb5BUGWXPEsv
cJ4kJxJMSHTI3mVh3Q09OLfMqu+U8VXQ3Oq1MgFQRdmdeaRPblDhZ9xBYWPRk3Tc
EvfYVWCgyk7dm6BoCE9gCWxDfNgZOpGWffRyUgDdbh4XPg0OfMWOT9GI4BYzg9sd
/o2XFKwtQiFuku6cFcXfh8fpzz0OUBP6myG7vxBxTpQAqQnhp0khuKqapcKMALyJ
NzhUSXu/G8oS0EcuZmJmBuHGEj9MQJl3iMoSyKDLZvjrv2I1A3usjnVEViAvYBsp
2sKK+xBxNZBP9CTUQZ9omf/oeqneAtMiG6J9DoD2mzlvR0IGyDheY5Oa42eiO6o=
=X7lp
-----END PGP SIGNATURE-----

--5xr6Gr0irOxp3+3c--
