From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 2/2] power:bq27xxx: fix register numbers of bq27500
Date: Wed, 23 Dec 2015 20:52:28 -0600
Message-ID: <567B5DEC.3050106@ti.com>
References: <cover.1450347172.git.hns@goldelico.com>
 <dd1c67a7c8a2cabed0433f2d7b30f91bb0b06b78.1450347172.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52326 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbbLXCxT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2015 21:53:19 -0500
In-Reply-To: <dd1c67a7c8a2cabed0433f2d7b30f91bb0b06b78.1450347172.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com

On 12/17/2015 04:12 AM, H. Nikolaus Schaller wrote:
> bug: according to data sheet some register numbers are wrong.
>
> tested: no
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Indeed they are, good catch.

Acked-by: Andrew F. Davis <afd@ti.com>

> ---
>   drivers/power/bq27xxx_battery.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
> index e54a125..f9a5f4f 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -198,10 +198,10 @@ static u8 bq27500_regs[] = {
>   	INVALID_REG_ADDR,	/* TTECP - NA	*/
>   	0x0c,	/* NAC		*/
>   	0x12,	/* LMD(FCC)	*/
> -	0x1e,	/* CYCT		*/
> +	0x2a,	/* CYCT		*/
>   	INVALID_REG_ADDR,	/* AE - NA	*/
> -	0x20,	/* SOC(RSOC)	*/
> -	0x2e,	/* DCAP(ILMD)	*/
> +	0x2c,	/* SOC(RSOC)	*/
> +	0x3c,	/* DCAP(ILMD)	*/
>   	INVALID_REG_ADDR,	/* AP - NA	*/
>   };
>
>
