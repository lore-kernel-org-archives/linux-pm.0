From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] cpufreq: Fix runtime warnings on systems with shared
 core clocks
Date: Tue, 2 Jul 2013 12:15:30 +0100
Message-ID: <20130702111530.GK27646@sirena.org.uk>
References: <1372724227-17209-1-git-send-email-broonie@kernel.org>
 <CAKohponeEC=CGzJhgCY+Cvwna6YkkRBkANjYSAqP9jf8qfJ2yA@mail.gmail.com>
 <20130702094831.GA27646@sirena.org.uk>
 <CAKohpom0NOymffysneOcygFHT9QTMgPA+BVKmoZTMg9bUpaedw@mail.gmail.com>
 <20130702102910.GG27646@sirena.org.uk>
 <CAKohponf+bQ3KowmbBhAq9+MGMa8C_6RQvvDvkOiSHkir+jO_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRGszZcfTfZOqL0U"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohponf+bQ3KowmbBhAq9+MGMa8C_6RQvvDvkOiSHkir+jO_g@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--GRGszZcfTfZOqL0U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 04:02:32PM +0530, Viresh Kumar wrote:
> On 2 July 2013 15:59, Mark Brown <broonie@kernel.org> wrote:

> > If you're forced to do stuff like that then don't include the patch in
> > the body of the e-mail, it just makes everything worse.  Not only is the
> > copy in the body of the e-mail broken but there's now two copies so
> > tools like git am get even more upset as they may potentially see some
> > of the hunks twice.

> I do it so that people can review it. I still believe its important.

If your patch is sent as a text/plain attachment most mail clients will
tend to do the right thing with replies, at least the good ones.  Or
just figure out a VPN or something to get round the firewall issues,
mobile broadband is often a good technique if there's no carry
restrictions (usually phones are allowed...).

--GRGszZcfTfZOqL0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0rZPAAoJELSic+t+oim9mgoP/j9NMx/P7ff820N/Fgeld6CA
23wY8t+z+K5PIl8d4cv7bhip5ARjJaGupdfesX5ciTjBV5h38fSy/u9Dt4S3Wv4v
sBpvUvahUX8WKHPToRfAHL9pB22d2AlU0vrI+GflfanOZeQ3Msst6SoPvFGs0EUS
oXtCoGbE3DcboydB5nPiI3BMepMeYBDsrPjz6nHYyiSiDKr1fJpUSr+uLzm8lBpG
kC5aywedoOmatJKRiaxtBFxudgZo6JcC9eZId+GtZyT0PKYbMJ/zEaRSCTexQK/r
GWPZBXqlMbw9/5f0GUE89RBOoIFqBWr3fxRpeGs2nmip8gfR7BfjrbYTfme2LhWX
a9QOISYaQAYy1IaTMabaRhi5fOWLWLikgH1rf9ieoOOUmuoEhoo6d3lO/nNo57Ix
a7LBKdliAYDXJHkCxLhcQ5RoBAnhMC/cKBQnSR6DJhOYW1QUc063Pi7WHyukz10I
mYYP4xRoo9mnuGhVZwU5nx85ZjS3sjtdNov6YPf6K4F3l4u5+MH067DkXy8Cnj+e
Ih+8fs+0z5zYxEpO3vD1JQ/Dh6H9kjey5t9KQUSU2r9uFlFBqXdjB9uT5agJ5i77
3PepN+wQkPhmzV/NGN3a/kTcDtHnZJq4egO9s1iJVujOoMH+uAz/J0w1RVE9EVow
128IpGBKDw7Pmaz9hSUk
=BCa1
-----END PGP SIGNATURE-----

--GRGszZcfTfZOqL0U--
