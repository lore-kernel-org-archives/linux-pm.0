Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1C2C10F0E
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 16:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0E320643
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 16:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYqAfk1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbfDRQiF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:38:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46839 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfDRQiF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 12:38:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id z17so2805325qts.13
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M61+RmXJJHktVV8JGOo6yLtH6EhDmTU8B1yVSi7EmEU=;
        b=IYqAfk1Wq1DbzvrNZ21Xc2OMu3jQY+2B4/qimIWEOGsEoO9hZmXv2BI9XxP5GpqvT5
         kRyFPuJzjixI2bJVY2Q8OlI5CyzHD8PYGca6FTn5J/QuW8sNvZIzi+QQxvn1k4bYFfj9
         POl3+4yKwP/iBVD1zKuaIYDawTeN5IcejcFf/AMlUVty6ao4D+GBlJHoWc99qQNaJdvO
         niofC/ILSbtP0x1/2JVwMD7SlCX+Nxin7CqHGhIPW18Up10CiTqupU55VNaJhIU5EH8T
         MnyPsuM3esL6jjflyPTIbW3foxaehbcwxkabBsouQXhVIHvIrpGqXCKzR+IB6awFEwM0
         gZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M61+RmXJJHktVV8JGOo6yLtH6EhDmTU8B1yVSi7EmEU=;
        b=uNQ/Tz6ZtXzDsSxUd1vOsgFmZHdb50kLRfoShr/u65AOLiArcLHhRBuCgYZ1aqqJjy
         SHDAbM3hZfw/B/mCOYYoPKZoyXCyCV08LHnWt/6ZUNedncKVDbHzmxcO4wQLcouAvbla
         TWCSodGny9jiQ5OqQ1ccHfMHhVexGG77+xtk2U678Tp3qvtOnfjVmv36MyC4P5vsnjYN
         gJHcYTKJejcLdn9A+CIAluL2wiq4GzX74tonZR9ZCEL480s7uACNmgor/F91qE+NCvDK
         emNT0ebW3fU5+FTsQtofqsk9Ehww9feFNHyThPlRDvsW/LEhzFYaBANwLJLRxo5u+t1d
         iLGg==
X-Gm-Message-State: APjAAAV1+3Mq2hcDA39obw8jZkXDtLZOANxbF6TY28TbhvES28cKjG1T
        kF8V/R11/JBuDkstl0ieeXwG50X2TDhUTg==
X-Google-Smtp-Source: APXvYqwLzstR33WRPIO9Tsmsaa4MSn2ahISvc8ou0lMsRTGM6ykWHqagTeManRLeGWYKXDaUyWsp4g==
X-Received: by 2002:ac8:3653:: with SMTP id n19mr75038472qtb.95.1555605483960;
        Thu, 18 Apr 2019 09:38:03 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id k41sm1622394qtc.89.2019.04.18.09.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 09:38:03 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, edubezval@gmail.com,
        rui.zhang@intel.com,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 2/2] dt-bindings: thermal: generic-adc: make lookup-table optional
Date:   Thu, 18 Apr 2019 12:37:33 -0400
Message-Id: <20190418163733.17414-2-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190418163733.17414-1-jeff.dagenais@gmail.com>
References: <20190418163733.17414-1-jeff.dagenais@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 .../devicetree/bindings/thermal/thermal-generic-adc.txt        | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
index d72355502b78..691a09db2fef 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt
@@ -8,16 +8,22 @@ temperature using voltage-temperature lookup table.
 Required properties:
 ===================
 - compatible:		     Must be "generic-adc-thermal".
+- #thermal-sensor-cells:     Should be 1. See ./thermal.txt for a description
+		             of this property.
+Optional properties:
+===================
 - temperature-lookup-table:  Two dimensional array of Integer; lookup table
 			     to map the relation between ADC value and
 			     temperature. When ADC is read, the value is
 			     looked up on the table to get the equivalent
 			     temperature.
+
 			     The first value of the each row of array is the
 			     temperature in milliCelsius and second value of
 			     the each row of array is the ADC read value.
-- #thermal-sensor-cells:     Should be 1. See ./thermal.txt for a description
-			     of this property.
+
+			     If not specified, driver assumes the ADC channel
+			     gives milliCelsius directly.
 
 Example :
 #include <dt-bindings/thermal/thermal.h>
-- 
2.11.0

