From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] cpuidle: Rework the handling of the poll state
Date: Mon, 28 Aug 2017 23:17:43 +0200
Message-ID: <8432156.DIvYQkV4Qe@aspire.rjw.lan>
References: <21794463.WNaOdcSnfv@aspire.rjw.lan> <1350530b-bed8-ab45-d5d2-dcaf4178320d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1350530b-bed8-ab45-d5d2-dcaf4178320d@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 24, 2017 11:48:19 AM CEST Sudeep Holla wrote:
> 
> On 23/08/17 22:18, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On x86 the fist idle state is a polling one, but the way it is set up is far
> > from straightforward and then it is avoided by governors in rather somewhat
> > convoluted fashion.
> > 
> > Make this more clear by explicitly flagging that state as "polling" and
> > checking its flag where it needs to be avoided instead of using
> > arch-dependent numbering of idle states (patch [1/3]), move the
> > polling state code from driver.c to a separate C file (patch [2/3]) and
> > move the initialization of it from the core to the relevant cpuidle drivers -
> > ACPI and intel_idle (patch [3/3]).
> > 
> 
> Tested this on ARM64 platform(both DT and ACPI/LPI) and everything
> continues to work fine.
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks Sudeep!

I haven't seen any more comments on this which I'm taking as a green light for
it, so I'm going to queue it up for 4.14.

Thanks,
Rafael


