From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFT][PATCH v2 0/2] PM / QoS: Device resume latency framework fix
Date: Fri, 03 Nov 2017 12:42:57 +0100
Message-ID: <2520927.XkLgALY3I0@aspire.rjw.lan>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55251 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756060AbdKCLuU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Nov 2017 07:50:20 -0400
In-Reply-To: <5770848.Kdi5IjVKeE@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>

On Thursday, November 2, 2017 12:00:27 AM CET Rafael J. Wysocki wrote:
> Hi,
> 
> This series is a replacement for commit 0cc2b4e5a020 (PM / QoS: Fix device
> resume latency PM QoS) that had to be reverted due to problems introduced by it.
> 
> This time the genpd PM QoS governor is first updated to be more consistent
> and the PM QoS changes are made on top of that which simplifies the second
> patch quite a bit.
> 
> This is based on the linux-next branch from linux-pm.git as of now (should
> also apply to the current mainline just fine).
> 
> Please test if you can or let me know if you have any comments.

The v2 removes a couple of redundant checks from the first patch (and add
comments to explain why the checks are not needed) and fixes up the
"no constraint" value collision with a valid constraint multiplied by
NSEC_PER_USEC in the second patch.

Please test if possible and let me know about any issues.

Thanks,
Rafael
