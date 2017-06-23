From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / sleep: EC-based wakeup from suspend-to-idle on recent systems
Date: Fri, 23 Jun 2017 14:13:57 +0200
Message-ID: <2892243.DJpRz1t3Fg@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <2368998.dmCsnrcXZy@aspire.rjw.lan> <1AE640813FDE7649BE1B193DEA596E886CED4669@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E886CED4669@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, Tom Lanyon <tom@oneshoeco.com>, =?ISO-8859-1?Q?J=E9r=3Fme?= de Bretagne <jerome.debretagne@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, June 23, 2017 06:30:35 AM Zheng, Lv wrote:
> Hi, Rafael
> 

[cut]

> > 
> > Index: linux-pm/drivers/acpi/ec.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/ec.c
> > +++ linux-pm/drivers/acpi/ec.c
> > @@ -1835,7 +1835,7 @@ static int acpi_ec_suspend(struct device
> >  	struct acpi_ec *ec =
> >  		acpi_driver_data(to_acpi_device(dev));
> > 
> > -	if (ec_freeze_events)
> > +	if (acpi_sleep_no_ec_events() && ec_freeze_events)
> >  		acpi_ec_disable_event(ec);
> >  	return 0;
> >  }
> 
> I just notice a slight pontential issue.
> Should we add a similar change to acpi_ec_stop()?

Yes, it looks like that, thanks!

Rafael

