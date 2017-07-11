From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v4 0/2] power: supply: ltc2941-battery-gauge: Support LTC2942
Date: Tue, 11 Jul 2017 14:58:21 +0200
Message-ID: <20170711125821.nt5opxjvbjcppiaw@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:35594 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754695AbdGKM6Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 08:58:24 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Javier Martinez Canillas <javier@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>

This is 4th version of patch.
Changelog:
- v2: reworked voltage computing to not overflow and keep presision
- v3: update devicetree binding documentation
- v4: add ltc2942 devicetree compatible
 
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
