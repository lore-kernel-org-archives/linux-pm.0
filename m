Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1659C433F5
	for <linux-pm@archiver.kernel.org>; Sun, 17 Oct 2021 10:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7633161179
	for <linux-pm@archiver.kernel.org>; Sun, 17 Oct 2021 10:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241822AbhJQK16 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 17 Oct 2021 06:27:58 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50434 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbhJQK16 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Oct 2021 06:27:58 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1F04B1C0B76; Sun, 17 Oct 2021 12:25:48 +0200 (CEST)
Date:   Sun, 17 Oct 2021 12:25:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, rafael@kernel.org,
        len.brown@intel.com, linux-pm@vger.kernel.org, sfr@canb.auug.org.au
Subject: next-20211015: suspend to ram on x86-32 broken
Message-ID: <20211017102547.GA3818@amd>
References: <20211017093905.GA3069@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20211017093905.GA3069@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Thinkpad X60, suspend to ram no longer works. Suspend is okay, and
there are some signs of resume attempts for second or so, but screen
stays black and sleep LED stays on.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmFr+isACgkQMOfwapXb+vIxuACbBzSIgpleArT4uzCsGhIx0QY7
gw8An2gmf0zJjxgoC8PSWnmYibCz/UcE
=YQ4B
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
