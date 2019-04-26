From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] power: supply: bq27xxx_battery: Notify also about
 status changes
Date: Fri, 26 Apr 2019 12:47:19 +0200
Message-ID: <20190426104719.t6gyo3no7l4wjesz@pali>
References: <1556272742-17232-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556272742-17232-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 26 April 2019 11:59:02 Krzysztof Kozlowski wrote:
> User-space might be interested in receiving uevents when the charging
> starts/stops or if conditions of battery changes (e.g.
> over-temperature).  Notify about changes in battery also when the flags
> change, not only SoC.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Ok, you can add my
Reviewed-by: Pali Rohár <pali.rohar@gmail.com>

> ---
> 
> Changes since v1:
> 1. Remove unneeded backslash (pointed by Pali).
> ---
>  drivers/power/supply/bq27xxx_battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 29b3a4056865..195c18c2f426 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1612,7 +1612,8 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
>  			di->charge_design_full = bq27xxx_battery_read_dcap(di);
>  	}
>  
> -	if (di->cache.capacity != cache.capacity)
> +	if ((di->cache.capacity != cache.capacity) ||
> +	    (di->cache.flags != cache.flags))
>  		power_supply_changed(di->bat);
>  
>  	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)

-- 
Pali Rohár
pali.rohar@gmail.com
