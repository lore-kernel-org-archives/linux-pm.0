Return-Path: <SRS0=MfD0=YJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A807ECE599
	for <linux-pm@archiver.kernel.org>; Wed, 16 Oct 2019 19:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E795A21D7C
	for <linux-pm@archiver.kernel.org>; Wed, 16 Oct 2019 19:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7ysRnFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394490AbfJPThj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Oct 2019 15:37:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44817 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394486AbfJPThi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 15:37:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so23875760qkk.11
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 12:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n/EfPfS/rzayptMKHYVpYurUSNAbaOippVZDRNzUE4k=;
        b=F7ysRnFJGgjboY0XKIl3CtLjZJFKjN3OJG4bCNjVjWav0TojjT7TlmD3PaAM6iQR9u
         GcS1Z5nBswY2DKOKvyJO/RvfLfj7i0rWvBNgLB88JfwDCy5oYNpt7b3atBSY+sipZjr/
         bF5X2OMqJwz/Ou9jLpokuEH3QARY+FUTC2MiGwgqv9Gde2DlexNMDXUSZgQdneRlaFB6
         lqGBlMzHG+5HX+EN8CN0rrN6Hfi+wrfQBnR00tko+t/VJLtGGAEm6fvdThSOJikYa+wi
         /vD0th1bPwVwJYlguPu+7gbN0zL9mEjngSxc6XxE+EeeqafD4MbtcpRxcc50fYQdkQNM
         iyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n/EfPfS/rzayptMKHYVpYurUSNAbaOippVZDRNzUE4k=;
        b=afS+jIojdj6x4LquYw7ojwPALN2Z89377iHzRFirCmeWFZzutT/MZ+G4kQkBIHPGn/
         ZlGAsdaeSK426PdFeczXb9fU12r+rG6c7xEBn77dNABrQHTep2p6GENimod4uebarA5L
         UnyIv8ss5qiZgEBlMfbRuVNcfmqKc0lW1DtU2tPgkNOfUivyFY8J0HfIu6TDU+X/zHVB
         frS/lLz9a/n/7xoECkqw0pKOj/rwmNWhFSD++Rrlz3sW4oOZPSPXuYpRwaazyPimjvOE
         8y0wwokCujiEvAyrX4XPy4NAwuOJjTqVUwceguScFZDAfEU6HbGOIPKM2m6VsrE2ApVK
         fyOg==
X-Gm-Message-State: APjAAAUN9YjcF+sAy+fNYX21EoWnDGKieHpEv4bQsSKVsmNKtbAlE0E0
        m9F6QLoj9Z0cfIaHyFMOaiYIOQ==
X-Google-Smtp-Source: APXvYqysYd7L9p+e4+IwwD6T7cSHsFrZy5H/RVDaOTydJlo6DwCvGscuYB6HjYK4z+zLYTb2qhRraA==
X-Received: by 2002:a37:907:: with SMTP id 7mr43233321qkj.129.1571254657726;
        Wed, 16 Oct 2019 12:37:37 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id 54sm16246030qts.75.2019.10.16.12.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 12:37:37 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     edubezval@gmail.com, rui.zhang@intel.com, ulf.hansson@linaro.org,
        daniel.lezcano@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     amit.kucheria@verdurent.com, mark.rutland@arm.com,
        rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power controller binding to describe thermal warming device
Date:   Wed, 16 Oct 2019 15:37:20 -0400
Message-Id: <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RPMh power controller hosts mx domain that can be used as thermal
warming device. Add a sub-node to specify this.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
index eb35b22..fff695d 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
@@ -18,6 +18,16 @@ Required Properties:
 Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
 various OPPs for different platforms as well as Power domain indexes
 
+= SUBNODES
+RPMh alsp hosts power domains that can behave as thermal warming device.
+These are expressed as subnodes of the RPMh. The name of the node is used
+to identify the power domain and must therefor be "mx".
+
+- #cooling-cells:
+	Usage: optional
+	Value type: <u32>
+	Definition: must be 2
+
 Example: rpmh power domain controller and OPP table
 
 #include <dt-bindings/power/qcom-rpmhpd.h>
-- 
2.1.4

