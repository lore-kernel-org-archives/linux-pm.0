From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/4] power: Add Qualcomm SMBB driver
Date: Sat, 25 Jul 2015 17:42:00 +0200
Message-ID: <20150725154159.GA17373@earth>
References: <1434662025-9485-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1434662025-9485-4-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434662025-9485-4-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Courtney Cavin <courtney.cavin@sonymobile.com>
List-Id: linux-pm@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Jun 18, 2015 at 02:13:44PM -0700, Bjorn Andersson wrote:
> Add the Qualcomm Switch-Mode Battery Charger and Boost driver, found in
> pm8941.

The driver's sourcecode looks fine to me. I'm not convinced by all
those new DT properties, though. I think "watermark" should be
replaced with "threshold" and "control" with "current" for all
properties. Additionally some comments. Note, that I only used the
driver's sourcecode as reference, since the DT binding document
was neither send to me, nor to linux-pm mailinglist.

 * battery-charge-control-limit

It's unclear, what this property is used for. Is the limit only
for "normal" charging or also for fast charging?

 * fast-charge-low-watermark
 * fast-charge-high-watermark

Add a unit to this property. Maybe "fast-charge-start-voltage"
and "fast-charge-stop-voltage"?

 * fast-charge-safe-voltage
 * fast-charge-safe-current

These properties are fine to me. I wonder if they should be named
fast-charge-max-*, though.

 * auto-recharge-low-watermark

I think the "low" can be dropped. Instead a -voltage
should be appended, since it could also be a percentage.

 * minimum-input-voltage

Add a vendor prefix to this property.

 * usb-charge-control-limit

I suggest to remove this from DT. If no USB detection is
implemented, the default should be 100mA according to USB
standard.

 * dc-charge-control-limit

Please add a vendor prefix and I think "dc-current-limit"
is a more fitting name.

 * disable-dc

Please add a vendor prefix.

 * jeita-extended-temp-range

Looks ok to me.

-- Sebastian

smbb_charger_attr_parse

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVs65FAAoJENju1/PIO/qac0MP/2Mc2g/pUHMxFdtnm7vMXGgj
LPj98qiR9JxjowFp2+BUsPq8yeC2gCZyU8ZbUpf2R71IVfTivLDdGoRtcJhHCljQ
fSOafBUDd1UByWRGhljzQHctb0ERO/zHDo3JvBAqY32LW89FAqNAoRPtz/Ljz/tS
i3kvRls/4jx7mUdzHKxCZN+YgjzTrrjLHtnCWSEdy65Qfe8qap9gGe9NDdtSD0v1
AhptI4I4kh4NlwSO/+POWM/LnPXoTzQsxvcysKPL67FHNYYgVq7QUUk8MkzIygZ0
zs8ig8ncdkWEKXtaol9g4C1IJF6o/E5i++rSu57B6fbCm1H+6FwZvtwakF5YAwOj
RLOQJaA73jaaOUKSEB3c0xFAXLGIzRBuVvTlECBPjuzhmOLoD9WmUTh5xaRcDdPG
4IWXb3ANWEHus9HqRBeRqN9ICiOiB6CcYbf9AQ3/+t0BNefO7zgcTU20jEsPDSnq
8BDqXHPDHshcJcKCg0JmhorLyaqYr9Q86QciBoHCafVPIsss0WyxPe0By3UoA4yS
RoX2AVBs5oTdYv9gjL0yx4oCUURgb1Lp+Ix1JLEcwDY7ro/qNjbcS4tU6msOarqB
Rw64WwaJJpryMPolrQgfEvT7/nC7eZEuWXzQdInaWo3EAbA9AFYbZMRPf02Q4+xp
9VfJMBJUtM5SQibYu01m
=P7sw
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
