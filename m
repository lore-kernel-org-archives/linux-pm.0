From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v8 4/6] power: supply: Add 'usb_type' property and
 supporting code
Date: Tue, 24 Apr 2018 15:46:39 +0300
Message-ID: <20180424124639.GF25723@kuha.fi.intel.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
 <36488aeca4c870e24ddbcf8bc9d3064c9973413f.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <36488aeca4c870e24ddbcf8bc9d3064c9973413f.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 23, 2018 at 03:10:59PM +0100, Adam Thomson wrote:
> This commit adds the 'usb_type' property to represent USB supplies
> which can report a number of different types based on a connection
> event.
> 
> Examples of this already exist in drivers whereby the existing 'type'
> property is updated, based on an event, to represent what was
> connected (e.g. USB, USB_DCP, USB_ACA, ...). Current implementations
> however don't show all supported connectable types, so this knowledge
> has to be exlicitly known for each driver that supports this.
> 
> The 'usb_type' property is intended to fill this void and show users
> all possible USB types supported by a driver. The property, when read,
> shows all available types for the driver, and the one currently chosen
> is highlighted/bracketed. It is expected that the 'type' property
> would then just show the top-level type 'USB', and this would be
> static.
> 
> Currently the 'usb_type' enum contains all of the USB variant types
> that exist for the 'type' enum at this time, and in addition has
> SDP and PPS types. The mirroring is intentional so as to not impact
> existing usage of the 'type' property.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  Documentation/ABI/testing/sysfs-class-power | 12 ++++++++
>  drivers/power/supply/power_supply_core.c    |  8 ++++-
>  drivers/power/supply/power_supply_sysfs.c   | 45 +++++++++++++++++++++++++++++
>  include/linux/power_supply.h                | 16 ++++++++++
>  4 files changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index e046566..5e23e22 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -409,6 +409,18 @@ Description:
>  		Access: Read
>  		Valid values: Represented in 1/10 Degrees Celsius
>  
> +What: 		/sys/class/power_supply/<supply_name>/usb_type
> +Date:		March 2018
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Reports what type of USB connection is currently active for
> +		the supply, for example it can show if USB-PD capable source
> +		is attached.
> +
> +		Access: Read-Only
> +		Valid values: "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
> +			      "PD_DRP", "PD_PPS", "BrickID"
> +
>  What: 		/sys/class/power_supply/<supply_name>/voltage_max
>  Date:		January 2008
>  Contact:	linux-pm@vger.kernel.org
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index a7984af..ecd68c2 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -843,7 +843,7 @@ static void psy_unregister_cooler(struct power_supply *psy)
>  {
>  	struct device *dev;
>  	struct power_supply *psy;
> -	int rc;
> +	int i, rc;
>  
>  	if (!parent)
>  		pr_warn("%s: Expected proper parent device for '%s'\n",
> @@ -852,6 +852,12 @@ static void psy_unregister_cooler(struct power_supply *psy)
>  	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
>  		return ERR_PTR(-EINVAL);
>  
> +	for (i = 0; i < desc->num_properties; ++i) {
> +		if ((desc->properties[i] == POWER_SUPPLY_PROP_USB_TYPE) &&
> +		    (!desc->usb_types || !desc->num_usb_types))
> +			return ERR_PTR(-EINVAL);
> +	}
> +
>  	psy = kzalloc(sizeof(*psy), GFP_KERNEL);
>  	if (!psy)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 5204f11..1350068 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -46,6 +46,11 @@
>  	"USB_PD", "USB_PD_DRP", "BrickID"
>  };
>  
> +static const char * const power_supply_usb_type_text[] = {
> +	"Unknown", "SDP", "DCP", "CDP", "ACA", "C",
> +	"PD", "PD_DRP", "PD_PPS", "BrickID"
> +};
> +
>  static const char * const power_supply_status_text[] = {
>  	"Unknown", "Charging", "Discharging", "Not charging", "Full"
>  };
> @@ -73,6 +78,41 @@
>  	"Unknown", "System", "Device"
>  };
>  
> +static ssize_t power_supply_show_usb_type(struct device *dev,
> +					  enum power_supply_usb_type *usb_types,
> +					  ssize_t num_usb_types,
> +					  union power_supply_propval *value,
> +					  char *buf)
> +{
> +	enum power_supply_usb_type usb_type;
> +	ssize_t count = 0;
> +	bool match = false;
> +	int i;
> +
> +	for (i = 0; i < num_usb_types; ++i) {
> +		usb_type = usb_types[i];
> +
> +		if (value->intval == usb_type) {
> +			count += sprintf(buf + count, "[%s] ",
> +					 power_supply_usb_type_text[usb_type]);
> +			match = true;
> +		} else {
> +			count += sprintf(buf + count, "%s ",
> +					 power_supply_usb_type_text[usb_type]);
> +		}
> +	}
> +
> +	if (!match) {
> +		dev_warn(dev, "driver reporting unsupported connected type\n");
> +		return -EINVAL;
> +	}
> +
> +	if (count)
> +		buf[count - 1] = '\n';
> +
> +	return count;
> +}
> +
>  static ssize_t power_supply_show_property(struct device *dev,
>  					  struct device_attribute *attr,
>  					  char *buf) {
> @@ -115,6 +155,10 @@ static ssize_t power_supply_show_property(struct device *dev,
>  	else if (off == POWER_SUPPLY_PROP_TYPE)
>  		return sprintf(buf, "%s\n",
>  			       power_supply_type_text[value.intval]);
> +	else if (off == POWER_SUPPLY_PROP_USB_TYPE)
> +		return power_supply_show_usb_type(dev, psy->desc->usb_types,
> +						  psy->desc->num_usb_types,
> +						  &value, buf);
>  	else if (off == POWER_SUPPLY_PROP_SCOPE)
>  		return sprintf(buf, "%s\n",
>  			       power_supply_scope_text[value.intval]);
> @@ -241,6 +285,7 @@ static ssize_t power_supply_store_property(struct device *dev,
>  	POWER_SUPPLY_ATTR(time_to_full_now),
>  	POWER_SUPPLY_ATTR(time_to_full_avg),
>  	POWER_SUPPLY_ATTR(type),
> +	POWER_SUPPLY_ATTR(usb_type),
>  	POWER_SUPPLY_ATTR(scope),
>  	POWER_SUPPLY_ATTR(precharge_current),
>  	POWER_SUPPLY_ATTR(charge_term_current),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index f0139b4..0c9a572 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -145,6 +145,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
>  	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
>  	POWER_SUPPLY_PROP_TYPE, /* use power_supply.type instead */
> +	POWER_SUPPLY_PROP_USB_TYPE,
>  	POWER_SUPPLY_PROP_SCOPE,
>  	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
>  	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
> @@ -170,6 +171,19 @@ enum power_supply_type {
>  	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  };
>  
> +enum power_supply_usb_type {
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN = 0,
> +	POWER_SUPPLY_USB_TYPE_SDP,		/* Standard Downstream Port */
> +	POWER_SUPPLY_USB_TYPE_DCP,		/* Dedicated Charging Port */
> +	POWER_SUPPLY_USB_TYPE_CDP,		/* Charging Downstream Port */
> +	POWER_SUPPLY_USB_TYPE_ACA,		/* Accessory Charger Adapters */
> +	POWER_SUPPLY_USB_TYPE_C,		/* Type C Port */
> +	POWER_SUPPLY_USB_TYPE_PD,		/* Power Delivery Port */
> +	POWER_SUPPLY_USB_TYPE_PD_DRP,		/* PD Dual Role Port */
> +	POWER_SUPPLY_USB_TYPE_PD_PPS,		/* PD Programmable Power Supply */
> +	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
> +};
> +
>  enum power_supply_notifier_events {
>  	PSY_EVENT_PROP_CHANGED,
>  };
> @@ -196,6 +210,8 @@ struct power_supply_config {
>  struct power_supply_desc {
>  	const char *name;
>  	enum power_supply_type type;
> +	enum power_supply_usb_type *usb_types;
> +	size_t num_usb_types;
>  	enum power_supply_property *properties;
>  	size_t num_properties;
>  
> -- 
> 1.9.1

-- 
heikki
