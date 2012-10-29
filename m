From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/7] ACPI / PM: ACPI power management callback routines for subsystems
Date: Mon, 29 Oct 2012 10:06:32 +0100
Message-ID: <1766582.8gdQKXoi0K@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Huang Ying <ying.huang@intel.com>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

The following series of patches rearranges ACPI device power management
code and introduces universal PM callback routines that may be used by
bus types that don't support power management natively and/or by drivers
of devices with those bus types.

[1/7] Move routines for adding/removing device wakeup notifiers into a separate
      file.
[2/7] Move device power state selection routine to the new device PM file.
[3/7] Move runtime remote wakeup setup routine to the new device PM file.
[4/7] Split device wakeup management routines, so that it is possible to
      reduce the number of acpi_bus_get_device() calls.
[5/7] Provide low-lever device PM functions operationg on struct acpi_device
      objects.
[6/7] Move device PM functions related to sleep states from sleep.c to the
      new device PM file.
[7/7] Provide ACPI PM callback routines for subsystems.

The patches are on top of the current Linus' tree with the git branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-qos

merged.  The resulting kernel has been run on my test-bed Toshiba Portege R500
and hasn't crashed it, but more testing is still needed, so please use it with
care.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
