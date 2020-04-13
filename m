Return-Path: <SRS0=Imah=55=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96B8C2BA19
	for <linux-pm@archiver.kernel.org>; Mon, 13 Apr 2020 07:00:51 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89E72076A
	for <linux-pm@archiver.kernel.org>; Mon, 13 Apr 2020 07:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYrT913r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89E72076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pm-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgDMHAv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgDMHAu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 03:00:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AB9C008651;
        Mon, 13 Apr 2020 00:00:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h69so1551491pgc.8;
        Mon, 13 Apr 2020 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kfy/ROQ7gtXLXzXKgSpMRgFDcYEAd8k4j64w9UUThVk=;
        b=XYrT913rsTzhy3QwXikOs/GzZx59MEF6RbPx7FH9kaLVOEE8nO928g0cvW2dXDefkm
         /h90ME84J09Y44EKCfDwP7EVMaGtpqfnixocf/IAN83UiWsLPaqhxhV8uNO1VO8KH4g6
         G1sZeTw1D5jSD/rtXKftLB1VFyKaOcqfJh5j0YX+/HMRE4lXHvsG5va4UHOsPgPnt30T
         8RFCUgSCQKPcAYpn/EhtcVMK8rSXS+ow8MHX1nEb7vHTWVpTu72WgGnxmL1lvIPtzTQU
         HtvoItp1pW8nxpaOjgp+gx6wbOzZH6/65Wzyk3WUD/0WWL9DzPs3K8aFQEgz/yc/QjfJ
         rL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kfy/ROQ7gtXLXzXKgSpMRgFDcYEAd8k4j64w9UUThVk=;
        b=ZaMSzVdYPwDT7CfGicuqlJFdDBVVj7fGxr9ytrZ7p7Sa4px/cgOHuDEmhg/2M5pNGY
         za4BLdyt2k9NijAyUBdS4RXqfYzI7XgcJEKSS5ZPZnUTM5cEmc1BBp24ab5GBSi8e0oD
         K37a7fcOHsVwDwMmAMUUsrLIaYJN3PGHlrKsYDp9YPgYMODVVwK/a4tCOK9jFRgcKvFf
         vSs1Udh8QEFbLUqFor8mAm7DZWufLaegDwhUeL/xqz83ACfeC8aZfwUWa0duMoJiB6ok
         dpgPF3PgbCu+U/EmaVREprtKqUoOq8PokpqiuvJaoYPU0rs97TxseuXkd4gKMJmLLlR0
         pA8g==
X-Gm-Message-State: AGi0PuYGM6KXlGQDHmFApMK4ezeA7Hmg8k17V7NLoMKTMqe7IyfUdknH
        SqG+EJYeiSMiYn3zAKEgqjI=
X-Google-Smtp-Source: APiQypJkaYl+NqjsZJuSnP7/Kdsz5tEB3wmizLHj6zJSqYGAcE5ED0p58ZTn/TgOYz0CWWp4WaZLTw==
X-Received: by 2002:a65:5b05:: with SMTP id y5mr16522768pgq.239.1586761248942;
        Mon, 13 Apr 2020 00:00:48 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p4sm7815670pfg.163.2020.04.13.00.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 00:00:48 -0700 (PDT)
From:   zhang.lyra@gmail.com
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RFC PATCH v1 2/2] dt-bindings: arm: Add description to the new property for-s2idle-only
Date:   Mon, 13 Apr 2020 15:00:14 +0800
Message-Id: <20200413070014.12960-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200413070014.12960-1-zhang.lyra@gmail.com>
References: <20200413070014.12960-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Add a new property for-s2idle-only. The idle-state marked with this
property will be set with CPUIDLE_FLAG_S2IDLE during initialization
and it would be expected to be found as deepest state for s2idle
rather than other cases like play_idle().

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 Documentation/devicetree/bindings/arm/idle-states.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/idle-states.yaml b/Documentation/devicetree/bindings/arm/idle-states.yaml
index ea805c1e6b20..cec47b3a447f 100644
--- a/Documentation/devicetree/bindings/arm/idle-states.yaml
+++ b/Documentation/devicetree/bindings/arm/idle-states.yaml
@@ -263,7 +263,6 @@ patternProperties:
     description: |
       Each state node represents an idle state description and must be defined
       as follows.
-
       The idle state entered by executing the wfi instruction (idle_standby
       SBSA,[3][4]) is considered standard on all ARM platforms and therefore
       must not be listed.
@@ -283,6 +282,15 @@ patternProperties:
              lost on state entry, otherwise it is retained.
         type: boolean
 
+      for-s2idle-only:
+        description:
+          This indicates that the state only can be found as deepest state
+          for s2idle rather than other cases like play_idle(). In general,
+          the state having this property should have longer min-residency
+          than the cpuidle target min-residency which CPU QoS constraints
+          defines, to avoid being used by runtime cpuidle.
+        type: boolean
+
       entry-latency-us:
         description:
           Worst case latency in microseconds required to enter the idle state.
-- 
2.20.1

