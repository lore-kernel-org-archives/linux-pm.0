From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/6] intel_idle: Add ->enter_freeze callbacks
Date: Thu, 05 Mar 2015 01:18:38 +0100
Message-ID: <2502414.MyBzvuWGMR@vostro.rjw.lan>
References: <8292243.ibkmfVtXac@vostro.rjw.lan> <25445086.IBiaGBbm1j@vostro.rjw.lan> <54F79A42.9070801@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <54F79A42.9070801@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, March 05, 2015 07:50:26 AM Li, Aubrey wrote:
> On 2015/2/13 0:24, Rafael J. Wysocki wrote:
> > On Thursday, February 12, 2015 02:26:43 PM Peter Zijlstra wrote:
> >>
> >> Why bother with enter_freeze() for any but the deepest state (C6 in this
> >> case)?
> > 
> > User space may disable the deepest one (and any of them in general) via sysfs
> > and there's no good reason to ignore its choice in this particular case while
> > we're honoring it otherwise.
> > 
> > So the logic is basically "find the deepest one which isn't disabled" and
> > setting the pointers costs us nothing really.
> > 
> 
> If the user has chance to disable C6 via /sys, that means c6 works?
> Shouldn't we ignore user space setting during freeze? Otherwise, we will
> lost S0ix?

We can't ignore it, because we don't know the reason why the state was
disabled.

It may just not work reliably enough on the given platform.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
