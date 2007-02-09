From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 13/12] mpic: add affinity callback for IPI
	"chip"
Date: Fri, 09 Feb 2007 16:41:08 +0100
Message-ID: <1171035668.4520.12.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<1170940611.4385.56.camel@johannes.berg>
	<1170969252.2620.335.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0244821416=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1170969252.2620.335.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============0244821416==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zPaFEoyswYyTO6SYPiBy"


--=-zPaFEoyswYyTO6SYPiBy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-02-09 at 08:14 +1100, Benjamin Herrenschmidt wrote:
>=20
> > This patch adds a dummy affinity callback for the IPI "chip" to avoid
> > getting a warning ("Cannot set affinity for irq 251") when taking a
> > CPU offline via sysfs or during suspend.
>=20
> Wouldn't be a better option to make sure they have IRQF_PERCPU set and
> that we don't do the affinity thing on interrupts with that flag when=20
> offlining a CPU ?

Hmm. Yeah, something like that could be possible. Looking at
fixup_irqs() there is a test:

                if (irq_desc[irq].status & IRQ_PER_CPU)
                        continue;

but I'd have to dig what else this means.

johannes

--=-zPaFEoyswYyTO6SYPiBy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFzJYU/ETPhpq3jKURAl39AKCx9da7MJvKlrWL0p6Gg3y0iEHjpwCfdUzy
3bHIMm/M8KBGpHlfhTyvnd4=
=rR9r
-----END PGP SIGNATURE-----

--=-zPaFEoyswYyTO6SYPiBy--


--===============0244821416==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0244821416==--
