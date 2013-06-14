From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] ACPI / PM: Cleanups and device power state selection rework
Date: Fri, 14 Jun 2013 14:29:57 +0200
Message-ID: <6895318.cKDBc4OdI0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

The following series of patches cleans up the ACPI device PM core code and
reworks the routine used for selecting power states to put devices into.

[1/4] Rename a function whose name is the same as the name of a data type and
      make it static.

[2/4] Replace ACPI_STATE_D3 with ACPI_STATE_D3_COLD in device_pm.c.

[3/4] Rework functions used for selecting power states to put devices into.

[4/4] Drop some unused code.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
