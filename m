From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] power:bq27xxx: 27000/10 read FLAGS register as single
Date: Tue, 26 Jul 2016 08:08:57 +0200
Message-ID: <D019AEBF-8DE0-4496-943A-DB526C84BEE1@goldelico.com>
References: <6ff28e18f78d1b9581cba5fd214fcc00e4a6d23a.1468858328.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:36018 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbcGZGJM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2016 02:09:12 -0400
In-Reply-To: <6ff28e18f78d1b9581cba5fd214fcc00e4a6d23a.1468858328.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F . Davis" <afd@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Andrzej Hajda <a.hajda@samsung.com>, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org

ping

> Am 18.07.2016 um 18:12 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
> 
> The bq27000 and bq27010 have a single byte FLAGS register.
> Other gauges have 16 bit FLAGS registers.
> 
> For reading the FLAGS register it is sufficient to read the single
> register instead of reading RSOC at the next higher address as
> well and then ignore the high byte.
> 
> This does not change functionality but optimizes i2c and hdq
> traffic.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> drivers/power/bq27xxx_battery.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
> index 45f6ebf..56712b2 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -656,8 +656,9 @@ static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
> static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
> {
> 	int flags;
> +	bool has_singe_flag = di->chip == BQ27000 || di->chip == BQ27010;
> 
> -	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, false);
> +	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
> 	if (flags < 0) {
> 		dev_err(di->dev, "error reading flag register:%d\n", flags);
> 		return flags;
> @@ -760,7 +761,7 @@ static int bq27xxx_battery_current(struct bq27xxx_device_info *di,
> 	}
> 
> 	if (di->chip == BQ27000 || di->chip == BQ27010) {
> -		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, false);
> +		flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, true);
> 		if (flags & BQ27000_FLAG_CHGS) {
> 			dev_dbg(di->dev, "negative current!\n");
> 			curr = -curr;
> -- 
> 2.7.3
> 

