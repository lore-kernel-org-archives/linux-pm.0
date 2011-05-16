From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
	ahci_start_engine compliant to AHCI spec"
Date: Mon, 16 May 2011 13:02:17 -0400
Message-ID: <20633.1305565337__49380.5951126435$1305565533$gmane$org@localhost>
References: <201105120025.34531.rjw@sisk.pl>
	<BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com>
	<201105132222.11582.rjw@sisk.pl> <201105132244.29605.rjw@sisk.pl>
	<20110514101807.GA23665@htj.dyndns.org>
	<20110514102804.GB23665@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0738530485324690802=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: Your message of "Sat, 14 May 2011 12:28:04 +0200."
	<20110514102804.GB23665@htj.dyndns.org>
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
To: Tejun Heo <tj@kernel.org>
Cc: Michael Leun <lkml20100708@newton.leun.net>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jian Peng <jipeng2005@gmail.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

--===============0738530485324690802==
Content-Type: multipart/signed; boundary="==_Exmh_1305565337_2487P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1305565337_2487P
Content-Type: text/plain; charset=us-ascii

On Sat, 14 May 2011 12:28:04 +0200, Tejun Heo said:
> This reverts commit 270dac35c26433d06a89150c51e75ca0181ca7e4.
> 
> The commits causes command timeouts on AC plug/unplug.  It isn't yet
> clear why.  As the commit was for a single rather obscure controller,
> revert the change for now.
> 
> The problem was reported and bisected by Gu Rui in bug#34692.
> 
>  https://bugzilla.kernel.org/show_bug.cgi?id=34692
> 
> Also, reported by Rafael and Michael in the following thread.
> 
>  http://thread.gmane.org/gmane.linux.kernel/1138771

This also fixes the issue I had with a 10-second pause on my Dell Latitude E6500
laptop at boot while detecting the CD/DVD drive.

--==_Exmh_1305565337_2487P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFN0ViZcC3lWbTT17ARAlsZAJ91zKbQW9Gq0dUJEYzqYDccsyH3YgCfX/Om
eOxZRGIEc0/BfbLY5Uhc4wY=
=ZQ/P
-----END PGP SIGNATURE-----

--==_Exmh_1305565337_2487P--


--===============0738530485324690802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0738530485324690802==--
