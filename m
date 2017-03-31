From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/4] i2c: core: Allow drivers to specify index for
 irq to get from of / ACPI
Date: Fri, 31 Mar 2017 23:13:01 +0300
Message-ID: <1490991181.708.92.camel@linux.intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170331195407.GA1449@katana>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2017-03-31 at 21:54 +0200, Wolfram Sang wrote:

> > That previous patch works for me too (and even simplifies my driver
> > somewhat),
> > if you like it better I can go back to that. But thinking more about
> > this
> > I decided that having a "dear i2c-core please don't try to out-smart 
> > the
> > driver, leave irq handling to me" flag would be better / more
> > generally
> > useful.
> 
> I agree. The last sentence made me understand that you want to flag
> "this driver wants custom irq handling" more than "this driver does
> not
> use irq" what I misinterpreted before.

Latest Hans' explanation gets it clear to me either.

>  This is a much broader use case
> and we can probably help more people with that. I like it. Maybe we
> should name the flag something like "custom_irq_handling" to prevent
> similar misunderstandings? Just an idea.

I would go with custom_irq_resource (or custom_irq_mapping).
IRQ handling sounds a bit confusing (do the core handles interrupts on
behalf of my device?).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
