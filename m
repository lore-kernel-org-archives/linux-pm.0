From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH/RFC 4/5] regulator: bd9571mwv: Add support for backup mode
Date: Wed, 18 Oct 2017 12:24:19 +0100
Message-ID: <20171018112419.3eqz34epcshxas3f@sirena.co.uk>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-5-git-send-email-geert+renesas@glider.be>
 <20171018110238.hjv7huiievhr5obs@sirena.co.uk>
 <CAMuHMdU2PpiSftwnqHjb8uFpu5Huw7hpedk4cSzDY-eeKio_Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5uw2cqilggug5c63"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU2PpiSftwnqHjb8uFpu5Huw7hpedk4cSzDY-eeKio_Dw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--5uw2cqilggug5c63
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 18, 2017 at 01:19:08PM +0200, Geert Uytterhoeven wrote:
> On Wed, Oct 18, 2017 at 1:02 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Oct 10, 2017 at 05:26:17PM +0200, Geert Uytterhoeven wrote:

> >> Backup mode is not enabled automatically, as e.g. on Renesas
> >> Salvator-X(S) boards enabling backup mode changes the role of the ACC
> >> switch from a power switch to a wake-up switch.  Hence enabling it
> >> prevents the board from being powered off using the ACC switch, which
> >> may confuse the user.

> > This sounds an awful lot like the standard power/wakeup, though the
> > power change is a bit unexpected there.  I'm also wondering if it makes
> > sense to just only enable the wakeup mode when suspending which
> > preserves the power off functionality while also keeping the wakeup
> > support.

> The ACC switch is not a momentary switch (push button), but a toggle
> switch with two positions.
> Hence you cannot enable wakeup mode while suspending, as the proper
> system suspend/resume procedure is:
>   1. Enable backup mode in the PMIC,
>   2. Switch ACC off (no-op as backup mode has been enabled),
>   3. Suspend to RAM (PSCI suspend) => system suspends,
>   4. Switch ACC on => system wakes up.
> If you would combine steps 1 and 3, you can no longer do step 2 in between.

> Yes, it's complicated :-(

I'm confused, I thought this was a physical switch but that's talking
about this as something software controlled (at least in step 2)?

--5uw2cqilggug5c63
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnnOeIACgkQJNaLcl1U
h9C+oAf/bOA4C3TKqZqzSKRnw7KU07BvidI2B1x5dfQkmlmEB8SxvByc96cjDFS6
eCGXj1qm/Dfm5U5k/Qz+PupsUCYf2jqCwRfhmk3sq6pv9BerBhvqdn+7foM0x/Hn
Z11skUTWtspiYUX2fQhtn/rSMmfrqW1Ikys2fBTMt4wo/InEjBwcEzkF40G2O4a2
bowsm0pQ9/xAhCZc/UCtJUHcnAWiTpAcrtqvTAEXuqAwyS41ZaIFuRZBG1mTVhlD
8hGCpTEOrZKpFcRIds7CkAG6bmnd2DGFCu+rRqAtHB/2tOdBViuwiUm8I7MbO+7v
TtG7rYmOrAMwM1h/KRjoH3Q96ywfLw==
=y76h
-----END PGP SIGNATURE-----

--5uw2cqilggug5c63--
