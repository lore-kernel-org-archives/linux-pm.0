From: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
Subject: [PATCH v4 0/1] Fix get sharing cpus when hotplug is used
Date: Wed, 26 Jul 2017 14:11:39 +0200
Message-ID: <20170726121151.7576-2-waldemarx.rymarkiewicz@intel.com>
References: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:35712 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbdGZMMW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Jul 2017 08:12:22 -0400
In-Reply-To: <20170726121151.7576-1-waldemarx.rymarkiewicz@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: waldemar.rymarkiewicz@gmail.com, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi,

This patch fixes problem with setting opp shared cpus bitmask on
hotplugable systems. See patch commit message for details.

CHANGLOG:

v4  Added Reviewed-by: Stephen Boyd <sboyd@codeaurora.org> + use pr_err
    instead dev_err for missing opp node phandle.

v3  Acked-by: Viresh Kumar added

v2  Abandon v1 as it was not good enough. Still check all possible CPUs as in
    original code, but don't check device struct. Instead check device_node
    directly in DT.

v1  [PATCH] PM / OPP: Don't check not plugged in CPUs to avoid error
    Avoid error by checking all present cpus instead possible cpus.

Thanks,
/Waldek


Waldemar Rymarkiewicz (1):
  PM / OPP: Fix get sharing cpus when hotplug is used

 drivers/base/power/opp/of.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

-- 
2.10.1
