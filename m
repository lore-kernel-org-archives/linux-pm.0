From: Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH] power: bq24261_charger: Add support for TI BQ24261 charger
Date: Thu, 10 Sep 2015 01:47:50 +0300
Message-ID: <CALW4P+LXn29xvYMJy2Nb-M3gx7B7HtfeKHHtBxHn2or9pZC-GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Jenny TC <jenny.tc@intel.com>, Andreas Dannenberg <dannenberg@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi Ramakrishna,

On Sun, Sep 6, 2015 at 8:23 PM, Ramakrishna Pallala
<ramakrishna.pallala@intel.com> wrote:
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

[..]

> +static int bq24261_probe(struct i2c_client *client,
> +                        const struct i2c_device_id *id)
> +{
> +       struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> +       struct power_supply_config charger_cfg = {};
> +       struct bq24261_charger *chip;
> +       int ret;
> +       enum bq2426x_model model;
> +
> +       adapter = to_i2c_adapter(client->dev.parent);

Please also check if you really need to call to_i2c_adapter() twice.

-- 
Best regards, Klimov Alexey
