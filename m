Return-Path: <SRS0=1j1E=BK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C196C433E1
	for <linux-pm@archiver.kernel.org>; Fri, 31 Jul 2020 03:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714CA22BF5
	for <linux-pm@archiver.kernel.org>; Fri, 31 Jul 2020 03:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OnyvQOR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgGaDjM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 30 Jul 2020 23:39:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35699 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731317AbgGaDjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 23:39:12 -0400
X-UUID: bd3d21d8beb9465f864473798a8a906e-20200731
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=oh7I0V3mU+PQ8llIZifICHSnU6p1Nl4Cu1lEjZrbxTE=;
        b=OnyvQOR3cbo3idYIKyAGUtrmMzPFeRRU04dYSL7oNpIeGP9FQLDAKfd3n06W9Z2vChOIiVElLFjvwG056JmnTGQJI8lExBz4WEF+WQ9tCuD95f4R27w2EFf9yX8B1QhqF9/vhKNp8sHchas3C0fjYmwrkAaBoedDpvgIQdB8PRA=;
X-UUID: bd3d21d8beb9465f864473798a8a906e-20200731
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1155119920; Fri, 31 Jul 2020 11:39:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 31 Jul 2020 11:39:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 31 Jul 2020 11:39:06 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <linux-acpi@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: acpi: fix 'return' with no value build warning
Date:   Fri, 31 Jul 2020 11:39:03 +0800
Message-ID: <1596166744-2954-1-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

KioqIEJMVVJCIEhFUkUgKioqDQoNCk5lYWwgTGl1ICgxKToNCiAgYWNwaTogZml4ICdyZXR1cm4n
IHdpdGggbm8gdmFsdWUgYnVpbGQgd2FybmluZw0KDQogZHJpdmVycy9hY3BpL3Byb2Nlc3Nvcl9p
ZGxlLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KDQotLSANCjIuMTguMA0K

