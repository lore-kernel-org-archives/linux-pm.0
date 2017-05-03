From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] power: supply: twl4030-charger: make twl4030_bci_property_is_writeable static
Date: Wed, 3 May 2017 14:25:57 +0200
Message-ID: <84E3CDD6-1B1D-4316-B23A-8F43B3C2E397@goldelico.com>
References: <20170503103357.22598-1-colin.king@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:27653 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbdECM0A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2017 08:26:00 -0400
In-Reply-To: <20170503103357.22598-1-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Sebastian Reichel <sre@kernel.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Colin,

> Am 03.05.2017 um 12:33 schrieb Colin King <colin.king@canonical.com>:
>=20
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The function twl4030_bci_property_is_writeable can be made static
> as it does not need to be in global scope.

Indeed. Have tested and it still works.

>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/power/supply/twl4030_charger.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/twl4030_charger.c =
b/drivers/power/supply/twl4030_charger.c
> index abd10f6861ae..2f82d0e9ec1b 100644
> --- a/drivers/power/supply/twl4030_charger.c
> +++ b/drivers/power/supply/twl4030_charger.c
> @@ -943,7 +943,7 @@ static int twl4030_bci_set_property(struct =
power_supply *psy,
> 	return 0;
> }
>=20
> -int twl4030_bci_property_is_writeable(struct power_supply *psy,
> +static int twl4030_bci_property_is_writeable(struct power_supply =
*psy,
> 				      enum power_supply_property psp)
> {
> 	switch (psp) {
> --=20
> 2.11.0
>=20

Thanks and BR,
Nikolaus
