From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] cpufreq: Fix runtime warnings on systems with shared
 core clocks
Date: Tue, 2 Jul 2013 11:29:10 +0100
Message-ID: <20130702102910.GG27646@sirena.org.uk>
References: <1372724227-17209-1-git-send-email-broonie@kernel.org>
 <CAKohponeEC=CGzJhgCY+Cvwna6YkkRBkANjYSAqP9jf8qfJ2yA@mail.gmail.com>
 <20130702094831.GA27646@sirena.org.uk>
 <CAKohpom0NOymffysneOcygFHT9QTMgPA+BVKmoZTMg9bUpaedw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xDpVnDuQvJgs1tNg"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpom0NOymffysneOcygFHT9QTMgPA+BVKmoZTMg9bUpaedw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--xDpVnDuQvJgs1tNg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 03:32:34PM +0530, Viresh Kumar wrote:
> On 2 July 2013 15:18, Mark Brown <broonie@kernel.org> wrote:

> > This doesn't apply terribly easily, the patch is corrupt and appears to
> > be based on something other than what's in -next so neither git am nor
> > patch can figure out how to apply it.

> Two things,

> - I rebased my patch now against latest linux-next/master and it applied
>   cleanly.
> - Somehow one of my changes to include/linux/cpufreq.h didn't get commited

> Try attached patch now and it should really work..

That seems to work, yes.

Tested-by: Mark Brown <broonie@linaro.org>

> I am using gmail for replying to mails from office which corrupts mails. And
> I can't use other mail clients from office, firewall issues.

If you're forced to do stuff like that then don't include the patch in
the body of the e-mail, it just makes everything worse.  Not only is the
copy in the body of the e-mail broken but there's now two copies so
tools like git am get even more upset as they may potentially see some
of the hunks twice.

--xDpVnDuQvJgs1tNg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0qtzAAoJELSic+t+oim9dXYP/11MabCOZd6ppKUQwSPluaRJ
nEMICxWO7SRX7XkjADfiv4AUnVAHJgBYymHtOUttrDPFf7HH3pzVVqla7BnEVXgf
aSYRFurUkpYbreUX2l48QBPhKY+fVGs1ONlIMZNg0lxAjk/Fh5rXkcRim23lPs09
VCLGuXd4fR4Yz8U5hdavqPEYeDRIVX5R5hEjezlQIB8kgK+JeKEGJ6/AdGFxY1vj
xsdjBSOmxHhATB4T0PvjAWwMbaiJ3cUvcQSjceJM2VGeHBjdT1qI8Y9EQ8amHSCU
RV0whOnvzG+EVS+hzBAS9dbRtMk448drxubpLiwChJ0vqpiON2uDR4s8WwDjhrOh
Lj6HUkUQzsBeIqo+aBn4UERs8Z7lToFqgnU3/swVTMyWEgYKEUq28t1v0nfGqy+G
0GDERWI7QdkXcEcQFPUCMmKUi10Hg/6bYK+QpxFAfGKvsZkGoo7hloXW973gAnuv
h7txSgt2QDdef+Cr3phVWnj4MQay3T9x1C+9ISwKz5RdHZ6f62E8akMYmNqeBjid
BOVCSpRnzLVqVlFyM5lyj05KdeJ73t9VtmTGFTOEhZjqCcKcBUb6UKpMeeCGWZ8g
mJLfnzkjALuuasZgy5uLeZbjMcCm9DrmShPIxWUaF+G98cI/Vgx2m7x4e8aWQ4nt
BA+qVtJa37w3bMlZpe80
=Z/7c
-----END PGP SIGNATURE-----

--xDpVnDuQvJgs1tNg--
