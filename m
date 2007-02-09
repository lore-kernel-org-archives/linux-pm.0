From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
Date: Fri, 09 Feb 2007 16:39:21 +0100
Message-ID: <1171035561.4520.10.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
	<1170941321.4385.61.camel@johannes.berg>
	<17867.40281.175422.116673@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1106131547=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <17867.40281.175422.116673@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============1106131547==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LmFdauLa3tZI+xVHu6Mi"


--=-LmFdauLa3tZI+xVHu6Mi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-02-09 at 08:59 +1100, Paul Mackerras wrote:
> Johannes Berg writes:
>=20
> > +#ifdef CONFIG_CPU_HOTPLUG
> > +	/* if we have fake CPU hotplug just to support suspend to disk
> > +	 * and can't really turn off a CPU, it may be taking timer interrupts
> > +	 * even when it is dead. Avoid doing anything in that case so global
> > +	 * state is not modified for and by a CPU that doesn't really exist. =
*/
> > +	if (__get_cpu_var(cpu_state) =3D=3D CPU_DEAD)
> > +		return;
> > +#endif
>=20
> Are you sure this is necessary?  IIRC, the if (!cpu_is_offline(cpu)) a
> little bit further down is there to cope with this exact situation.

Yes, but we still do irq_enter() and as it happens with HZ=3D1000 we
almost always kick the CPU out while it's inbetween irq_enter() and
irq_exit().

You said:

> And cpu hotplug already works on G4 SMP powermacs, where we can't
> physically remove the cpu either - we just put it into sleep mode with
> interrupts disabled, which is what we would be doing on a G5 powermac
> also.

and then Benh said:

> I've always had doubts about wether SLEEP with EE off was legal and
> wouldn't actually still go out of sleep when getting an interrupt... In
> that case, at least on CPUs where the DEC acts "level" triggered, we
> need to at least reset the DEC to some sane value.

I probably should've mentioned that. I tried going into NAP with EE off
and that seemed to get me a busy loop where the CPU wasn't even napping
at all. I could have done something wrong, of course.

johannes

--=-LmFdauLa3tZI+xVHu6Mi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFzJWp/ETPhpq3jKURAg0xAJ9Kk6WxqmnWpc8cmfmjmRpM2ZpyigCgnb/f
nqwCKAj5rhDcdCEJEXN4vjo=
=vJhb
-----END PGP SIGNATURE-----

--=-LmFdauLa3tZI+xVHu6Mi--


--===============1106131547==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1106131547==--
