From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 08/18] staging: typec: fusb302: Add support for USB2
 charger detection through extcon
Date: Sun, 6 Aug 2017 07:22:40 -0700
Message-ID: <9de0a2f3-7316-5a7d-d715-29e83a278844@roeck-us.net>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-9-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46979 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdHFOWn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Aug 2017 10:22:43 -0400
In-Reply-To: <20170806123555.5124-9-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org

On 08/06/2017 05:35 AM, Hans de Goede wrote:
> The fusb302 port-controller relies on an external device doing USB2
> charger-type detection.
> 
> The Intel Whiskey Cove PMIC with which the fusb302 is combined on some
> X86/ACPI platforms already has a charger-type detection driver which
> uses extcon to communicate the detected charger-type.
> 
> This commit uses the tcpm_get_usb2_current_limit_extcon helper to enable
> USB2 charger detection on these systems. Note that the "fcs,extcon-name"
> property name is only for kernel internal use by X86/ACPI platform code
> and as such is NOT documented in the devicetree bindings.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/staging/typec/fusb302/fusb302.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
> index be454b5ff6c7..1d8c9b66df2f 100644
> --- a/drivers/staging/typec/fusb302/fusb302.c
> +++ b/drivers/staging/typec/fusb302/fusb302.c
> @@ -1201,6 +1201,8 @@ static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
>   {
>   	fusb302_tcpc_dev->init = tcpm_init;
>   	fusb302_tcpc_dev->get_vbus = tcpm_get_vbus;
> +	fusb302_tcpc_dev->get_usb2_current_limit =
> +		tcpm_get_usb2_current_limit_extcon;
>   	fusb302_tcpc_dev->set_cc = tcpm_set_cc;
>   	fusb302_tcpc_dev->get_cc = tcpm_get_cc;
>   	fusb302_tcpc_dev->set_polarity = tcpm_set_polarity;
> @@ -1685,6 +1687,7 @@ static int fusb302_probe(struct i2c_client *client,
>   	struct fusb302_chip *chip;
>   	struct i2c_adapter *adapter;
>   	struct device *dev = &client->dev;
> +	const char *name;
>   	int ret = 0;
>   	u32 val;
>   
> @@ -1717,6 +1720,19 @@ static int fusb302_probe(struct i2c_client *client,
>   	if (device_property_read_u32(dev, "fcs,operating-snk-mw", &val) == 0)
>   		chip->tcpc_config.operating_snk_mw = val;
>   
> +	/*
> +	 * Devicetree platforms should get extcon via phandle (not yet
> +	 * supported). On ACPI platforms, we get the name from a device prop.
> +	 * This device prop is for kernel internal use only and is expected
> +	 * to be set by the platform code which also registers the i2c client
> +	 * for the fusb302.
> +	 */
> +	if (device_property_read_string(dev, "fcs,extcon-name", &name) == 0) {

Those new devicetree properties need to be documented and approved by dt maintainers.

> +		chip->tcpc_dev.usb2_extcon = extcon_get_extcon_dev(name);
> +		if (!chip->tcpc_dev.usb2_extcon)

extcon_get_extcon_dev() can also return an ERR_PTR.

As before, I am not really happy typing this into tcpm via tcpc_dev.
Until we have a better solution, I would prefer for that code to stay with the fusb302
code.

> +			return -EPROBE_DEFER;
> +	}
> +
>   	ret = fusb302_debugfs_init(chip);
>   	if (ret < 0)
>   		return ret;
> 
