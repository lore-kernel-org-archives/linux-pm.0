From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Q: acpi-cpufreq module auto-loading after processor driver change
Date: Fri, 07 Jun 2013 00:44:44 +0200
Message-ID: <3155099.bCeEkuSrim@vostro.rjw.lan>
References: <1511440.Xd41mcOoEa@vostro.rjw.lan> <5836546.v3RJP00CT7@vostro.rjw.lan> <20130606222113.GA9271@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20130606222113.GA9271@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, June 06, 2013 03:21:13 PM Greg Kroah-Hartman wrote:
> On Fri, Jun 07, 2013 at 12:13:58AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, June 06, 2013 11:51:54 PM Rafael J. Wysocki wrote:
> > > On Thursday, June 06, 2013 01:24:19 PM Greg Kroah-Hartman wrote:
> > > > On Thu, May 30, 2013 at 11:38:37PM +0200, Rafael J. Wysocki wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > I've noticed during recent testing that with this commit applied:
> > > > > 
> > > > > http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=acpi-hotplug&id=ac212b6980d8d5eda705864fc5a8ecddc6d6eacc
> > > > > 
> > > > > on my openSUSE (and Tubmbleweed) installations I need to modify
> > > > > /etc/sysconfig/kernel to make mkinitrd put the acpi-cpufreq module into the
> > > > > initramfs or otherwise it won't be loaded automatically.
> > > > > 
> > > > > I think I understand why it needs to be present in the initramfs along the
> > > > > processor module for the automatic loading to work (acpi_processor_load_module()
> > > > > seems to need that), but before the above commit it wasn't necessary to make
> > > > > any changes to /etc/sysconfig/kernel and acpi-cpufreq was loaded automatically
> > > > > anyway.
> > > > > 
> > > > > Unfortunately, my experience with udev and related things is kind of limited
> > > > > and I have no idea what exactly makes the difference.  Can you please have a
> > > > > look and help me understand that?
> > > > 
> > > > Don't you need a MODULE_DEVICE_TABLE() macro in that module somewhere so
> > > > that udev and the like know to load it when it sees the hardware?
> > > 
> > > Well, that was my first thought about that, but there is one already and my
> > > commit hasn't changed it. :-)
> > 
> > My understanding of this is that on x86 (which is the case here)
> > topology_init() calls arch_register_cpu() for all available CPUs which
> > calls register_cpu() and that causes the uevent to be emitted through
> > device_register().  But then, the commit above doesn't change that (at least
> > I don't see how).
> 
> At first glance, I don't see how either, sorry.

Well, thanks for looking. :-)

This is not a big deal, because the module is loaded when present in the
initramfs, but then I'm slightly concerned that people will complain "Oh, why
do I need to have this module in my initramfs now and I didn't before?! It
must be broken somehow!".

And besides, I'm just curious what's going on here. :-)

So far I have verified that topology_init() is executed before acpi_init()
(which appears to be pure coincidence, but oh well), so even the *ordering*
is the same as before.  The only difference is that the device in question
now has a driver bound to it and it didn't before (the driver was bound to
something else).

Hmm. I suspect udev just thinks "ok, I have found a driver for that device,
so I don't need to look for one any more" and that's why it doesn't load
acpi_cpufreq.  If that's the case, is there any way to make it load all
matching modules anyway?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
