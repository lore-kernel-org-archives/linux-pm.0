From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v4] power: bq27xxx_battery: Fix bq27541 AveragePower
 register address
Date: Wed, 13 Jan 2016 09:16:17 -0600
Message-ID: <56966A41.3060809@ti.com>
References: <1452348639-3072-1-git-send-email-liu.xiang6@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51440 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbcAMPQr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2016 10:16:47 -0500
In-Reply-To: <1452348639-3072-1-git-send-email-liu.xiang6@zte.com.cn>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liu Xiang <liu.xiang6@zte.com.cn>, linux-pm@vger.kernel.org
Cc: pali.rohar@gmail.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org

On 01/09/2016 08:10 AM, Liu Xiang wrote:
> Currently in bq27541 driver, the average power register address is
> incorrectly set to 0x76, which would result in an error:
> bq27xxx-battery 2-0055: error reading average power register  10: -11
> According to the bq27541 datasheet, fix this problem by setting
> the average power register address to 0x24.
>
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> ---
> v4:
>   - Modify the patch format.
> ---
>   drivers/power/bq27xxx_battery.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
> index 880233c..633f96d 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -242,7 +242,7 @@ static u8 bq27541_regs[] = {
>   	INVALID_REG_ADDR,	/* AE - NA	*/
>   	0x2c,	/* SOC(RSOC)	*/
>   	0x3c,	/* DCAP		*/
> -	0x76,	/* AP		*/
> +	0x24,	/* AP		*/
>   };
>
>   static u8 bq27545_regs[] = {
>

Acked-by: Andrew F. Davis <afd@ti.com>
