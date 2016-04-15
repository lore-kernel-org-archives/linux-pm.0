From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [RESEND PATCH 0/3] power: Remove the deprecated extcon functions
Date: Fri, 15 Apr 2016 09:43:33 +0900
Message-ID: <1460681016-2770-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36469 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbcDOAnm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2016 20:43:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

This patch-set removes the deprecated notifier API of extcon framework and
then use the new extcon API[2] with the unique id[1] to indicate the each
external connector. Alter deprecated API as following:
- extcon_register_interest() -> extcon_register_notifier()
- extcon_unregister_interest() -> extcon_unregister_notifier()
- extcon_set_cable_state() -> extcon_set_cable_state_()
- extcon_get_cable_state() -> extcon_get_cable_state_()

And, extcon alters the name of USB charger connector in patch[3] as following:
- EXTCON_CHG_USB_SDP /* Standard Downstream Port */
- EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
- EXTCON_CHG_USB_CDP /* Charging Downstream Port */
- EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */

[1] Commit 2a9de9c0f08d61
- ("extcon: Use the unique id for external connector instead of string)
[2] Commit 046050f6e623e4
- ("extcon: Update the prototype of extcon_register_notifier() with enum extcon
[3] Commit 11eecf910bd81d
- ("extcon: Modify the id and name of external connector")

Chanwoo Choi (3):
  power: charger-manager: Replace deprecatd API of extcon
  power: axp288_charger: Replace deprecatd API of extcon
  extcon: Remove the deprecated extcon functions

 .../bindings/power_supply/charger-manager.txt      |   4 +-
 drivers/extcon/extcon.c                            | 201 +++------------------
 drivers/power/axp288_charger.c                     |  77 +++++---
 drivers/power/charger-manager.c                    |  31 ++--
 include/linux/extcon.h                             |  59 ------
 include/linux/power/charger-manager.h              |   4 +-
 6 files changed, 101 insertions(+), 275 deletions(-)

-- 
1.9.1

