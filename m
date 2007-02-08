From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
Date: Thu, 08 Feb 2007 16:38:19 +0100
Message-ID: <1170949099.4385.67.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170941321.4385.61.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1827734272=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1170941321.4385.61.camel@johannes.berg>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============1827734272==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-A/EJZGzzs6gtQSLRxE8G"


--=-A/EJZGzzs6gtQSLRxE8G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-02-08 at 14:28 +0100, Johannes Berg wrote:
>=20
> +#ifdef CONFIG_CPU_HOTPLUG
> +       /* if we have fake CPU hotplug just to support suspend to disk
> +        * and can't really turn off a CPU, it may be taking timer interr=
upts
> +        * even when it is dead. Avoid doing anything in that case so glo=
bal
> +        * state is not modified for and by a CPU that doesn't really exi=
st. */
> +       if (__get_cpu_var(cpu_state) =3D=3D CPU_DEAD)
> +               return;
> +#endif

Michael Buesch suggested to add an unlikely() there which I'll do for
the next round.

johannes

--=-A/EJZGzzs6gtQSLRxE8G
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFy0Pr/ETPhpq3jKURAlUXAJsF+/uwDThXLNwaCFJAiEjWfFoxfwCglNRf
2v5yc0jCi+ZqI2beGp+MyAs=
=PK2k
-----END PGP SIGNATURE-----

--=-A/EJZGzzs6gtQSLRxE8G--


--===============1827734272==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1827734272==--
