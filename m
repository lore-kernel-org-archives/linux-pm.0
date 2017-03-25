From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 0/4]: i2c-core improvements for complex ACPI-devices + cht-wc-fuel-gauge driver
Date: Sat, 25 Mar 2017 14:55:46 +0100
Message-ID: <20170325135550.22509-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbdCYNz5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 25 Mar 2017 09:55:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org

Hi Wolfram, Sebastian, All,

Here is v3 of my i2c-core improvements for complex ACPI-devices and
my Cherry Trail Whiskey Cove PMIC Fuel Gauge driver.

The fuel-gauge driver depends on the i2c-core changes, which is
why I'm posting this as a single series. It might be easiest
to merge the fuel-gauge driver through the i2c tree (once it
passes review). Sebastian is that ok for you ?

See inside the individual patches for a per patch changelog.

Regards,

Hans
