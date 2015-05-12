From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: [PATCH 0/2] power_supply: bq2415x_charger: Fix coding style issues && add ACPI support
Date: Tue, 12 May 2015 12:11:31 +0300
Message-ID: <1431421893-18816-1-git-send-email-anda-maria.nicolae@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi all,

The following 2 patches do the following to bq2415x_charger:
- first patch fixes pre-existing coding style issues reported by checkpatch.pl
- second patch adds ACPI enumeration support

Thanks,
Anda

Anda-Maria Nicolae (2):
  power_supply: bq2415x_charger: Fix coding style issues
  power_supply: bq2415x_charger: Add ACPI support

 drivers/power/bq2415x_charger.c |   94 +++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 28 deletions(-)

-- 
1.7.9.5
