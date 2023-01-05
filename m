Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C332C53210
	for <linux-pm@archiver.kernel.org>; Thu,  5 Jan 2023 00:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjAEAW2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Jan 2023 19:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjAEAWZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Jan 2023 19:22:25 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A506C1AD9E
        for <linux-pm@vger.kernel.org>; Wed,  4 Jan 2023 16:22:24 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id f20so37205722lja.4
        for <linux-pm@vger.kernel.org>; Wed, 04 Jan 2023 16:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fc+e1Wrqq4V5fta3bJ+Z/tnWjxVJEg8xzf66W9K/0o4=;
        b=mUZrkIkjyuG0yydo+LZSs35Xp4eEUvd7tuI0+IgsMBHzDQKBCByVXRurDLNQ8sWlxk
         VEur3SVfhqissP6NGjKvrKZnYSFbhXmYuYNW8wt/AIDx4YzIMYnErkvNwdjpqxH06X1t
         zRJn/U5Gf+KU6RKw3WDTPICAc1uL8zx7EpxC/RMKB28z9QyLbb6XvSyZFy5M1ut+prky
         8qcU1J3h7Iv4ucisORhJq9/r1lLOB0bqVcdGxr4s2shTM7LLm72l0+0DJdRdnQBHWBSp
         REokbkxmKCIc6Ml3zNRiI7n1EMXbRqbdSzlkjX4Oh93SKXGWc+B8wFnminw0gfGP+hiO
         KndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fc+e1Wrqq4V5fta3bJ+Z/tnWjxVJEg8xzf66W9K/0o4=;
        b=MPNoOO2DMR+fODTqTEY7LGB1vcuYeGczT62P6bzlQ/Ai00Dv3EysNOtSm9B41lygcQ
         JZFj/bRmzxTMrakcNl7RQ67uuYizkpMQB4Moo4a8y07r6gVQce7nTHYAVjLumA5KiDs3
         wCLJg4RI/t2ba0b1qoTDzCiBnXpvKfEXCZZQF4ug8a7mEWnTVDCF7K5k0cMMjgTFfkSj
         ielKXwCF7XFhTMLy4DSURBFq0ogoOsJc1LvBY7h7Iw9DSrCehWmRPNSQ16vVKO/gYFl1
         jJDY5xVsNSujcMX3toutOrysLH8qAvxJ1Cy2x+TZGl36Vp8i/f1tZq0WKB1mmvxsigpv
         bU0w==
X-Gm-Message-State: AFqh2kqnW3dsnnI2ajvfELxMUJv6DWTtDpaqmzOKqsvH+RqhDvwEadxP
        ZM8v4Cm7C4sYY7J9kxZ4vbADyA==
X-Google-Smtp-Source: AMrXdXs7UOIS4610Df0fYQLXcyJqdoyIuRuVbCjPH0YG+963HoNzi6xIOLH+DZQY8/obbKPQEJW3JQ==
X-Received: by 2002:a05:651c:1541:b0:27f:f897:b8d3 with SMTP id y1-20020a05651c154100b0027ff897b8d3mr3811539ljp.25.1672878142982;
        Wed, 04 Jan 2023 16:22:22 -0800 (PST)
Received: from eriador.lan (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d18-20020ac241d2000000b004b4cbc942a3sm5291992lfi.127.2023.01.04.16.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 16:22:22 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/3] interconnect: qcom: several fixes
Date:   Thu,  5 Jan 2023 02:22:18 +0200
Message-Id: <20230105002221.1416479-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Patches 1 and 2 are applicable on top of 6.2-rc1, patch 3 applies only
on top of the immutable branch `icc-sm8550-immutable'.

Dmitry Baryshkov (3):
  interconnect: qcom: osm-l3: fix icc_onecell_data allocation
  interconnect: qcom: sm8450: switch to qcom_icc_rpmh_* function
  interconnect: qcom: sm8550: switch to qcom_icc_rpmh_* function

 drivers/interconnect/qcom/osm-l3.c |  2 +-
 drivers/interconnect/qcom/sm8450.c | 98 +----------------------------
 drivers/interconnect/qcom/sm8550.c | 99 +-----------------------------
 3 files changed, 5 insertions(+), 194 deletions(-)

-- 
2.39.0

