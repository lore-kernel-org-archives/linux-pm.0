From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change
 notification
Date: Wed, 20 Jun 2018 14:25:07 +0100
Message-ID: <20180620132507.GE6242@sirena.org.uk>
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
 <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
 <2523505.Jaak4fIuPm@aspire.rjw.lan>
 <20180620103558.GA6242@sirena.org.uk>
 <CAJZ5v0ju3F7qWxMUDuCyWBzFQGyrmxVo90yytFbKnCmENvRuew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ju3F7qWxMUDuCyWBzFQGyrmxVo90yytFbKnCmENvRuew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 20, 2018 at 02:15:38PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 20, 2018 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:

> > The flip side of that is that either suspend and resume or poweroff are
> > broken for userspace unless they know about this magic sysfs file which
> > isn't great either.

> But to me that isn't that much different from an RTC wake alarm, say.

> Enabling it to wake up the system in general isn't sufficient, you
> also need to actually set the alarm using a different interface.

It seems more like hardware breakage we're trying to fix than a feature
- it's not like it's adding something we didn't have already (like
setting a time in an alarm where the alarm is an additional thing), more
just trying to execute on an existing user interface successfully.  I
can see that there's a case that it doesn't map very well onto the
standard interfaces so perhaps we have to add something on the side as
the hardware is just too horrible to fit in with the standard interfaces
and we have to do that.

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsqVbMACgkQJNaLcl1U
h9A/8wf/edSKCvLJfA8FPCcWaXKtd7YTc71TCr1jz7RBfueoY8ZUUIo4igRRyPuu
uec0o3k/XlxOHFyoEu/BWzRkQlkDAjWB7te8TxEuMmgVsQ2qxh0fZnCzvi7I75an
94HqrYQiMJula4JgZckA6qc0E2lKMGnIdcwcACaHd598CqNU3EXg/3PaO+1xF+rt
oRiBzprQ08xkv3NV9YxYtl63K7s4QctQ4+90WlZv4R1GNTmLCVOU1QvY8dbtTPtn
1vchVgmbdLsNpQ1A54xehaesFfrPTzOWzpkSIrxZAhZC3KX564gRDehiDgRfCANf
apyvr5dp1gK2UstjWXV1VoaRG1p4VA==
=4PTh
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
