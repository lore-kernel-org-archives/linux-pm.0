From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/15] power_supply: Fixes & cleanups
Date: Thu,  4 Sep 2014 17:30:04 +0530
Message-ID: <cover.1409831636.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:56346 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMAt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:00:49 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so19916311pac.39
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:00:45 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Guys,

I was required to work on a battery driver and found some fixes/cleanups while
going through the core.

First two are fixes and rest are cleanups. Please see if they make any sense at
all.

Pushed here: git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git battery/fixes

--
viresh

Viresh Kumar (15):
  power-supply: Don't over-allocate memory for "supplied-from" array
  power-supply: Return early if "power-supplies" property isn't valid
  Documentation: Charger Manager: Fix spelling mistakes
  power-supply: Forward declare structs together
  power-supply: Drop unnecessary typecasts
  power-supply: Use 'break' instead of 'continue' to end loop
  power-supply: Rearrange code to remove duplicate lines
  power-supply: Propagate error returned by
    power_supply_find_supply_from_node()
  power-supply: Don't return -EINVAL from
    __power_supply_find_supply_from_node()
  power-supply: Drop useless 'if (ret.intval)' statements
  power-supply: Mark 'if' blocks in power_supply_changed_work() with
    'likely'
  power-supply: Use PTR_ERR_OR_ZERO() routine
  power-supply: Check for failures only when we can fail
  power-supply: Avoid unnecessary 'goto' statements
  power_supply: Don't iterate over devices to return -EPROBE_DEFER

 Documentation/power/charger-manager.txt |   2 +-
 drivers/power/power_supply_core.c       | 100 +++++++++++++++-----------------
 drivers/power/power_supply_leds.c       |  19 ++----
 drivers/power/power_supply_sysfs.c      |  21 +++----
 include/linux/power_supply.h            |   3 +-
 5 files changed, 64 insertions(+), 81 deletions(-)

-- 
2.0.3.693.g996b0fd

