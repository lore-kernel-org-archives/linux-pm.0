From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/3] thermal: Fix module autoload for drivers
Date: Fri, 14 Oct 2016 11:34:59 -0300
Message-ID: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:57009
        "EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbcJNOfR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2016 10:35:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

Hello,

This small series contains trivial fixes to allow modules to be autoloaded
when its correspoinding thermal device is registered.

Best regards,
Javier


Javier Martinez Canillas (3):
  thermal: max77620: Fix module autoload
  thermal: tango: Fix module autoload
  thermal: db8500: Fix module autoload

 drivers/thermal/db8500_thermal.c   | 1 +
 drivers/thermal/max77620_thermal.c | 1 +
 drivers/thermal/tango_thermal.c    | 1 +
 3 files changed, 3 insertions(+)

-- 
2.7.4

