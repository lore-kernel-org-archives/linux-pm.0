From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/4] restore bq27000 code of v4.3-rc4
Date: Wed, 7 Oct 2015 20:43:53 +0200
Message-ID: <4DA04A3C-AD50-4A8A-80D4-DA3520A9C9A8@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com> <e94ee6deea6f194215927e188d97d1d28ebd00bb.1444243358.git.hns@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:9125 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbJGSoC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 14:44:02 -0400
In-Reply-To: <e94ee6deea6f194215927e188d97d1d28ebd00bb.1444243358.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?iso-8859-1?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org

Sorry, please forget this.

Am 07.10.2015 um 20:42 schrieb H. Nikolaus Schaller <hns@goldelico.com>:

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> drivers/power/bq27x00_battery.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
> index 709d1e4..8287261f 100644
> --- a/drivers/power/bq27x00_battery.c
> +++ b/drivers/power/bq27x00_battery.c
> @@ -491,7 +491,7 @@ static void bq27x00_update(struct bq27x00_device_info *di)
> 	if (cache.flags >= 0) {
> 		if (!is_bq27500 && !is_bq27425 && !is_bq27742 && !is_bq27510
> 				&& (cache.flags & BQ27000_FLAG_CI)) {
> -			dev_dbg(di->dev, "battery is not calibrated! ignoring capacity values\n");
> +			dev_info(di->dev, "battery is not calibrated! ignoring capacity values\n");
> 			cache.capacity = -ENODATA;
> 			cache.energy = -ENODATA;
> 			cache.time_to_empty = -ENODATA;
> -- 
> 2.5.1
> 

