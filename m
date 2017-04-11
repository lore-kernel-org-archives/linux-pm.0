From: Liam Breck <liam@networkimprov.net>
Subject: [PATCH v5 0/4] BQ24190 charger fixes
Date: Tue, 11 Apr 2017 04:59:53 -0700
Message-ID: <20170411115957.14253-1-liam@networkimprov.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36227 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbdDKMAA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 08:00:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id i5so10186411pfc.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Apr 2017 05:00:00 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>

Hi Sebastian,

Here in one patchset are two patches I posted recently, and two more:

Patch 1 is a replacement (as agreed) for
  "power: supply: bq24190_charger: Don't spam the logs on charger plug / unplug"
Patch 2 fixes up Hans' extcon patch. If you would like me to squash it with his
  original patch, let me know.
Patch 3 (repost) fixes some issues with PM runtime error handling.
Patch 4 fixes a nit in register_reset().

Changed in v5:
* move condition in extcon OTG boost code
* document extcon client invocation of charger driver
* udelay -> usleep_range in register_reset()

Changes in v4:
* fix definition of bq24190_reg_poc_chg_config_*
* revert to if (device_property_read... == 0)
