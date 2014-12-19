From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH RESEND V2 0/10] Improve charger manager driver for optimized
 operation.
Date: Fri, 19 Dec 2014 11:47:20 +0900
Message-ID: <1418957250-6542-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58369 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbaLSCrg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 21:47:36 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, myungjoo.ham@samsung.com, cw00.choi@samsung.com, Jonghwa Lee <jonghwa3.lee@samsung.com>

After charger manager's initially introduced, it has kept its codes without any
big change. However, the charger manager working operation isn't optimized and
it also has unused codes and non-generic interface. This series tries to make
charger manager more generic and maintainable with some fixes.

[Changes in V2]
- Rebase patch series on latest of battery-2.6.git.
- Seperate 'power: charger-manager: Rearrange data and monitor ~' patch into
  several patches depends on its purpose.
- Add 2 patches related with polling mode.

Jonghwa Lee (10):
  power: charger-manager: Use thermal subsystem interface only to get
    temperature.
  power: charger-manager: Use power_supply_changed() not private
    uevent.
  power: charger-manager: Remove deprecated function,
    cm_notify_event().
  power: charger-manager: Fix to use CHARGE_NOW/FULL property
    correctly.
  power: charger-manager: Concentrate scattered power_supply_changed()
    calls.
  power: charger-manager: Get external power souce information only
    from EXTCON.
  power: charger-manager: Make chraging decision focusing on battery
    status.
  power: charger-manager: Not to start charging directly in cable
    nofitication.
  power: charger-manager: Support different polling mode for sleep
    state.
  power: charger-manager: Support to change polling rate in runtime.

 .../bindings/power_supply/charger-manager.txt      |    1 -
 drivers/power/Kconfig                              |    1 +
 drivers/power/charger-manager.c                    |  758 ++++++--------------
 include/linux/power/charger-manager.h              |   34 +-
 4 files changed, 219 insertions(+), 575 deletions(-)

-- 
1.7.9.5

