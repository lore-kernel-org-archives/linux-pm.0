From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] Suspend-to-idle fixes for Surface Pro3
Date: Wed, 10 Jan 2018 13:22:42 +0100
Message-ID: <4046497.JI7UjL75gC@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Valentin Manea <valy@mrs.ro>
List-Id: linux-pm@vger.kernel.org

Hi All,

After some changes made during the 4.13 cycle, power button doesn't wake up
the system from suspend-to-idle any more on Surface Pro3.

It turns out that the platform expects EC events to be processed while
suspended for this to work (patch [1/2]) and the button driver needs to
report wakeup events properly too (patch [2/2]).

Thanks,
Rafael
