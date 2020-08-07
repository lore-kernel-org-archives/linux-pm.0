Return-Path: <SRS0=ssS9=BR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A25C433E1
	for <linux-pm@archiver.kernel.org>; Fri,  7 Aug 2020 23:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C342087C
	for <linux-pm@archiver.kernel.org>; Fri,  7 Aug 2020 23:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWshW0Il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHGXt2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 7 Aug 2020 19:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHGXt2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2020 19:49:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2651CC061756;
        Fri,  7 Aug 2020 16:49:28 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so3710930ejb.11;
        Fri, 07 Aug 2020 16:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BJDYcXK7p3J3f4EUrsb6z6vjaDofjAoKW5G2mK2MyfM=;
        b=kWshW0IlL5tA+fqky3jj1z4mGdBj/Bu9h92/gjKWCgNnpop36C4IwYym9eTr3gqHic
         1Pamhp8uNwHcOtbVIppn8VT88c8ZF8GA3XMYWDP1n7DoC9riJ2QxW2m0J3bK8F+djL0c
         Puhdzgfe3DcMrHsTdb+SAYRo7ugvhArgB7SV14OgfnSxX1JUpAzFKMq0KDfY0bFgCj4h
         g6fpfZvOQu95FEmwtyPb3geq80HLt3X3L/ZaPpl2slquhlM03UpIim7skdLaLJlp34Iz
         5rwdYryU1u67EM6WgA8VMGOGsBrInVo0KqKiha5dUl7I+vAys8AnGbkr1eaWBf7/O7cd
         a3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BJDYcXK7p3J3f4EUrsb6z6vjaDofjAoKW5G2mK2MyfM=;
        b=CBUxyaQEHhmjyh4tL9LX9v5+918o9eUBflMkwtlEOJTWUXtI6Et4cnHGG0TjlGkmpO
         tR04y3PleNZ/1+has2Dt9n1iop4YZByBPGD9ntqpAI0cw5tK5d5mAYsIutgcKATqC3J1
         8LYn/g3KZ8hXvqaJTQLX/IB80T35DPoInBhdtqu4/RgDafWRC6eskKzOdXPkmJ+lPcpP
         SropWJp4wC1tMqEB9LWdkpddhEFRS3KarRs5GlBMT9o4b7B3J6L81r0V2vEjEMpyVJN/
         iGFup45NBdu6UmMK72quJU30lREqiFeRYytCaKJmLmL8SJYqARq8BWDj8nJekx+B/Yo7
         diBA==
X-Gm-Message-State: AOAM531k5Yyt27Y5MjVUSKCJCz8Uxd3TV+EYhu4psaThRKecjxsQPeBr
        JY0fsVPCOfgv4DrbttZ/6HI=
X-Google-Smtp-Source: ABdhPJxMjmi5TrRyiI6dUL/FzWUjuPzbcfAIgB8g2ELsEtHc3/WGb/KQ7YjKT3ToQmyWL+6IGKuNfQ==
X-Received: by 2002:a17:906:b815:: with SMTP id dv21mr11518592ejb.517.1596844166630;
        Fri, 07 Aug 2020 16:49:26 -0700 (PDT)
Received: from Ansuel-XPS.localdomain ([87.13.195.83])
        by smtp.googlemail.com with ESMTPSA id k17sm6977826eji.28.2020.08.07.16.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 16:49:25 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/2] Add Krait Cache Scaling support
Date:   Sat,  8 Aug 2020 01:49:10 +0200
Message-Id: <20200807234914.7341-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds Krait Cache scaling support using the cpufreq notifier.
I have some doubt about where this should be actually placed (clk or cpufreq)?
Also the original idea was to create a dedicated cpufreq driver (like it's done in
the codeaurora qcom repo) by copying the cpufreq-dt driver and adding the cache
scaling logic but i still don't know what is better. Have a very similar driver or
add a dedicated driver only for the cache using the cpufreq notifier and do the
scale on every freq transition.
Thanks to everyone who will review or answer these questions.

v2:
* Fix Documentation error reported by bot
* Rework code to fail probe on missing required params
* Optimize notifier callback to reduce CPU cycle

Ansuel Smith (2):
  cpufreq: qcom: Add Krait Cache Scaling support
  dt-bindings: cpufreq: Document Krait CPU Cache scaling

 .../bindings/cpufreq/krait-cache-scale.yaml   |  92 ++++++++
 drivers/cpufreq/Kconfig.arm                   |   9 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/krait-cache.c                 | 214 ++++++++++++++++++
 4 files changed, 316 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cache-scale.yaml
 create mode 100644 drivers/cpufreq/krait-cache.c

-- 
2.27.0

