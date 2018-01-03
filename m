From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
Subject: Re: [PATCH v12 3/4] thinkpad_acpi: Add support for battery thresholds
Date: Wed, 3 Jan 2018 15:58:26 +0100
Message-ID: <20180103145826.GB17694@thinkpad>
References: <20180103115922.GA10135@thinkpad>
 <CAHp75Vdqz=VMcdaa04fVywFeHs+C6_a7ux0M1XE1=Q9TTpWOvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vdqz=VMcdaa04fVywFeHs+C6_a7ux0M1XE1=Q9TTpWOvA@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 03, 2018 at 04:42:35PM +0200, Andy Shevchenko wrote:
> On Wed, Jan 3, 2018 at 1:59 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
> > thinkpad_acpi registers two new attributes for each battery:
> >
> > 1) Charge start threshold
> > /sys/class/power_supply/BATN/charge_start_threshold
> >
> > Valid values are [0, 99]. A value of 0 turns off the
> > start threshold wear control.
> >
> > 2) Charge stop threshold
> > /sys/class/power_supply/BATN/charge_stop_threshold
> >
> > Valid values are [1, 100]. A value of 100 turns off
> > the stop threshold wear control. This must be
> > configured first.
> >
> > Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
> 
> Thanks for an update!
> 
> > ---
> >
> > Notes:
> 
> >     * Change int to acpi_status in tpacpi_battery_acpi_eval
> 
> Then you need to check return code with ACPI_FAILURE() or ACPI_SUCCESS() macros.
> That is one of the additional burden while I can't see usefulness of
> ACPI return codes in that function and why I suggested to use plain
> int.

Thos macros basically do the same stuff I do manually. I think that most
of the kernel does errors on a non-0 basis, and ACPI is no exception.

That being said, I think that using a simple non-0 check if more clean
than using those macros.

Isn't this:

if (!acpi_eval....

nicer than this?

if ACPI_FAILURE(acpi_eval...

It just adds more stuff to get wrong. And I don't really think that the 
ACPI implementation will change those macros anytime soon, or ever.

Keeping it simple.

> 
> One more question: why don't you use dev_err()/dev_*() macros instead
> of pr_*() ones?
> (Note, it's a question, needs a bit of discussion, I would like to
> hear a rationale of this, I think it might be one)

Techically, I'm not adding a device this I did not use those macros. I'm
only adding more attributes to a device that the battery module manages.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
