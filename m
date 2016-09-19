From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 16/19] power: reset: st-poweroff: Remove obsolete
 platforms.
Date: Mon, 19 Sep 2016 21:34:25 +0200
Message-ID: <20160919193423.dhhzk33eu66fbtt6@earth>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-17-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dk4gmzmd7ndllvze"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbcISTed (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Sep 2016 15:34:33 -0400
Content-Disposition: inline
In-Reply-To: <1473859677-9231-17-git-send-email-peter.griffin@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, devicetree@vger.kernel.org, lee.jones@linaro.org, dwmw2@infradead.org, dbaryshkov@gmail.com, linux-pm@vger.kernel.org


--dk4gmzmd7ndllvze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Sep 14, 2016 at 02:27:54PM +0100, Peter Griffin wrote:
> This patch removes support for STiH415/6 SoC's from the
> st-poweroff driver, as support for these platforms is
> being removed from the kernel.

I queued this to power-supply's for-next branch. Please
cc me to full thread next time, so that I can see what
is goin on.

-- Sebastian

--dk4gmzmd7ndllvze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX4D2/AAoJENju1/PIO/qaze0P/RpvjBG4mmyl3h/8+lOt25dz
taZhTsl/M2/F0Q+kCJD85nUVgM5YJssRtchPixIm6I/OMg1okvkThvYWrYkY2ZFi
cEY/ny8uI7wSTr5vs4UMxpJ1GysLqM9vDV1eJHesr2VS/1601nSIGjsv+NXIPxci
DQ7xjspHQHN111nTcmiaXrxjn7bS4XB/MfPpIwRttgwxWfJtZMP9HVvH6TFvNt5J
vrNnBAckFCX8QsnGi8SGcV/MJ3KlXr8NILMwD3wZzMCchnSuzexqmpLdh1SYNx2Z
J1JhraHuyDnuP3fAVE7LgFiyO/nX36i8RHzQ9Lio6IUk1aPr+6B6X/UYSGUihT9w
qE2cqAQsp8199ronydxy0T4SkyX8ph/OgAV22NnE0GBAmmsxcjd+i7+bNfMkXc64
wSWhWdprxSAf4LBxbeJQ5othafZkbP6F59LLT7+FV6EVpYWtgWKCqf+OvSTUC8Tv
+vOUnOiffj+2T0aYdEFTw9eCYHcPTeeyW7Me19B37Hctgx8wwxDw/BHQlbLAO+dd
2ilsS0arDhsaXPkKJ8poUsDWehQzTHui/Bft6vvNwojNMOhnKQGryoWboEZanKQW
oBplP4VElmkuWgjuVrFrZZKOPOCOSmzHHoxlRouClF9TXMGdkqECsh/9vz9QYEBW
NIijanioo10HyhWEpxpw
=FHE/
-----END PGP SIGNATURE-----

--dk4gmzmd7ndllvze--
