From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] cpufreq: Fix runtime warnings on systems with shared
 core clocks
Date: Tue, 2 Jul 2013 10:48:31 +0100
Message-ID: <20130702094831.GA27646@sirena.org.uk>
References: <1372724227-17209-1-git-send-email-broonie@kernel.org>
 <CAKohponeEC=CGzJhgCY+Cvwna6YkkRBkANjYSAqP9jf8qfJ2yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hx7WYMxL4WLyMs5Q"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohponeEC=CGzJhgCY+Cvwna6YkkRBkANjYSAqP9jf8qfJ2yA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--Hx7WYMxL4WLyMs5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 10:45:02AM +0530, Viresh Kumar wrote:

> Please see if below fixes it for you. Use attached patch for testing it.

This doesn't apply terribly easily, the patch is corrupt and appears to
be based on something other than what's in -next so neither git am nor
patch can figure out how to apply it.

--Hx7WYMxL4WLyMs5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0qHsAAoJELSic+t+oim9mx4P/00oI+3B+73+RUczVuinysgo
BtDFD4/fTJWnFm9WOz6ofHfNoPJfE3m1GNQvcCjjoMyQypyv/bGxPwyrXrrYk1xZ
0lIzE5/TJeO/rn012Vwwa6L4B6YQAauDXwMHhszKjrz9XCxXAD070RgoUqF7+Lou
TmLn7Hjlcdlpddbxs+/y7MeVvwMKSa3rR+MlsU7wnyFJGOPYyONV10qFXi7ChgSg
mjGExfyTkCBkrlCUlrX7DNHt43d7prImW0Wfbe1Y04OAL43npv3jB71jQghH8OLe
p82EmIbjzOP7gENevu6oAhTa6hMpC04x2aGlG/aaq0p2Fd3Wg0qxExw3zLZ+Y3y5
7YCEvxKMjUONKAk8S4C1QKwqTWJGd0vJR6iOdTsoBqVL4Aap09LhoAV11HH4aF+g
gtAOGjX0cXlNyIGBJniWVQ4fk4M5W4lT9ywtRmxczfpuYCqjgfAaS+oPULis7nn0
YT55iEIHezSlcgGkveyZ3Hsaa7CvwWyn20b2/PTD+uvSk8M9OceFOXSjzebSsUlU
qo6+koZkERPuJAJVzhjMVm6pc1JjIdq87iP+M/TzjED0MIgHs2Eqvi0yhM5yCRVO
vyw+AgdLeZXyU5o4RtnVZc93Pys28pVBrNWDmt0cvdr3B3/NYsfTrpAFnnQSUK3J
ATrpGkK397umeeMbLYs6
=Gu6i
-----END PGP SIGNATURE-----

--Hx7WYMxL4WLyMs5Q--
