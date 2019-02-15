From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] max17042_battery: fix potential use-after-free on device
 remove
Date: Fri, 15 Feb 2019 23:08:19 +0100
Message-ID: <3e771d70-4e51-114c-6e00-460b34dd0909@redhat.com>
References: <20190215220344.16604-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215220344.16604-1-TheSven73@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 2/15/19 11:03 PM, Sven Van Asbroeck wrote:
> The work which is scheduled on a POR boot is potentially left
> pending or running until after the device module is removed,
> which could result in a use-after-free.
> 
> Fix by registering a cancel/sync callback, which gets executed as
> part of standard resource unwinding.
> 
> This issue was detected with the help of Coccinelle.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>

Looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/power/supply/max17042_battery.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index 2a8d75e5e930..581c6bd23388 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -995,6 +995,13 @@ static const struct power_supply_desc max17042_no_current_sense_psy_desc = {
>   	.num_properties	= ARRAY_SIZE(max17042_battery_props) - 2,
>   };
>   
> +static void max17042_stop_work(void *data)
> +{
> +	struct max17042_chip *chip = data;
> +
> +	cancel_work_sync(&chip->work);
> +}
> +
>   static int max17042_probe(struct i2c_client *client,
>   			const struct i2c_device_id *id)
>   {
> @@ -1101,6 +1108,9 @@ static int max17042_probe(struct i2c_client *client,
>   	regmap_read(chip->regmap, MAX17042_STATUS, &val);
>   	if (val & STATUS_POR_BIT) {
>   		INIT_WORK(&chip->work, max17042_init_worker);
> +		ret = devm_add_action(&client->dev, max17042_stop_work, chip);
> +		if (ret)
> +			return ret;
>   		schedule_work(&chip->work);
>   	} else {
>   		chip->init_complete = 1;
> 
