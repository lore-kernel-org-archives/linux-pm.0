From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] ACPI / PM: Dispatch EC GPE early on s2idle resume if LPS0 _DSM is used
Date: Wed, 16 May 2018 14:10:55 +0200
Message-ID: <2406722.gU2bUHd7bl@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Erik Schmauss <erik.schmauss@intel.com>, Bob Moore <robert.moore@intel.com>, "Wang, Wendy" <wendy.wang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

The purpose of this series is to address a power button wakeup issue on
some platforms where EC events aren't looked for early enough after
wakeup from suspend-to-idle.

The first patch modifies acpi_ev_detect_gpe() to compute a gpe_event_info
if NULL is passed as its second argument and adds a wrapper around it that
is used in the second patch.

The second patch checks the EC GPE in-line after detecting an SCI wakeup
to avoid missing the wakeup event.

Thanks,
Rafael
