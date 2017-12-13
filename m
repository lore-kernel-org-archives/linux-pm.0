From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 0/2] cpufreq: few fix on mvebu driver
Date: Wed, 13 Dec 2017 18:29:12 +0100
Message-ID: <20171213172914.6148-1-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42540 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753189AbdLMR3Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 12:29:24 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>

Hi,

The second patch of this series was originally part of the series "Add CPU
Frequency scaling support on Armada 37xx" [1].

As requested by Viresh Kumar, it is extracted in a independent series.
In the meantime, Thomas Petazzoni pointed an issue on the first
version that I fixed in this series.

While I was on this driver I found an aother issue that I fixed with
the first patch.

Thanks,

Gregory

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/547650.html

Gregory CLEMENT (2):
  cpufreq: mvebu: Free the clock reference in the normal path
  cpufreq: mvebu: Free opp if registering failed

 drivers/cpufreq/mvebu-cpufreq.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.15.1
