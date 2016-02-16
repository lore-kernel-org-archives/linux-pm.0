From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v2 6/8] power: cros_usbpd-charger: Add EC-based USB PD
 charger driver
Date: Tue, 16 Feb 2016 15:35:34 +0100
Message-ID: <CAAObsKDXcq78fkm3_h8dXfoZp8_N6EU2i=56cHGa=Vikjm1Y=g@mail.gmail.com>
References: <1455281825-23526-1-git-send-email-tomeu.vizoso@collabora.com>
 <1455281825-23526-7-git-send-email-tomeu.vizoso@collabora.com> <56BE7CF6.20201@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56BE7CF6.20201@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sameer Nanda <snanda@chromium.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 13 February 2016 at 01:46, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 02/12/2016 04:57 AM, Tomeu Vizoso wrote:
>> +
>> +#define EC_MAX_IN_SIZE EC_PROTO2_MAX_REQUEST_SIZE
>> +#define EC_MAX_OUT_SIZE EC_PROTO2_MAX_RESPONSE_SIZE
>> +uint8_t ec_inbuf[EC_MAX_IN_SIZE];
>> +uint8_t ec_outbuf[EC_MAX_OUT_SIZE];
>
> static? Why can't these be part of charger_data?

Actually, I don't think we need any of that pre-allocation.

>> +static int set_ec_usb_pd_override_ports(struct charger_data *charger,
>> +                                     int port_num)
>> +{
>> +     struct device *dev = charger->dev;
>> +     struct ec_params_charge_port_override req;
>> +     int ret;
>> +
>> +     req.override_port = port_num;
>> +
>> +     ret = ec_command(charger->ec_dev, 0, EC_CMD_PD_CHARGE_PORT_OVERRIDE,
>> +                      (uint8_t *)&req, sizeof(req),
>> +                      NULL, 0);
>> +     if (ret < 0) {
>> +             dev_info(dev, "Port Override command returned 0x%x\n", ret);
>
> dev_err?

Sounds good.

>> +     pr_info("PDLOG %d/%02d/%02d %02d:%02d:%02d.%03d P%d %s\n",
>> +             rt.tm_year + 1900, rt.tm_mon + 1, rt.tm_mday,
>> +             rt.tm_hour, rt.tm_min, rt.tm_sec,
>> +             (int)(ktime_to_ms(tstamp) % MSEC_PER_SEC),
>> +             PD_LOG_PORT(r->size_port), buf);
>
> Is the kernel log a good place to be putting this information? Maybe
> this should go into debugfs?

It should be really sparse and it has already proved useful to users
willing to know if their Type-C cables are broken.We could also make
it dev_dbg.

http://www.ibtimes.co.uk/googler-shows-how-test-compatibility-usb-c-cable-chromebook-pixel-2015-1527334

>> +             return NOTIFY_OK;
>> +     } else {
>> +             return NOTIFY_DONE;
>> +     }
>
> Simplify to return NOTIFY_DONE without the else.

Ok.

>> +}
>> +
>> +static char *charger_supplied_to[] = {"cros-usb_pd-charger"};
>
> const?

In principle yes, but power_supply_config.supplied_to isn't const.

