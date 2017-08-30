From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 05/11] staging: typec: fusb302: Use client->irq as irq
 if set
Date: Wed, 30 Aug 2017 06:56:34 -0700
Message-ID: <7e94e85c-11a7-2d54-d645-7cae5e15d428@roeck-us.net>
References: <20170830094814.17758-1-hdegoede@redhat.com>
 <20170830094814.17758-6-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170830094814.17758-6-hdegoede@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Yueyao (Nathan) Zhu" <yueyao@google.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Liam Breck <liam@networkimprov.net>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/30/2017 02:48 AM, Hans de Goede wrote:
> The fusb302 is also used on x86 systems where the platform code sets
> the irq in client->irq and there is no gpio named fcs,int_n.
> 
> Cc: "Yueyao (Nathan) Zhu" <yueyao@google.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/staging/typec/fusb302/fusb302.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
> index 1c1751c994db..675161cf4f3a 100644
> --- a/drivers/staging/typec/fusb302/fusb302.c
> +++ b/drivers/staging/typec/fusb302/fusb302.c
> @@ -1735,9 +1735,13 @@ static int fusb302_probe(struct i2c_client *client,
>   		goto destroy_workqueue;
>   	}
>   
> -	ret = init_gpio(chip);
> -	if (ret < 0)
> -		goto destroy_workqueue;
> +	if (client->irq) {
> +		chip->gpio_int_n_irq = client->irq;
> +	} else {
> +		ret = init_gpio(chip);
> +		if (ret < 0)
> +			goto destroy_workqueue;
> +	}
>   
>   	chip->tcpm_port = tcpm_register_port(&client->dev, &chip->tcpc_dev);
>   	if (IS_ERR(chip->tcpm_port)) {
> 
