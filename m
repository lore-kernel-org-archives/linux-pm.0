From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Q: acpi-cpufreq module auto-loading after processor driver change
Date: Thu, 30 May 2013 23:38:37 +0200
Message-ID: <1511440.Xd41mcOoEa@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Greg,

I've noticed during recent testing that with this commit applied:

http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=acpi-hotplug&id=ac212b6980d8d5eda705864fc5a8ecddc6d6eacc

on my openSUSE (and Tubmbleweed) installations I need to modify
/etc/sysconfig/kernel to make mkinitrd put the acpi-cpufreq module into the
initramfs or otherwise it won't be loaded automatically.

I think I understand why it needs to be present in the initramfs along the
processor module for the automatic loading to work (acpi_processor_load_module()
seems to need that), but before the above commit it wasn't necessary to make
any changes to /etc/sysconfig/kernel and acpi-cpufreq was loaded automatically
anyway.

Unfortunately, my experience with udev and related things is kind of limited
and I have no idea what exactly makes the difference.  Can you please have a
look and help me understand that?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
