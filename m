From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 3/3] power: supply: cros: add property to detect connected ports
Date: Fri, 1 Jun 2018 18:30:57 +0200
Message-ID: <CAFqH_52541jTrMdBeNyq6Qhv4_GcF+YDHsGoXDXRTkUn0_tOYw@mail.gmail.com>
References: <20180530031704.18597-1-fparent@baylibre.com> <20180530031704.18597-4-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530031704.18597-4-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: Sebastian Reichel <sre@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, gpain@baylibre.com
List-Id: linux-pm@vger.kernel.org

Hi Fabien,

Many thanks for the patch.

2018-05-30 5:17 GMT+02:00 Fabien Parent <fparent@baylibre.com>:
> When a port is connected but acting as a source, its 'online' and
> 'status' properties are identical to a port that is not connected. This
> makes it tedious for userspace to know for sure whether a port is
> connected or not.
>
> This commit adds a new property 'present' to reflect whether a port
> is connected or not.
>

Actually, there is an attempt to align the usage of the different
properties between drivers [1]. According to current documentation,
the present property is used to report whether a battery is present or
not in the system. So, I am not sure if using the present property is
the proper way to do it. Maybe Sebastian can give us some clues or
preferences?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/tree/Documentation/ABI/testing/sysfs-class-power?h=for-next&id=91dabc54073324006d5eaba483679c47b6eb93a8#n159

Best regards,
  Enric

> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/power/supply/cros_usbpd-charger.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> index 808688a6586c..d44ab35670ab 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -32,6 +32,7 @@ struct port_data {
>         struct power_supply_desc psy_desc;
>         int psy_usb_type;
>         int psy_online;
> +       int psy_present;
>         int psy_status;
>         int psy_current_max;
>         int psy_voltage_max_design;
> @@ -54,6 +55,7 @@ struct charger_data {
>
>  static enum power_supply_property cros_usbpd_charger_props[] = {
>         POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_PRESENT,
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_CURRENT_MAX,
>         POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> @@ -65,6 +67,7 @@ static enum power_supply_property cros_usbpd_charger_props[] = {
>
>  static enum power_supply_property cros_usbpd_dedicated_charger_props[] = {
>         POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_PRESENT,
>         POWER_SUPPLY_PROP_STATUS,
>         POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  };
> @@ -205,18 +208,22 @@ static int cros_usbpd_charger_get_power_info(struct port_data *port)
>         case USB_PD_PORT_POWER_DISCONNECTED:
>                 port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 port->psy_online = 0;
> +               port->psy_present = 0;
>                 break;
>         case USB_PD_PORT_POWER_SOURCE:
>                 port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 port->psy_online = 0;
> +               port->psy_present = 1;
>                 break;
>         case USB_PD_PORT_POWER_SINK:
>                 port->psy_status = POWER_SUPPLY_STATUS_CHARGING;
>                 port->psy_online = 1;
> +               port->psy_present = 1;
>                 break;
>         case USB_PD_PORT_POWER_SINK_NOT_CHARGING:
>                 port->psy_status = POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 port->psy_online = 1;
> +               port->psy_present = 1;
>                 break;
>         default:
>                 dev_err(dev, "Unknown role %d\n", resp.role);
> @@ -362,6 +369,7 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
>                  */
>                 if (ec_device->mkbp_event_supported || port->psy_online)
>                         break;
> +       case POWER_SUPPLY_PROP_PRESENT:
>         case POWER_SUPPLY_PROP_CURRENT_MAX:
>         case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>         case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> @@ -380,6 +388,9 @@ static int cros_usbpd_charger_get_prop(struct power_supply *psy,
>         case POWER_SUPPLY_PROP_ONLINE:
>                 val->intval = port->psy_online;
>                 break;
> +       case POWER_SUPPLY_PROP_PRESENT:
> +               val->intval = port->psy_present;
> +               break;
>         case POWER_SUPPLY_PROP_STATUS:
>                 val->intval = port->psy_status;
>                 break;
> --
> 2.17.0
>
