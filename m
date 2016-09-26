From: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Subject: [PATCH 0/3] max77693: USB event listener for charger
Date: Tue, 27 Sep 2016 01:31:07 +0200
Message-ID: <1474932670-11953-1-git-send-email-wolfgit@wiedmeyer.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from wiedmeyer.de ([85.116.192.112]:38744 "EHLO wiedmeyer.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754144AbcIZXcC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Sep 2016 19:32:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by wiedmeyer.localdomain (Postfix) with ESMTP id 7135F8E91B9
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2016 01:31:59 +0200 (CEST)
Received: from wiedmeyer.de ([127.0.0.1])
        by localhost (wiedmeyer.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UQlfo2ztXdSH for <linux-pm@vger.kernel.org>;
        Tue, 27 Sep 2016 01:31:57 +0200 (CEST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: krzk@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: cw00.choi@samsung.com, b.zolnierkie@samsung.com, broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>

This patch series adds an USB event listener to the charger driver
that enables charging if an USB cable is connected. Before the charger
can be enabled, the maximum input current and the fast charge current
need to be set. In order to make this possible, the regulator function
that sets the current needs to be extended. 

Wolfgang Wiedmeyer (3):
  mfd: max77693: Add defines for charger current control
  regulator: max77693: Also manipulate the fast charge current
  power_supply: max77693: Listen for cable events and enable charging

 drivers/power/Kconfig                  |   2 +-
 drivers/power/max77693_charger.c       | 171 +++++++++++++++++++++++++++++++++
 drivers/regulator/max77693-regulator.c |  45 ++++++++-
 include/linux/mfd/max77693-private.h   |   7 ++
 4 files changed, 221 insertions(+), 4 deletions(-)

-- 
2.8.0.rc3

