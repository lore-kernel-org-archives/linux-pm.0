From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCHv3 6/6] sh_eth: enable wake-on-lan for sh7763
Date: Mon,  9 Jan 2017 16:34:09 +0100
Message-ID: <20170109153409.13956-7-niklas.soderlund+renesas@ragnatech.se>
References: <20170109153409.13956-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-4.sys.kth.se ([130.237.48.193]:52292 "EHLO
        smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdAIPfS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 10:35:18 -0500
In-Reply-To: <20170109153409.13956-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>, netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

This is based on public datasheet for sh7763 which shows it has the
same behavior and registers for WoL as other versions of sh_eth.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/sh_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 5292022fe6b1..ecf0f7997a72 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -847,6 +847,7 @@ static struct sh_eth_cpu_data sh7763_data = {
 	.no_ade		= 1,
 	.tsu		= 1,
 	.irq_flags	= IRQF_SHARED,
+	.magic		= 1,
 };
 
 static struct sh_eth_cpu_data sh7619_data = {
-- 
2.11.0

