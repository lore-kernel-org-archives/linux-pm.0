From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH 1/2] swsusp: preserve boot-time printk
	output after resume
Date: Fri, 27 Apr 2007 14:39:58 +0200
Message-ID: <1177677599.6024.7.camel@johannes.berg>
References: <Pine.LNX.4.64.0704271522070.11149@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2889807022824380358=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0704271522070.11149@sbz-30.cs.Helsinki.FI>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


--===============2889807022824380358==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vF7OwVluZrzNk5+j7Wi5"


--=-vF7OwVluZrzNk5+j7Wi5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 15:25 +0300, Pekka J Enberg wrote:
> =20
> +#ifdef CONFIG_PRINTK_NOSAVE
> +#define POSS_NOSAVE __nosavedata

Interestingly I stumbled across this this morning. What's the purpose of
the POSS naming? I can't make sense of that.

johannes

--=-vF7OwVluZrzNk5+j7Wi5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMe8e/ETPhpq3jKURAka1AKCzLY3C1mcU0ilKT4TaPGGhKTHtggCgi/mS
w4x3d6WLEF1lkPASM/hkml8=
=hstH
-----END PGP SIGNATURE-----

--=-vF7OwVluZrzNk5+j7Wi5--


--===============2889807022824380358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2889807022824380358==--
