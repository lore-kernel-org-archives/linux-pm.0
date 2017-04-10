From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/3] Thermal/int340x: Fine-tuning for five function
 implementations
Date: Mon, 10 Apr 2017 22:15:52 +0200
Message-ID: <3ba36cc1-8445-462c-ca75-2b0928f3290a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:52727 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752776AbdDJUQt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Apr 2017 16:16:49 -0400
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 10 Apr 2017 22:08:11 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use kcalloc() in two functions
  Improve size determinations in two functions
  Use kcalloc() in int340x_thermal_zone_add()

 drivers/thermal/int340x_thermal/acpi_thermal_rel.c     | 8 ++++----
 drivers/thermal/int340x_thermal/int340x_thermal_zone.c | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.12.2
