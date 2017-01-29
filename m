From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 6/8] power: bq27xxx_battery: add i2c bulk read/write
 functions
Date: Sun, 29 Jan 2017 23:22:45 +0100
Message-ID: <20170129222245.kimtf5f5t5zjjcnq@earth>
References: <20170129200825.32648-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bwg5xbe7npn7bpoe"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbdA2WWv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Jan 2017 17:22:51 -0500
Content-Disposition: inline
In-Reply-To: <20170129200825.32648-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>


--bwg5xbe7npn7bpoe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 29, 2017 at 12:08:25PM -0800, Liam Breck wrote:
> On Sun, 2017-01-29 at 18:38:26, Sebastian Reichel wrote:
> >> diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/pow=
er/bq27xxx_battery.h
> >> index 3f265dbf11af..581402380d6e 100644
> >> --- a/include/linux/power/bq27xxx_battery.h
> >> +++ b/include/linux/power/bq27xxx_battery.h
> >> @@ -41,6 +41,9 @@ struct bq27xxx_platform_data {
> >>  struct bq27xxx_device_info;
> >>  struct bq27xxx_access_methods {
> >>  	int (*read)(struct bq27xxx_device_info *di, u8 reg, bool single);
> >> +	int (*write)(struct bq27xxx_device_info *di, u8 reg, int value, bool=
 single);
> >> +	int (*read_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, i=
nt len);
> >> +	int (*write_bulk)(struct bq27xxx_device_info *di, u8 reg, u8 *data, =
int len);
> >
> >So I had a look at patch 8 and I think we should start with finally
> >converting bq27xxx to regmap API and probably a second regmap for
> >the block data stuff. That way you get all the debugging info in
> >debugfs and the driver looks much cleaner.
> 									=09
> Could we complete this patchset using the I2C api? We haven't added to it
> extensively, and regmap is unrelated to the purpose of this patchset.

Previously we had only a read operation, which could be easily
converted to regmap, since it accesses a single register. Afterwards
we have read,write,bulk_read and bulk_write. That's 400% and 2/4
functions, which do not follow the regmap style.

So what is your definition of extensively? :)

> Also maybe the primary maintainers of BQ27xxx should be on the hook for
> that api change :-)

https://lkml.org/lkml/2015/9/23/542

The w1 stuff is not that hard to implement actually by just using
the existing functions and devm_regmap_init().

> Plus we're blocked here on devicetree support for BQ24190 waiting for
> power_supply_battery_info.

Well this patch depends on the power_supply_battery_info patch, not
the other way around. I will apply the power_supply_battery_info
patch once its ok. No need to wait for this patch. So not really a
problem for your BQ24190 work?

-- Sebastian

--bwg5xbe7npn7bpoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOazIACgkQ2O7X88g7
+pqn1w//biPciBb9Pfa7MEk0r9xZIx0nqCpWWgCLkVJDcjxWDuxyzCx5QaPtepM9
F4vK7U9DhvMn9pFEPTqGlHZJD6kAxCQ0GmY3Y9oDy1SzFdafdXedt4MiuO+d1HlU
PA9rhbn0gXlf/QpbBxPm1Qt7/6O4+oobOx7T8vNmEwpsCtZZNLgkmFpNUKRaWD+w
NV363pqEzMHc7k8akp+NNrV58nAnPiGj+03evoj5VFQRexWz18EI5Q0dNqmxJ3IQ
adh3mAv/5Ag0XPiT/zAPRRSrH/FWDPxmsJFMS8ubVmLdIafBbIk1xTBQrt+V1Cmt
xSdujBhrO2hOtEd1rIgRPBSamlwUPSXG0xMeVA657PDVONzf229cu/C0hIG5ccql
S5X9XadRrlDa9c4ekPwAV38+lkaTkN+x+O5SDFAOkVf8pF4ZW1AnDKEC3OZpwnyJ
BG2WoMID4tBpab2dk6S8Sz3VjnMASdDNgBZdsaW9EAiMBIKjNSRj7G3lY+zVg0qA
9w2eEhhWYK0dpBedRez0/q8cztvVBH47hnbCDEepL/nIor4yknNQcSvlNOooxAP1
4jeS37XsEDj336nThoOVpjbdqKOApaPXWCNyqacE53ty5iAi9FUwp/8SfDfM9Lv+
CLKDx+9H9UwyH2ki75/N0OjuP7pFJEu20g2oN0/USPw60uR8t7s=
=wmvs
-----END PGP SIGNATURE-----

--bwg5xbe7npn7bpoe--
