Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F58EC388F7
	for <linux-pm@archiver.kernel.org>; Tue, 10 Nov 2020 08:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD46F20E65
	for <linux-pm@archiver.kernel.org>; Tue, 10 Nov 2020 08:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgKJIK4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 Nov 2020 03:10:56 -0500
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:57082 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJIKz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 03:10:55 -0500
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id A68B91A3B62;
        Tue, 10 Nov 2020 16:10:20 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <APoA5gC4DV1j7eiIeLvDwqqi.1.1604995820664.Hmail.bernard@vivo.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: =?UTF-8?B?W1Jlc2VuZF1bUEFUQ0hdIGRyaXZlcnMvdGhlcm1hbDogY2xlYW51cCBjb2Rpbmcgc3R5bGUgYSBiaXQ=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.157
MIME-Version: 1.0
Received: from bernard@vivo.com( [58.213.83.157) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 10 Nov 2020 16:10:20 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Tue, 10 Nov 2020 16:10:20 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGh0dTRlNTBlCS0JMVkpNS09CQk5DSUtMTUtVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzorFDpOHDhPPy1KEUweEjIeNw0*
        DAoKElVKVUpNS09CQk5DSUpKSUNVMxYaEhdVGR4JFRoJHzsNEg0UVRgUFkVZV1kSC1lBWU5DVUlK
        SFVDSFVKTkxZV1kIAVlBSU5JTzcG
X-HM-Tid: 0a75b134ac9a93b4kuwsa68b91a3b62
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnVuY3Rpb24gdGhlcm1hbF9hZGRfaHdtb25fc3lzZnMsIGh3bW9uIHdpbGwgYmUgTlVMTCB3aGVu
Cm5ld19od21vbl9kZXZpY2UgPSAwLCBzbyB0aGVyZSBpcyBubyBuZWVkIHRvIGNoZWNrLCBrZnJl
ZSB3aWxsCmhhbmRsZSBOVUxMIHBvaW50LgoKU2lnbmVkLW9mZi1ieTogQmVybmFyZCBaaGFvIDxi
ZXJuYXJkQHZpdm8uY29tPgotLS0KIGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2h3bW9uLmMgfCAz
ICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2h3bW9uLmMgYi9kcml2ZXJzL3RoZXJt
YWwvdGhlcm1hbF9od21vbi5jCmluZGV4IDhiOTJlMDBmZjIzNi4uYWQwMzI2MmNjYTU2IDEwMDY0
NAotLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9od21vbi5jCisrKyBiL2RyaXZlcnMvdGhl
cm1hbC90aGVybWFsX2h3bW9uLmMKQEAgLTIwNiw4ICsyMDYsNyBAQCBpbnQgdGhlcm1hbF9hZGRf
aHdtb25fc3lzZnMoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6KQogCWlmIChuZXdfaHdt
b25fZGV2aWNlKQogCQlod21vbl9kZXZpY2VfdW5yZWdpc3Rlcihod21vbi0+ZGV2aWNlKTsKICBm
cmVlX21lbToKLQlpZiAobmV3X2h3bW9uX2RldmljZSkKLQkJa2ZyZWUoaHdtb24pOworCWtmcmVl
KGh3bW9uKTsKIAogCXJldHVybiByZXN1bHQ7CiB9Ci0tIAoyLjI5LjAKCg0KDQo=
