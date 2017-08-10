From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI: Add some debug statements related to PM
Date: Fri, 11 Aug 2017 01:30:50 +0200
Message-ID: <14884530.U9YM2D2TGn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following two patches add pr_debug() and acpi_handle_debug() in a couple
of places to help debug issues related to ACPI events, such as device wakeup.

Thanks,
Rafael

