From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH 1/2] platform/x86: add Atom PMC quirk to disable SATA
Date: Wed, 13 Dec 2017 17:04:34 +0100
Message-ID: <e4760a03-b6af-00fc-6c26-9fff8ed6c378@redhat.com>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
 <20170925191749.2oamusbajgs6clcg@sig21.net>
 <20170925192109.rty2fnm7c4jnj3vx@sig21.net>
 <34396652.fljU28PShI@aspire.rjw.lan>
 <a2c8d724-015a-e6c3-23ab-4b6036cc22eb@redhat.com>
 <CAEG3pNDL-8srk_JwqtZxs_waHAPfmRC_5Orhs_=XUhwdHTdM-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAEG3pNDL-8srk_JwqtZxs_waHAPfmRC_5Orhs_=XUhwdHTdM-g@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Johannes Stezenbach <js@sig21.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk <linux-clk@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 13-12-17 16:25, Michael Turquette wrote:
> Hell Hans, all,
> 
> On Wed, Dec 13, 2017 at 12:53 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 13-12-17 01:00, Rafael J. Wysocki wrote:
>>>
>>> On Monday, September 25, 2017 9:21:09 PM CET Johannes Stezenbach wrote:
>>>>
>>>> SATA controller is enabled on Asus E200HA even though the
>>>> machine doesn't use it (it has eMMC storage), however
>>>> SATA being on blocks S0ix entry so we need to disable it.
>>>>
>>>> Signed-off-by: Johannes Stezenbach <js@sig21.net>
>>>
>>>
>>> Mika, Andy, Hans, any comments on this one?
>>
>>
>> Seems sensible to me, I'm afraid we may need the same quirk on
>> other devices, but I see no way around this.
> 
> Quirks go directly into the driver? Is there a Device Tree analogue
> for x86 that could help here?

No.

>> Although, maybe we need to have a specialized (derived)
>> ahci driver for these Atom SoCs and in there if no
>> disk is detected do this through the clock framework?
> 
> Yes please. x86 is already modeling some clocks properly through the
> clock framework. During late init we clean up any clocks that were
> enabled out of reset or by the firmware/bootloader but not claimed and
> enabled by any Linux driver. That should ideally disable this
> particular clock for the case when no SATA drive is present, and
> require no quirk logic in the driver.

Ah so you're thinking a special ahci driver which knows about
the clock, yes I think that could work.

Or maybe do a match on the CPU model and if it is know to
not have SATA (or not routed to the outside), disable
the clock? That seems better because if I understood Johannes
correctly there is no SATA/AHCI PCI device (so nothing for
a driver to bind to) but the clock is still enabled, although
in that case the clock framework should do the right thing
if we revert commit d31fd43c0f9a "clk: x86: Do not gate clocks enabled by the firmware"

Regards,

Hans



> 
> Regards,
> Mike
> 
>>
>> That may be better then a long list of quirks.
>>
>> Johannes, question how did you test this and figure out
>> which clocks to disable, a quick howto on this, I think
>> a patch adding a little howto / README as say
>> Documentation/power/intel-S0ix-debugging.txt
>> documenting this would be great. I'm certainly interested
>> in trying to reproduce this on some of my own Bay Trail and
>> Cherry Trail devices and add fixes for those if necessary.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>
>>>
>>>> ---
>>>>    drivers/platform/x86/pmc_atom.c | 33 +++++++++++++++++++++++++++++++++
>>>>    1 file changed, 33 insertions(+)
>>>>
>>>> diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
>>>> index 8d13c86cc418..b5dd38712268 100644
>>>> --- a/drivers/platform/x86/pmc_atom.c
>>>> +++ b/drivers/platform/x86/pmc_atom.c
>>>> @@ -17,6 +17,7 @@
>>>>      #include <linux/debugfs.h>
>>>>    #include <linux/device.h>
>>>> +#include <linux/dmi.h>
>>>>    #include <linux/init.h>
>>>>    #include <linux/io.h>
>>>>    #include <linux/platform_data/x86/clk-pmc-atom.h>
>>>> @@ -57,6 +58,9 @@ struct pmc_dev {
>>>>    static struct pmc_dev pmc_device;
>>>>    static u32 acpi_base_addr;
>>>>    +static u32 quirks;
>>>> +#define QUIRK_DISABLE_SATA BIT(0)
>>>> +
>>>>    static const struct pmc_clk byt_clks[] = {
>>>>          {
>>>>                  .name = "xtal",
>>>> @@ -271,6 +275,15 @@ static void pmc_hw_reg_setup(struct pmc_dev *pmc)
>>>>           * - GPIO_SCORE shared IRQ
>>>>           */
>>>>          pmc_reg_write(pmc, PMC_S0IX_WAKE_EN, (u32)PMC_WAKE_EN_SETTING);
>>>> +
>>>> +       if (quirks & QUIRK_DISABLE_SATA) {
>>>> +               u32 func_dis;
>>>> +
>>>> +               pr_info("pmc: disable SATA IP\n");
>>>> +               func_dis = pmc_reg_read(pmc, PMC_FUNC_DIS);
>>>> +               func_dis |= BIT_SATA;
>>>> +               pmc_reg_write(pmc, PMC_FUNC_DIS, func_dis);
>>>> +       }
>>>>    }
>>>>      #ifdef CONFIG_DEBUG_FS
>>>> @@ -500,6 +513,24 @@ static struct pmc_notifier_block pmc_freeze_nb = {
>>>>    };
>>>>    #endif
>>>>    +static int cht_asus_e200ha_cb(const struct dmi_system_id *id)
>>>> +{
>>>> +       pr_info("pmc: Asus E200HA detected\n");
>>>> +       quirks |= QUIRK_DISABLE_SATA;
>>>> +       return 1;
>>>> +}
>>>> +
>>>> +static const struct dmi_system_id cht_table[] = {
>>>> +       {
>>>> +               .callback = cht_asus_e200ha_cb,
>>>> +               .matches = {
>>>> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "E200HA"),
>>>> +               },
>>>> +       },
>>>> +       { }
>>>> +};
>>>> +
>>>>    static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>>    {
>>>>          struct pmc_dev *pmc = &pmc_device;
>>>> @@ -526,6 +557,8 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>>          pmc->map = map;
>>>>    +     dmi_check_system(cht_table);
>>>> +
>>>>          /* PMC hardware registers setup */
>>>>          pmc_hw_reg_setup(pmc);
>>>>
>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
