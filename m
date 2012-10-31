From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5] ACPI-based enumeration of devices that are not discoverable natively
Date: Wed, 31 Oct 2012 10:31:14 +0100
Message-ID: <1421417.rIOjExM5Pt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lv Zheng <lv.zheng@intel.com>, Huang Ying <ying.huang@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86 list <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

The following patch series adds support for ACPI-based enumeration of devices
that aren't discoverable natively to the driver core and ACPI subsystem.  It
covers the generic part and the platform bus type support.

Since in this case the role of ACPI is analogous to the role of Device Trees,
the idea is to follow what Device Trees did previously.

[1/5] Move ACPI handle to struct device and add device IDs table to
      struct device_driver.

[2/5] Generic functions for matching ACPI device nodes.

[3/5] Export GSI registration/unregistration functions on x86 (needed by [5/5]).

[4/5] Export GSI registration/unregistration functions on ia64 (needed by [5/5]).

[5/5] ACPI-based device enumeration support for platform devices.

The patches are on top of the linux-next branch of the linux-pm.git tree
with the "ACPI / PM: ACPI power management callback routines for subsystems"
patch series applied (although that series is not strictly necessary for them
to work).  They have been tested by Mika.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
