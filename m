From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Sun, 4 Oct 2015 23:55:06 +0100
Message-ID: <20151004225506.GD12635@sirena.org.uk>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
 <20151001174308.GL12635@sirena.org.uk>
 <20151001175849.GH4469@saruman.tx.rr.com>
 <20151002164743.GR12635@sirena.org.uk>
 <20151002172311.GI5552@saruman.tx.rr.com>
 <20151002184909.GC12635@sirena.org.uk>
 <20151002191125.GC5552@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FSGgxso9lj1d9SFz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151002191125.GC5552@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org
List-Id: linux-pm@vger.kernel.org


--FSGgxso9lj1d9SFz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 02, 2015 at 02:11:25PM -0500, Felipe Balbi wrote:
> On Fri, Oct 02, 2015 at 07:49:09PM +0100, Mark Brown wrote:
> > On Fri, Oct 02, 2015 at 12:23:11PM -0500, Felipe Balbi wrote:

> > > > Things more difficult, if nothing else it means we need to get whatever
> > > > userspace component deployed in all relevant userspace stacks with
> > > > appropriate configuration in order to do things.

> > > but that will be a thing for the kernel too. We will have to deploy this new
> > > kernel component in all relevant stacks with appropriate configuration in order
> > > to do things :-) No changes there.

> > Sure, but it's one project which is developed entirely in the open -
> > that's a lot more manageable.

> We can have a fully open source userland daemon too. Much like systemd, bluez,
> neard, and many, many others. Why wouldn't that be a thing ?

The trouble is getting traction on adoption.  Vendors have a habit of
doing things like finding problems and rather than reporting them
deciding that the open source solution isn't great and going and writing
their own thing (especially when they're in stealth mode) rather than
talking to anyone.  Sometimes we manage to avoid that but it can be
challenging, and often we only even hear about the new thing after it's
shipping and there's a lot of inertia behind changing it.  The kernel
ABIs tend to be a lot sticker than userspace things here.

> Similar applies to power delivery charging profile themselves. Not all profiles
> are mandatory. Some are optional and that will be completely device/board
> specific. How an OEM implements that in the PCB is also completely
> board-specific :-) Some might have a dumb IC hardcoding some messages, some
> might have something largely more flexible.

Right, and what I was trying to say was that it seems like the kernel
ought to be worrying about the board specific bits and userspace
worrying about what to do with those bits.

> > The things we've got with audio are a combination of tuning to taste and
> > (even more importantly) very different ideas about what you want to do
> > with an audio subsystem that influence how you set things up in a given
> > use case.

> the same thing will happen with Type-C and power delivery. There won't be tuning
> to taste, of course :-) But there will be "very different ideas what what you
> want to do with" your charging methodology.

Are those very different things about the use cases ("don't bother with
high speed data, get all the power you can" or whatever) or are they
about the details of the board?

> > > Actually, I was thinking about it in a more granular fashion. Kernel exposes a
> > > charger/power_supply, a few regulators, a UDC view and this single userspace
> > > daemon figures out how to tie those together.

> > That sounds worrying - it means that new hardware support needs
> > supporting in every userspace (it seems inevitable that there will be at
> > least some reimplementations because that's fun) which gets old really
> > fast, and every userspace needs to understand every topology.

> very true, but it's also true for a kernel solution.

> It seems like you want it in the kernel because of it being convenient :-)

Yes, definitely - my experience both in terms of watching how people
like handset vendors often work internally and in terms of getting
things adopted is that it's a lot easier if you can have one component
you need to update to handle new hardware rather than multiple ones that
need to be upgraded for things that are purely board differences.

> > > The view here isn't really a USB port, it's just a source of power. But how much
> > > power we can draw from it depends on, possibly, a ton of different chips and
> > > different notifications.

> > Right, yes - it's the power input/output associated with the USB port.
> > The USB port is just the physical thing users can see so it's a good way
> > to label it.  That could mean that we ought to move the aggregation bit
> > into the power supply code of course, but then a lot of the decisions
> > are going to be specific to USB.

> in a sense, yes. But they can happen at a layer which knows nothing (or very
> little) about USB. Here's an example:

> Not everybody follows USB Battery Charging class. Some chargers don't short
> D+/D- to signify they are a wall charger. Some will use different resistance
> values on the ID pin to tell you how much current you can draw from them.

> From a PMIC (or something else) point of view, all it needs is a tiny current
> source and a an ADC, then it reports the ADC value to the upper layer. This
> really doesn't even need to know that it's using an ID pin, or whatever.

This doesn't seem much different to things like the various GPIO to
subsystem X drivers we've got - we already have some for IIO type
things IIRC.

> > How different are the end goals of these designs really going to be
> > though - that's more of the question for me?  Part of what the kernel is
> > doing is hiding implementation details from userspace.  I'd expect
> > userspace to be interested in things like the maximum current allowed in
> > or out in a given mode rather than the details of how that is accomplished.

> okay, this is a fair point :-) I just don't see, as of now at least, how we can
> get to that in a way that's somewhat future-proof. It seems like we will
> add more and more notifications until we can't maintain this anymore.

