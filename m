From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 0/2] power: supply: ltc2941-battery-gauge: Support LTC2942
Date: Mon, 12 Jun 2017 17:02:26 +0200
Message-ID: <20170612150226.woxfdi4lharq5gtq@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:41528 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbdFLPC3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 11:02:29 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990644AbdFLPC1nJbRm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Jun 2017 17:02:27 +0200
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Javier Martinez Canillas <javier@osg.samsung.com>

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
