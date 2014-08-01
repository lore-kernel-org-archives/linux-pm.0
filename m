From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH] PM / sleep: Rename symbols, functions and variables related to sleep
Date: Fri, 01 Aug 2014 15:56:31 +0200
Message-ID: <4200761.44Q8iqWhBp@vostro.rjw.lan>
References: <5215142.eaz1Ajyth6@vostro.rjw.lan> <5425640.ztbaPas56b@vostro.rjw.lan> <20140730065034.GB8024@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140730065034.GB8024@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 30, 2014 08:50:34 AM Pavel Machek wrote:
> On Wed 2014-07-30 01:41:25, Rafael J. Wysocki wrote:
> > On Monday, July 28, 2014 01:13:56 AM Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > The names of several symbols, data types, functions and variables
> > > related to system sleep states are confusing and don't reflect the
> > > real behavior of those states correctly.
> > > 
> > > First of all, there generally are two sleep states that require
> > > platform support and one sleep state that is platform-independent.
> > > The first two of them are currently known as MEM and STANDBY,
> > > although these names really only match what the states do on full
> > > hardware ACPI compliant systems.  MEM in particular is supposed
> > > to mean "suspend-to-RAM", but in fact it means "the deepest sleep
> > > state available with platform support".  The definition of STANDBY
> > > is even more arbitrary.
> > > 
> > > Moreover, the remaining sleep state that doesn't need platform support
> > > is currently called FREEZE, which leads to double confusion with the
> > > process freezer (used during transitions to all sleep states) and
> > > with the freeze stage of processing devices during hibernation.
> > > 
> > > For these reasons, rename the PM_SUSPEND_MEM, PM_SUSPEND_STANDBY
> > > and PM_SUSPEND_FREEZE symbols to PM_SUSPEND_PLATFORM_DEEP,
> > > PM_SUSPEND_PLATFORM_SHALLOW and PM_SUSPEND_IDLE_SLEEP, respectively,
> > > everywhere and rename data types, functions and variables related to
> > > those states to match the new names of the symbols.
> > > 
> > > This is a semi-mechanical replacement of names and it should not lead
> > > to any functional differences.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > OK, any comments or objections anyone?
> > 
> > Or should I just make it a non-RFC and apply it?
> 
> I don't really like the new names, and I'm not sure if I like
> direction this is heading. At least on ACPI machines, S1 and S3 is
> different -- different parts of hardware will stay powered on.
> 
> So if you want to charge your cellphone with machine suspended, you
> want S1... and you don't want S1/S3 to change names. (Ok, this is not
> what you are doing now, but what you plan AFAICT.)
> 
> > > For these reasons, rename the PM_SUSPEND_MEM, PM_SUSPEND_STANDBY
> > > and PM_SUSPEND_FREEZE symbols to PM_SUSPEND_PLATFORM_DEEP,
> > > PM_SUSPEND_PLATFORM_SHALLOW and PM_SUSPEND_IDLE_SLEEP, respectively,
> 
> I'm not sure why you want to mention "platform there", AFAICT better
> names would be
> 
> PM_SUSPEND_DEEP, PM_SUSPEND_SHALLOW, PM_IDLE_SLEEP.

OK, that makes sense.

Rafael
