From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.26-rc0
Date: Thu, 1 May 2008 10:26:41 +1000
Message-ID: <20080501102641.b7970395.sfr__44793.2916730226$1209601824$gmane$org@canb.auug.org.au>
References: <200804301420.11696.lenb@kernel.org>
	<alpine.LFD.1.10.0804301153100.2980@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0796788195741225661=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0804301153100.2980@woody.linux-foundation.org>
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
To: postmaster@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============0796788195741225661==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__1_May_2008_10_26_41_+1000_cousAr.6IDldLgrM"

--Signature=_Thu__1_May_2008_10_26_41_+1000_cousAr.6IDldLgrM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2008 11:55:57 -0700 (PDT) Linus Torvalds <torvalds@linux-fou=
ndation.org> wrote:
>
> There were some (smaller) rejects in drivers/misc/intel_menlow.c due to=20
> two different versions of the same patch from Julia Lawall (again, the=20
> other came through Andrew), and I picked the one from Andrew because it=20
> had the later date. But again, you should double-check.

I reported these to Len yesterday at 14:13 (+1000) but hera and zeus1
rejected this email with "451 4.3.2 Please try again later" until 4:41
(+1000) this morning ... Does anyone know why?

In fact, even then the logs said:

May  1 04:41:17 chilli postfix/qmgr[25076]: BFB2F36800C: from=3D<sfr@canb.a=
uug.org
.au>, size=3D1742, nrcpt=3D2 (queue active)
May  1 04:41:19 chilli postfix/smtp[29167]: BFB2F36800C: host zeus1.kernel.=
org[2
04.152.191.4] said: 451 4.3.2 Please try again later (in reply to MAIL FROM=
 comm
and)
May  1 04:41:21 chilli postfix/smtp[29167]: BFB2F36800C: to=3D<lenb@kernel.=
org>, r
elay=3Dzeus2.kernel.org[204.152.191.36]:25, delay=3D52057, delays=3D52053/0=
.03/3.2/0.6
8, dsn=3D2.0.0, status=3Dsent (250 2.0.0 m3UIfK9Z027193 Message accepted fo=
r deliver
y)

And, as you can see, it was eventually delivered via zeus2.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__1_May_2008_10_26_41_+1000_cousAr.6IDldLgrM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIGQ5FTgG2atn1QN8RAt7zAKCFhhz/J3BagUT8CeK9WEIueXPoDACdFr1Y
nXSAv+PA3DIfBr5lBerSv1E=
=jKhE
-----END PGP SIGNATURE-----

--Signature=_Thu__1_May_2008_10_26_41_+1000_cousAr.6IDldLgrM--

--===============0796788195741225661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0796788195741225661==--
