From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Mon, 5 Oct 2015 17:18:33 +0100
Message-ID: <20151005161833.GZ12635@sirena.org.uk>
References: <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
 <20151001174308.GL12635@sirena.org.uk>
 <20151001175849.GH4469@saruman.tx.rr.com>
 <20151002164743.GR12635@sirena.org.uk>
 <20151002172311.GI5552@saruman.tx.rr.com>
 <20151002184909.GC12635@sirena.org.uk>
 <20151002191125.GC5552@saruman.tx.rr.com>
 <20151004225506.GD12635@sirena.org.uk>
 <20151005151511.GA18784@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v+f2vxqcSo8kvURS"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45453 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbbJEQUP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 12:20:15 -0400
Content-Disposition: inline
In-Reply-To: <20151005151511.GA18784@saruman.tx.rr.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org


--v+f2vxqcSo8kvURS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2015 at 10:15:11AM -0500, Felipe Balbi wrote:
> On Sun, Oct 04, 2015 at 11:55:06PM +0100, Mark Brown wrote:

> > The trouble is getting traction on adoption.  Vendors have a habit of doing
> > things like finding problems and rather than reporting them deciding that the
> > open source solution isn't great and going and writing their own thing
> > (especially when they're in stealth mode) rather than talking to anyone.
> > Sometimes we manage to avoid that but it can be challenging, and often we only
> > even hear about the new thing after it's shipping and there's a lot of inertia
> > behind changing it.  The kernel ABIs tend to be a lot sticker than userspace
> > things here.

> but this is not a solid enough argument to push anything into the kernel.

To my mind it is a concern when considering design - it's not the only
consideration certainly but it should influence if or how we split
things.

> > > the same thing will happen with Type-C and power delivery. There won't be tuning
> > > to taste, of course :-) But there will be "very different ideas what what you
> > > want to do with" your charging methodology.

> > Are those very different things about the use cases ("don't bother with
> > high speed data, get all the power you can" or whatever) or are they
> > about the details of the board?

> I'm pretty sure there will be interesting designs in the market. I'm pretty sure
> there will be type-C systems which won't support USB 3.1 for example, even
> though they'll support USB Power Delivery in its entirety.

That's sounding like generic USB stuff to me.

> > Yes, definitely - my experience both in terms of watching how people
> > like handset vendors often work internally and in terms of getting
> > things adopted is that it's a lot easier if you can have one component
> > you need to update to handle new hardware rather than multiple ones that
> > need to be upgraded for things that are purely board differences.

> IMO, just because you have it in the kernel, it doesn't mean it'll be
> adopted. Look at pm_runtime, for example; it's a very nice API and, yet, not
> used by Android (or has that changed ?)

That's always been a bit of a myth - most Android systems use runtime PM
extensively when they're running, the discussion is really about the
edge case where you're idling the system.  The Android suspend behaviour
is about the system idle case and is as much about providing a simple
way to go into an idle state, especially bearing in mind that they have
apps installed from the app store there, as anything else.  It's the
making sure things are idle part of things that's different.

> > > okay, this is a fair point :-) I just don't see, as of now at least, how we can
> > > get to that in a way that's somewhat future-proof. It seems like we will
> > > add more and more notifications until we can't maintain this anymore.

> > So we need to look at the new/upcoming USB specs and understand the

> not upcoming, it's already out there.

I assume there's ongoing work on further revisions to the spec though?

> > Yup, which is a really cool feature and keeps us all employed too! :)
> > This is one reason for attaching things to the USB stack, right now it
> > does a limited negotiation but in future like you say there's more and
> > more features coming.

> keep in mind that the same stack used to change a charging current, will also be
> used to tell the other end to mux those lines differently.

Sure.

> > Does the problem not get easier if we break it down to just the charger
> > elements and realise that the USB C modes are going to have a lot more
> > policy in them?

> the thing with USB C is that it's not only for negotiating a charging power
> (with power delivery you're not necessarily tied to 5V, btw), that very stack
> will also be used to change to other alternate modes, and those can be anything:
> Thunderbolt, PCIe, DisplayPort, etc.

Surely these features have sufficient orthogonality to allow us to split
things up and deal with some of the problems while providing spaces for
future work?

--v+f2vxqcSo8kvURS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEqLVAAoJECTWi3JdVIfQiEsH/3n6GEXd1uPzyLEkcdOA7uwf
qBo32/CxZX0yO+gyLRzt9pE/Om3nPEr6KY69UkAy+qRyRofuD2tvuu4hzbNJ6v6c
w7XeNB4ETMlrYiXLigL57sGAel+PYiEJuOTNdsoD+51NYnuCGTy3wNHFaE6Q1HL2
TOaVqmNjT3sMX6/etdelZlZzYzN1dRAzP2B0xAQBw/rFQ2fJpBlWCNKtDYdZwKDy
IsnFIgqyO3+IlSLJZxihlfX9Ns7uAZH2dhnoJcK+IXJnKK+CVyrJo+3zZiCGE7wB
vSZJMaFyBPTp2FpZGykL2RQPrFGBZWXHrCDP0/BMap2knqhisMSeOzsLkH7bgGw=
=JoyZ
-----END PGP SIGNATURE-----

--v+f2vxqcSo8kvURS--
