From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] power: supply: fix spelling mistake "Gauage" -> "Guage"
Date: Sat, 13 Oct 2018 16:28:45 +0100
Message-ID: <4f424c43-29b6-c8a8-12a8-13e38b28306a@canonical.com>
References: <20181013152727.5520-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181013152727.5520-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13/10/2018 16:27, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in MODULE_DESCRIPTION text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/supply/ds2780_battery.c | 2 +-
>  drivers/power/supply/ds2781_battery.c | 2 +-
>  drivers/power/supply/ds2782_battery.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
> index 370e9109342b..cad14ba1b648 100644
> --- a/drivers/power/supply/ds2780_battery.c
> +++ b/drivers/power/supply/ds2780_battery.c
> @@ -829,5 +829,5 @@ module_platform_driver(ds2780_battery_driver);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Clifton Barnes <cabarnes@indesign-llc.com>");
> -MODULE_DESCRIPTION("Maxim/Dallas DS2780 Stand-Alone Fuel Gauage IC driver");
> +MODULE_DESCRIPTION("Maxim/Dallas DS2780 Stand-Alone Fuel Gauge IC driver");
>  MODULE_ALIAS("platform:ds2780-battery");
> diff --git a/drivers/power/supply/ds2781_battery.c b/drivers/power/supply/ds2781_battery.c
> index d1b5a19aae7c..5e794607f732 100644
> --- a/drivers/power/supply/ds2781_battery.c
> +++ b/drivers/power/supply/ds2781_battery.c
> @@ -829,6 +829,6 @@ module_platform_driver(ds2781_battery_driver);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Renata Sayakhova <renata@oktetlabs.ru>");
> -MODULE_DESCRIPTION("Maxim/Dallas DS2781 Stand-Alone Fuel Gauage IC driver");
> +MODULE_DESCRIPTION("Maxim/Dallas DS2781 Stand-Alone Fuel Gauge IC driver");
>  MODULE_ALIAS("platform:ds2781-battery");
>  
> diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
> index a1b7e0592245..019c58493e3d 100644
> --- a/drivers/power/supply/ds2782_battery.c
> +++ b/drivers/power/supply/ds2782_battery.c
> @@ -471,5 +471,5 @@ static struct i2c_driver ds278x_battery_driver = {
>  module_i2c_driver(ds278x_battery_driver);
>  
>  MODULE_AUTHOR("Ryan Mallon");
> -MODULE_DESCRIPTION("Maxim/Dallas DS2782 Stand-Alone Fuel Gauage IC driver");
> +MODULE_DESCRIPTION("Maxim/Dallas DS2782 Stand-Alone Fuel Gauge IC driver");
>  MODULE_LICENSE("GPL");
> 

Oops, spelling mistake in title, should be "Gauge" and not "Guage".
