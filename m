From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/4] i2c: core: Allow drivers to specify index for irq
 to get from of / ACPI
Date: Fri, 31 Mar 2017 22:59:31 +0200
Message-ID: <0ff7a58f-b6d3-edb2-2751-e30069098c61@redhat.com>
References: <20170325135550.22509-1-hdegoede@redhat.com>
 <20170325135550.22509-4-hdegoede@redhat.com>
 <1490530535.21738.31.camel@linux.intel.com>
 <1935239d-fdd8-3917-9865-de389e6728e8@redhat.com>
 <20170330203954.GA1452@katana>
 <149df3eb-8111-4c91-472e-f6c708302ede@redhat.com>
 <20170331162332.dar3f3mval2ch2uh@ninjato>
 <2b4d002f-9e6b-b193-7dc3-2f4c20a93276@redhat.com>
 <20170331195407.GA1449@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170331195407.GA1449@katana>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 31-03-17 21:54, Wolfram Sang wrote:
> Hi Hans,
>
>> The problem here is that the i2c system is somewhat special in that
>> it does irq mapping on behalf of the driver and does not even bother
>> to call the driver's probe() if the acpi_dev_gpio_irq_get() call
>> returns -EPROBE_DEFER.
>
> Yes, the client->irq handling is cruft, I am fully aware of that.
>
>>> Or maybe you simply want to be early and don't want to get deferred? Are
>>> we talking then about boot optimizations or necessities?
>>
>> The problem which I'm trying to fix is not having to write a (complex)
>> gpio driver for an undocumented PMIC which I (and AFAICT no-one) needs (*)
>> just because the i2c-core needs to be "special" and do the acpi_dev_gpio_irq_get
>> for me even though in this specific driver I don't need the irq at index
>> 0 at all. IOW the problem which I'm trying to fix is to get i2c_device_probe
>> to not out-smart me and never call my driver's probe method for
>> invalid reasons.
>
> So, it is a necessity because you have an ACPI entry to a PMIC which is
> totally undocumented. Point taken.
>
>>
>> My previous patch for this added an irq_index member to i2c_driver instead,
>> because my use-case does actually need an irq, but the one with
>> resource-index 1, not the useless one at index 0. Which is yet another
>> indication that the naive irq-handling in the i2c-core sometimes get
>> somewhat in the way. In my experience many more complex i2c devices have
>> more then 1 irq line.
>
> I am aware of this problem as well.
>
>> That previous patch works for me too (and even simplifies my driver somewhat),
>> if you like it better I can go back to that. But thinking more about this
>> I decided that having a "dear i2c-core please don't try to out-smart the
>> driver, leave irq handling to me" flag would be better / more generally
>> useful.
>
> I agree. The last sentence made me understand that you want to flag
> "this driver wants custom irq handling" more than "this driver does not
> use irq" what I misinterpreted before. This is a much broader use case
> and we can probably help more people with that. I like it.

Good, I'm glad to hear that :)

 > Maybe we
> should name the flag something like "custom_irq_handling" to prevent
> similar misunderstandings? Just an idea.

Ok, so bringing in Andy's suggestions here as well (thank you Andy),
proposed names for the flag are:

"no_irq" - my initial attempt at a name, not really descriptive)
"custom_irq_handling" - I think Andy's right that the handling in the name may throw people of
"custom_irq_resource" - Does not feel entirely right either
"custom_irq_mapping"  - Idem

So I'm going to throw in a fifth option for a name for the flag:

"disable_i2c_core_irq_mapping"

It is a bit long, but IMHO best describes what it does, "custom"
is a bit vague and IMHO makes the flag sound more special then it is.

Shorter alternatives would be: "disable_irq_mapping".

Wolfram, if you can let me know which name you prefer then I
will update my local patches accordingly and post a new version
of my patch-set.

> Sorry if you got annoyed by my questions, yet with the prospect of
> not only adding code to the core but also adding something to
> i2c_driver, I really want to make sure it is worth it.

Understood, thank you for understanding my use-case / problem and
sorry if I sounded a bit annoyed.

I wish you both a nice weekend too,

Hans
