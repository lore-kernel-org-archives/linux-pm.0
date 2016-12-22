From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/1] power: supply: axp288_fuel_gauge: Remove unnecessary irq?_en writes
Date: Thu, 22 Dec 2016 13:00:10 +0100
Message-ID: <20161222120011.11652-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934708AbcLVMAT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Dec 2016 07:00:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org

Hi,

Here is one more axp288_fuel_gauge patch, note this applies on top of
my previous axp288_fuel_gauge patches, specifically on top of the not
yet merged:

"power: supply: axp288_fuel_gauge: Drop platform_data dependency"

patch.

Regards,

Hans
