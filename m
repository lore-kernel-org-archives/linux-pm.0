From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] power: supply: charger-manager: 1 fix and 2 minor clean-ups
Date: Mon,  7 Aug 2017 00:37:54 +0200
Message-ID: <cover.1502058761.git.christophe.jaillet@wanadoo.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:35891 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbdHFWiG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Aug 2017 18:38:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

This patch series improves 'charger_manager_probe()'. The first patch is
about a missing memory allocation failure test.
The 2 others are just things spotted in this function:
   - a comment that is no more up to date
   - a style issue (which saves 1 line)

Christophe JAILLET (3):
  power: supply: charger-manager: Fix a NULL pointer dereference in
    'charger_manager_probe()'
  power: supply: charger-manager: Fix a comment
  power: supply: charger-manager: Slighly simplify code

 drivers/power/supply/charger-manager.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.11.0
