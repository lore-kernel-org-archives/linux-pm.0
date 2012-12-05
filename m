From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] ACPI / PM: Export ACPI power states of devices via sysfs
Date: Wed, 05 Dec 2012 01:39:26 +0100
Message-ID: <1464990.iyrX0DeZyT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi All,

In some situations it is very useful to know the current ACPI power states of
devices.  For this reason, the following series of patches makes it possible
to retrieve that information via sysfs.

Patches [1-2/3] are trivial function renames, patch [3/3] is the real thing.

The series is on top of the master branch of linux-pm.git.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
