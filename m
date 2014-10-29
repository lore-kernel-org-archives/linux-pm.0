From: Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 0/4] poweroff-source DT property renaming
Date: Wed, 29 Oct 2014 07:35:31 +0000
Message-ID: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:50338 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbaJ2HcW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 03:32:22 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de
Cc: grant.likely@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, johan@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org

The goal of this serie is to rename the property "poweroff-source" to 
"system-power-controller" and to fix things incrementally.

Changes and explanations since v1:

  - The first patch defines "of_is_system_power_controller" which is compatible
    with both "vendor,system-power-controller" and "system-power-controller"
    properties. Also, It keeps the old helper function of_system_has_poweroff_source
    for source compatibility until everything is renamed (in this way, bisections
    are not broken and change is made "atomically" between each commit)

    Note: the property "poweroff-source" itself is not used in dts files yet.
    Before this patch tps65910 was broken due to missing backward compatibility
    with "vendor,system-power-controller". As the old helper uses the new one,
    it works again.

  - act8865 and tps65910 are ported to the new helper function

  - The last commit removes the olf helper which was only used for source compatibility

Romain Perier (4):
  of: Rename "poweroff-source" property to "system-power-controller"
  regulator: act8865: Convert poweroff-source DT property to
    system-power-controller
  mfd: tps65910: Convert poweroff-source DT property to
    system-power-controller
  of: Remove of_system_has_poweroff_source helper function

 .../devicetree/bindings/power/power-controller.txt | 18 ++++++++++++
 .../devicetree/bindings/power/poweroff.txt         | 18 ------------
 .../bindings/regulator/act8865-regulator.txt       |  4 +--
 drivers/mfd/tps65910.c                             |  2 +-
 drivers/of/base.c                                  | 34 ++++++++++++++++++++++
 drivers/regulator/act8865-regulator.c              |  2 +-
 include/linux/of.h                                 | 12 ++------
 7 files changed, 58 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/power-controller.txt
 delete mode 100644 Documentation/devicetree/bindings/power/poweroff.txt

-- 
1.9.1

