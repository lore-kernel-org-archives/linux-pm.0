From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] PM / wakeup / ACPI: Suspend-to-idle wakeup fixes and optimization
Date: Sun, 14 May 2017 01:50:45 +0200
Message-ID: <2169867.RZcCZmJK9B@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56271 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756319AbdENAEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 May 2017 20:04:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Box <david.e.box@linux.intel.com>

Hi,

Two recent commits related to suspend-to-idle introduced a couple of issues
that need to be fixed.

In addition to that, there turns out to be a way to avoid carrying out the
"noirq" phase of device resume in order to check if wakeup triggered by an
ACPI SCI is a real one, which patch [3/3] is about.

Refer to patch changelogs for details.

Thanks,
Rafael
