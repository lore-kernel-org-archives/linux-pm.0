Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E24C433F5
	for <linux-pm@archiver.kernel.org>; Tue, 26 Apr 2022 22:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355712AbiDZWTF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 26 Apr 2022 18:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355723AbiDZWSz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 18:18:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863002AE28
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n32-20020a05600c3ba000b00393ea7192faso130613wms.2
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2022 15:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xqo8cdwZZ7Q/0XbGV8OGpU2bIpfLRX69Ze0bOBuXZM=;
        b=BGWFkjuPN+z4ttF0UmF8Pk2FFczgajxL4OHrl/9N8HdkGRGnGxP/z9A3dBlcN+Kp25
         g5LedZNfLm6BaVlieYI1A/Jry8K0eB59sTqdzRMo7V0FySw24yyh1gqZ9k3gHYysf9NP
         02och3dCV+wvYrAPRG7NdALoqN50IE/UL1g9H+DtEQX0mzt6+INKlYt1vyf296wheVRC
         +QXhQXwpJSnts5oR7p3dT4ndR5kHBi8d3mMkMura9r3J7KxO7PN0VuRRiqCYEXRtP4IV
         cgyAnMiZmhCg1DK7FCWBf3IR10CICfQyTp0Sml+4XTiN239mEtiluy7WEBGHr+7hAzpJ
         824Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xqo8cdwZZ7Q/0XbGV8OGpU2bIpfLRX69Ze0bOBuXZM=;
        b=rWdlU9abxwEMgBEmGzXQfjb8zMv3LyaxxEx4Vrbs+D+k/qoVunync9WrEDJjx9iA5B
         CGNFy2n+yspR1xI2EHprY9zfHeTKUsnSVPBxOMJ9ABabf0UyqpAFGIOQc+hEW3Fwo7mm
         n75xeEh2uEo1urUecmxSyACQAZyv7jrJB7xeqGB1m1aLZvb0TGZvvZ5mzBbLb/T32Nsl
         D7/Xvzy+WhrRQe+VBG+g6YMBAjxj9ViRo/Mlu3FSv0GDB9RsSnqroWPOBLinegMgfvqE
         eZYFhtz2ODpb9C146xrhJYb/al7rxgLoXkBR6HEsKSsVZsYWZ6m9lP6xNua0YdYf1AWq
         c1Wg==
X-Gm-Message-State: AOAM53233iwAvXz43yv2wKdONS/jQf7KLUeGuDEm0JqnfamJtkLpcfsc
        gk9RKDt/ExLUj7QujLE1pRszOw==
X-Google-Smtp-Source: ABdhPJxPhhOKiPiX/8lriPpnQIomwLWWbla9zIeSYHjIy7+J6eWA/DsMwABJdJhTEiFCksgKHEVJMQ==
X-Received: by 2002:a05:600c:ad1:b0:38c:8bf6:7d6b with SMTP id c17-20020a05600c0ad100b0038c8bf67d6bmr23444731wmr.84.1651011345148;
        Tue, 26 Apr 2022 15:15:45 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id j19-20020adfb313000000b0020aed8ece65sm393314wrd.32.2022.04.26.15.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:15:44 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     khilman@baylibre.com, abailon@baylibre.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] thermal/of: Store the trips in the thermal zone
Date:   Wed, 27 Apr 2022 00:15:21 +0200
Message-Id: <20220426221523.3056696-14-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
References: <20220426221523.3056696-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As the thermal zone contains the trip point, we can store them
directly in the when registering the thermal zone. That will allow
another step forward to remove the duplicate thermal zone structure we
find in the thermal_of code.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc; Eduardo Valentin <eduval@amazon.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 25ec70c8b7ed..069b421a54ae 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -1105,11 +1105,9 @@ int __init of_parse_thermal_zones(void)
 		tzp->slope = tz->slope;
 		tzp->offset = tz->offset;
 
-		zone = thermal_zone_register(child->name, tz->ntrips,
-						    mask, tz,
-						    ops, tzp,
-						    tz->passive_delay,
-						    tz->polling_delay);
+		zone = thermal_zone_register_with_trips(child->name, tz->trips, tz->ntrips,
+							mask, tz, ops, tzp, tz->passive_delay,
+							tz->polling_delay);
 		if (IS_ERR(zone)) {
 			pr_err("Failed to build %pOFn zone %ld\n", child,
 			       PTR_ERR(zone));
-- 
2.25.1

