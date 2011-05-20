From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
	ahci_start_engine compliant to AHCI spec"
Date: Fri, 20 May 2011 11:40:20 -0400
Message-ID: <10124.1305906020__6379.32800823382$1305919942$gmane$org@localhost>
References: <201105120025.34531.rjw@sisk.pl> <20633.1305565337@localhost>
	<BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
	<201105182144.37713.rjw@sisk.pl>
	<BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
	<BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8591112088024657521=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: Your message of "Wed, 18 May 2011 17:14:56 PDT."
	<BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
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
To: Jian Peng <jipeng2005@gmail.com>
Cc: Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

--===============8591112088024657521==
Content-Type: multipart/signed; boundary="==_Exmh_1305906020_2669P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1305906020_2669P
Content-Type: text/plain; charset=us-ascii

On Wed, 18 May 2011 17:14:56 PDT, Jian Peng said:

> > @@ -1353,6 +1332,8 @@
> >
> >
> >   ahci_start_engine(ap);
> >
> > + msleep(5);
> > +
> >   if (online)
> >
> >    *class = ahci_dev_classify(ap);
> >

It may very well be that adding a magic msleep(5) here just Makes It Work, but
I have a gut feeling that it's in the wrong place (for starters, 'online' can't change
during the msleep() unless somebody *else* sets it - in which case the locking
is screwed up as we're not forcing a re-read of the value).  The msleep() probably
needs to be before something else further down in the code (but I have no idea
exactly what).

--==_Exmh_1305906020_2669P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFN1otkcC3lWbTT17ARAkbWAKCcDK9WjpHXKaCoOJFCpWMpU1POgQCfZPkw
A7iqndZ6E+a9fXTQ8HEUA4E=
=1r68
-----END PGP SIGNATURE-----

--==_Exmh_1305906020_2669P--


--===============8591112088024657521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8591112088024657521==--
