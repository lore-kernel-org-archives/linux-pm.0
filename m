From: Marcus Better <marcus@better.se>
Subject: Re: [3/5] 2.6.21-rc4: known regressions (v2)
Date: Tue, 27 Mar 2007 11:42:46 +0200
Message-ID: <200703271142.50425.marcus@better.se>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <200703261942.52126.marcus@better.se> <20070326184857.GD16477@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1384114.uKSMRjCNLc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753464AbXC0JnI@vger.kernel.org>
In-Reply-To: <20070326184857.GD16477@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, pavel@suse.cz, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--nextPart1384114.uKSMRjCNLc
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Adrian Bunk wrote:
> > > Does setting CONFIG_PCI_MSI=n make any difference?
> >
> > Yes, it does. The hanging resume problem went away.
>
> Thanks for testing.
>
> If you enable it again, does the patch from [1] also fix it?

Yes, it appears to fix it.

Marcus

--nextPart1384114.uKSMRjCNLc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGCOcaXjXn6TzcAQkRAut6AJ4gHdtuSC1CvXKPpsl53UWFGbY/GQCcDn0Q
oZPC7R94a1R7BAdUMGmI3jE=
=rGIL
-----END PGP SIGNATURE-----

--nextPart1384114.uKSMRjCNLc--
