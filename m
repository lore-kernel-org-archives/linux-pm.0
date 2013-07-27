From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] ACPI / PM: Device PM cleanups
Date: Sat, 27 Jul 2013 15:09:29 +0200
Message-ID: <10433383.dueoNg39qi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Aaron Lu <aaron.lu@intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi All,

The following 3 patches clean up ACPI device PM a bit:

[1/3] Fix acpi_device_set_power() to avoid printing useless messages for
      devices that aren't power manageable.

[2/3] Fix messages in acpi_device_set_power() to always contain a device
      name.

[3/3] Replace ACPI_STATE_D3 witn ACPI_STATE_D3_COLD everywhere in the tree
      (leave definition as part of ACPICA).

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
