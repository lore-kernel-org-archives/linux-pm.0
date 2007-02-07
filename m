From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 10/10] powermac: fix G5-cpufreq for cpu
	on/offline
Date: Wed, 07 Feb 2007 13:21:23 +0100
Message-ID: <1170850883.6798.27.camel@johannes.berg>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185838.837935000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0230190523=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070205185838.837935000@sipsolutions.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: cpufreq list <cpufreq@lists.linux.org.uk>, linux-pm@lists.osdl.org, Jacob Shin <jacob.shin@amd.com>, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org


--===============0230190523==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2ybR2Rnv/PhBoQo+DTyJ"


--=-2ybR2Rnv/PhBoQo+DTyJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:

> The original code here is wrong, it applies "previous" knowledge.
> The way the cpufreq core is designed is that the policy for the
> secondary CPU that comes online says that it must in fact not
> use this policy but use the same as the other CPUs that are
> listed, which in fact is CPU#0.

> Not tested yet but from what Jacob said this should work.

Works great, will resend with proper signed-off-by etc. Thanks again
Jacob for explaining how it should work.

johannes

--=-2ybR2Rnv/PhBoQo+DTyJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFycRD/ETPhpq3jKURAsELAJ9iHqYVXP4qp1dc+mWyph5ivJoN5gCeMLQV
VtOydeOUEsZGrl/bNdg+vP4=
=MKhI
-----END PGP SIGNATURE-----

--=-2ybR2Rnv/PhBoQo+DTyJ--


--===============0230190523==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0230190523==--
