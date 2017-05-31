From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] power: reset: Couple of POWER_RESET_BRCMSTB Kconfig changes
Date: Wed, 31 May 2017 13:39:44 -0700
Message-ID: <20170531203946.32644-1-f.fainelli@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36698 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdEaUjy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 16:39:54 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: sre@kernel.org, linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>

Hi Sebastian,

Here are two small tweaks to the POWER_RESET_BRCMSTB Kconfig selection to allow
the driver on ARM64 and make it default to BMIPS_GENERIC on MIPS platforms.

Based on your "for-next" branch.

Thanks

Florian Fainelli (2):
  power: reset: Allow selecting POWER_RESET_BRCMSTB on ARM64
  power: reset: Default POWER_RESET_BRCMSTB to BMIPS_GENERIC

 drivers/power/reset/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.9.3
