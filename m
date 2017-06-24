From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v3 0/2] power: supply: ltc2941-battery-gauge: Support LTC2942
Date: Sat, 24 Jun 2017 17:05:45 +0200
Message-ID: <20170624150545.2oxwror5fy2xlvaz@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:58582 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754802AbdFXPFu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2017 11:05:50 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23993877AbdFXPFrqcynW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 24 Jun 2017 17:05:47 +0200
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>

This is 3rd version of patch.
Changelog:
- v2: reworked voltage computing to not overflow and keep presision
- v3: update devicetree binding documentain
 
LTC2942 is pin compatible with LTC2941 providing few more registers
holding information about battery voltage and temperature. It can
be runtime detected using bit A7 in the Status register.

PATCH 1/2 defines LTC2942 registers with no functional changes
while 2/2 does actually the job.

I'm not sure, whenever splitting support into two patches makes
sense, but it just makes reviewing easier. I'd happily
squash patches together.

Comments welcome,
	ladis
