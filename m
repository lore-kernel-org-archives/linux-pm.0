From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/2] PM / suspend: Add platform_suspend_target_state()
Date: Sat, 15 Jul 2017 19:36:08 -0700
Message-ID: <20170716023610.4658-1-f.fainelli@gmail.com>
References: <20170623010837.11199-1-f.fainelli@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33459 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdGPCgQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2017 22:36:16 -0400
In-Reply-To: <20170623010837.11199-1-f.fainelli@gmail.com>
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

Changes from RFC:

- make platform_target_state an enum that platforms can modify to
  include their own states
- updated brcmstb PM code to translate internal states to externally
  visible platform_target_state

Florian Fainelli (2):
  PM / suspend: Add platform_suspend_target_state()
  soc: bcm: brcmstb: PM: Implement target_state callback

 drivers/soc/bcm/brcmstb/pm/pm-arm.c | 22 ++++++++++++++++++++++
 include/linux/suspend.h             | 26 ++++++++++++++++++++++++++
 kernel/power/suspend.c              | 15 +++++++++++++++
 3 files changed, 63 insertions(+)

-- 
2.9.3
