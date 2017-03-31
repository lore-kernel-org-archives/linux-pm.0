From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/4] i2c: core: Allow drivers to specify index for irq
 to get from of / ACPI
Date: Fri, 31 Mar 2017 12:03:44 +0200
Message-ID: <149df3eb-8111-4c91-472e-f6c708302ede@redhat.com>
References: <20170325135550.22509-1-hdegoede@redhat.com>
 <20170325135550.22509-4-hdegoede@redhat.com>
 <1490530535.21738.31.camel@linux.intel.com>
 <1935239d-fdd8-3917-9865-de389e6728e8@redhat.com>
 <20170330203954.GA1452@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170330203954.GA1452@katana>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 30-03-17 22:39, Wolfram Sang wrote:
> Hi Hans,
>
>> Sorry for doing this in the middle of the thread, but this is the only
>> mail I could find in my archives (I guess I delete mail to aggressively).
>
> I use patchwork to track patches (which is mentioned in MAINTAINERS).
> And patchwork has the nice feature to download patches or series of
> patches as mbox. And from there you can reply directly, or bounce to
> yourself first, etc. That's what I do when I lost a mail.

Ok, I will do that the next time.

>> Anyways self-nack for this series, there are multiple issues with it:
>>
>> 1) In hindsight the irq_index is a bad idea and instead we need a noirq
>> flag in i2c_driver
>
> What do you mean by that? No IRQ assigned? In Linux, 0 is no irq. I
> guess you mean something else...

Note I said "flag in i2c_driver" the idea is that the driver can tell
the i2c_core that it is not going to use i2c_client->irq by
setting i2c_driver->no_irq and that the i2c_core then will not bother
with trying to get an irq in i2c_device_probe(), this is esp. useful
for ACPI i2c instantiated devices where we otherwise might end up
returning -EPROBE_DEFER (waiting for an irq to show up) without
needing the irq, which is esp. troublesome when there is no driver
for the irqchip the ACPI irq resource points to as then we end up
waiting indefinitely.

I hope this makes things more clear, if you've another suggestion
for handling this I'm all ears.

Regards,

Hans

