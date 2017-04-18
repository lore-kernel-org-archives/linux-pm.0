From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v6] power: supply: bq24190_charger: Add disable-reset device-property
Date: Tue, 18 Apr 2017 02:34:39 -0700
Message-ID: <CAKvHMgT81wy7MGYucazcyOiL=zoHeo=Tn==iSE8iC9kiPsPjrQ@mail.gmail.com>
References: <20170414165233.4532-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34757 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755461AbdDRJek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 05:34:40 -0400
Received: by mail-io0-f195.google.com with SMTP id h41so31877867ioi.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2017 02:34:40 -0700 (PDT)
In-Reply-To: <20170414165233.4532-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

Hi Hans,


On Fri, Apr 14, 2017 at 9:52 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Allow platform-code to disable the reset on probe and suspend/resume
> by setting a "disable-reset" boolean device property on the device.
>
> There are several reasons why the platform-code may want to disable
> the reset on probe and suspend/resume:
>
> 1) Resetting the charger should never be necessary it should always have
> sane values programmed. If it is running with invalid values while we
> are not running (system turned off or suspended) there is a big problem
> as that may lead to overcharging the battery.
>
> 2) The reset in suspend() is meant to put the charger back into default
> mode, but this is not necessary and not a good idea. If the charger has
> been programmed with a higher max charge_current / charge_voltage then
> putting it back in default-mode will reset those to the safe power-on
> defaults, leading to slower charging, or charging to a lower voltage
> (and thus not using the full capacity) while suspended which is
> undesirable. Reprogramming the max charge_current / charge_voltage
> after the reset will not help here as that will put the charger back
> in host mode and start the i2c watchdog if the host then does not do
> anything for 40s (iow if we're suspended for more then 40s) the watchdog
> expires resetting the device to default-mode, including resetting all
> the registers to there safe power-on defaults. So the only way to keep
> using custom charge settings while suspending is to keep the charger in
> its normal running state with the i2c watchdog disabled. This is fine
> as the charger will still automatically switch from constant current
> to constant voltage and stop charging when the battery is full.
>
> 3) Besides never being necessary resetting the charger also causes
> problems on systems where the charge voltage limit is set higher then the
> reset value, if this is the case and the charger is reset while charging
> and the battery voltage is between the 2 voltages, then about half the
> time the charger gets confused and claims to be charging (REG08 contains
> 0x64) but in reality the charger has decoupled itself from VBUS (Q1 off)
> and is drawing 0A from VBUS, leaving the system running from the battery.
>
> This last problem is happening on a GPD-win mini PC with a bq24292i
> charger chip combined with a max17047 fuel-gauge and a LiHV battery.
> I've checked and TI does not list any errata for the bq24292i which
> could explain this (there are no errata at all).
>
> Cc: Liam Breck <kernel@networkimprov.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -This is a new patch in v2 of this patch-set
> Changes in v3:
> -Disable the reset code by default, but leave it around guarded by
>  a check for a reset-on-probe device-property
> Changes in v4:
> -Rebase on top of current power-supply/next
> Changes in v5:
> -Updated commit msg to describe the hw on which I'm seeing the charger getting
>  stuck while reset during charging and Vbat is above the reset charge volt limit
> Changes in v6:
> -Keep the reset enabled by default, allow disabling it by setting a
>  "disable-reset" boolean device property on the device
> ---
>  drivers/power/supply/bq24190_charger.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index bd9e5c3..2d379a2 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -533,6 +533,9 @@ static int bq24190_register_reset(struct bq24190_dev_info *bdi)
>         int ret, limit = 100;
>         u8 v;
>
> +       if (device_property_read_bool(bdi->dev, "disable-reset"))
> +               return 0;
> +
>         /* Reset the registers */
>         ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>                         BQ24190_REG_POC_RESET_MASK,

This is one of those patches with a 1:10 code:comment ratio :-)

I've been seeking a rationale for a property with more context than
disable-reset, without much luck. If you have any ideas, please
advise, but otherwise...

Acked-by: Liam Breck <kernel@networkimprov.net>
