From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power: supply: bq2415x: check for NULL acpi_id to avoid
 null pointer dereference
Date: Sat, 21 Jan 2017 01:02:20 +0100
Message-ID: <20170121000220.GI32502@pali>
References: <20170120132506.20514-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170120132506.20514-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 20 January 2017 13:25:06 Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> acpi_match_device can potentially return NULL, so it is prudent to
> check if acpi_id is null before it is dereferenced.  Add a check
> and an error message to indicate the failure.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/supply/bq2415x_charger.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
> index 73e2f0b..c4770a9 100644
> --- a/drivers/power/supply/bq2415x_charger.c
> +++ b/drivers/power/supply/bq2415x_charger.c
> @@ -1569,6 +1569,11 @@ static int bq2415x_probe(struct i2c_client *client,
>  		acpi_id =
>  			acpi_match_device(client->dev.driver->acpi_match_table,
>  					  &client->dev);
> +		if (!acpi_id) {
> +			dev_err(&client->dev, "failed to match device name\n");
> +			ret = -ENODEV;
> +			goto error_1;
> +		}
>  		name = kasprintf(GFP_KERNEL, "%s-%d", acpi_id->id, num);
>  	}
>  	if (!name) {

Looks good! Add my Reviewed-by.

-- 
Pali Rohár
pali.rohar@gmail.com
