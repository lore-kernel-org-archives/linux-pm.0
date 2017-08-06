From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 11/18] power: supply: Fix power_supply_am_i_supplied to
 return -ENODEV when apropriate
Date: Sun, 6 Aug 2017 07:31:09 -0700
Message-ID: <31e2a928-61f8-4706-9981-0d2e9ab2bc10@roeck-us.net>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-12-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56697 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbdHFObN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Aug 2017 10:31:13 -0400
In-Reply-To: <20170806123555.5124-12-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org

On 08/06/2017 05:35 AM, Hans de Goede wrote:
> Commit 2848e039c562 ("power: supply: Make power_supply_am_i_supplied return
> -ENODEV if there are no suppliers") was supposed to make
> power_supply_am_i_supplied() return -ENODEV when there are no supplies
> which supply the supply passed to it.
> 
> But instead it will only return -ENODEV when there are no supplies at
> all as data->count++; is incremented on every call of the iterator, rather
> then only when __power_supply_is_supplied_by returns true. This commit
> fixes this.
> 
> Fixes: 2848e039c562 ("power: supply: Make power_supply_am_i_supplied ...")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Independent of this series ?

> ---
>   drivers/power/supply/power_supply_core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 540d3e0aa011..0741fcef3b44 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -314,11 +314,12 @@ static int __power_supply_am_i_supplied(struct device *dev, void *_data)
>   	struct power_supply *epsy = dev_get_drvdata(dev);
>   	struct psy_am_i_supplied_data *data = _data;
>   
> -	data->count++;
> -	if (__power_supply_is_supplied_by(epsy, data->psy))
> +	if (__power_supply_is_supplied_by(epsy, data->psy)) {
> +		data->count++;
>   		if (!epsy->desc->get_property(epsy, POWER_SUPPLY_PROP_ONLINE,
>   					&ret))
>   			return ret.intval;
> +	}
>   
>   	return 0;
>   }
> 
