From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] bq2415x_charger: Fix null pointer dereference
Date: Mon, 21 Sep 2015 16:58:20 +0200
Message-ID: <1442847500-22435-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38333 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbbIUO6m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 10:58:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

Commit b68c3161430a (bq2415x_charger: Allow to load and use driver even=
 if
notify device is not registered yet) introduced null pointer dereferenc=
e in
case bq is NULL. This patch fixes it.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/power/bq2415x_charger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_ch=
arger.c
index ec212b5..4afd768 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1704,7 +1704,7 @@ error_4:
 error_3:
 	bq2415x_power_supply_exit(bq);
 error_2:
-	if (bq->notify_node)
+	if (bq && bq->notify_node)
 		of_node_put(bq->notify_node);
 	kfree(name);
 error_1:
--=20
1.7.10.4

