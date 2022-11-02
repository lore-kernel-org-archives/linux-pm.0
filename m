Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED6DC433FE
	for <linux-pm@archiver.kernel.org>; Wed,  2 Nov 2022 06:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKBGuo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Nov 2022 02:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBGun (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 02:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12895FA9
        for <linux-pm@vger.kernel.org>; Tue,  1 Nov 2022 23:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56B5F617F4
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 06:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477B1C4347C;
        Wed,  2 Nov 2022 06:50:39 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] ACPI / table: Print CORE_PIC information when MADT is parsed
Date:   Wed,  2 Nov 2022 14:48:38 +0800
Message-Id: <20221102064838.2615669-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When MADT is parsed, print CORE_PIC information as below:

ACPI: CORE PIC (processor_id[0x00] core_id[0x00] enabled)
ACPI: CORE PIC (processor_id[0x01] core_id[0x01] enabled)
...
ACPI: CORE PIC (processor_id[0xff] core_id[0xff] enabled)

This debug information will be very helpful to bring up early systems to
see if processor_id and core_id are matched or not as spec defined.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/acpi/tables.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 47ec11d4c68e..23bff77b09f4 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -210,6 +210,16 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_CORE_PIC:
+		{
+			struct acpi_madt_core_pic *p =
+			    (struct acpi_madt_core_pic *)header;
+			pr_debug("CORE PIC (processor_id[0x%02x] core_id[0x%02x] %s)\n",
+				 p->processor_id, p->core_id,
+				 (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
 			header->type);
-- 
2.31.1

