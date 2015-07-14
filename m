From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: Destroy IDRs on module exit
Date: Tue, 14 Jul 2015 12:19:48 +0200
Message-ID: <20150714101948.GA17240@earth>
References: <1436865374-22027-1-git-send-email-jthumshirn@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53793 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649AbbGNKTx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jul 2015 06:19:53 -0400
Content-Disposition: inline
In-Reply-To: <1436865374-22027-1-git-send-email-jthumshirn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[+CC: Tejun Heo <tj@kernel.org>, for being very active in lib/idr.c]

Hi,

On Tue, Jul 14, 2015 at 11:16:14AM +0200, Johannes Thumshirn wrote:
> Destroy IDRs on module exit, freeing the resources for
> * bq2415x_charger.c
> * ds2782_battery.c
> * ltc2941-battery-gauge.c

You missed bq27x00_battery.c. Maybe a coccinelle script should be
written?

> The drivers had to be converted to "ordinary" module_init()/module_exit()
> style drivers instead of using module_i2c_driver.

mh I would prefer another solution. How about adding something
like this:

static void idr_remove_and_destroy(struct idr *idp, int id)
{
    idr_remove(idp, id);
    if (idr_is_empty(idp)
        idr_destroy(idp);
}

If that is called by the drivers instead of idr_remove(), there
should be no need for adding idr_destroy to module_exit().

-- Sebastian

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVpOJBAAoJENju1/PIO/qa7CsP/jUDMFHTlHcD5g0AQsBUyyqa
IZdRpn1Z2fSB+UWbGOeNJPtdrbS64/77C3PtTP09rRj3SB6cILXEw6oQqNB7UZlM
LS1grTsPFC6SQRaC6xAbo3dnirLx4kuZ4nSvBqyusKl9pkSZBX0mxhZqCE1AVHeE
AlCzRAtPlqgqGMG7zlsvdsZ+Z1JwHJZx5wL5ePMmiWtDTa2bb0hxBCXBfdCylYZn
OybEEkoEBYyBRPNreGpRJi/TaRvjnR1W0c6kyYRFdoIC0mFdHwHviyEG+ZiyNAvM
+F4YX0wZS+v8nx9u8d1kTI99DaJtIXWkzGLGZlDbJ96I0kRgkVunLdNMxHHXvjUn
1voc5n0I35nALVsrNwWk451FN8ggF8hYCFt6hc6YWzsE0rlhaevLO5M7AaWhE1SN
UBy3y7wHmMlktjLtdyvLHv8uAzPrld0YBTkmlPkmxodJLS8cHMgrn4FHyZCeVvSs
/PC7jyIAn9/2ZI2r3Yg+SXv8NQsn9rwuXtjXdWrACQw4Dpl3UFhNo/z+B0tsLdBB
5ndRL+qCjZbOunerjgtbEKOU6MlIfGzMzxC1sIWoMQQupcFfJyyU7zeIJLunlnnX
VXk9Q0T+4XAUJ1N56PBxS+RunOLa80KYw2fAINtkcZKT/8SLXV/LWi3oepLqkBrI
9V85lYjWzqazW8cD/8X1
=NigO
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
