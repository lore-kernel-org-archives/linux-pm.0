From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 0/1] power: sbs-manager: Add interrupt support and battery detect gpios
Date: Mon, 25 Jul 2016 15:50:02 +0800
Message-ID: <1469433003-68564-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:48556 "EHLO
	preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752264AbcGYHuL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2016 03:50:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, preid@electromag.com.au, karl-heinz@schneider-inet.de, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

Adds SMBALERT interupt support fo AC present and battery insertation / removal.

This patch is dependent on karl-heinz@schneider-inet.de patch series:
[PATCH v3] Add support for Smart Battery System Manager

Tested with my patches to the sbs-battery driver applied:
[PATCH v2] power: sbs-battery fixup gpio detect irq handling

sbs-battery driver patch  can be applied before or after this series without
breaking anything.


Phil Reid (1):
  power: sbs-manager: Add interrupt support and battery detect gpios

 .../devicetree/bindings/power/sbs,sbs-manager.txt  |  29 ++++
 drivers/power/sbs-manager.c                        | 157 +++++++++++++++++++++
 2 files changed, 186 insertions(+)

-- 
1.8.3.1

