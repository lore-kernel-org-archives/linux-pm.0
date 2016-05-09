From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v8 6/7] power: cros_usbpd-charger: Add EC-based USB PD
 charger driver
Date: Mon, 9 May 2016 14:59:49 +0200
Message-ID: <CAAObsKCGZU6yVRdyYo83m74u--KSS2_dj9JHnVmXNes3hFhKdQ@mail.gmail.com>
References: <1460464350-30414-1-git-send-email-tomeu.vizoso@collabora.com>
 <1460464350-30414-7-git-send-email-tomeu.vizoso@collabora.com>
 <CAAObsKCcjtt66qtCrjOxSYxxvSBt7Dz8HU=hsVghja2JsLpFcw@mail.gmail.com> <571F473F.1020902@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <571F473F.1020902@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 26 April 2016 at 12:47, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Hi Tomeu,
>
> Thanks for the patch, looks good, a few comments below.
>
>
> On 20/04/16 09:42, Tomeu Vizoso wrote:
>>
>> Hi Sebastian,
>>
>> is there any chance that you could review this patch?
>>
>> Thanks,
>>
>> Tomeu
>>
>> On 12 April 2016 at 14:32, Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> wrote:
>>>
>>> +config CHARGER_CROS_USB_PD
>>> +       tristate "Chrome OS EC based USB PD charger"
>>> +       depends on MFD_CROS_EC
>>> +       default y
>
>
> Guess you should not set default to yes here.

Ok.

