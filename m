Return-Path: <SRS0=SEw5=TT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17D0C04AB4
	for <linux-pm@archiver.kernel.org>; Sun, 19 May 2019 21:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B742081C
	for <linux-pm@archiver.kernel.org>; Sun, 19 May 2019 21:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfESVfA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 19 May 2019 17:35:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59876 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfESVe7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 May 2019 17:34:59 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A5A4180378; Sun, 19 May 2019 23:34:47 +0200 (CEST)
Date:   Sun, 19 May 2019 23:34:57 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 1/3] PM: wakeup: Add routine to help fetch wakeup
 source object.
Message-ID: <20190519213457.GG31403@amd>
References: <20190517033946.30763-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sLx0z+5FKKtIVDwd"
Content-Disposition: inline
In-Reply-To: <20190517033946.30763-1-ran.wang_1@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190519213457.tguLdaXwgoovsU9rVeI2yiUVHvmB4cDLrBWaq6rx3_M@z>


--sLx0z+5FKKtIVDwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> --- a/include/linux/pm_wakeup.h

> @@ -70,6 +71,7 @@ struct wakeup_source {
>  	unsigned long		wakeup_count;
>  	bool			active:1;
>  	bool			autosleep_enabled:1;
> +	struct device	*attached_dev;
>  };
> =20
>  #ifdef CONFIG_PM_SLEEP

You might want to format this similary to the rest...
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sLx0z+5FKKtIVDwd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzhzAEACgkQMOfwapXb+vJFYwCfWepB4p66NbXEV3e8W5ZictQ/
Es8AmgKZXmLs30UjIBYDFKic2DbgBegF
=KZ5b
-----END PGP SIGNATURE-----

--sLx0z+5FKKtIVDwd--
