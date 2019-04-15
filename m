Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAE0C10F0E
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 21:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EDE20880
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 21:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555363913;
	bh=Wn55LCzxxn6BClCZgun7QPJfuo8QZWZE2Ah4Lj+eN4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JbRvQ/WsHbOh7XLmXSso3N06mCagq7X6TRQyeL0W6745tynmx4L5ONrP/ykhUmmCd
	 YzJv7Bq53u228ycEBbH7T7QfLb6IRFOz0WfBJ58IWlCY09pMzhrhf5c+2i7eur3aa4
	 w1BbriXMLEpPkL94xT9IiAYv8wkqk+7T63E6WAZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfDOVbw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbfDOVbw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Apr 2019 17:31:52 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6373B2070D;
        Mon, 15 Apr 2019 21:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555363911;
        bh=Wn55LCzxxn6BClCZgun7QPJfuo8QZWZE2Ah4Lj+eN4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZRPSrG7t5a26ePiEQQGZZPR8In383DRlZxj1XgwjghDrT+nXhLAcssKFnjLBJvN/b
         3A4WmtXl/4bgNFIs5b+yw6tZPrfRuH4W6sbKPoTRogFwlJjHC5n/1h4jBhtqEDubWW
         I2Kv5uHIz3ygsvb+wGMnRvAoMtU5oB8Y8W2FS18g=
Received: by earth.universe (Postfix, from userid 1000)
        id E18953C08D5; Mon, 15 Apr 2019 23:31:48 +0200 (CEST)
Date:   Mon, 15 Apr 2019 23:31:48 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/7] Some fixes and improvments for cpcap battery and
 charger
Message-ID: <20190415213148.zd4mtxt6u4apcr7x@earth.universe>
References: <20190407181254.64537-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ivwyreocyn7n4fhx"
Content-Disposition: inline
In-Reply-To: <20190407181254.64537-1-tony@atomide.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ivwyreocyn7n4fhx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 07, 2019 at 11:12:47AM -0700, Tony Lindgren wrote:
> I've been trying to figure out how come the coulomb counter on droid 4 is=
 off
> especially for the low power consumption values. Turns out the "coulomb c=
ounter"
> values correlate better with average power consumption if we divide the v=
alue with
> number of samples. Otherwise we have a curve instead of flat correlation =
between
> the register values and power consumed. I have some patches coming up eve=
ntually to
> fix that, but meanwhile I've noticed some minor issues in general that wo=
uld be
> good to have out of the way.
>=20
> I've only tagged the first one with fixes tag, the other ones can certain=
ly wait
> for the merge window considering further changes are needed at least for =
low power
> consumption values.

Thanks, all queued.

-- Sebastian

--ivwyreocyn7n4fhx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly0+D8ACgkQ2O7X88g7
+pq0Yg//e+ONsDQpI54T/NKLx9lFbTR2k2P7oGOkAdiFCjBTm+22Vu0lCYKgsgxz
G/JbTBHl+VhM5YQqOkVQkfUGZ5XFoTYUEnmqL8uPpxSUDHRr5MLEv7HGKqlXAgFe
3sERoVeum/hzMLEsmfthVs3WLxqKidCAEhvuZqEmxWjfnnaXGadSsF0SCuqZJS/g
RXu6AWWwWAPlHlJgiUrxVpkfZvuBkzHiBrIdXIfNRc4zGtPJqJYyzh8bIbTc0kO0
D+B0qC8CMvTTcsPoLXOkY4hYYAG2m+G/U7gqQUwQ6XFxOeJnnWNZuKsPxgYKXJ11
NFPaRE60KnLSyAZ08+FFcTMA0/DbUNa4Nucc/pGeuNhtrwi22lfNLdpxK+62daZY
/5Z1wzAHnUaFZEZuQTPL4CLQDn69rbe8gYz1N3zdWp0hx7tzEA4bipxy1uki4Zop
rhb5G1nnVGvrG3KtDgPUR47U5KclLe9v4vZ3pAgroBGUPyngFZdfxD6XdFzMycFK
cZfsKmEl7x8VyTplwB4ChSFy8QH+HkRFypi472lDrmfSAZ7SrLS9E04+MVtzQCM2
u5ymLt4MoICXdcLCi3UCG+t3rI9y8tppXYg7lH++/2JnO9zIYB1UXzWHJ2wLbmft
XHu8OpYaI4qKLCbFKw/SePSz1GKYJTE8Fx3p6zj+fVaT4LUWtTQ=
=s/KK
-----END PGP SIGNATURE-----

--ivwyreocyn7n4fhx--
