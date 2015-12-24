From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 1/2] power:bq27xxx: fix reading for bq27000 and bq27010
Date: Wed, 23 Dec 2015 20:46:43 -0600
Message-ID: <567B5C93.9090000@ti.com>
References: <cover.1450347172.git.hns@goldelico.com>
 <deacb36df6842521628c0d324c2c8033733e2cb5.1450347172.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <deacb36df6842521628c0d324c2c8033733e2cb5.1450347172.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com
List-Id: linux-pm@vger.kernel.org

On 12/17/2015 04:12 AM, H. Nikolaus Schaller wrote:
> bug: the driver reports funny capacity values:
>
> root@letux:/sys/class/power_supply/bq27000-battery# cat uevent
> POWER_SUPPLY_NAME=bq27000-battery
> POWER_SUPPLY_STATUS=Charging
> POWER_SUPPLY_PRESENT=1
> POWER_SUPPLY_VOLTAGE_NOW=3702000
> POWER_SUPPLY_CURRENT_NOW=-464635
> POWER_SUPPLY_CAPACITY=1536			<- over 100% is magic
> POWER_SUPPLY_CAPACITY_LEVEL=Normal
> POWER_SUPPLY_TEMP=311
> POWER_SUPPLY_TIME_TO_FULL_NOW=10440
> POWER_SUPPLY_TECHNOLOGY=Li-ion
> POWER_SUPPLY_CHARGE_FULL=805450
> POWER_SUPPLY_CHARGE_NOW=1068
> POWER_SUPPLY_CHARGE_FULL_DESIGN=8844998	<- battery has just 1200 mAh
> POWER_SUPPLY_CYCLE_COUNT=21
> POWER_SUPPLY_ENERGY_NOW=0
> POWER_SUPPLY_POWER_AVG=0
> POWER_SUPPLY_HEALTH=Good
> POWER_SUPPLY_MANUFACTURER=Texas Instruments
>
> reason: the state of charge and the design capacity register are single
> byte only. The design capacity returns the higer order byte.
>
> tested: GTA04 with Openmoko/FIC HF08x battery (using hdq)
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>   drivers/power/bq27xxx_battery.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
> index 880233c..e54a125 100644
> --- a/drivers/power/bq27xxx_battery.c
> +++ b/drivers/power/bq27xxx_battery.c
> @@ -471,7 +471,10 @@ static int bq27xxx_battery_read_soc(struct bq27xxx_device_info *di)
>   {
>   	int soc;
>
> -	soc = bq27xxx_read(di, BQ27XXX_REG_SOC, false);
> +	if (di->chip == BQ27000 || di->chip == BQ27010)
> +		soc = bq27xxx_read(di, BQ27XXX_REG_SOC, true);
> +	else
> +		soc = bq27xxx_read(di, BQ27XXX_REG_SOC, false);
>
>   	if (soc < 0)
>   		dev_dbg(di->dev, "error reading State-of-Charge\n");
> @@ -536,7 +539,10 @@ static int bq27xxx_battery_read_dcap(struct bq27xxx_device_info *di)
>   {
>   	int dcap;
>
> -	dcap = bq27xxx_read(di, BQ27XXX_REG_DCAP, false);
> +	if (di->chip == BQ27000 || di->chip == BQ27010)
> +		dcap = bq27xxx_read(di, BQ27XXX_REG_DCAP, true);
> +	else
> +		dcap = bq27xxx_read(di, BQ27XXX_REG_DCAP, false);
>

I'm wondering how the I2C versions will be effected by this change, will
we get the right byte when we only read one? Maybe the fix should be
to still read 2-bytes but mask out the right bits from the result? The
data-sheet doesn't seem clear on this.

Well, it is more right than it was before, I'll look for a bq27200 to
test and make changes if needed some other time, but for now:

Acked-by: Andrew F. Davis <afd@ti.com>

>   	if (dcap < 0) {
>   		dev_dbg(di->dev, "error reading initial last measured discharge\n");
> @@ -544,7 +550,7 @@ static int bq27xxx_battery_read_dcap(struct bq27xxx_device_info *di)
>   	}
>
>   	if (di->chip == BQ27000 || di->chip == BQ27010)
> -		dcap *= BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
> +		dcap = (dcap << 8) * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
>   	else
>   		dcap *= 1000;
>
>

-- 
Andrew F. Davis
