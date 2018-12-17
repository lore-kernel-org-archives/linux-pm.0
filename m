From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFT][PATCH 0/2] ACPI / PM: Avoid spurious wakeups from non-wakeup GPEs in suspend-to-idle
Date: Mon, 17 Dec 2018 12:19:27 +0100
Message-ID: <4307523.O7RPX2KSmk@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

It turns out that on some systems non-wakeup GPEs cause trouble (see the
changelog of patch [1/2]), so they better should be disabled during
suspend-to-idle (at least before entering the main loop of it).  This
is done in patch [1/2].

Patch [2/2] is just a folllow-up.

Thanks,
Rafael