>> +         !charger->num_charger_ports) {
>> +             /*
>> +              * This can happen on a system that doesn't support USB PD.
>> +              * Log a message, but no need to warn.
>> +              */
>> +             dev_info(dev, "No charging ports found\n");
>
> dev_err?

I think so, but will also need to make sure that we only register a
device if we have one or more charging port.

>> +             ret = -ENODEV;
>> +             goto fail_nowarn;
>> +     }
>> +
>> +     for (i = 0; i < charger->num_charger_ports; i++) {
>> +             port = devm_kzalloc(dev, sizeof(struct port_data), GFP_KERNEL);
>> +             if (!port) {
>> +                     dev_err(dev, "Failed to alloc port structure\n");
>
> We don't need error messages on allocation failures (checkpatch usually
> catches this).

It did catch another one in this file, not sure why it failed here.

>> +
>> +fail_nowarn:
>> +     if (charger) {
>
> This is always true?

Ah, yes.

>> +             for (i = 0; i < charger->num_registered_psy; i++) {
>> +                     port = charger->ports[i];
>> +                     power_supply_unregister(port->psy);
>> +                     devm_kfree(dev, port);
>> +             }
>> +             platform_set_drvdata(pd, NULL);
>> +             devm_kfree(dev, charger);
>
> Seems like we could let devres take care of this.

Indeed.

>> +     }
>> +
>> +     dev_info(dev, "Failing probe (err:0x%x)\n", ret);
>
> Is this necessary? Doesn't driver core already spew something out for
> this case if some debugging flag is enabled?

True, a warning is printed.

>> +     return ret;
>> +}
>> +
>> +static int cros_usb_pd_charger_remove(struct platform_device *pd)
>> +{
>> +     struct charger_data *charger = platform_get_drvdata(pd);
>> +     struct device *dev = charger->dev;
>> +     struct port_data *port;
>> +     int i;
>> +
>> +     if (charger) {
>
> We just derefed charger a few lines up.

Ok.

>> +             for (i = 0; i < charger->num_registered_psy; i++) {
>> +                     port = charger->ports[i];
>> +                     power_supply_unregister(port->psy);
>> +                     devm_kfree(dev, port);
>
> Can't we let driver removal take care of this?

Ok.

>> +             }
>> +             flush_delayed_work(&charger->log_work);
>> +             platform_set_drvdata(pd, NULL);
>
> This is not needed.

Ok.

>> +             devm_kfree(dev, charger);
>
> Again, driver remove already does this?

Yup.

>> +     }
>> +     return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int cros_usb_pd_charger_resume(struct device *dev)
>> +{
>> +     struct charger_data *charger = dev_get_drvdata(dev);
>> +     int i;
>> +
>> +     if (!charger)
>> +             return 0;
>
> Seems sort of impossible...

True.

>> +
>> +     charger->suspended = false;
>> +
>> +     dev_dbg(dev, "cros_usb_pd_charger_resume: updating power supplies\n");
>> +     for (i = 0; i < charger->num_registered_psy; i++) {
>> +             power_supply_changed(charger->ports[i]->psy);
>> +             charger->ports[i]->last_update =
>> +                             jiffies - CROS_USB_PD_CACHE_UPDATE_DELAY;
>> +     }
>> +     queue_delayed_work(charger->log_workqueue, &charger->log_work,
>> +             CROS_USB_PD_LOG_UPDATE_DELAY);
>> +
>> +     return 0;
>> +}
>> +
>> +static int cros_usb_pd_charger_suspend(struct device *dev)
>> +{
>> +     struct charger_data *charger = dev_get_drvdata(dev);
>> +
>> +     charger->suspended = true;
>> +
>> +     if (charger)
>
> We just derefed charger so it better be non-NULL

Yup.

>> +     ret = ec_command(ec, 0, EC_CMD_EXT_POWER_CURRENT_LIMIT,
>> +                      (uint8_t *)&req, sizeof(req), NULL, 0);
>> +     if (ret < 0) {
>> +             dev_warn(ec->dev,
>> +                      "External power limit command returned 0x%x\n",
>> +                      ret);
>
> dev_err?

Sounds good to me.

>> +     if (ext_current_lim == EC_POWER_LIMIT_NONE)
>> +             dev_info(ec->dev, "External current limit removed\n");
>> +     else
>> +             dev_info(ec->dev, "External current limit set to %dmA\n",
>> +                      ext_current_lim);
>
> Why are we dev_info printing on sysfs writes?

Cannot think of a good reason, so I'm changing those to dev_dbg.

>> +     ext_voltage_lim = tmp_val;
>> +     if (ext_voltage_lim == EC_POWER_LIMIT_NONE)
>> +             dev_info(ec->dev, "External voltage limit removed\n");
>> +     else
>> +             dev_info(ec->dev, "External voltage limit set to %dmV\n",
>> +                      ext_voltage_lim);
>
> Again...

Ok.

>> +
>> +     return count;
>> +}
>> +
>> +static DEVICE_ATTR(ext_current_lim, S_IWUSR | S_IWGRP | S_IRUGO,
>> +                get_ec_ext_current_lim,
>> +                set_ec_ext_current_lim);
>> +static DEVICE_ATTR(ext_voltage_lim, S_IWUSR | S_IWGRP | S_IRUGO,
>> +                get_ec_ext_voltage_lim,
>> +                set_ec_ext_voltage_lim);
>
> Any documentation for these in Documentation/ABI?

Will add.

>> +static struct attribute *__ext_power_cmds_attrs[] = {
>> +     &dev_attr_ext_current_lim.attr,
>> +     &dev_attr_ext_voltage_lim.attr,
>> +     NULL,
>> +};
>> +
>> +struct attribute_group cros_usb_pd_charger_attr_group = {
>
> static?

Not really, as it's to be used externally.

>> +     .name = "usb-pd-charger",
>> +     .attrs = __ext_power_cmds_attrs,
>> +};
>> +
>> +static SIMPLE_DEV_PM_OPS(cros_usb_pd_charger_pm_ops,
>> +     cros_usb_pd_charger_suspend, cros_usb_pd_charger_resume);
>
> const?

The macro already has the const keyword.

>> +
>> +static struct platform_driver cros_usb_pd_charger_driver = {
>> +     .driver = {
>> +             .name = "cros-usb-pd-charger",
>> +             .owner = THIS_MODULE,
>
> This isn't needed anymore.

Ok.

Thank you very much for the great review!

Tomeu
