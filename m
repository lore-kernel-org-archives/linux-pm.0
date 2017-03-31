From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/4] i2c: core: Allow drivers to specify index for irq
 to get from of / ACPI
Date: Fri, 31 Mar 2017 20:22:55 +0200
Message-ID: <2b4d002f-9e6b-b193-7dc3-2f4c20a93276@redhat.com>
References: <20170325135550.22509-1-hdegoede@redhat.com>
 <20170325135550.22509-4-hdegoede@redhat.com>
 <1490530535.21738.31.camel@linux.intel.com>
 <1935239d-fdd8-3917-9865-de389e6728e8@redhat.com>
 <20170330203954.GA1452@katana>
 <149df3eb-8111-4c91-472e-f6c708302ede@redhat.com>
 <20170331162332.dar3f3mval2ch2uh@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170331162332.dar3f3mval2ch2uh@ninjato>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 31-03-17 18:23, Wolfram Sang wrote:
>
>> Note I said "flag in i2c_driver" the idea is that the driver can tell
>> the i2c_core that it is not going to use i2c_client->irq by
>> setting i2c_driver->no_irq and that the i2c_core then will not bother
>> with trying to get an irq in i2c_device_probe(), this is esp. useful
>> for ACPI i2c instantiated devices where we otherwise might end up
>> returning -EPROBE_DEFER (waiting for an irq to show up) without
>> needing the irq, which is esp. troublesome when there is no driver
>> for the irqchip the ACPI irq resource points to as then we end up
>> waiting indefinitely.
>
> Okay, thanks. I understand the big picture. But does it really need to
> be fixed in I2C core? Independent of I2C: if an irq is described in ACPI
> and the driver for the needed irq controller is not available, that can
> lead to various problems everywhere.

Normally drivers call acpi_dev_gpio_irq_get themselves in their probe
method and the -EPROBE_DEFER handling is done in the drivers probe
itself, giving drivers various options to deal with irqs.

The problem here is that the i2c system is somewhat special in that
it does irq mapping on behalf of the driver and does not even bother
to call the driver's probe() if the acpi_dev_gpio_irq_get() call
returns -EPROBE_DEFER.

> Or maybe you simply want to be early and don't want to get deferred? Are
> we talking then about boot optimizations or necessities?

The problem which I'm trying to fix is not having to write a (complex)
gpio driver for an undocumented PMIC which I (and AFAICT no-one) needs (*)
just because the i2c-core needs to be "special" and do the acpi_dev_gpio_irq_get
for me even though in this specific driver I don't need the irq at index
0 at all. IOW the problem which I'm trying to fix is to get i2c_device_probe
to not out-smart me and never call my driver's probe method for
invalid reasons.

My previous patch for this added an irq_index member to i2c_driver instead,
because my use-case does actually need an irq, but the one with
resource-index 1, not the useless one at index 0. Which is yet another
indication that the naive irq-handling in the i2c-core sometimes get
somewhat in the way. In my experience many more complex i2c devices have
more then 1 irq line.

That previous patch works for me too (and even simplifies my driver somewhat),
if you like it better I can go back to that. But thinking more about this
I decided that having a "dear i2c-core please don't try to out-smart the
driver, leave irq handling to me" flag would be better / more generally
useful.

Regards,

Hans


*) And because there is no use-case for it other then satisfying the
i2c-core's desire to be able to do acpi_dev_gpio_irq_get(0) also no
way to test!
