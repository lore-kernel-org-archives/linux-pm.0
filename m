From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 1/2] thermal_hwmon: Sanitize attribute name passed to hwmon
Date: Wed, 18 Jul 2018 11:42:28 +0200
Message-ID: <CAFqH_50Ky=yNmUXFjzwdWG0NiEHjBF3Mm0w1gAoSq2zL_E+HbQ@mail.gmail.com>
References: <20180710154035.26828-1-marc.zyngier@arm.com> <20180710154035.26828-2-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710154035.26828-2-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: marc.zyngier@arm.com
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Marc,
Missatge de Marc Zyngier <marc.zyngier@arm.com> del dia dt., 10 de
jul. 2018 a les 17:42:
>
> My Chromebook Plus (kevin) is spitting the following at boot time:
>
> (NULL device *): hwmon: 'sbs-9-000b' is not a valid name attribute, please fix
>
> Clearly, __hwmon_device_register is unhappy about the property name.
> Some investigation reveals that thermal_add_hwmon_sysfs doesn't
> sanitize the name of the attribute.
>
> In order to keep it quiet, let's replace '-' with '_' in hwmon->type
> This is consistent with what iio-hwmon does since b92fe9e3379c8.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/thermal/thermal_hwmon.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index 11278836ed12..0bd47007c57f 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -142,6 +142,7 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>
>         INIT_LIST_HEAD(&hwmon->tz_list);
>         strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
> +       strreplace(hwmon->type, '-', '_');
>         hwmon->device = hwmon_device_register_with_info(NULL, hwmon->type,
>                                                         hwmon, NULL, NULL);
>         if (IS_ERR(hwmon->device)) {
> --
> 2.18.0
>

That's one of the annoying messages you saw for a long time during
boot but you had never time to look at. I am happy that when I found a
slot to look at I found already it was fixed.
Thanks!

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Best regards,
 Enric
