From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] power: supply: bq27xxx: Update comments
Date: Mon, 23 Jul 2018 09:18:27 -0500
Message-ID: <22d140c9-6947-9b7a-68dd-7d859620fa99@ti.com>
References: <1532253504-17563-1-git-send-email-liu.xiang6@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532253504-17563-1-git-send-email-liu.xiang6@zte.com.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liu Xiang <liu.xiang6@zte.com.cn>
Cc: pali.rohar@gmail.com, sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, liuxiang_1999@126.com
List-Id: linux-pm@vger.kernel.org

On 07/22/2018 04:58 AM, Liu Xiang wrote:
> The URL of bq27441-g1 and bq27426 are missing and bq27520-g4 is duplicated.
> 
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> ---


Acked-by: Andrew F. Davis <afd@ti.com>


>  drivers/power/supply/bq27xxx_battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index d44ed8e..f022e1b 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -26,7 +26,6 @@
>   * http://www.ti.com/product/bq27510-g1
>   * http://www.ti.com/product/bq27510-g2
>   * http://www.ti.com/product/bq27510-g3
> - * http://www.ti.com/product/bq27520-g4
>   * http://www.ti.com/product/bq27520-g1
>   * http://www.ti.com/product/bq27520-g2
>   * http://www.ti.com/product/bq27520-g3
> @@ -40,7 +39,9 @@
>   * http://www.ti.com/product/bq27545-g1
>   * http://www.ti.com/product/bq27421-g1
>   * http://www.ti.com/product/bq27425-g1
> + * http://www.ti.com/product/bq27426
>   * http://www.ti.com/product/bq27411-g1
> + * http://www.ti.com/product/bq27441-g1
>   * http://www.ti.com/product/bq27621-g1
>   */
>  
> 
