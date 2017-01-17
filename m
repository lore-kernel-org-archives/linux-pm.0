From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Regression on Dell XPS13 (was: [char-misc for 4.10-rc4 V2] mei:
 bus: enable OS version only for SPT and newer)
Date: Tue, 17 Jan 2017 19:23:37 +0100
Message-ID: <20170117182337.GB12600@kroah.com>
References: <b1ecfd53-e856-ce10-d56e-4fea27095a8f@molgen.mpg.de>
 <20170113130018.GA896@kroah.com>
 <5549d8c0527412390d71236d80dff419@molgen.mpg.de>
 <20170114193959.GA30750@kroah.com>
 <5B8DA87D05A7694D9FA63FD143655C1B5437C2D3@hasmsx108.ger.corp.intel.com>
 <20170115105830.GD26374@kroah.com>
 <20170116110539.GA1307@kroah.com>
 <1b1feb50-2b22-b7e7-0fb8-2011340f5c47@leemhuis.info>
 <55b349b2-2999-94d5-9f68-b1944df1d374@molgen.mpg.de>
 <954f9b4e8bd844c98f8d3c12f0fe366f@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <954f9b4e8bd844c98f8d3c12f0fe366f@ausx13mpc120.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: pmenzel@molgen.mpg.de, rafael.j.wysocki@intel.com, linux@leemhuis.info, tomas.winkler@intel.com, jan@gondor.com, alexander.usyskin@intel.com, linux-kernel@vger.kernel.org, yu.c.chen@intel.com, tomi.p.sarvela@intel.com, daniel@quora.org, len.brown@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 17, 2017 at 04:57:49PM +0000, Mario.Limonciello@dell.com wrote:
> So in the <6s scenario, the intel-hid driver is responsible to receive the ACPI
> event and process accordingly.  The maintainer has a patch ready for the intel-hid
> portion of this work, but it's currently being reviewed by Intel to ensure it
> can be legally submitted into the kernel.

Who at Intel do I need to go kick to make this mythical legal review
happen faster so we can see the code?

Len and Rafael, what is going on here?

> > 406e79385f3223d82272cf2be86bc95cd000a258 is the first bad commit commit
> > 406e79385f3223d82272cf2be86bc95cd000a258
> > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Date:   Mon Nov 21 22:45:40 2016 +0100
> > 
> >      PM / sleep: System sleep state selection interface rework
> > 
> >      There are systems in which the platform doesn't support any special
> >      sleep states, so suspend-to-idle (PM_SUSPEND_FREEZE) is the only
> >      available system sleep state.  However, some user space frameworks
> >      only use the "mem" and (sometimes) "standby" sleep state labels, so
> >      the users of those systems need to modify user space in order to be
> >      able to use system suspend at all and that may be a pain in practice.
> > 
> >      Commit 0399d4db3edf (PM / sleep: Introduce command line argument for
> >      sleep state enumeration) attempted to address this problem by adding
> >      a command line argument to change the meaning of the "mem" string in
> >      /sys/power/state to make it trigger suspend-to-idle (instead of
> >      suspend-to-RAM).
> > 
> >      However, there also are systems in which the platform does support
> >      special sleep states, but suspend-to-idle is the preferred one anyway
> >      (it even may save more energy than the platform-provided sleep states
> >      in some cases) and the above commit doesn't help in those cases.
> > 
> >      For this reason, rework the system sleep state selection interface
> >      again (but preserve backwards compatibiliby).  Namely, add a new
> >      sysfs file, /sys/power/mem_sleep, that will control the system
> >      suspend mode triggered by writing "mem" to /sys/power/state (in
> >      analogy with what /sys/power/disk does for hibernation).  Make it
> >      select suspend-to-RAM ("deep" sleep) by default (if supported) and
> >      fall back to suspend-to-idle ("s2idle") otherwise and add a new
> >      command line argument, mem_sleep_default, allowing that default to
> >      be overridden if need be.
> > 
> >      At the same time, drop the relative_sleep_states command line
> >      argument that doesn't make sense any more.
> > 
> >      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >      Tested-by: Mario Limonciello <mario.limonciello@dell.com>
> > 
> > :040000 040000 a5770fe0413cbe7794eab28f72dfe8ede1f090c2
> > a2882c77659517aa7137c930e0e7f178bc76bfbd M      Documentation
> > :040000 040000 2594b1a87815173e97199ef9d9c5918fec22fcfd
> > fe0b69953be653644c5366ac631131fdbbdb9bcc M      kernel
> > $ git tag --contains 406e79385f3223d82272cf2be86bc95cd000a258
> > v4.10-rc1
> > v4.10-rc2
> > v4.10-rc3
> > ```
> > 
> > Please find the config and the bisection log attached. Sometimes I had to
> > cherry-pick build fix commits for PIE enabled GCC on top.
> > 
> > Rafael, do you want me to open a bug report for that? Mario, what systems
> > did you actually test this on? (Why isn’t that listed in the commit message?)
> > Mario, do you have access to Dell XPS13 (9360) devices to help getting this
> > fixed?
> > 
> 
> I tested this on several systems and ensured that the kernel was doing the
> right thing in terms of choosing the correct state to go into.
> 
> As I mentioned above, those behaviors are currently expected until these
> types issues are identified and fixed in the proper subsystems.  If they
> end up being troublesome to resolve, it's possible to quirk individual systems,
> to disable this behavior and return to traditional S3 but I would prefer to actually 
> identify and fix the various problems so that we can push the Linux stack forward.

If the machine stops working on a newer kernel when it used to work
before, then you need to either revert the change, or provide a fix for
it.

I think I might have access to a newer Dell XPS13 now, I'll try to set
it up tomorrow to test 4.10-rc4 out...

thanks,

greg k-h
