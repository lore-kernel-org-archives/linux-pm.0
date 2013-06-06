From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Q: acpi-cpufreq module auto-loading after processor driver change
Date: Thu, 06 Jun 2013 23:51:54 +0200
Message-ID: <1508841.LDMR7VidnZ@vostro.rjw.lan>
References: <1511440.Xd41mcOoEa@vostro.rjw.lan> <20130606202419.GF18075@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59161 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908Ab3FFVmu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 6 Jun 2013 17:42:50 -0400
In-Reply-To: <20130606202419.GF18075@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday, June 06, 2013 01:24:19 PM Greg Kroah-Hartman wrote:
> On Thu, May 30, 2013 at 11:38:37PM +0200, Rafael J. Wysocki wrote:
> > Hi Greg,
> > 
> > I've noticed during recent testing that with this commit applied:
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=acpi-hotplug&id=ac212b6980d8d5eda705864fc5a8ecddc6d6eacc
> > 
> > on my openSUSE (and Tubmbleweed) installations I need to modify
> > /etc/sysconfig/kernel to make mkinitrd put the acpi-cpufreq module into the
> > initramfs or otherwise it won't be loaded automatically.
> > 
> > I think I understand why it needs to be present in the initramfs along the
> > processor module for the automatic loading to work (acpi_processor_load_module()
> > seems to need that), but before the above commit it wasn't necessary to make
> > any changes to /etc/sysconfig/kernel and acpi-cpufreq was loaded automatically
> > anyway.
> > 
> > Unfortunately, my experience with udev and related things is kind of limited
> > and I have no idea what exactly makes the difference.  Can you please have a
> > look and help me understand that?
> 
> Don't you need a MODULE_DEVICE_TABLE() macro in that module somewhere so
> that udev and the like know to load it when it sees the hardware?

Well, that was my first thought about that, but there is one already and my
commit hasn't changed it. :-)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
