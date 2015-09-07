From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] power: bq24261_charger: Add support for TI BQ24261 charger
Date: Mon, 7 Sep 2015 12:57:56 +0900
Message-ID: <CAJKOXPfDu+LxoiQrV+CsqUbEVwYb1Zmk-m9y-L_1JxrB6ouS0g@mail.gmail.com>
References: <1441560187-23611-1-git-send-email-ramakrishna.pallala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35172 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbbIGD55 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 6 Sep 2015 23:57:57 -0400
In-Reply-To: <1441560187-23611-1-git-send-email-ramakrishna.pallala@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Jenny TC <jenny.tc@intel.com>, Andreas Dannenberg <dannenberg@ti.com>

2015-09-07 2:23 GMT+09:00 Ramakrishna Pallala <ramakrishna.pallala@intel.com>:
>
> Add new charger driver support for BQ24261 charger IC.
>
> BQ24261 charger driver relies on extcon notifications to get the
> charger cable type and based on that it will set the charging parameters.
>
> Signed-off-by: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> Signed-off-by: Jennt TC <jenny.tc@intel.com>
> ---
>  .../devicetree/bindings/power/bq24261.txt          |   37 +
>  drivers/power/Kconfig                              |    6 +
>  drivers/power/Makefile                             |    1 +
>  drivers/power/bq24261_charger.c                    | 1208 ++++++++++++++++++++
>  include/linux/power/bq24261_charger.h              |   27 +
>  5 files changed, 1279 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/bq24261.txt
>  create mode 100644 drivers/power/bq24261_charger.c
>  create mode 100644 include/linux/power/bq24261_charger.h
>
> diff --git a/Documentation/devicetree/bindings/power/bq24261.txt b/Documentation/devicetree/bindings/power/bq24261.txt
> new file mode 100644
> index 0000000..25fc5c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/bq24261.txt
> @@ -0,0 +1,37 @@
> +Binding for TI bq24261 Li-Ion Charger

Please split the bindings into separate patch (the first patch in patchset).

> +
> +Required properties:
> +- compatible: Should contain one of the following:
> +    * "ti,bq24261"
> +- reg: integer, i2c address of the device.
> +- ti,charge-current: integer, default charging current (in mA);
> +- ti,charge-voltage: integer, default charging voltage (in mV);
> +- ti,termination-current: integer, charge will be terminated when current in
> +    constant-voltage phase drops below this value (in mA);
> +- ti,max-charge-current: integer, maximum charging current (in mA);
> +- ti,max-charge-voltage: integer, maximum charging voltage (in mV);
> +- ti,min-charge-temperature: integer, minimum charging temperature (in DegC);
> +- ti,max-charge-temperature: integer, maximum charging temperature (in DegC).

Before accepting "[PATCH 13/13] dt: power: bq24257-charger: Cover
additional devices"
http://www.spinics.net/lists/devicetree/msg92134.html

could you and Andreas figure out common bindings? Look at this:

+- ti,charge-current: integer, maximum charging current in uA.
+- ti,charge-current: integer, default charging current (in mA);

Different meaning and different units. This is madness! :)

In the same time you are adding TI-common bindings (not device
specific, there is no prefix) so I would expect exactly the same
bindings if it is possible.


> +
> +Optional properties:
> +- ti,thermal-sensing: boolean, if present thermal regulation will be enabled;

What is the requirement for thermal-sensing? Can it be enabled always?
If yes, then this is not really a hardware property.

> +- ti,enable-user-write: boolean, if present driver will allow the user space
> +    to control the charging current and voltage through sysfs;

This is not DT property. It does not describe hardware.

Best regards,
Krzysztof

> +
> +Example:
> +
> +bq25890 {
> +        compatible = "ti,bq24261
> +        reg = <0x6b>;
> +
> +        ti,charge-current = <1000>;
> +        ti,charge-voltage = <4200>;
> +        ti,termination-current = <128>;
> +        ti,max-charge-current = <3000>;
> +        ti,max-charge-voltage = <4350>;
> +        ti,min-charge-temperature = <0>;
> +        ti,max-charge-temperature = <60>;
> +
> +        ti,thermal-sensing;
> +        ti,enable-user-write;
> +};
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index f8758d6..cd47d0d 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -396,6 +396,12 @@ config CHARGER_BQ24190
>         help
>           Say Y to enable support for the TI BQ24190 battery charger.
>
> +config CHARGER_BQ24261
> +       tristate "TI BQ24261 charger driver"
> +       depends on I2C && EXTCON
> +       help
> +         Say Y here to enable support for TI BQ24261 battery charger.
> +
>  config CHARGER_BQ24257
>         tristate "TI BQ24257 battery charger driver"
>         depends on I2C
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 5752ce8..bec8409 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_CHARGER_MAX8997) += max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)  += max8998_charger.o
>  obj-$(CONFIG_CHARGER_BQ2415X)  += bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)  += bq24190_charger.o
> +obj-$(CONFIG_CHARGER_BQ24261)  += bq24261_charger.o
>  obj-$(CONFIG_CHARGER_BQ24257)  += bq24257_charger.o
>  obj-$(CONFIG_CHARGER_BQ24735)  += bq24735-charger.o
>  obj-$(CONFIG_CHARGER_BQ25890)  += bq25890_charger.o
