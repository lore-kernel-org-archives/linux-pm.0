From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 0/8] PM / Sleep / Runtime: Fixup some driver's system
 suspend
Date: Wed, 5 Mar 2014 14:16:47 +0800
Message-ID: <20140305061647.GS13126@sirena.org.uk>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
 <7021741.2WcVMr4q95@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RMlwNl9HEic8ziTx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56123 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbaCEG3N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Mar 2014 01:29:13 -0500
Content-Disposition: inline
In-Reply-To: <7021741.2WcVMr4q95@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Alessandro Rubini <rubini@unipv.it>, Josh Cartwright <joshc@codeaurora.org>


--RMlwNl9HEic8ziTx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2014 at 12:38:47AM +0100, Rafael J. Wysocki wrote:

> OK, I've queued up [1-2/8] for 3.15.  The rest generally didn't apply for me
> and I think it'd be better to push them through the respective subsystem trees
> later anyway.

Is there a tag we can pull to get those patches?  The driver changes
depend on the new API introduced in patch 2.

--RMlwNl9HEic8ziTx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFsFMAAoJELSic+t+oim9LWsP/0GgVIAaO6ZZrK3i7eiTLruI
s+Bhu24UzVd4CAzO9q1KY/B8Yzrw4PgNK7r+24fnGbAJSBzrL09z+LmnICM7QTUt
7vHMMT5/HLq+LrJafeJlsR5w1LP3uewSTCXM6VmPoE08qAbTyj4gCMJBUSbF6Gfy
f7+B5DhrKCZXRCb+gQ1v/FgcPboA22ryObHQzDZrLt1ZSulYl1E1RfYIr5p6ndbU
nI5RWweGfkQGrk4aVC0dhb6KjpP7RQZPrXf3sBVB7vMM3cx4bsf0fUybZyJxwV/L
LRvQibS2xJieG+oreawFq2DfuCNS5sF/l1VxKFPjYCMqNssNbX7EbIsstSC4xZXJ
PlAFgZxKYWWDQ63z9hWjnNCLodMllWbkTgcm6Fpmk+0NoV7EiuemqYTfUcd+EflA
u8mshnxhO3tE7RDQCAON80XzpmLPQNKXduzmqDOq8E1gMK1jlcDVauVOanRnkL6y
6ZEvceQy2+0qjwU4XrZ9OFuhhuBK6ws2NZANK2jwm2oE55a8Lmm1RUA4Upxtk0dA
UQqrELEgzXFgQ6y6xGyzTHoBGPW/bL6IjzwP1jaK8rb2+ej74eY372ELe2PG9i7j
7DlGm2bwcSXSGexMd/nJaDZ1vGZOH6+lmbJx8JdEFqlwhYcDVmd7tX8SIqR6wnf3
I+ScqFheV5l2lZXtDe2c
=RO3t
-----END PGP SIGNATURE-----

--RMlwNl9HEic8ziTx--
