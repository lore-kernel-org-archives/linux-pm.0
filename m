From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 0/2]  cpufreq: Sort Kconfig and Makefile
Date: Wed, 13 Dec 2017 18:05:34 +0100
Message-ID: <20171213170536.28238-1-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41398 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753253AbdLMRFp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 12:05:45 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Evan Wang <xswang@marvell.com>, Andre Heider <a.heider@gmail.com>

Hi,

The patch of this series was originally part of the series "Add CPU
Frequency scaling support on Armada 37xx" [1].

As requested by Rafael J. Wysocki, these 2 patches are extracted in a
independent series, in the meantime, Viresh Kumar gave his acked-by
that I added to the patches.

In this second version only the 1st patch had been modified, see the
changelog for the details.

Thanks,

Gregory

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/546709.html

Changelog:
v1 -> v2:

 - Fixed tab vs space issue in KConfig, suggested by Randy Dunlap
 - Removed unneeded "default n" in KConfig, suggested by Randy Dunlap

Gregory CLEMENT (2):
  cpufreq: ARM: sort the Kconfig menu
  cpufreq: sort the drivers in ARM part

 drivers/cpufreq/Kconfig.arm | 81 ++++++++++++++++++++++-----------------------
 drivers/cpufreq/Makefile    |  8 ++---
 2 files changed, 44 insertions(+), 45 deletions(-)

-- 
2.15.1
