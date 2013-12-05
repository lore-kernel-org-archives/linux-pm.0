From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: enable ARM drivers on arm64
Date: Thu, 5 Dec 2013 18:16:06 +0000
Message-ID: <20131205181606.GY29268@sirena.org.uk>
References: <1386202994-30784-1-git-send-email-robherring2@gmail.com>
 <1386202994-30784-2-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4646470604206560882=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386202994-30784-2-git-send-email-robherring2@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============4646470604206560882==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQ6PUHtvLgXN2OhJ"
Content-Disposition: inline


--yQ6PUHtvLgXN2OhJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2013 at 06:23:13PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>=20
> Enable cpufreq and power kconfig menus on arm64 along with arm cpufreq
> drivers. The power menu is needed for OPP support. At least on Calxeda
> systems, the same cpufreq driver is used for arm and arm64 based
> systems.

If this needs any revisions (I'd be surprised but...) can you please
keep me on the CCs?  I intend to pull this into LSK if that's OK since I
was about to do roughly the same thing for it and upstream the result.

--yQ6PUHtvLgXN2OhJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSoMLjAAoJELSic+t+oim9VRMP/3QLSg70vtKAWvb9Fcbqn5xy
GRwsUuIwlcGT0YZ/H/9RhTvikNkjkU1qu2twLM9XLA7ptA8lof/ATzWLe2EBXQHr
EpfD65IZU10LtiCNXfecfF5DU6HP7XhQt7taqYofMCdny1U6s/xNYZGBqxWSieWl
TKzCM/bUCyODE4SIE8YsEutnzszReXFZoQKOmIOsKfqzJzizH7cPiFR7mBDwYxlU
f2KhH5bleAwPx21JHfRruB1R6pQz1cHRav0F2bnWQDLmjXtiijTVLse8iiIWfOd9
g6Xe+suVknKoOCz1j/eckgqy8mrnm8dfPmqr8ftpvjGnSHIoeJ621YdhEUTL+96Q
MsSzbaoj1kQF8hUyeulNVtTQj4NrNL+ccZNFK7OEenMICeuJQJehQSYC1MThGRt9
AH/8Z3MGYk2rALEfPZuHDUNXeB4Fhc4TiWdeMrIYJHQePDmzbSxsoYth1J92yNjh
4lKv2eSwfPmn6xNfcKma218fqSOzYYnY7D25ILoOr9U34psqbUanollla8mlvd2H
CQjJ7PjclACDAdx+XXxqaSQ1oF/0chO0gD8qfPFdN10fQu9ocGsSwgcNLTEyllgh
U32IXRy4+I9cklyS5JK8rprOFy5OUJAwVmAxqfUlMvidrWYal0Pdh4FdH+XDmuX0
fpFSbeqHbh0QNeh556fA
=dXXF
-----END PGP SIGNATURE-----

--yQ6PUHtvLgXN2OhJ--


--===============4646470604206560882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4646470604206560882==--
