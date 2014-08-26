From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 0/2] power: charger-manager: Fix bug and resolve mismatch
 issue
Date: Tue, 26 Aug 2014 13:41:37 +0900
Message-ID: <1409028099-6081-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:18876 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbaHZEln (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Aug 2014 00:41:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: myungjoo.ham@samsung.com, jonghwa3.lee@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patchset fix bug about checking wrong return type of of_cm_parse_desc()
and check the charging state after completed initialization of charger-manager
because existing charger-manger has the mismatch issue between real state of
cable connection and the charging state of charger-manager until first polling
time of charger-manager.

Changes from v1:
- This patchset includes new patch2.

Chanwoo Choi (2):
  power: charger-manager: Fix checking of wrong return type
  power: charger-manager: Check charging state right after completed initialization

 drivers/power/charger-manager.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
a.8.0


