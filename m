Return-Path: <SRS0=FCtK=4V=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C81CC3F2D7
	for <linux-pm@archiver.kernel.org>; Wed,  4 Mar 2020 21:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC1E20838
	for <linux-pm@archiver.kernel.org>; Wed,  4 Mar 2020 21:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb3IOFXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbgCDV0R (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:26:17 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33604 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbgCDV0Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 16:26:16 -0500
Received: by mail-ed1-f68.google.com with SMTP id c62so4082595edf.0;
        Wed, 04 Mar 2020 13:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eMvhBOIg5MRjHF1oFd/XQ7SSnXXeEGxIFK8nINn5g7k=;
        b=Eb3IOFXsE/5oc8UPJfOC7SVDxP8zUqyH896zGb2lG90S92LZk+QnhPw4pVvGkuUOBc
         HNNsuwN8g4bIw/+bygigUIyQKJD/dfC8mJ3EKwOiH5mRU9/gG0AvuY3Q3Dg5yAwO7RZ4
         jtSI3psRzrtJ/pMIT/q2i5jPkznXQcEtRj3jIc9pJ3e9XZBnSXXLXANUpAWvHvr8RgYv
         UdfrXmvdYQSm1ZjK6rHHxch+eHZcWs5gxG/b0VpLsvwOLoktgmI+ac0Ez0dINeXkQzn7
         caRHXsHS/MDmtrJwJaPuE/nSk0XsJmSMFdMuNcwzd0BUrrVPgIa+Z6+2oWfWT2arzwej
         2Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eMvhBOIg5MRjHF1oFd/XQ7SSnXXeEGxIFK8nINn5g7k=;
        b=Z+qgQAg7m+jrRnD1ftT3V1ZHIJbh7QapYMC3lRPEFHdHNHxrIhRtXLyFLmPkqvRCt3
         NLQ5d+8uTRn8IGXFWMp3pMMcLZuJIt809vDF3d40SFAZE8rtjr1lEn2sr3dHWQRrkZmU
         N78Ks7GRMg1zpyjFieMJ0EtrHZP6SkdFLdeDS7Scw3412seooWki5JovjQmb9QTIO0jJ
         ZSNHMVHu10BSiro2aQlb0jg8xHi2n7u/Zn7UUnlmmQDgyL7prrHSzirLghlCuRZ5FSL7
         7VRM6ho0nsoD8kDBM4SVrWxfeLpuvdFryqF1MjHgHYH/2TreEyGW8ajpHaNvraZtzaT4
         GtHg==
X-Gm-Message-State: ANhLgQ3YC6GBH5N89YXhk60b0KIU/IWuiNZ92MOJYkp9Q7xz0WwY7rs+
        b0PDgTL5dGeK0XuQS+KtMGp2HsmrimI=
X-Google-Smtp-Source: ADFU+vsYttFIIZKSMto/Dsvrd8XkxFID6j5epaPlIKW2H/3V/H1ZiJlIaehOf50JN/z7KI79i34OKQ==
X-Received: by 2002:a50:b043:: with SMTP id i61mr4672103edd.194.1583357174832;
        Wed, 04 Mar 2020 13:26:14 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d16:4100:5c62:5f:595c:f76d])
        by smtp.gmail.com with ESMTPSA id ss15sm1332396ejb.10.2020.03.04.13.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:26:14 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Yangtao Li <tiny.windzz@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pm@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: update ALLWINNER CPUFREQ DRIVER entry
Date:   Wed,  4 Mar 2020 22:26:00 +0100
Message-Id: <20200304212600.6172-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit b30d8cf5e171 ("dt-bindings: opp: Convert Allwinner H6 OPP to a
schema") converted in Documentation/devicetree/bindings/opp/ the file
sun50i-nvmem-cpufreq.txt to allwinner,sun50i-h6-operating-points.yaml.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches \
  F: Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt

Adjust the file pattern in the ALLWINNER CPUFREQ DRIVER entry.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Changes to v1:
  - do not include new maintainers because it is not needed.

Maxime, Chen-Yu, Yangtao, please ack.
Rob, please pick this patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6158a143a13e..9402b05630f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -693,7 +693,7 @@ ALLWINNER CPUFREQ DRIVER
 M:	Yangtao Li <tiny.windzz@gmail.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
+F:	Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
 F:	drivers/cpufreq/sun50i-cpufreq-nvmem.c
 
 ALLWINNER CRYPTO DRIVERS
-- 
2.17.1

