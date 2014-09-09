From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/9] PM / Domains: Generic OF-based support
Date: Tue, 9 Sep 2014 12:54:46 +0100
Message-ID: <20140909115446.GW2601@sirena.org.uk>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
 <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yZxAaITavNk3ADw/"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410262570-22785-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org


--yZxAaITavNk3ADw/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 01:36:01PM +0200, Ulf Hansson wrote:
> Changes in v4:
> 	- Rebased patch "PM / Domains: Add generic OF-based PM domain look-up" -
> 	  and updated the author and the commit message.
> 	- Adopted review comments for "PM / Domains: Add APIs to attach/detach
> 	  a PM domain for a device".
> 	- Updated author and commit message for "ARM: exynos: Move to generic
> 	  PM domain DT bindings".
> 	- Added some acks and reviewed by tags.
> 	- Started to use the "--in-reply-to" option to git-send-email. It should
> 	  provide the option to show a better diffstat per patch.

Please don't send serieses in reply to earlier versions, it buries
things in the middle of old discussions which can mean they don't get
noticed, especially when you're sending multiple large patch serieses at
the same time.

--yZxAaITavNk3ADw/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDuqGAAoJECTWi3JdVIfQH9sH/3Td7uTj0Fz8dDmg/UngLTCZ
ia57OO1tMIIzMeZBgSOnZI+JjlNo5LAtIqXl02gCpdGWtZKqXbG0dh8BKCwsPI5X
bGA73PSJJpfCLW9qQGthYDeX5p7faY+KumKFu/1AFVKfsG0anciv80Zc4ud7WL5j
f//rRBcJZGGWqup8nqmMMTOb3alvOtpzz+IB9VUPmuU23kvYELkFgjRFTcT8wiVL
3m9T8xoCSdFYwbiqCWRuCjlR4cGgz0M8k43Abe19TBejE8sdJV+YJgChD5tjnFdC
LKjiuQ6/EzeeCcip9n7Nf7V+F/OSlpFO79QR53E4Za9IFoBYOrFIu1ynsTldVzA=
=nYah
-----END PGP SIGNATURE-----

--yZxAaITavNk3ADw/--
