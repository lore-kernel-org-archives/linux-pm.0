From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/2] power: supply: axp288_charger: Only wait for INT3496
 device if present
Date: Mon, 20 Mar 2017 16:56:18 +0800
Message-ID: <CAGb2v67VFa-Pu3j0rUUsFRKe4nndrbuPWN34j1F=R4uhB6papw@mail.gmail.com>
References: <20170316161736.339-1-hdegoede@redhat.com> <20170316161736.339-3-hdegoede@redhat.com>
 <20170320013039.vyi3zd5cc5ujqd5o@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170320013039.vyi3zd5cc5ujqd5o@earth>
Sender: linux-acpi-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Mon, Mar 20, 2017 at 9:30 AM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Thu, Mar 16, 2017 at 05:17:36PM +0100, Hans de Goede wrote:
>> On some devices with an axp288 pmic setting vbus path based on the
>> id-pin is handled by an ACPI _AIE interrupt on the gpio and the
>> INT3496 device is disabled.
>>
>> Instead of returning -EPROBE_DEFER on these devices waiting for the
>> never to show up INT3496 device, check for its presence and only
>> request and monitor the matching extcon if the device is there,
>> otherwise let the firmware handle the vbus path control.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/power/supply/axp288_charger.c | 24 +++++++++++++++---------
>>  1 file changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
>> index d3bf4b2..6c4ad66 100644
>> --- a/drivers/power/supply/axp288_charger.c
>> +++ b/drivers/power/supply/axp288_charger.c
>> @@ -14,6 +14,7 @@
>>   * GNU General Public License for more details.
>>   */
>>
>> +#include <linux/acpi.h>
>>  #include <linux/module.h>
>>  #include <linux/device.h>
>>  #include <linux/regmap.h>
>> @@ -114,7 +115,8 @@
>>  #define ILIM_3000MA                  3000    /* 3000mA */
>>
>>  #define AXP288_EXTCON_DEV_NAME               "axp288_extcon"
>> -#define USB_HOST_EXTCON_DEV_NAME     "INT3496:00"
>> +#define USB_HOST_EXTCON_HID          "INT3496"
>> +#define USB_HOST_EXTCON_NAME         "INT3496:00"
>>
>>  static const unsigned int cable_ids[] =
>>       { EXTCON_CHG_USB_SDP, EXTCON_CHG_USB_CDP, EXTCON_CHG_USB_DCP };
>> @@ -808,10 +810,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
>>               return -EPROBE_DEFER;
>>       }
>>
>> -     info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_DEV_NAME);
>> -     if (info->otg.cable == NULL) {
>> -             dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
>> -             return -EPROBE_DEFER;
>> +     if (acpi_dev_present(USB_HOST_EXTCON_HID)) {
>
> I may have missed something, but as far as I can see axp288 also
> supports DT based init, so that should be handled here.

I doubt that will happen. AXP288 was designed specifically for Intel
Bay Trail platforms, which AFAIK use ACPI. For the other AXP series
PMIC we have another battery driver for them coming in.

If you look in drivers/mfd/axp20x.c and drivers/mfd/axp20x-i2c.c,
you'll see that AXP288 is only instantiated from ACPI, and all
the axp288 named drivers are only instantiated for the AXP288
mfd device.

Regards
ChenYu
