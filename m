From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Q: acpi-cpufreq module auto-loading after processor driver change
Date: Fri, 07 Jun 2013 00:13:58 +0200
Message-ID: <5836546.v3RJP00CT7@vostro.rjw.lan>
References: <1511440.Xd41mcOoEa@vostro.rjw.lan> <20130606202419.GF18075@kroah.com> <1508841.LDMR7VidnZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59170 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab3FFWEx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 6 Jun 2013 18:04:53 -0400
In-Reply-To: <1508841.LDMR7VidnZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, June 06, 2013 11:51:54 PM Rafael J. Wysocki wrote:
> On Thursday, June 06, 2013 01:24:19 PM Greg Kroah-Hartman wrote:
> > On Thu, May 30, 2013 at 11:38:37PM +0200, Rafael J. Wysocki wrote:
> > > Hi Greg,
> > > 
> > > I've noticed during recent testing that with this commit applied:
> > > 
> > > http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=acpi-hotplug&id=ac212b6980d8d5eda705864fc5a8ecddc6d6eacc
> > > 
> > > on my openSUSE (and Tubmbleweed) installations I need to modify
> > > /etc/sysconfig/kernel to make mkinitrd put the acpi-cpufreq module into the
> > > initramfs or otherwise it won't be loaded automatically.
> > > 
> > > I think I understand why it needs to be present in the initramfs along the
> > > processor module for the automatic loading to work (acpi_processor_load_module()
> > > seems to need that), but before the above commit it wasn't necessary to make
> > > any changes to /etc/sysconfig/kernel and acpi-cpufreq was loaded automatically
> > > anyway.
> > > 
> > > Unfortunately, my experience with udev and related things is kind of limited
> > > and I have no idea what exactly makes the difference.  Can you please have a
> > > look and help me understand that?
> > 
> > Don't you need a MODULE_DEVICE_TABLE() macro in that module somewhere so
> > that udev and the like know to load it when it sees the hardware?
> 
> Well, that was my first thought about that, but there is one already and my
> commit hasn't changed it. :-)

My understanding of this is that on x86 (which is the case here)
topology_init() calls arch_register_cpu() for all available CPUs which
calls register_cpu() and that causes the uevent to be emitted through
device_register().  But then, the commit above doesn't change that (at least
I don't see how).

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
