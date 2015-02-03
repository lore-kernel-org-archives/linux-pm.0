From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v4] thermal: Add QPNP PMIC temperature alarm driver
Date: Tue, 03 Feb 2015 11:24:45 +0200
Message-ID: <1422955485.2177.31.camel@mm-sol.com>
References: <1422890370-6914-1-git-send-email-iivanov@mm-sol.com>
	 <20150202181446.GE17425@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150202181446.GE17425@developer.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org


Hi Eduardo,

On Mon, 2015-02-02 at 14:14 -0400, Eduardo Valentin wrote:
> Ivan,
> 
> On Mon, Feb 02, 2015 at 05:19:30PM +0200, Ivan T. Ivanov wrote:
> > Add support for the temperature alarm peripheral found inside
> > Qualcomm plug-and-play (QPNP) PMIC chips. The temperature alarm
> > peripheral outputs a pulse on an interrupt line whenever the
> > thermal over temperature stage value changes.
> > 
> > Register a thermal sensor. The temperature reported by this thermal
> > sensor device should reflect the actual PMIC die temperature if an
> > ADC is present on the given PMIC. If no ADC is present, then the
> > reported temperature should be estimated from the over temperature
> > stage value.
> > 
> > Cc: David Collins <collinsd@codeaurora.org>
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> > ---
> > 
> > Changes since v3:
> > 
> > - Driver register thermal sensor instead thermal zone. Device thermal zone
> >   should be properly described in DT files according thermal.txt document.
> 
> Thanks a lot for keeping this up. I believe the driver looks smaller and
> cleaner now, don't you agree?

Yep.

> 
> > - Dropped support for software override PMIC shutdown sequence and related
> >   bit definitions. If software did not take action for clean device shutdown,
> >   until critical temperature is reached, PMIC chip will execute internal
> >   pre-programed shutdown sequence.
> > 
> 
> OK. Let me know if this functionality is crucial and needs further
> discussion.

Unless I miss something, I think that this functionality is
used only for the purpose of debugging.

> 
> 
> I have two very minor comments as follows.
> 
> 
> > v3: http://comments.gmane.org/gmane.linux.ports.arm.msm/10071
> > 
> >  .../bindings/thermal/qcom-spmi-temp-alarm.txt      |  57 ++++
> >  drivers/thermal/Kconfig                            |  11 +
> >  drivers/thermal/Makefile                           |   1 +
> >  drivers/thermal/qcom-spmi-temp-alarm.c             | 311 +++++++++++++++++++++
> >  4 files changed, 380 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> >  create mode 100644 drivers/thermal/qcom-spmi-temp-alarm.c
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt 
> > b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> > new file mode 100644
> > index 0000000..290ec06
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> > @@ -0,0 +1,57 @@
> > +Qualcomm QPNP PMIC Temperature Alarm
> > +
> > +QPNP temperature alarm peripherals are found inside of Qualcomm PMIC chips
> > +that utilize the Qualcomm SPMI implementation. These peripherals provide an
> > +interrupt signal and status register to identify high PMIC die temperature.
> > +
> > +Required properties:
> > +- compatible:      Should contain "qcom,spmi-temp-alarm".
> > +- reg:             Specifies the SPMI address and length of the controller's
> > +                   registers.
> > +- interrupts:      PMIC temperature alarm interrupt.
> > +- #thermal-sensor-cells: Should be 0. See thermal.txt for a description.
> > +
> > +Optional properties:
> > +- io-channels:     Should contain IIO channel specifier for the ADC channel,
> > +                   which report chip die temperature.
> > +- io-channel-names: Should contain "thermal".
> > +
> > +Example:
> > +
> > +       pm8941_temp: thermal-alarm@2400 {
> > +               compatible = "qcom,spmi-temp-alarm";
> > +               reg = <0x2400 0x100>;
> > +               interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
> > +               #thermal-sensor-cells = <0>;
> > +
> > +               io-channels = <&pm8941_vadc VADC_DIE_TEMP>;
> > +               io-channel-names = "thermal";
> > +       };
> > +
> > +       thermal-zones {
> > +               pm8941 {
> > +                       polling-delay-passive = <250>;
> > +                       polling-delay = <1000>;
> > +
> > +                       thermal-sensors = <&pm8941_temp>;
> > +
> > +                       trips {
> > +                               passive {
> > +                                       temperature = <1050000>;
> > +                                       hysteresis = <2000>;
> > +                                       type = "passive";
> > +                               };
> > +                               alert {
> > +                                       temperature = <125000>;
> > +                                       hysteresis = <2000>;
> > +                                       type = "hot";
> > +                               };
> > +                               crit {
> > +                                       temperature = <145000>;
> > +                                       hysteresis = <2000>;
> > +                                       type = "critical";
> > +                               };
> > +                       };
> > +               };
> > +       };
> 
> Do you have the appropriate DT changes under architecture code too?
> 
> I mean, I am fine picking these changes, but should this series include
> also a minor inclusion under arch/arm/boot/dts too, given that you
> already did the hard part?

