From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/9] PM / Domains: Add generic OF-based PM domain
 look-up
Date: Tue, 9 Sep 2014 12:40:51 +0100
Message-ID: <20140909114051.GT2601@sirena.org.uk>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
 <3105400.7vSnq2rA6s@vostro.rjw.lan>
 <CAMuHMdURbp8a0Ps2sZUZn7UHcWXZvRgS-4ubk1r=wGgXZ1PHmA@mail.gmail.com>
 <8273189.CFBBe805uk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FJ0JV+AOCbvjFtNn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:58845 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbaIILmM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 07:42:12 -0400
Content-Disposition: inline
In-Reply-To: <8273189.CFBBe805uk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@co>


--FJ0JV+AOCbvjFtNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 08, 2014 at 11:26:49PM +0200, Rafael J. Wysocki wrote:

> The s-o-b is more of a gray area, but again it is supposed to be possible
> to verify which it won't be if it bounces.

That's always going to be an issue with signoffs - people's addresses
can and do go bad at any point.

> Also note that this is not Tomasz who is submitting this patch today, but Ulf
> who doesn't even work for Samsung as far as I know.

> So I'd suggest using "Tomasz Figa <tomasz.figa@gmail.com>" as a "From:", remove
> his s-o-b entirely (and using the Ulf's one only) and add something like that
> to the changelog:

> "This patch was originally submitted by Tomasz Figa when he was employed
>  by Samsung.

>  Link: <URL-of-the-original-submission>"

> This way Samsung will get the recognition and there won't be bouncing addresses
> in tags etc.

Stripping people's signoffs seems more worrying than a bouncing address
TBH - it's more alarming to see a commit log that's missing an author
signoff than finding an address that doesn't work, I'd probably just
drop any submissions that did that.  If you're really worried updating
the signoff address or adding a comment with the new one is probably
better.

--FJ0JV+AOCbvjFtNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDudDAAoJECTWi3JdVIfQKJsH/ic/Tx9s9L3Z1VcmSf6jiEjw
M0NHsOiIxPxSaOSQvkpOgLbwzE7r6yvyifB93ZKJSRakqKv9RgoGpPXe/uR4Qrgs
fDtIFrTceFdTbnP6eb9/jMNdrz3ssyju8+TLQz/gq97BQzCr85/EJS2FVvb3BP11
PqUNfTeuRhafIU1QYGMSNGbqUUpFhJEZE0i1fFEZ9ervtRDFUXdxO5DjHamlzJqz
3PHfwX5XUHW+P1K3Ys/rKghSd7JMSK5N8EvsbWBjqn/9MJIkBZtcI1VbJJf9QaXW
jF79Ce1Jb63OctXoUEvusjeOiKY5J8I2rg5YMtVuxfliYyfr66CO9rxWzPXIe3k=
=KlCu
-----END PGP SIGNATURE-----

--FJ0JV+AOCbvjFtNn--
