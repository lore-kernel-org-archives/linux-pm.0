From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 0/2] extcon: Remove the deprecated extcon functions
Date: Tue, 31 May 2016 18:34:38 +0900
Message-ID: <1464687280-8155-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:37766 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756846AbcEaJep (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 05:34:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, wens@csie.org
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

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

Changes from v2:
- Drop the patch related to drivers/power/charger-manager.c.
- Remain the deprecatd function definition to prevent the build break
  of charger-manager.c driver.

Changes from v1:
- Fix the typo (EXTCON_CHG_USB_SDP -> EXTCON_CHG_USB_CDP) on axp288_charger.c

Chanwoo Choi (2):
  power: axp288_charger: Replace deprecatd API of extcon
  extcon: Remove the deprecated extcon functions

 drivers/extcon/extcon.c        | 201 +++++------------------------------------
 drivers/power/axp288_charger.c |  77 +++++++++++-----
 include/linux/extcon.h         |  80 +++++-----------
 3 files changed, 100 insertions(+), 258 deletions(-)

-- 
1.9.1

