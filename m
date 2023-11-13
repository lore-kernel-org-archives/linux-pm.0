Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6AFC4332F
	for <linux-pm@archiver.kernel.org>; Mon, 13 Nov 2023 22:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjKMWDf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Nov 2023 17:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMWDe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Nov 2023 17:03:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177DAD50;
        Mon, 13 Nov 2023 14:03:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096B6C433C7;
        Mon, 13 Nov 2023 22:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699913011;
        bh=pkmOTL04AJ1h5bNfaK/n1CUjH3QtMrv3NxFMXiMTlQM=;
        h=From:To:Cc:Subject:Date:From;
        b=LNJrCfmtv7peFxHZuym9obJNs3NUGicaVyGAtEVHtIJKXO6asqVT3+iO+YUhYdFBO
         q1u0v9Ub2WLLF6O2+rLPBFfcaSJq8kFxaVy49hc7qgkDMT6CVeYhP6VP4IvNQnsW8m
         oUsvl8t/oKXFQGFuxTOW2Udl/xSYiXJTrzE2GV7Xq306XfywSHAQa9R7hvYiRs5PwC
         zm15yKJzzTn35VCedUD8PBrhZ8woQYylkZcz/EPxy83VEn441+p7ezgkuO0z5qKQGj
         yA37IjC9t+rqkHDJ4abHxvQkVLHjsX7V3GDcgD0ATIMuvK2CFFBfxYyjB+lxdA+7Bx
         YFIzK7xXAJqUQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/2] cpuidle: Remove unnecessary TIF_NR_POLLING clear/TIF_NEED_RESCHED folding
Date:   Mon, 13 Nov 2023 17:03:24 -0500
Message-ID: <20231113220326.7933-1-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Those are cpuidle patches that you acked from a previous posting. I
figured they would be best routed through you so I'm reposting those
strict cpuidle bits from the series.

Thanks.

Frederic Weisbecker (2):
  cpuidle: Remove unnecessary current_clr_polling_and_test() from
    haltpoll
  cpuidle: Remove unnecessary current_clr_polling() on poll_idle()

 drivers/cpuidle/cpuidle-haltpoll.c | 5 +----
 drivers/cpuidle/poll_state.c       | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

-- 
2.42.1

