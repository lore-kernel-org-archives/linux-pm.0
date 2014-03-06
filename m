From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/8] spi: pl022: Let runtime PM callbacks be available
 for CONFIG_PM
Date: Thu, 6 Mar 2014 12:45:32 +0800
Message-ID: <20140306044532.GG13126@sirena.org.uk>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
 <1393671371-2398-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hteyPcSjfKKLJzLF"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56626 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbaCFEpn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Mar 2014 23:45:43 -0500
Content-Disposition: inline
In-Reply-To: <1393671371-2398-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>


--hteyPcSjfKKLJzLF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 11:56:06AM +0100, Ulf Hansson wrote:
> Convert to the SET_PM_RUNTIME_PM macro while defining the runtime PM
> callbacks. This means the callbacks becomes available for both
> CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME, which is needed to handle the
> combinations of these scenarios.

Applied, thanks.

--hteyPcSjfKKLJzLF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJTF/1pAAoJELSic+t+oim9m0UP9A2q2ZZRLpRfbbcniZNSNZhH
qlxIw64nscKZM3gFHtBZu38lvgvYbpbDcwneWQgjLJ3GrgGU8FIf0rJ03rclMRQL
xMwsf0JBSjeV2WTf/S6xUEe8HnM8bW4fYI765OZcY3UybaAtYKy2zKQazzGl3klW
X5ziog1wDZv5M7Kve/VxrO4DQ+x/3/7p2qZrt2NWxSgQ4gEyNGrwuleaaLxhNU8C
cDvppEot1HpWRI271aK4OcnCCjAg9h4zMi4bZL1VW7SoT5UIJbzZ1+FvgrcR7vzk
Jhvafw/hcRkMdkDvKoKyGU1v6IoEAWkTtYcJI7kJrMAcBKEFTrVCi3o0XHecAMLl
o/J8BzlNnt8euQ9kJjXbujlEQ6PMUBz6kguYN0bvNwQUYEr5Uy5DHjnws3MJFuju
r28hfpli2TYD0OCIJhSDvcdMYkHYT/wO8t5ZaeNlbNeTJBfIm5aVAzWPvJMSDhx9
5m3dg7rvhKeSxB7g/VCHaXvBNwlSkshG53RZla306ijR69wB1QLUqTwAAJjeQnyI
s8LKcs3QfAX5kVZz93VFMWveAqSmXub9UxhwKP3JVb8nif+eNxGDvKSrrFpcGRXZ
wc4Yk5Nr8kyT4pNgQKIcRmeiII3ZEJkoZlCuud302lQcQw+2DLHtOx2Atp06jOG7
8+TUZUr5J2W7zfmWDbA=
=vVIk
-----END PGP SIGNATURE-----

--hteyPcSjfKKLJzLF--
