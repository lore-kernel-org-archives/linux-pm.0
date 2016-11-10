From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / wakeirq: report wakeup events in dedicated wake-IRQs
Date: Thu, 10 Nov 2016 21:57:20 +0100
Message-ID: <20161110205720.GB31728@amd>
References: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34595 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755623AbcKJU5W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Nov 2016 15:57:22 -0500
Content-Disposition: inline
In-Reply-To: <1478801227-65527-1-git-send-email-briannorris@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2016-11-10 10:07:07, Brian Norris wrote:
> It's important that user space can figure out what device woke the
> system from suspend -- e.g., for debugging, or for implementing
> conditional wake behavior. Dedicated wakeup IRQs don't currently do
> that.
>=20
> Let's report the event (pm_wakeup_event()) and also allow drivers to
> synchronize with these events in their resume path (hence, disable_irq()
> instead of disable_irq_nosync()).
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>

How is this supposed to be presented to userspace?

There was big flamewar about that some time ago, and "what woke up the
system" is pretty much meaningless, and certainly unavailable on most
PC class hardware. Good question to ask is "what wakeup events
happened while the userspace was not available"....

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgk3zAACgkQMOfwapXb+vJLtgCgqkWn9+hDafq83lWpYQBTv8d+
Sn4An3CTnaAEcX5HucYo9wJ19VusCIlW
=3B0P
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
