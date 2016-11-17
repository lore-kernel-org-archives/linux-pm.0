From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] PM / sleep: Support for using suspend-to-idle by default
Date: Thu, 17 Nov 2016 03:19:27 +0100
Message-ID: <9316960.49SRRJV8RJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series is a follow-up for a BoF discussion during the LPC.

The discussion was about supporting Linux on modern laptops and one of
the issues mentioned was the lack of support for suspend-to-idle in user
space and if there's anything that can be done about that in the kernel.

The following patches are my input. :-)

The first one reworks the suspend interface to allow the "mem" string
in /sys/power/state to represent multiple things that can be selected via
an additional sysfs attribute.

The second one makes ACPI select suspend-to-idle as the default suspend mode
if so indicated in the FADT.

Please let me know what you think.

Thanks,
Rafael

