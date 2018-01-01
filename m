From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v11 3/5] thinkpad_acpi: Add support for battery thresholds
Date: Mon, 1 Jan 2018 12:24:39 +0200
Message-ID: <CAHp75VeYRYRpmqy_GGQ95e1YhvZGfWtsJrGbLiA4JskEmd69zg@mail.gmail.com>
References: <20171231141727.GA4643@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46416 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeAAKYk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jan 2018 05:24:40 -0500
In-Reply-To: <20171231141727.GA4643@thinkpad>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>

On Sun, Dec 31, 2017 at 4:17 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
> thinkpad_acpi registers two new attributes for each battery:
>
> 1) Charge start threshold
> /sys/class/power_supply/BATN/charge_start_threshold
>
> Valid values are [0, 99]. A value of 0 turns off the
> start threshold wear control.
>
> 2) Charge stop threshold
> /sys/class/power_supply/BATN/charge_stop_threshold
>
> Valid values are [1, 100]. A value of 100 turns off
> the stop threshold wear control. This must be
> configured first.
>

> This patch depends on the following patches:
>
> "battery: Add the battery hooking API"

Since this is series, no need to put above into changelog.

AFAICS it's not going to be backported either.


> +/**
> + * This evaluates a ACPI method call specific to the battery
> + * ACPI extension. The specifics are that an error is marked
> + * in the 32rd bit of the response, so we just check that here.
> + *
> + * Returns 0 on success
> + */
> +static int tpacpi_battery_acpi_eval(char *method, int *ret, int param)
> +{

One problem and one trick you may do.

A problem: you return ACPI status as int. We have special type for
that. So, be consistent with it.
Looking to acpi_evalf() which is private to the module, I think you
need to get rid of ACPI return codes here.

A trick: since you are using only least significant byte of the
response, you can declare it as u8 *value (yeah, ret is not best name
here I think).

So, something like

..._eval(..., u8 *value, ...)
{
  int response;

  if (!..._evalf(..., &response, ...)) {
  ...

> +       if (!acpi_evalf(hkey_handle, ret, method, "dd", param)) {
> +               acpi_handle_err(hkey_handle, "%s: evaluate failed", method);
> +               return AE_ERROR;
> +       }
> +
> +       if (*ret & METHOD_ERR) {

if (response & ...) {

> +               acpi_handle_err(hkey_handle,
> +                               "%s evaluated but flagged as error", method);
> +               return AE_ERROR;
> +       }

*value = response;

> +
> +       return AE_OK;
> +}

> +static int tpacpi_battery_get(int what, int battery, int *ret)
> +{
> +       switch (what) {
> +
> +       case THRESHOLD_START:
> +
> +               if (tpacpi_battery_acpi_eval(GET_START, ret, battery))
> +                       return -ENODEV;
> +

> +               /* The value is in the low 8 bits of the response */
> +               *ret = *ret & 0xFF;

So, this will gone with a trick above.

> +               return 0;
> +
> +       case THRESHOLD_STOP:
> +
> +               if (tpacpi_battery_acpi_eval(GET_STOP, ret, battery))
> +                       return -ENODEV;
> +
> +               /* Value is in lower 8 bits */
> +               *ret = *ret & 0xFF;

Ditto.

> +
> +               /*
> +                * On the stop value, if we return 0 that
> +                * does not make any sense. 0 means Default, which
> +                * means that charging stops at 100%, so we return
> +                * that.
> +                */
> +               if (*ret == 0)
> +                       *ret = 100;
> +
> +               return 0;
> +
> +       default:
> +               pr_crit("wrong parameter: %d", what);
> +               return -EINVAL;
> +       }
> +
> +}

> +static int tpacpi_battery_probe(int battery)
> +{
> +       int ret = 0;
> +
> +       memset(&battery_info, 0, sizeof(struct tpacpi_battery_driver_data));
> +
> +       /*
> +        * 1) Get the current start threshold
> +        * 2) Check for support
> +        * 3) Get the current stop threshold
> +        * 4) Check for support
> +        */
> +
> +       if (acpi_has_method(hkey_handle, GET_START)) {
> +
> +               if (tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
> +                       pr_err("Error probing battery %d\n", battery);
> +                       return -ENODEV;
> +               }
> +
> +               /* Individual addressing is in bit 9 */
> +               if (ret & BIT(9))
> +                       battery_info.individual_addressing = true;
> +
> +               /* Support is marked in bit 8 */
> +               if (ret & BIT(8))
> +                       battery_info.batteries[battery].start_support = 1;
> +               else
> +                       return -ENODEV;
> +
> +               if (tpacpi_battery_get(THRESHOLD_START, battery,
> +                       &battery_info.batteries[battery].charge_start)) {
> +                       pr_err("Error probing battery %d\n", battery);
> +                       return -ENODEV;
> +               }

> +

Please, get rid of all useless empty lines like this one, or above (in
between of two if:s).

> +       }

> +/* General helper functions */
> +
> +static int tpacpi_battery_get_id(const char *battery_name)
> +{
> +
> +       if (strcmp(battery_name, "BAT0") == 0)
> +               return BAT_PRIMARY;
> +       if (strcmp(battery_name, "BAT1") == 0)
> +               return BAT_SECONDARY;
> +
> +       /*
> +        * If for some reason the battery is not BAT0 nor is it
> +        * BAT1, we will assume it's the default, first battery,
> +        * AKA primary.
> +        */
> +       pr_warn("unknown battery %s, assuming primary", battery_name);
> +       return BAT_PRIMARY;
> +}
> +
> +/* sysfs interface */
> +
> +static ssize_t tpacpi_battery_store(int what,
> +                                   struct device *dev,
> +                                   const char *buf, size_t count)
> +{
> +       struct power_supply *supply = to_power_supply(dev);
> +       unsigned long value;
> +       int battery, errno;

> +       errno = kstrtoul(buf, 10, &value);

> +

Dont' split lines like these where one returns some error code
followed by conditional check.

> +       if (errno)

> +               return errno;

Besides, errno is a bad name, please consider what is used elsewhere
in this module (rc, ret, rval, ...?).

-- 
With Best Regards,
Andy Shevchenko
