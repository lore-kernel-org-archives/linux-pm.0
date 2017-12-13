From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH 1/2] platform/x86: add Atom PMC quirk to disable SATA
Date: Wed, 13 Dec 2017 17:37:15 +0100
Message-ID: <e6aa5c55-8174-7ad9-009f-c254d3aeaf72@redhat.com>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
 <20170925191749.2oamusbajgs6clcg@sig21.net>
 <20170925192109.rty2fnm7c4jnj3vx@sig21.net>
 <34396652.fljU28PShI@aspire.rjw.lan>
 <a2c8d724-015a-e6c3-23ab-4b6036cc22eb@redhat.com>
 <CAEG3pNDL-8srk_JwqtZxs_waHAPfmRC_5Orhs_=XUhwdHTdM-g@mail.gmail.com>
 <e4760a03-b6af-00fc-6c26-9fff8ed6c378@redhat.com>
 <20171213162206.GA7337@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171213162206.GA7337@sig21.net>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk <linux-clk@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 13-12-17 17:22, Johannes Stezenbach wrote:
> Hi,
> 
> On Wed, Dec 13, 2017 at 05:04:34PM +0100, Hans de Goede wrote:
>> On 13-12-17 16:25, Michael Turquette wrote:
>>> On Wed, Dec 13, 2017 at 12:53 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Although, maybe we need to have a specialized (derived)
>>>> ahci driver for these Atom SoCs and in there if no
>>>> disk is detected do this through the clock framework?
>>>
>>> Yes please. x86 is already modeling some clocks properly through the
>>> clock framework. During late init we clean up any clocks that were
>>> enabled out of reset or by the firmware/bootloader but not claimed and
>>> enabled by any Linux driver. That should ideally disable this
>>> particular clock for the case when no SATA drive is present, and
>>> require no quirk logic in the driver.
>>
>> Ah so you're thinking a special ahci driver which knows about
>> the clock, yes I think that could work.
>>
>> Or maybe do a match on the CPU model and if it is know to
>> not have SATA (or not routed to the outside), disable
>> the clock? That seems better because if I understood Johannes
>> correctly there is no SATA/AHCI PCI device (so nothing for
>> a driver to bind to) but the clock is still enabled, although
>> in that case the clock framework should do the right thing
>> if we revert commit d31fd43c0f9a "clk: x86: Do not gate clocks enabled by the firmware"
> 
> Please don't get confused with the other thread about clocks.
> This issue sets the "disable IP" bit, found by doing stupid
> experiments to enable S0ix on E200HA.

Ah my bad.

> 1. no idea if Cherry Trail even has SATA IP, maybe this is a
>     meaningless bit but PMC firmware carried over from
>     Bay Trail looks at it


There are no CHT SoCs with SATA AFAIK, but Braswell SoCs,
which I believe is the same die do have SATA.

I think the best fix here is to look at the model-string part
of the CPU-id and do a quirk based on that, setting the "disable IP"
bit for the SATA on all SoC models known to not have SATA
(Z8300, Z8350, Z8500, Z8550, Z8700, Z8750).

Rafael, Andy how does that sound as a solution?

> 2. BIOS should have set the bit, so it is a BIOS quirk
> 
> 3. or maybe there is a much better solution that I don't know about
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=193891
> also has lspci output

Regards,

Hans
