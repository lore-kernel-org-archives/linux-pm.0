From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
	ahci_start_engine compliant to AHCI spec"
Date: Fri, 20 May 2011 14:25:59 -0400
Message-ID: <17610.1305915959__23884.8119196065$1305916006$gmane$org@localhost>
References: <201105120025.34531.rjw@sisk.pl> <20633.1305565337@localhost>
	<BANLkTin7NgUMXSVyKn6P0TCrFZ5uaaRL1w@mail.gmail.com>
	<201105182144.37713.rjw@sisk.pl>
	<BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
	<BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
	<10124.1305906020@localhost>
	<20110520154341.GL31426@htj.dyndns.org>
	<BANLkTi=iNjWsaYCJqP057FkhAXtab5nS=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4016140378647179588=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: Your message of "Fri, 20 May 2011 10:02:56 PDT."
	<BANLkTi=iNjWsaYCJqP057FkhAXtab5nS=Q@mail.gmail.com>
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

--===============4016140378647179588==
Content-Type: multipart/signed; boundary="==_Exmh_1305915959_2669P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1305915959_2669P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 May 2011 10:02:56 PDT, Jian Peng said:
> --20cf307f38f6d842a904a3b81730

> You are both right that adding this majic 5ms delay at this place should not
> be the final solution.
> 
> If this magic 5ms delay works on other affected systems, I plan to post a
> new patch that inside ahci_start_engine(), still perform same check, and
> show warning message if failed, but will set a flag, then still set START
> bit, and if there is such failure flag, add 5ms delay.
> 
> Valdis, could you apply the following patch and retest it?

I should be able to do that this weekend.  To clarify - should this be with the
problem commit 270dac35c26433d06a89150c51e75ca0181ca7e4 applied, or reverted?


--==_Exmh_1305915959_2669P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFN1rI3cC3lWbTT17ARAholAKDXyBVpYZyAWJ8gqpx+ye9glWfMIwCeLr/V
nxlCRWYPv2DT4GrXxJPDTqg=
=pEhp
-----END PGP SIGNATURE-----

--==_Exmh_1305915959_2669P--


--===============4016140378647179588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4016140378647179588==--
