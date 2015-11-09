From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFD] Functional dependencies between devices
Date: Mon, 09 Nov 2015 22:42:04 +0100
Message-ID: <2017403.WqCaz90jK6@vostro.rjw.lan>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <20151109123202.GC23941@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2963599.pLnXJai3Fn"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151109123202.GC23941@ulmo.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <treding@nvidia.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org


--nextPart2963599.pLnXJai3Fn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, November 09, 2015 01:32:04 PM Thierry Reding wrote:
> On Tue, Oct 27, 2015 at 04:24:14PM +0100, Rafael J. Wysocki wrote:
> [...]
> > There's a question about what if the supplier device is being unbound before
> > the consumer one (for example, as a result of a hotplug event).  My current
> > view on that is that the consumer needs to be force-unbound in that case too,
> > but I guess I may be persuaded otherwise given sufficiently convincing
> > arguments.
> 
> I think this would be a huge step towards making the kernel more robust
> with little driver or subsystem code having to be duplicated. Currently
> most provider/consumer subsystems are fragile in that there isn't proper
> reference counting. Many subsystems will happily allow you to remove any
> of the provider, regardless of whether or not it has consumers. Most of
> the subsystems will make sure that modules can't be unloaded, but beyond
> that won't be able to prevent drivers from being unbound (either when a
> device is unplugged or unbound via sysfs). Even with proper reference
> counting there is no easy way to deal with devices going away (you'd
> need some sort of revoke semantics implemented for all providers, and
> consumers must be able to handle that situation gracefully).
> 
> Implementing a force-unbind policy would make this a whole lot easier.
> Dangling resources will automatically become a thing of the past. The
> downside of course is that force-unbinding consumers may not always be
> the most user-friendly course of action. Consider an SD/MMC slot that
> uses a GPIO as card-detect pin. Unbinding the provider of the GPIO
> would cause the SD/ MMC controller to be unbound, hence unmounting the
> filesystem that it provided. That filesystem might have been the root
> filesystem.

Well, the problem is that device_release_driver() cannot fail, so it
pretty much has to unbind everything that is not going to work after the
driver is unbound from the device.

> We discussed similar use-cases a while back and you proposed making the
> force-unbind policy be two-staged: reject unbind (-EBUSY) if there are
> any consumers, and force-unbind consumers if the provider was forcibly
> unbound (or caused by hot-unplug of the backing device). That sounds
> like a good compromise to me.

That can be done for bus types having device_offline/online() support,
but the number of these is quite limited at this point.

The "offline" operation, as opposed to device_release_driver(), can return
an error code to indicate that the device cannot be taken offline at this
time.  So, if offlining a supplier would require offlining all consumers
of it, that may be made fail in certain situation.  However, that would
require quite a bit of additional structure (and complexity) in pretty
much all bus types, so I wouldn't start with it at least. 

> That said I can also imagine subsystems where a reliable mechanism is in
> place to properly hotplug and -unplug providers. The good thing about
> the functional dependencies mechanism you propose here is that it's an
> optional mechanism that drivers use from ->probe(). Subsystems where a
> better mechanism exists can simply choose to do without functional
> dependencies.

I actually think that those things are at least partly orthogonal.

Thanks,
Rafael

--nextPart2963599.pLnXJai3Fn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJWQRMxAAoJEILEb/54YlRxVR8QAKDf+JKLCot/doeXNZ3R6VBN
1q8g6dlWzBmVfU/gXda75JMTEhWijbqIPBE/dRTk7DPG3s9VUQXyTPFtBNV5OzZd
XKyAovSB0FthBROcAa2yUXlFhXg7qFzUwBKT8Q1vFq1DkB4t2ddEls6slSip/7Uh
FF2QMB2BhW/D6NiqJCKlxWDJgLbL8DWici+eVY96c2N3WfML4ldfDgazFhAadC1F
BpcI4K/K+x/SUaimNHX6nTRSSJExrLB2mqoa9RUFAFSEU/FoSyI97oD/MF7ZrsQT
Y6NolgCoa5KL0qyohkFOEcrzjXZ9ng0OqkQnHg+P2KJu04dQ5eRm7DbYP20EVcjc
tLpxNv8nIysQ9FBpYgP9Hw01ARKS+R+R/BM5H2i78lesBtRbF224MHAHbh9FDl61
0ZBh4OwGfYb0XNzZLMeGLXOgE8HirIadCp8dMJ28//1R+ntiHI5N2rbFnVCOEAws
EtVPFLLb8vJ5lms6dZ/bjhqWmaZ9vON1F2xFAYBk8tISWUEYzsZwAWKVWZVVPacV
fnvAQLHEloDa7GLwi680P8kLA+ndEH74gF2vL0Q0mHy6PUfRKs3OuH7JAAQ50mdb
8Hk/ABkbJ7HQy3KWhuetab6tSMl3pnYcHFDo4RAe+abr1PDP614ndmiYZQ1QQfhs
K1ktgejVDo33WT8yo+OF
=ejBx
-----END PGP SIGNATURE-----

--nextPart2963599.pLnXJai3Fn--
