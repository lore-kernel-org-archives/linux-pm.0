Return-Path: <SRS0=0rhz=YV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764D1CA9EA0
	for <linux-pm@archiver.kernel.org>; Mon, 28 Oct 2019 07:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4919D20862
	for <linux-pm@archiver.kernel.org>; Mon, 28 Oct 2019 07:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SrgmiIPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbfJ1HT4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:19:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39658 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732514AbfJ1HT4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 03:19:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so6284371pff.6
        for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2019 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ssMFBj43632FcWk2CcxAhFxBDGN9BLK5UqZaapoI3EI=;
        b=SrgmiIPW0C51iZX8hYKQ2hSUsynSut8k+7kzklaDe3hpral131t906w1kTxvTbV5tI
         3AJFcoHHfri+SAsbQwrHOkCumk9s5R6sxf0Lsy79Eu3J5KBusj0Cen9tu0V/2wqWGbOH
         RETMM4ndBRk1j1in/GGXg8h7nnVqMSf39k7vZ9ymw67v30mM/OouHrZs1i+tJqqJyyOF
         E3KORbX1/MWIMAzbqYg5QFuWzs2eufjGB9AgaqQiuXq3TcGvlFZyGGOLnDd9ObkzVP+4
         sNMQvk6FIeWdhMOwKBK32SKHR1/sO5Itv7GXMlIUpon3uADMjv1Nqvuf//N/tlfER0f+
         1T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ssMFBj43632FcWk2CcxAhFxBDGN9BLK5UqZaapoI3EI=;
        b=WG/4x8SIh1Dl/qjIJpMukFcQKiSLAAEZyEtjOzUdc/5/4IxZAAMkMH523QJ1rha1cO
         Kb8BhNO6fjnixxi0oweiGcqDWHY/4uCEF2oqCQAclEk3hu/9RfwYd/snXwz23XHkTF6z
         GZcRYsTk6C+tFanxjnT5D3XdYe2xl/kW5LnTfYTcVY3/uykc4oPjCZVwqcq3ZwMrNV/L
         /g4GHFT8pTKdFD0yppnk/4fUrxZ8inWgMl6Z6OfUhNUY+ttr/iebxW5AX+x7neJEe5De
         dEPxBHQZiVaADljJlIaQbO9XvcnF3CWjCGM4o/6At2Jat5Quogu46UWYRnKxZKBYXMxv
         dsJA==
X-Gm-Message-State: APjAAAV+LXmwgOcw0/eodyKG8g2T8OtxQ9OPDCpjchM8u70JRJdeOeAv
        YZzt7T2ESpbx5hb1Vo1Ogp129Q==
X-Google-Smtp-Source: APXvYqyOl7sbyoI1mYNi/ewKV9zLdhmDBcQe9nL/ufV1lXHqClNmhenBTTW1DVH/LhXSpRQwKSwSQg==
X-Received: by 2002:a17:90b:f10:: with SMTP id br16mr20271382pjb.111.1572247194072;
        Mon, 28 Oct 2019 00:19:54 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 13sm11504703pgq.72.2019.10.28.00.19.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 00:19:53 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH 1/5] dt-bindings: power: Introduce one property to describe the battery resistance with temperature changes
Date:   Mon, 28 Oct 2019 15:18:57 +0800
Message-Id: <44f0c19510c7317cb4ee6cac54b3adfa81c2d6d0.1572245011.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572245011.git.baolin.wang@linaro.org>
References: <cover.1572245011.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572245011.git.baolin.wang@linaro.org>
References: <cover.1572245011.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the battery internal resistance can be changed as the temperature
changes, thus add one table to describe the battery resistance percent
in different temperature to get a accurate battery internal resistance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/power/supply/battery.txt   |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 5c913d4c..1a6f951 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -35,6 +35,10 @@ Optional Properties:
    for each of the battery capacity lookup table. The first temperature value
    specifies the OCV table 0, and the second temperature value specifies the
    OCV table 1, and so on.
+ - resistance-temp-table: An array providing the resistance percent and
+   corresponding temperature in degree Celsius, which is used to look up the
+   resistance percent according to current temperature to get a accurate
+   batterty internal resistance.
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -61,6 +65,7 @@ Example:
 		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
 		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
 		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
+		resistance-temp-table = <20 100>, <10 90>, <0 80>, <(-10) 60>;
 	};
 
 	charger: charger@11 {
-- 
1.7.9.5

