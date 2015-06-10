From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/8] Driver core: wakeup the parent device before
 trying probe
Date: Wed, 10 Jun 2015 17:02:21 +0300
Message-ID: <1433944941.26331.119.camel@linux.intel.com>
References: <1433170082-117462-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1433170082-117462-4-git-send-email-andriy.shevchenko@linux.intel.com>
	 <6646339.jahMH2QKDR@vostro.rjw.lan> <3252449.XN2pzxrAPQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3252449.XN2pzxrAPQ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2015-06-10 at 02:08 +0200, Rafael J. Wysocki wrote: 
> On Tuesday, June 09, 2015 01:42:00 AM Rafael J. Wysocki wrote:
> > On Monday, June 01, 2015 05:47:57 PM Andy Shevchenko wrote:
> > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > 
> > > If the parent is still suspended when driver probe is
> > > attempted, the result may be failure.
> > > 
> > > For example, if the parent is a PCI MFD device that has been
> > > suspended when we try to probe our device, any register
> > > reads will return 0xffffffff.
> > > 
> > > To fix the problem, making sure the parent is always awake
> > > before attempting driver probe.

[]

> Actually, something like the below should work too (the bumping up of the
> parent's usage counter before the loop will keep it in the runtime-active
> state throughout the loop).

It works. Thanks for the patch. We incorporate it instead of the
previous Heikki's patch into v4.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

