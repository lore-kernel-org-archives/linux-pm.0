From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v11 3/5] thinkpad_acpi: Add support for battery thresholds
Date: Wed, 03 Jan 2018 12:24:53 +0100
Message-ID: <7475117.k4QWeGOQkJ@aspire.rjw.lan>
References: <20171231141727.GA4643@thinkpad> <CAHp75VeYRYRpmqy_GGQ95e1YhvZGfWtsJrGbLiA4JskEmd69zg@mail.gmail.com> <20180103103455.GA17803@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:56369 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbeACLZ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jan 2018 06:25:58 -0500
In-Reply-To: <20180103103455.GA17803@thinkpad>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?ISO-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>

On Wednesday, January 3, 2018 11:34:55 AM CET Ognjen Galić wrote:
> On Mon, Jan 01, 2018 at 12:24:39PM +0200, Andy Shevchenko wrote:
> > On Sun, Dec 31, 2017 at 4:17 PM, Ognjen Galic <smclt30p@gmail.com> wrote:
> > > thinkpad_acpi registers two new attributes for each battery:
> > >
> > > 1) Charge start threshold
> > > /sys/class/power_supply/BATN/charge_start_threshold
> > >
> > > Valid values are [0, 99]. A value of 0 turns off the
> > > start threshold wear control.
> > >
> > > 2) Charge stop threshold
> > > /sys/class/power_supply/BATN/charge_stop_threshold
> > >
> > > Valid values are [1, 100]. A value of 100 turns off
> > > the stop threshold wear control. This must be
> > > configured first.
> > >
> > 
> > > This patch depends on the following patches:
> > >
> > > "battery: Add the battery hooking API"
> > 
> > Since this is series, no need to put above into changelog.
> > 
> > AFAICS it's not going to be backported either.
> > 
> > 
> > > +/**
> > > + * This evaluates a ACPI method call specific to the battery
> > > + * ACPI extension. The specifics are that an error is marked
> > > + * in the 32rd bit of the response, so we just check that here.
> > > + *
> > > + * Returns 0 on success
> > > + */
> > > +static int tpacpi_battery_acpi_eval(char *method, int *ret, int param)
> > > +{
> > 
> > One problem and one trick you may do.
> > 
> > A problem: you return ACPI status as int. We have special type for
> > that. So, be consistent with it.
> > Looking to acpi_evalf() which is private to the module, I think you
> > need to get rid of ACPI return codes here.
> > 
> > A trick: since you are using only least significant byte of the
> > response, you can declare it as u8 *value (yeah, ret is not best name
> > here I think).
> 
> Not really. In one place I need bit #9, so that will stay a int.
> I have changed the acpi return value to acpi_status tho.

OK, you can resend the updated series when you're ready.

Thanks,
Rafael
