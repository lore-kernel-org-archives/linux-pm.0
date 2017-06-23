From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [RFC 0/2] PM / suspend: Add platform_suspend_target_state()
Date: Thu, 22 Jun 2017 18:08:35 -0700
Message-ID: <20170623010837.11199-1-f.fainelli@gmail.com>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36587 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753785AbdFWBIv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jun 2017 21:08:51 -0400
In-Reply-To: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Linux ARM <linux-arm-kernel@lists.infradead.org>

This patch series implements the idea discussed in this thread:

https://www.spinics.net/lists/arm-kernel/msg590068.html

The last patch is relative to the pending submission of the Broadcom STB
S2/S3/S5 suspend/resume code that can be found below, and is provided
as an example of how this can be useful.

https://lkml.org/lkml/2017/6/16/737

Florian Fainelli (2):
  PM / suspend: Add platform_suspend_target_state()
  soc: bcm: brcmstb: PM: Implement target_state callback

 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 15 +++++++++++++++
 include/linux/suspend.h             | 12 ++++++++++++
 kernel/power/suspend.c              | 15 +++++++++++++++
 3 files changed, 42 insertions(+)

-- 
2.9.3
