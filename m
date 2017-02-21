From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 04/18] iio: adc: add support for X-Powers AXP20X and
 AXP22X PMICs ADCs
Date: Tue, 21 Feb 2017 12:32:13 +0800
Message-ID: <CAGb2v66D-11CcuPoTWGtBuy4z3uUu4Srgg-CZv-B9ua8p0dhzg@mail.gmail.com>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-5-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170214094112.27426-5-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 14, 2017 at 5:40 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
> battery voltage, battery charge and discharge currents, AC-in and VBUS
> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
>
> This adds support for most of AXP20X and AXP22X ADCs.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>
> v3:
>  - moved from switch to if condition in axp20x_adc_raw and
>  axp22x_adc_raw,
>  - removed DT support as DT node has been dropped,
>    - use of platform_device_id
>  - correctly defined the name of the iio device (name used to probe the
>  driver),
>  - added goto for errors in probe,
>  - added iio_map_array_unregister to the remove function,
>
> v2:
>  - removed unused defines,
>  - changed BIT(x) to 1 << x when describing bits purpose for which 2 <<
>  x or 3 << x exists, to be consistent,
>  - changed ADC rate defines to macro formulas,
>  - reordered IIO channels, now different measures (current/voltage) of
>  the same part of the PMIC (e.g. battery), have the same IIO channel in
>  their respective IIO type. When a part of the PMIC have only one
>  measure, a number is jumped,
>  - left IIO channel mapping in DT to use iio_map structure,
>  - removed indexing of ADC internal temperature,
>  - removed unused iio_dev structure in axp20x_adc_iio,
>  - added a structure for data specific to AXP20X or AXP22X PMICs instead
>  of using an ID and an if condition when needing to separate the
>  behaviour of both,
>  - added a comment on batt_chrg_i really being on 12bits rather than
>  what the Chinese datasheets say (13 bits),
>  - corrected the offset for AXP22X PMIC temperature,
>  - set the ADC rate to a value (100Hz) shared by the AXP20X and AXP22X,
>  - created macro formulas to compute the ADC rate for each,
>  - added a condition on presence of ADC_EN2 reg before setting/resetting
>  it,
>  - switched from devm_iio_device_unregister to the non-devm function
>  because of the need for a remove function,
>  - removed some dead code,
>
>  drivers/iio/adc/Kconfig      |  10 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/axp20x_adc.c | 606 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 617 insertions(+)
>  create mode 100644 drivers/iio/adc/axp20x_adc.c
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 9c8b558..ed17fe1 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -154,6 +154,16 @@ config AT91_SAMA5D2_ADC
>           To compile this driver as a module, choose M here: the module will be
>           called at91-sama5d2_adc.
>
> +config AXP20X_ADC
> +       tristate "X-Powers AXP20X and AXP22X ADC driver"
> +       depends on MFD_AXP20X
> +       help
> +         Say yes here to have support for X-Powers power management IC (PMIC)
> +         AXP20X and AXP22X ADC devices.
> +
> +         To compile this driver as a module, choose M here: the module will be
> +         called axp20x_adc.
> +
>  config AXP288_ADC
>         tristate "X-Powers AXP288 ADC driver"
>         depends on MFD_AXP20X
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d36c4be..f5c28a5 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD7887) += ad7887.o
>  obj-$(CONFIG_AD799X) += ad799x.o
>  obj-$(CONFIG_AT91_ADC) += at91_adc.o
>  obj-$(CONFIG_AT91_SAMA5D2_ADC) += at91-sama5d2_adc.o
> +obj-$(CONFIG_AXP20X_ADC) += axp20x_adc.o
>  obj-$(CONFIG_AXP288_ADC) += axp288_adc.o
>  obj-$(CONFIG_BCM_IPROC_ADC) += bcm_iproc_adc.o
>  obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> new file mode 100644
> index 0000000..5ef6af8
> --- /dev/null
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -0,0 +1,606 @@

[...]

> +
> +static const struct platform_device_id axp20x_adc_id_match[] = {
> +       { .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
> +       { .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
> +       { /* sentinel */ },
> +};

MODULE_DEVICE_TABLE(platform, axp20x_adc_id_match);

So module autoloading works. Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> +
> +static int axp20x_probe(struct platform_device *pdev)
> +{
> +       struct axp20x_adc_iio *info;
> +       struct iio_dev *indio_dev;
> +       struct axp20x_dev *axp20x_dev;
> +       int ret;
> +
> +       axp20x_dev = dev_get_drvdata(pdev->dev.parent);
> +
> +       indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       info = iio_priv(indio_dev);
> +       platform_set_drvdata(pdev, indio_dev);
> +
> +       info->regmap = axp20x_dev->regmap;
> +       indio_dev->dev.parent = &pdev->dev;
> +       indio_dev->dev.of_node = pdev->dev.of_node;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +       info->data = (struct axp_data *)platform_get_device_id(pdev)->driver_data;
> +
> +       indio_dev->name = platform_get_device_id(pdev)->name;
> +       indio_dev->info = info->data->iio_info;
> +       indio_dev->num_channels = info->data->num_channels;
> +       indio_dev->channels = info->data->channels;
> +
> +       /* Enable the ADCs on IP */
> +       regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
> +
> +       if (info->data->adc_en2)
> +               /* Enable GPIO0/1 and internal temperature ADCs */
> +               regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
> +                                  AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
> +
> +       /* Configure ADCs rate */
> +       regmap_update_bits(info->regmap, AXP20X_ADC_RATE, AXP20X_ADC_RATE_MASK,
> +                          info->data->adc_rate(100));
> +
> +       ret = iio_map_array_register(indio_dev, info->data->maps);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to register IIO maps: %d\n", ret);
> +               goto fail_map;
> +       }
> +
> +       ret = iio_device_register(indio_dev);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "could not register the device\n");
> +               goto fail_register;
> +       }
> +
> +       return 0;
> +
> +fail_register:
> +       iio_map_array_unregister(indio_dev);
> +
> +fail_map:
> +       regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
> +
> +       if (info->data->adc_en2)
> +               regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
> +
> +       return ret;
> +}
> +
> +static int axp20x_remove(struct platform_device *pdev)
> +{
> +       struct axp20x_adc_iio *info;
> +       struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +
> +       info = iio_priv(indio_dev);
> +
> +       iio_device_unregister(indio_dev);
> +       iio_map_array_unregister(indio_dev);
> +
> +       regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
> +
> +       if (info->data->adc_en2)
> +               regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver axp20x_adc_driver = {
> +       .driver = {
> +               .name = "axp20x-adc",
> +       },
> +       .id_table = axp20x_adc_id_match,
> +       .probe = axp20x_probe,
> +       .remove = axp20x_remove,
> +};
> +
> +module_platform_driver(axp20x_adc_driver);
> +
> +MODULE_DESCRIPTION("ADC driver for AXP20X and AXP22X PMICs");
> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.9.3
>
