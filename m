From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] ACPI / PM: Initial power state checking and power state setting changes
Date: Tue, 22 Jan 2013 03:05:41 +0100
Message-ID: <1792467.qHBR6KraFh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

The following patches make the determination of the initial device power state
more robust and change the way ACPI device power states are changed to be more
in line with the spec.

[1/4] Make the determination of initial device power states more robust.
[2/4] Reduce duplication of code between ACPI device PM functions.
[3/4] Make the changing of device power states follow the spec literally.
[4/4] Sanitize checks in acpi_power_on_resources().

The patches are on top of linux-pm.git/linux-next.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
