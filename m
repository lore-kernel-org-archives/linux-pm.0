From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 0/1] power: supply: bq24190_charger: Remove extcon handling
Date: Tue, 28 Nov 2017 10:08:29 +0100
Message-ID: <20171128090830.15186-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44041 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbdK1JIc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Nov 2017 04:08:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Now that all the changes moving drivers/i2c/busses/i2c-cht-wc.c over
to using "input-current-limit-from-supplier" instead of "extcon-name"
have landed, the last user of the bq24190 extcon code is gone.

So the patch removing the extcon code can be merged now.

Regards,

Hans
