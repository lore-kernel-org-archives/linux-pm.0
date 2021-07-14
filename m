Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C681FC1B08C
	for <linux-pm@archiver.kernel.org>; Wed, 14 Jul 2021 19:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3057613FA
	for <linux-pm@archiver.kernel.org>; Wed, 14 Jul 2021 19:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhGNTsS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236767AbhGNTq4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Jul 2021 15:46:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 958C7613EC;
        Wed, 14 Jul 2021 19:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626291776;
        bh=FQXIRt4S9fKQcn3FknQpuVukK2IJVmAwxwDQPkJ1EHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/PPXh1Fr1nJ+c+9JUEA/RHZk1EbaX1fgBw+gtZF11nPD1Klhn38Oky4dnXoq48Cg
         /sKlGuwz43v0KDeGw6O6lYMp34AClW2k/BHnKPMNjdDkFEci8G6x/tV5VcE95FB7Jq
         Z5raDJUW/Re8n706zl7xkl9L1+zivS3AP4ZyVxN/y3VXgWz8TlYEXRIcXIoEUQtCas
         /zdKKzxeQ5bae+7364aFyas90E7bC4ezn3lOMWhcnEx0u0kTS1wKahWRtamNI0EHfn
         4ysDShdC/rbn/kZxlGhWR9YZ2RaTbtLk62WUHjhWX004lsXanod+j160cj3xXJqpYM
         rvZ9RKhfMv3Sg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 099/102] thermal/core/thermal_of: Stop zone device before unregistering it
Date:   Wed, 14 Jul 2021 15:40:32 -0400
Message-Id: <20210714194036.53141-99-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210714194036.53141-1-sashal@kernel.org>
References: <20210714194036.53141-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit 5e5c9f9a75fc4532980c2e699caf8a36070a3a2e ]

Zone device is enabled after thermal_zone_of_sensor_register() completion,
but it's not disabled before senor is unregistered, leaving temperature
polling active. This results in accessing a disabled zone device and
produces a warning about this problem. Stop zone device before
unregistering it in order to fix this "use-after-free" problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210616190417.32214-3-digetx@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_of.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5b76f9a1280d..6379f26a335f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -559,6 +559,9 @@ void thermal_zone_of_sensor_unregister(struct device *dev,
 	if (!tz)
 		return;
 
+	/* stop temperature polling */
+	thermal_zone_device_disable(tzd);
+
 	mutex_lock(&tzd->lock);
 	tzd->ops->get_temp = NULL;
 	tzd->ops->get_trend = NULL;
-- 
2.30.2

