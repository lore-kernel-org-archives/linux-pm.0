From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH] sbs-battery: correct capacity mode selection bits
Date: Tue, 11 Jul 2017 10:32:22 +0800
Message-ID: <b5fbff52-3e9d-fef1-02ed-3a2328fda32a@electromag.com.au>
References: <1a1c52f56a9e530ae2d0bf825e67f6a6@heine.so>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:51520 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753810AbdGKCc1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 22:32:27 -0400
In-Reply-To: <1a1c52f56a9e530ae2d0bf825e67f6a6@heine.so>
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Heinemann <posted@heine.so>, linux-pm@vger.kernel.org

On 7/07/2017 22:23, Michael Heinemann wrote:
> The capacity mode bit is bit 15. Currently it is written as
> default initialized enum and never shifted. This leads to
> a behaviour where the BATTERY_MODE is not correctly
> recognized and set again.
> 
> This commit initializes the enum accordingly.
> 
> Signed-off-by: Michael Heinemann <committed@heine.so>

Tested-by: Phil Reid <preid@electromag.com.au>


> ---
>   drivers/power/supply/sbs-battery.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> index 8bb2eb3..498e9af 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -60,8 +60,8 @@ enum {
>   #define BATTERY_MODE_OFFSET        0x03
>   #define BATTERY_MODE_MASK        0x8000
>   enum sbs_battery_mode {
> -    BATTERY_MODE_AMPS,
> -    BATTERY_MODE_WATTS
> +    BATTERY_MODE_AMPS = 0,
> +    BATTERY_MODE_WATTS = 0x8000
>   };
> 
>   /* manufacturer access defines */

-- 
Regards
Phil Reid
