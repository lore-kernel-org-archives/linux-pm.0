From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFT][PATCH 0/2] PM / QoS: Device resume latency framework fix
Date: Thu, 02 Nov 2017 00:00:27 +0100
Message-ID: <5770848.Kdi5IjVKeE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48335 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752260AbdKAXED (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2017 19:04:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>

Hi,

This series is a replacement for commit 0cc2b4e5a020 (PM / QoS: Fix device
resume latency PM QoS) that had to be reverted due to problems introduced by it.

This time the genpd PM QoS governor is first updated to be more consistent
and the PM QoS changes are made on top of that which simplifies the second
patch quite a bit.

This is based on the linux-next branch from linux-pm.git as of now (should
also apply to the current mainline just fine).

Please test if you can or let me know if you have any comments.

Thanks,
Rafael
