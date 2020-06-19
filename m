Return-Path: <SRS0=28Z2=AA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CDDC433E0
	for <linux-pm@archiver.kernel.org>; Fri, 19 Jun 2020 16:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38AB21707
	for <linux-pm@archiver.kernel.org>; Fri, 19 Jun 2020 16:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583808;
	bh=XPPEpC2yTAW6izKCvYgVtt0TlCBTsFss0avmq3pxYOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JlYnU+yckYyJXDNnENTyYQtQY6QoRN/4gH1PC5bomignGUyLOeqkHZIhCULr2v6Wi
	 6jQshtVocdJzqzNRCUgLFtA+RU4CahY3pH3oW2UXD8l63FIIJB3o2vwVIRjd1mFR29
	 8LUGhXVptgfPgmnhH7XSCXkok7DPuFUj+jjBQmsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390508AbgFSO7W (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388538AbgFSO7U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 10:59:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE5CF21973;
        Fri, 19 Jun 2020 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578759;
        bh=XPPEpC2yTAW6izKCvYgVtt0TlCBTsFss0avmq3pxYOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPh62KtxUOI9B+TyZbBKf4dEX3PFDjqeOc75S/EqR4co3zGdBTtD+mnYXR/j2FKyC
         QFqLSAqgJ5SoGvIsM/rktrDuQy8LPN0vqcY0dYwhqGcwTXdcbTV3EYinpsfuzdMu9I
         oWO7fMIwqNJmwRuXySuHJ5nGrPJkl/QUskZ2T7Wo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 145/267] mips: cm: Fix an invalid error code of INTVN_*_ERR
Date:   Fri, 19 Jun 2020 16:32:10 +0200
Message-Id: <20200619141655.779549813@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

[ Upstream commit 8a0efb8b101665a843205eab3d67ab09cb2d9a8d ]

Commit 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache
errors") adds cm2_causes[] array with map of error type ID and
pointers to the short description string. There is a mistake in
the table, since according to MIPS32 manual CM2_ERROR_TYPE = {17,18}
correspond to INTVN_WR_ERR and INTVN_RD_ERR, while the table
claims they have {0x17,0x18} codes. This is obviously hex-dec
copy-paste bug. Moreover codes {0x18 - 0x1a} indicate L2 ECC errors.

Fixes: 3885c2b463f6 ("MIPS: CM: Add support for reporting CM cache errors")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/mips-cm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 7f3f136572de..50d3d74001cb 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -123,9 +123,9 @@ static char *cm2_causes[32] = {
 	"COH_RD_ERR", "MMIO_WR_ERR", "MMIO_RD_ERR", "0x07",
 	"0x08", "0x09", "0x0a", "0x0b",
 	"0x0c", "0x0d", "0x0e", "0x0f",
-	"0x10", "0x11", "0x12", "0x13",
-	"0x14", "0x15", "0x16", "INTVN_WR_ERR",
-	"INTVN_RD_ERR", "0x19", "0x1a", "0x1b",
+	"0x10", "INTVN_WR_ERR", "INTVN_RD_ERR", "0x13",
+	"0x14", "0x15", "0x16", "0x17",
+	"0x18", "0x19", "0x1a", "0x1b",
 	"0x1c", "0x1d", "0x1e", "0x1f"
 };
 
-- 
2.25.1



