From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 1/3] mfd: cros: add charger port count command definition
Date: Fri, 1 Jun 2018 18:40:18 +0200
Message-ID: <CAFqH_525z=b2etKO7SGKjJNnsqLrzPp+QL35YPa+EZoiiyN0ug@mail.gmail.com>
References: <20180530031704.18597-1-fparent@baylibre.com> <20180530031704.18597-2-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530031704.18597-2-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: Sebastian Reichel <sre@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, gpain@baylibre.com
List-Id: linux-pm@vger.kernel.org

2018-05-30 5:17 GMT+02:00 Fabien Parent <fparent@baylibre.com>:
> A new more command has been added to the ChromeOS embedded controller
> that allows to get the number of charger port count. Unlike
> EC_CMD_USB_PD_PORTS, this new command also includes the dedicated
> port if present.
>
> This command will be used to expose the dedicated charger port
> in the ChromeOS charger driver.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  include/linux/mfd/cros_ec_commands.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
> index 0d926492ac3a..e3187f8bdb7e 100644
> --- a/include/linux/mfd/cros_ec_commands.h
> +++ b/include/linux/mfd/cros_ec_commands.h
> @@ -3005,6 +3005,16 @@ struct ec_params_usb_pd_info_request {
>         uint8_t port;
>  } __packed;
>
> +/*
> + * This command will return the number of USB PD charge port + the number
> + * of dedicated port present.
> + * EC_CMD_USB_PD_PORTS does NOT include the dedicated ports
> + */
> +#define EC_CMD_CHARGE_PORT_COUNT 0x0105
> +struct ec_response_charge_port_count {
> +       uint8_t port_count;
> +} __packed;
> +
>  /* Read USB-PD Device discovery info */
>  #define EC_CMD_USB_PD_DISCOVERY 0x0113
>  struct ec_params_usb_pd_discovery_entry {
> --
> 2.17.0
>

The patch looks good to me, ideally, will be good if you can add the
kernel-doc documentation for the struct, in any case

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
  Enric
