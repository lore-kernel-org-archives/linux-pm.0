From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/4] Avoid duplicate registering of ACPI and native power-supplies
Date: Thu, 16 Mar 2017 17:15:57 +0100
Message-ID: <20170316161601.32267-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:9195 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754621AbdCPQYh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Mar 2017 12:24:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

Hi All,

The last 2 patches of this series depend on the first 2, as such it might
be better to merge all 4 through the acpi tree if Sebastius is ok with
that.

Otherwise these patches are pretty self-explanatory.

Regards,

Hans
