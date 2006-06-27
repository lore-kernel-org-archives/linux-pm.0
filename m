From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: suspend to RAM (embedded) ppc?
Date: Tue, 27 Jun 2006 20:07:15 +0200
Message-ID: <1151431635.4289.2.camel@localhost>
References: <Pine.LNX.4.60.0606241957470.22786@poirot.grange>
	<17565.58599.858812.278800@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0606252034260.9893@poirot.grange>
	<17567.32285.641865.387583@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.60.0606262040230.5678@poirot.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0017070322=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.60.0606262040230.5678@poirot.grange>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0017070322==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-lXtvGXTRqnJpb6Ag6G0W"


--=-lXtvGXTRqnJpb6Ag6G0W
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-06-26 at 20:44 +0200, Guennadi Liakhovetski wrote:

> Thanks Johannes and Paul! would never find myself... Looking further.=20
> Expect more questions:-)

You may want to hold off working on this a bit and first ask BenH for
his old patches that converted the pmu stuff to the generic thing but
needed invasive generic stuff first.

On the other hand, you can also just implement it for your board :)

johannes

--=-lXtvGXTRqnJpb6Ag6G0W
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARKFz0aVg1VMiehFYAQLWmBAArIhzqarweB8R6gvRQO2mj0FxJqptEk9J
2eacJayveIdRpTAN2aWtepXJXO9amndmeLlYuqG8e16VfTiUXo76JF4aVSBltrbw
yBZFxGQmf1knpCX5X+B5z8ETAeuiL3bNlCEuPHfBLmwxsvKh2AhLE7IbUX81ZYSy
w+WsohGbXK/kxF6BC9PfytYLRBHqjJAbFzBromg/B4yWlfjKA/NsG0e2v/DlSGh6
lvPRXVUzDMgesFnAeOIAzcvlcAaywDE8Ozi4BfmkoOdxA3QND+gwSmD6pozQQzsW
kiS2NsdsqmN+Qicr/dQglGREiErjjqRgOjPdKXbTr163+oB3Qm3UoZ1FgyVbWt5M
n0o0PropJOfHZ4Dxq9bOqETBW4+0l+SoAEd1xIBU6pH5A6lQ0146Z8LFalwJEiZk
u9YJ8fsh4ev1kY2DYYMo7f9tqIDx22oWdyMq3+wDRJ112Tx0p/rg3UYAmiiEst6m
et/T8a5sE7S9ZimtpYN3FRCTKD/gkXDrzVJLYMi7FV6RTu7Oywou6xv04WnEHsQa
Gsj/9HqIdwyOEK+kJbxrYlKG4BvYApw5uSi94IOvD0GoTyq/mdjV+l11k4VtXaxX
3EK02eLuC8JLLACsKC4zKD+1pveUTIyBYzOPgHExjHhl4PmgmE2oNvQ+QFcqbssE
+Q6DmbdfnNQ=
=cAP3
-----END PGP SIGNATURE-----

--=-lXtvGXTRqnJpb6Ag6G0W--


--===============0017070322==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0017070322==--
