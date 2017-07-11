From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v2 0/3] power: supply: sbs-battery: Add delay when changing capacity mode
Date: Tue, 11 Jul 2017 17:43:40 +0800
Message-ID: <1499766223-130934-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:45846 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753195AbdGKJnt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 05:43:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, preid@electromag.com.au, linux-pm@vger.kernel.org, posted@heine.so

This is based on Michael Heinemann's patch:
"sbs-battery: correct capacity mode selection bits"

First two are housing keep / cleanup.
As reported by Michael with his patch he found the mode didn't always change.
I found adding a delay fixed the problem for several Insipered Energy SBS 
compatible batteries I have on hand.

Changes from v2:
- power: supply: sbs-battery: sort includes
  - Remove errousnous chunk
- power: supply: sbs-battery: Don't reset mode in get_battery_capacity
  - drop patch as it needs more thought

Phil Reid (3):
  power: supply: sbs-battery: Remove FSF mailing address from comments
  power: supply: sbs-battery: sort includes
  power: supply: sbs-battery: Add delay when changing capacity mode bit

 drivers/power/supply/sbs-battery.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

-- 
1.8.3.1
