Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B553C63699
	for <linux-pm@archiver.kernel.org>; Mon, 16 Nov 2020 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E685E2137B
	for <linux-pm@archiver.kernel.org>; Mon, 16 Nov 2020 15:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHKaw16f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E685E2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-pm-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbgKPP1N (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 16 Nov 2020 10:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730912AbgKPP1N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 10:27:13 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76869C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 07:27:11 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so24073758wmg.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 07:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AN+diq6krUutxY4s1BjD5o/2cLxtj1QMMKMF7O1rYVo=;
        b=jHKaw16f3JcgFuPOI2wbaph8tTmnALDn0khAmRDjUattsPMELsHZEeszdwoUn49Ygt
         ywb62K5wnfWRAWHSPxljbLVvR0CKhM7faGVfdHxG/KzrkMIeHO763+hOptr5w2JHxRrb
         8VoSAokMfLFxjM2zKnCDJ1fo8c0ZKrFKMOJDepDRi3pqMQR8WTaVJcXh07QuwnFUT/83
         hMJB/s920zKWRyvH2BE/bHNO4O0YHrgz44uwS0t4vLV7br81HjzHs46KUHHBQZ6olvKB
         0rQs0jGm04oV47EGxHU2rU93VXl4lwSB5PmF4YCcYTVE0sF47UrHZa5KuKklQ+4QubVB
         lYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AN+diq6krUutxY4s1BjD5o/2cLxtj1QMMKMF7O1rYVo=;
        b=iPVYCT+Z0m2wdTIJUlCkrMtkGtLIXw6cjO7PYSyb64DXkjshL0V9tYOl4IysEfA96L
         dpvpytv/lJwRN0C+YhznfKnX3w6YPeGt16yPMLLg/MQlUKlsb/8tXhSGidj8fmb9zuhM
         P8WksgxGSxg/8fXmj9AVIY/TcWIUCbh2mWuMG+Wa2nfYGn1Zf+uo6/yjWilbIvFonWfM
         HZQ4Mv/qycHW9k6Z+0dhGHHiDtWMbc6Bz5NNbwJVRAnIfemBqnMCagbzaJ9Nt5zxMAIC
         ppqOCh7e/Ecfzc/Xbs1snBgS0S9Bt7aN0N6ynWKj56jBMlw1WFW2bk6G8Z4gDyFswy1T
         fxkg==
X-Gm-Message-State: AOAM533AobDqvU1Anh12plucoYhV5tJBdzfK5yY+xNJq+chzKZjaJ0+S
        +0lkOxRf4McnwgXDd7G+J5rZ5Q==
X-Google-Smtp-Source: ABdhPJy6aHvbhszTIpGcG5YaGEh0c4mxwL33CLH0slye4X7gVGiV8ZjagFX66At4zxWvR2lsFI40pQ==
X-Received: by 2002:a1c:ddd7:: with SMTP id u206mr15867144wmg.27.1605540430116;
        Mon, 16 Nov 2020 07:27:10 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-240.adsl.proxad.net. [82.252.135.240])
        by smtp.gmail.com with ESMTPSA id k20sm19930453wmi.15.2020.11.16.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:27:09 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     ilina@codeaurora.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rkumbako@codeaurora.org, rui.zhang@intel.com
Subject: [PATCH v2 1/4] units: Add Watt units
Date:   Mon, 16 Nov 2020 16:26:46 +0100
Message-Id: <20201116152649.11482-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116152649.11482-1-daniel.lezcano@linaro.org>
References: <20201116152649.11482-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As there are the temperature units, let's add the Watt macros definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/units.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index aaf716364ec3..92c234e71cab 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -4,6 +4,10 @@
 
 #include <linux/kernel.h>
 
+#define MILLIWATT_PER_WATT	1000L
+#define MICROWATT_PER_MILLIWATT	1000L
+#define MICROWATT_PER_WATT	1000000L
+
 #define ABSOLUTE_ZERO_MILLICELSIUS -273150
 
 static inline long milli_kelvin_to_millicelsius(long t)
-- 
2.17.1