>>> +static int get_ec_num_ports(struct charger_data *charger, int
>>> *num_ports)
>>> +{
>>> +       struct device *dev = charger->dev;
>>> +       struct ec_response_usb_pd_ports resp;
>>> +       int ret;
>>> +
>>> +       *num_ports = 0;
>>> +       ret = ec_command(charger->ec_dev, 0, EC_CMD_USB_PD_PORTS, NULL,
>>> 0,
>>> +                        (uint8_t *)&resp, sizeof(resp));
>>> +       if (ret < 0) {
>>> +               dev_err(dev, "Unable to query PD ports (err:0x%x)\n",
>>> ret);
>>> +               return ret;
>
>
> Generally you return -EINVAL instead of ret when ec_command fails, any
> reason why here is different?

No reason indeed, will be changing it.

>>> +       snprintf(port->manufacturer, MANUFACTURER_MODEL_LENGTH, "%x",
>>> resp.vid);
>
>
> This looks a vendor id code, generally I saw this propietry show the
> manufacturer name.

Unfortunately the EC firmware gives us only the USB vendor and product IDs.

>>> +
>>> +       dev_dbg(dev, "cros_usb_pd_charger_power_changed\n");
>
>
> nit: In my opinion this debug message is not needed and doesn't add any
> information. It only shows that the function is called. You can usethe
> kernel tracing tools for that.

Agreed.

>>> +       case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX:
>>> +               /* TODO: send a TBD host command to the EC. */
>>> +               val->intval = 0;
>
>
> If I'm not mistaken the function below sets the control limit max value, but
> here you always return a 0. This is confusing for me. Seems that this is not
> supported yet? So maybe is better remove the code related to this or store
> the value set in a variable meanwhile you're not able to ask the value to
> the EC.

Good point, I have chosen to return -ENODATA as that should make clear
to the user that we cannot really show what is being asked right now.

>>> +       msecs = ktime_to_ms(tstamp);
>>> +       do_div(msecs, MSEC_PER_SEC);
>>> +       pr_info("PDLOG %d/%02d/%02d %02d:%02d:%02d.%03llu P%d %s\n",
>>> +               rt.tm_year + 1900, rt.tm_mon + 1, rt.tm_mday,
>>> +               rt.tm_hour, rt.tm_min, rt.tm_sec, msecs,
>>> +               PD_LOG_PORT(r->size_port), buf);
>
>
> nit: Maybe is better use a debug print level here. How often is this called?

This has been mentioned before, and the reason is that it's very
useful when helping users determine if the type-c cable that they are
using is defective or not:

http://www.ibtimes.co.uk/googler-shows-how-test-compatibility-usb-c-cable-chromebook-pixel-2015-1527334

Shouldn't happen often at all.

>>> +static int cros_usb_pd_charger_probe(struct platform_device *pd)
>>> +{
>>> +       struct device *dev = &pd->dev;
>>> +       struct cros_ec_dev *ec_dev = dev_get_drvdata(pd->dev.parent);
>>> +       struct cros_ec_device *ec_device;
>>> +       struct charger_data *charger;
>>> +       struct port_data *port;
>>> +       struct power_supply_desc *psy_desc;
>>> +       struct power_supply_config psy_cfg = {};
>>> +       int i;
>>> +       int ret = -EINVAL;
>>> +
>>> +       dev_dbg(dev, "cros_usb_pd_charger_probe\n");
>
>
> nit: Remove? You can use kernel tracing tools to print functions calls.

Cool.

>>> +       if (!ec_dev) {
>>> +               WARN(1, "%s: No EC dev found\n", dev_name(dev));
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       ec_device = ec_dev->ec_dev;
>>> +       if (!ec_device) {
>>> +               WARN(1, "%s: No EC device found\n", dev_name(dev));
>>> +               return -EINVAL;
>>> +       }
>>> +
>>> +       charger = devm_kzalloc(dev, sizeof(struct charger_data),
>>> +                                   GFP_KERNEL);
>
>
> Alignement should match with parentheses.

Ok.

>>> +       if (!charger)
>>> +               return -ENOMEM;
>>> +
>>> +       charger->dev = dev;
>>> +       charger->ec_dev = ec_dev;
>>> +       charger->ec_device = ec_device;
>>> +
>>> +       platform_set_drvdata(pd, charger);
>>> +
>>> +       if ((get_ec_num_ports(charger, &charger->num_charger_ports) < 0)
>>> ||
>>> +           !charger->num_charger_ports) {
>>> +               dev_err(dev, "No charging ports found\n");
>>> +               ret = -ENODEV;
>>> +               goto fail;
>
>
> I think you can return -ENODEV directly here, you don't need to jump to
> fail.

The idea is to undo the call to platform_set_drvdata.

>>> +       }
>>> +
>>> +       for (i = 0; i < charger->num_charger_ports; i++) {
>>> +               port = devm_kzalloc(dev, sizeof(struct port_data),
>>> GFP_KERNEL);
>>> +               if (!port) {
>>> +                       ret = -ENOMEM;
>>> +                       goto fail;
>>> +               }
>>> +
>>> +               port->charger = charger;
>>> +               port->port_number = i;
>>> +               sprintf(port->name, CHARGER_DIR_NAME, i);
>>> +
>>> +               psy_desc = &port->psy_desc;
>>> +               psy_desc->name = port->name;
>>> +               psy_desc->type = POWER_SUPPLY_TYPE_USB;
>>> +               psy_desc->get_property = cros_usb_pd_charger_get_prop;
>>> +               psy_desc->set_property = cros_usb_pd_charger_set_prop;
>>> +               psy_desc->property_is_writeable =
>>> +                       cros_usb_pd_charger_is_writeable;
>>> +               psy_desc->external_power_changed =
>>> +                       cros_usb_pd_charger_power_changed;
>>> +               psy_desc->properties = cros_usb_pd_charger_props;
>>> +               psy_desc->num_properties = ARRAY_SIZE(
>>> +                       cros_usb_pd_charger_props);
>>> +
>>> +               psy_cfg.drv_data = port;
>>> +               psy_cfg.supplied_to = charger_supplied_to;
>>> +               psy_cfg.num_supplicants =
>>> ARRAY_SIZE(charger_supplied_to);
>>> +
>>> +               port->psy = power_supply_register_no_ws(dev, psy_desc,
>>> +                                                       &psy_cfg);
>
>
> Guess you can use devm_power_supply_register_no_ws here.

Cool.

>>> +               if (IS_ERR(port->psy)) {
>>> +                       dev_err(dev, "Failed to register power supply:
>>> %ld\n",
>>> +                               PTR_ERR(port->psy));
>>> +                       continue;
>>> +               }
>>> +
>>> +               charger->ports[charger->num_registered_psy++] = port;
>>> +       }
>>> +
>>> +       if (!charger->num_registered_psy) {
>>> +               ret = -ENODEV;
>>> +               dev_err(dev, "No power supplies registered\n");
>>> +               goto fail;
>>> +       }
>>> +
>>> +       if (ec_device->mkbp_event_supported) {
>>> +               /* Get PD events from the EC */
>>> +               charger->notifier.notifier_call = cros_usb_pd_ec_event;
>>> +               ret = blocking_notifier_chain_register(
>>> +                       &ec_device->event_notifier, &charger->notifier);
>>> +               if (ret < 0)
>>> +                       dev_warn(dev, "failed to register notifier\n");
>>> +       }
>>> +
>>> +       /* Retrieve PD event logs periodically */
>>> +       INIT_DELAYED_WORK(&charger->log_work, cros_usb_pd_log_check);
>>> +       charger->log_workqueue =
>>> +               create_singlethread_workqueue("cros_usb_pd_log");
>>> +       queue_delayed_work(charger->log_workqueue, &charger->log_work,
>>> +               CROS_USB_PD_LOG_UPDATE_DELAY);
>>> +
>>> +       return 0;
>>> +
>>> +fail:
>>> +       for (i = 0; i < charger->num_registered_psy; i++) {
>>> +               port = charger->ports[i];
>>> +               power_supply_unregister(port->psy);
>
>
> If you use devm_power_supply_register_no_ws this is not needed since it
> would be called by managed resources infrastructure.

Nod.

>>> +               devm_kfree(dev, port);
>
>
> Guess the managed resources infrastructure will do this for you.

Nod.

> Best regards,
>  Enric

Thanks a lot for the review!

Tomeu
