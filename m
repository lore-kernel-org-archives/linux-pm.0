From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng implementation
Date: Fri, 30 Jun 2017 19:37:15 +0300
Message-ID: <CAHp75VdLU57x2YuDH+SkB1jR3rSpqcVNszhq5fDUVZZt+sqxyQ@mail.gmail.com>
References: <20170629121009.30234-1-benjamin.tissoires@redhat.com>
 <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com> <20170630155706.GL26073@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170630155706.GL26073@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, Sebastian Reichel <sre@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 30, 2017 at 6:57 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Jun 29 2017 or thereabouts, Andy Shevchenko wrote:
>> On Thu, Jun 29, 2017 at 3:10 PM, Benjamin Tissoires
>> <benjamin.tissoires@redhat.com> wrote:

>> What devices (laptops, tablets) have it?
>> Surface 3. What else?
>
> So far, Surface 3 only. It's a Microsoft PNPId, so I guess they control
> which device has it. Maybe the model after the Surface 3 (reduced
> platform) will have such chip, but for now, it's unknown.

Please, extend introduction in commit message to state above.

>> > I couldn't manage to get the IRQ correctly triggered, so I am using a
>> > good old polling thread to check for changes.
>>
>> It might be

It seems I didn't finished the sentence here.

I though it might be actually ACPI event, GPE or direct IRQ (when GPIO
chip should not disable it, though if it's the case it likely a BIOS
bug for this hardware).

>> > +       help
>> > +         Select this option to enable support for ACPI operation
>> > +         region of the Surface 3 battery platform driver.
>>
>> > +/*
>> > + * Supports for the power IC on the Surface 3 tablet.
>>
>> Shouldn't it go to drivers/acpi/pmic folder ?
>
> Already answered later in the thread, so yes, I'll move it there.

Actually Hans did a good point, so, feel free to use drivers/platform/x86.

>> And did you check if it have actual chip IP vendor name and model?
>> Most likely it's a TI (based?) solution.
>
> As mentioned, I have strictly no idea. I can not crack open the Surface
> 3 without breaking the warranty (I already had to return it once because
> the disk crashed).

We have one indeed cracked (screen is broken for good :-) ), so, I
would check what I can find there.

> And I do not find anything brand-related under Windows either:
> - it's called "Surface Platform Power Driver"
> - and the driver is provided by Microsoft

Fair enough.

>> > +static int mshw0011_bix(struct mshw0011_data *cdata, struct bix *bix)
>> > +{
>>
>> > +       memcpy(bix->serial, buf + 7, 3);
>> > +       memcpy(bix->serial + 3, buf, 6);
>> > +       bix->serial[9] = '\0';
>>
>> snprintf()?
>
> probably :)

I would do this until we have an evidence that it contains non-printable symbols
(or, in case you want to fix ahead, make the buffer 4 times bigger and use %*pE)

>> > +       memcpy(bix->OEM, buf, 3);
>> > +       bix->OEM[4] = '\0';
>>
>> snprintf() ?

Ditto.

>> > +       snprintf(prefix, ARRAY_SIZE(prefix), "%s: ", bat0->name);
>>
>> > +       prefix[127] = '\0';
>>
>> Why?
>
> Just me being paranoid in case the code doesn't follow the spec... Yeah, I'll
> remove it.

snprintf() despite n in the name takes care of terminating NUL.

>> > +static int mshw0011_probe(struct i2c_client *client,
>> > +                         const struct i2c_device_id *id)
>> > +{
>>
>> > +       data->notify_version = version == MSHW0011_EV_2_5;
>>
>> 0x1ff as version sounds hmm suspicious.
>
> So after a little bit of digging, it appears those values were taken
> from the DSDT:
> https://bugzilla.kernel.org/attachment.cgi?id=187171 line 11694.
>
> It appears 0x3F is EV 2.1 and before, and 0x1FF is EV 2.5 and above.
> The returned value is not a version of the chip, just a flag to know
> which path we are taking in the DSM.
>
> The name is probably not the best.

63 and 511 looks too suspicious to be a version. Rather block size, a
mask or alike.

>> > +static const struct i2c_device_id mshw0011_id[] = {
>> > +       { }
>> > +};
>> > +MODULE_DEVICE_TABLE(i2c, mshw0011_id);
>>
>> ->probe_new(), please.
>
> Correct
>
>>
>> If I2C framework is _still_ broken we need to fix that part.
>
> I haven't check, so let's see for v3.

Cc: Wolfram for v3 and ask him directly. Last time I checked it looks
like I2C core doesn't care about ACPI when ->probe_new() is used.

-- 
With Best Regards,
Andy Shevchenko
