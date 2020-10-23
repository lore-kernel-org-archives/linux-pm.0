Return-Path: <SRS0=XRtZ=D6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD28EC55179
	for <linux-pm@archiver.kernel.org>; Fri, 23 Oct 2020 08:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C6822210
	for <linux-pm@archiver.kernel.org>; Fri, 23 Oct 2020 08:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="REqEq5DQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460544AbgJWIZN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:25:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54300 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S460536AbgJWIZL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 04:25:11 -0400
X-UUID: 3d526c3e86174cb295d6d5aed979d2f1-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UBtQH+OlTScmb/PO4fc+5+GucCo+qd6V6KQVG2XIAsg=;
        b=REqEq5DQ71HR+x0jqq323w4bhNpSCgR/FnagOYs23UJ6OyYaEw5GzQRbfjPCTGVPGuNBG8qV1BT8Sj2E+SK9Nkk3z6NhfZyiXlAwSv6GtoFvMdDHbyrZ6lIBXZO/1Yp2pHJ6QvibHFBTKwC17sqZICzsE55mzTdzmaPa12vrz1Y=;
X-UUID: 3d526c3e86174cb295d6d5aed979d2f1-20201023
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 695823342; Fri, 23 Oct 2020 16:25:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 16:24:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 16:24:59 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v1 6/6] cpufreq: mediatek-hw: Add cooling dev flag
Date:   Fri, 23 Oct 2020 16:24:53 +0800
Message-ID: <1603441493-18554-7-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KDQpBZGQgY29v
bGluZyBkZXZpY2UgZmxhZyBmb3IgdGhlcm1hbCB0aHJvdHRsZQ0KDQpTaWduZWQtb2ZmLWJ5OiBI
ZWN0b3IuWXVhbiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9jcHVm
cmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYyB8ICAgIDMgKystDQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVm
cmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYyBiL2RyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVm
cmVxLWh3LmMNCmluZGV4IDE1ZmJhMjAuLjY2NWYyMjBmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9j
cHVmcmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYw0KKysrIGIvZHJpdmVycy9jcHVmcmVxL21lZGlh
dGVrLWNwdWZyZXEtaHcuYw0KQEAgLTE2NSw3ICsxNjUsOCBAQCBzdGF0aWMgaW50IG10a19jcHVm
cmVxX2h3X2NwdV9leGl0KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQ0KIA0KIHN0YXRp
YyBzdHJ1Y3QgY3B1ZnJlcV9kcml2ZXIgY3B1ZnJlcV9tdGtfaHdfZHJpdmVyID0gew0KIAkuZmxh
Z3MJCT0gQ1BVRlJFUV9TVElDS1kgfCBDUFVGUkVRX05FRURfSU5JVElBTF9GUkVRX0NIRUNLIHwN
Ci0JCQkgIENQVUZSRVFfSEFWRV9HT1ZFUk5PUl9QRVJfUE9MSUNZLA0KKwkJCSAgQ1BVRlJFUV9I
QVZFX0dPVkVSTk9SX1BFUl9QT0xJQ1kgfA0KKwkJCSAgQ1BVRlJFUV9JU19DT09MSU5HX0RFViwN
CiAJLnZlcmlmeQkJPSBjcHVmcmVxX2dlbmVyaWNfZnJlcXVlbmN5X3RhYmxlX3ZlcmlmeSwNCiAJ
LnRhcmdldF9pbmRleAk9IG10a19jcHVmcmVxX2h3X3RhcmdldF9pbmRleCwNCiAJLmdldAkJPSBt
dGtfY3B1ZnJlcV9od19nZXQsDQotLSANCjEuNy45LjUNCg==

