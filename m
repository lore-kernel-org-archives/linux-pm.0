From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 00/14] extcon api extension + axp288_charger fixes
Date: Mon, 19 Dec 2016 01:07:17 +0100
Message-ID: <20161219000731.10188-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbcLSAHg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Dec 2016 19:07:36 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi extcon and power-supply system maintainers,

This series really are 2 separate series, patches 1 - 2 add a new
extcon_get_extcon_dev_by_cable_id function to the extcon core.

Patches 3 - 15 consist of various fixes for the axp288_charger
driver, including one fix which uses the new extcon_get_extcon_dev_by_cable_id
making this series depend on the extcon patches.

So we will need some coordination between the merging of these 2
series. Since the extcon patches are quite simple, perhaps they can
still be merged into 4.10 ? Otherwise the extcon maintainers will need
to provide a stable branch with these 2 patches which the power-supply
maintainer can merge into power-supply/next .

Regards,

Hans
