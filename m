From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 0/8] PM / Sleep / Runtime: Fixup some driver's system
 suspend
Date: Thu, 6 Mar 2014 12:43:44 +0800
Message-ID: <20140306044344.GF13126@sirena.org.uk>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
 <7021741.2WcVMr4q95@vostro.rjw.lan>
 <20140305061647.GS13126@sirena.org.uk>
 <2429070.qaGktSfi2s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fXTucb2auvC9mqz5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56611 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbaCFEoH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Mar 2014 23:44:07 -0500
Content-Disposition: inline
In-Reply-To: <2429070.qaGktSfi2s@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>


--fXTucb2auvC9mqz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 02:02:24PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, March 05, 2014 02:16:47 PM Mark Brown wrote:

> > Is there a tag we can pull to get those patches?  The driver changes
> > depend on the new API introduced in patch 2.

> They are in the pm-drivers branch of linux-pm.git.

I've pulled them now, thanks.

--fXTucb2auvC9mqz5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTF/z8AAoJELSic+t+oim9gbkP/1L2EoTOJvC3pIrd2S10M0FH
s9g2Jri/8+VJY/EaOkcWCII9KjU8Q5APwlgr0zGlqVxBFCpNKh0AW9HhTLv+w3ej
/cgQqCKn9QpYBbwl2xMbet6PTJM8VshlPSelJDk1jZ4cnUszWbFNLCL9cZRaeLap
sggDkjXmrz3eiA+xkqj/QfGxrtjNWKKS+Knvk2f7/bmqqVthD3sl0FJ8nXnkDuP5
DiND+CzsuDsqMuBmblTF/dsz8rVG2K4UplHqZVG2UKnI4YK/JPbMWxCW51BWfYC8
lYj50YWlg54hZ34hcMyWu5Xfk1N40r9C6nREwmALoLnrzRMpjqE1t2DbX9H/Rsve
Z3epxsiRrpfdNqRdhBvelJUnImqknUbYVw1/62WBGgwHWtfO0FuI4jBtZETgOidJ
z8dmd7np+BXyssuEfhTb6g8PFE/MK+zsg0Zh0eXkOIBFs16MxVHbeY+hVp0KD/39
IGvBs/ij2mv5cD3wfKxxpvwOJiigIWc4B2Ph+ti1pMJ3dHs1hURJ+1oY6cuQ/f+E
OEuQSLv2mmJdbAZgaYtM7aXCr90kxNePnTT7vtluu1C6t0U/40+q1/Vvd2TzM3Y+
9K5p9m2EkS45uwNrLk2/5bJeWyJhdygHXY3iWYFau7SHDtC5MzcbmtonhR5tuVY9
Q/dD5RfJsWhMZzGcXbPJ
=8Y3i
-----END PGP SIGNATURE-----

--fXTucb2auvC9mqz5--
