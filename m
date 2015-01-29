From: Karol Wrona <k.wrona@samsung.com>
Subject: [RFC PATCH 0/1] PM / domains: Add support for virtual power domains
Date: Thu, 29 Jan 2015 19:12:55 +0100
Message-ID: <1422555176-13054-1-git-send-email-k.wrona@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:19472 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbbA2SNX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 13:13:23 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>, Karol Wrona <k.wrona@samsung.com>

Hello,

This patch adds virtual power domain handling.  Some comments are needed if
such approach has any sense.  The goal is to know the state of devices
residing in domain which is never gated or are gated only during sleep.
I.e. in Exynos3250 SoC there is one domain which is only put into retention
in LPD state and to enter it some devices (i.e. mmc host controller) have
to be inactive.  Using domains and runtime PM it would be able to give
an information to PM core that the SoC is ready for deeper power state.

TODO: binding doc, add child-parent hierarchy 

Thanks,
Karol

Karol Wrona (1):
  PM / domains: Add support for virtual power domains

 drivers/base/power/Makefile          |    3 +-
 drivers/base/power/pm_domains_virt.c |   54 ++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/power/pm_domains_virt.c

-- 
1.7.9.5