So we need to look at the new/upcoming USB specs and understand the
problem space, and how much of it we need to worry about right now in
this scope.

> With Type-C there's no port type anymore. What we used to refer as Host/Hub
> Charger, Standard Port, Charging Port, Wall Charger, etc, now becomes a single
> type (let's call it type-c for short) which can provide profiles. These profiles
> are negotiated using that new stack I pointed out above, not by checking
> resistance on data lines or ID pin.

Yup, which is a really cool feature and keeps us all employed too! :)
This is one reason for attaching things to the USB stack, right now it
does a limited negotiation but in future like you say there's more and
more features coming.

> Add to that the fact that the same power delivery pipe (the CC pins) can be used
> to tell the other end of remux the pins to e.g. PCIe, and s**t just hit the fan
> :-)

> In short, whatever we do, needs to consider coping with incoming requests from
> userspace at a minimum because userspace will need control over the port
> alternate modes. I mean, don't get me wrong, these is all uber-cool to me, but
> it'll be a pain to make a flexible/generic solution :-)

That seems to make sense to me - anything the kernel is able to do
autonomously for USB C should probably be pretty dumb.  Older USB
standards are already pretty dumb themselves (although inconsistently
standardised).

> > > The real difficulty here is coming up with an interface which we're agreeing to
> > > supporting for the next 30 years. Whatever that is, as soon as it gets exposed
> > > to userland, we will have to support it.

> > To me that sounds like an argument for hiding things :)

> the problem with hiding, though, is that once something new comes about, it
> might not fit our current abstraction and it might be big PITA to support "old"
> and new systems.

Does the problem not get easier if we break it down to just the charger
elements and realise that the USB C modes are going to have a lot more
policy in them?

> > > And this another reason I think a more granular approach is better, as it allows
> > > us to easily add more pieces as they come along.

> > OTOH it's more work for the system as a whole.

> it's more work outside the kernel, yes. The total amount of work (kernel +
> userspace) will be the same, regardless if you hide it in the kernel or in userspace.

Like I say I'm worried about deployment issues for the split solutions
making things harder than they should be.

--FSGgxso9lj1d9SFz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEa5GAAoJECTWi3JdVIfQW8gH/0Fanp1n53dl5EcOhwJcGVlq
hhq3FNb2fI69DbJsObjV9+fYfZeL5k80oWqOTiG2AiNi+ZCM13loYPWH1IeQ7pha
++AAaa+8yO9fReL4Ov7I6mKP5Z04u023CBjgzL6ZwbgqAl1p9nFjmZncHQSo3vkw
GUqXh5zntC1PvsBoe1WSD7A0HH3VJzAJ/HWMJxHZeumOwwztb5YPNgTvGS98pKoX
+66lK3CxQHGJOHG9sDiW/3zvIXlI3LipprrysYkR1iq/fCa0tM0t+rqgVgd140TT
kq8vjKF8khj9LS+Vzo/TvhH6IVGArE5Wl2iA2rMd4qjeoFCA5Z6B+TNRLjpImo0=
=79Xb
-----END PGP SIGNATURE-----

--FSGgxso9lj1d9SFz--