We don't have any DT files for these PMIC's upstream. Probably is time 
to start adding them. I have waiting to have some drivers accepted 
before pushing such changes. But not we have 2 types of ADC, RTC, GPIO's, 
MPP's and hopefully Thermal :-). I would like this to be a separate effort.


> > + * This function updates the internal temp value based on the
> > + * current thermal stage and threshold as well as the previous stage
> > + */
> > +static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
> > +{
> > +       unsigned int stage;
> > +       int ret;
> > +       u8 reg = 0;
> > +
> > +       ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       stage = reg & STATUS_STAGE_MASK;
> > +
> > +       if (stage > chip->stage) {
> > +               /* increasing stage, use lower bound */
> > +               chip->temp = (stage - 1) * TEMP_STAGE_STEP +
> > +                                                               chip->thresh * TEMP_THRESH_STEP 
> > +
> > +                                                               TEMP_STAGE_HYSTERESIS + 
> > TEMP_THRESH_MIN;
> > +       } else if (stage < chip->stage) {
> > +               /* decreasing stage, use upper bound */
> > +               chip->temp = stage * TEMP_STAGE_STEP +
> > +                                                               chip->thresh * TEMP_THRESH_STEP 
> > -
> > +                                                               TEMP_STAGE_HYSTERESIS + 
> > TEMP_THRESH_MIN;
> > +       }
> 
> For my own edification, no change in state means no change in
> temperature too, right?

More or less, just no way to estimate exact temperature
between stages.

> 
> > +
> > +       chip->stage = stage;
> > +
> > +       return 0;
> > +}
> > +

<snip>

> > +static int qpnp_tm_probe(struct platform_device *pdev)
> > +{
> > +       struct qpnp_tm_chip *chip;
> > +       struct device_node *node;
> > +       u8 type, subtype;
> > +       u32 res[2];
> > +       int ret, irq;
> > +
> > +       node = pdev->dev.of_node;
> > +
> > +       chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> > +       if (!chip)
> > +               return -ENOMEM;
> > +
> > +       dev_set_drvdata(&pdev->dev, chip);
> > +
> > +       chip->map = dev_get_regmap(pdev->dev.parent, NULL);
> > +       if (!chip->map)
> > +               return -ENXIO;
> > +
> > +       ret = of_property_read_u32_array(node, "reg", res, 2);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       /* ADC based measurements are optional */
> > +       chip->adc = iio_channel_get(&pdev->dev, "thermal");
> > +       if (PTR_ERR(chip->adc) == -EPROBE_DEFER)
> > +               return PTR_ERR(chip->adc);
> > +
> > +       irq = platform_get_irq(pdev, 0);
> > +       if (irq < 0)
> > +               return irq;
> > +
> > +       chip->base = res[0];
> > +
> > +       ret = qpnp_tm_read(chip, QPNP_TM_REG_TYPE, &type);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "could not read type\n");
> > +               goto fail;
> > +       }
> > +
> > +       ret = qpnp_tm_read(chip, QPNP_TM_REG_SUBTYPE, &subtype);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "could not read subtype\n");
> > +               goto fail;
> > +       }
> > +
> > +       if (type != QPNP_TM_TYPE || subtype != QPNP_TM_SUBTYPE) {
> > +               dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
> > +                       type, subtype);
> > +               ret = -ENODEV;
> > +               goto fail;
> > +       }
> > +
> > +       ret = qpnp_tm_init(chip);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "init failed\n");
> > +               goto fail;
> > +       }
> > +
> > +       chip->tz_dev = thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
> > +                                                       &qpnp_tm_sensor_ops);
> > +       if (IS_ERR(chip->tz_dev)) {
> > +               dev_err(&pdev->dev, "failed to register sensor\n");
> > +               ret = PTR_ERR(chip->tz_dev);
> > +               goto fail;
> > +       }
> > +
> > +       ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
> > +                                       IRQF_ONESHOT, node->name, chip);
> 
> What if we request this IRQ before registering the of thermal zone
> sensor? I believe it makes more sense conceptually, as you mean, you
> register into upper layers once your driver is fully ready to do so.
> 
> Any objections changing the order?

Sure.

> 
> > +       if (ret < 0)
> > +               goto unreg;
> > +
> > +       return 0;
> > +
> > +unreg:
> > +       thermal_zone_of_sensor_unregister(&pdev->dev, chip->tz_dev);
> 
> As mentioned by Stanimir Varban, you may also remove the above, since
> the irq is devm.

Sure. s/Varban/Varbanov/ ;-)

Thank you.
Ivan
