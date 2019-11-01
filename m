Return-Path: <SRS0=AJ/8=YZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EF3CA9ECF
	for <linux-pm@archiver.kernel.org>; Fri,  1 Nov 2019 19:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F133321855
	for <linux-pm@archiver.kernel.org>; Fri,  1 Nov 2019 19:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYb2sQCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfKATHf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:07:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35470 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKATHf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 15:07:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id r22so4208251qtt.2
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 12:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Zrt7Ciu4aEbO1sutkMk41HncYdL+eJqeqa2yKbY6m8=;
        b=LYb2sQCf+hVD51/AaxMTr5P56gM5TugPuWmdhGKsEn/bKeuSP+E9QfBb3QnlBH1lPO
         /hjMCCaxzKEYUnBo2QTp5cmnmfvS01uZNBlilO8V4yaIN3irx9FKVqCcHnrFgp3hQBsc
         w4l4lZ5Dl03jBm+fpD3BR3wlNS5YN9q1F478RkUShv6z1DnMPwLjdtQwJU2bOHPVKNFN
         9UAZSZWj395jWoJ6cbGbP+nCQhAALt+dErfkfv5eyeEgomiK9VdRk5oexkIup3IOZ+P0
         ICFHlzmtmDsQjL1vIxmB43RQnbzPwEEFL2UdtYz1oIOKVIi9KiHu05OdY8jAkGd4dj0D
         I5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Zrt7Ciu4aEbO1sutkMk41HncYdL+eJqeqa2yKbY6m8=;
        b=O0eGxRYJjnXYISL+yYeCRIG+XvyRNNtzZGkMc/fwiyBqTbDcIs5bLlDrqFhMwhoy8E
         32ae9q9zs6LkGJnkGHolvq8QZWtgjCp6wOi+wKMucZesYDBijhO4ZqAcJ01okdbzHDqA
         759k9a+IaqKvGo073npbAxLjKKbOfan/Z+5qQyZlUTudYBeWwAeVTMAelF+POW+hWSe4
         yD5bHan2L53GjkDHPbl1ldC2kAsqhMV5LbsD2Y4V0hUOXrZQbElv0IseEw741C8jlAo2
         tQifuBeQuwfjcfuUIRQ3JiAZaKToCGdGEmH1jHdgExJ81aDRJ9t8KEiHihI+BjTpYEBt
         k9xA==
X-Gm-Message-State: APjAAAVEQOHqC+VuqC8IJ5Cbvn0NhDsaObOMVdpFO7y6Myyy/h3cwJNL
        aPdxd5k4k/KEodBHoWLoozY=
X-Google-Smtp-Source: APXvYqw0qim5XDlFLVZjFYFkwU15MKN9o9SCpHyR6JQ9cyjjPwcNg9u0vDqSxePgeGolvXfTms3aSQ==
X-Received: by 2002:a0c:eb90:: with SMTP id x16mr11662879qvo.140.1572635254599;
        Fri, 01 Nov 2019 12:07:34 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id d139sm5105905qkb.36.2019.11.01.12.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 12:07:34 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org
Cc:     Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 4/7] devicetree: bindings: sbs-battery: add sbs,force-load property
Date:   Fri,  1 Nov 2019 15:07:02 -0400
Message-Id: <20191101190705.13393-4-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101190705.13393-1-jeff.dagenais@gmail.com>
References: <20191101190705.13393-1-jeff.dagenais@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 .../devicetree/bindings/power/supply/sbs_sbs-battery.txt       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
index 4e78e51018eb..62ec842325b4 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
@@ -15,6 +15,8 @@ Optional properties :
    after an external change notification.
  - sbs,battery-detect-gpios : The gpio which signals battery detection and
    a flag specifying its polarity.
+ - sbs,force-load : Same as the module param, makes the probe skip the
+   detection of the battery and assume it is (or will be) present.
 
 Example:
 
@@ -24,4 +26,5 @@ Example:
 		sbs,i2c-retry-count = <2>;
 		sbs,poll-retry-count = <10>;
 		sbs,battery-detect-gpios = <&gpio-controller 122 1>;
+		sbs,force-load;
 	}
-- 
2.23.0

