Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F4EC77B60
	for <linux-pm@archiver.kernel.org>; Fri, 28 Apr 2023 19:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346543AbjD1TyC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 28 Apr 2023 15:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjD1TyB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Apr 2023 15:54:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0976C2700;
        Fri, 28 Apr 2023 12:53:59 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 106F766032CF;
        Fri, 28 Apr 2023 20:53:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682711638;
        bh=JJHjN58c2mTlQgbqU0pQ4tNlxG5r2+HmlKXQ3BAuk+o=;
        h=From:To:Cc:Subject:Date:From;
        b=glQT9Nc5Fm1X0sY7HRriotmjWXWM8rHX7Ssnhp8NSKuX3Q2C9ke2dwBfsmOvjiOSb
         4a2NH9EUemf4HwmsCO2aPJLDXXuAoP0ARcDqRbAnGIt0tvvusDgEA7NtPdDrlKFN7c
         eBXhnxz4PE7wszf4ySAXakrgFMQBmTqaLb9IyCTlM4Jp74zOsjKDfTaWZB4g17ducj
         zpnNgtGehzWhsPyJlBfU2jPTNzSGJIx2388uQ9/gl+7AmxIONZlRX6fPBk0AUvxjLR
         fakUBs5ZKNVzvqifBEsnkRmq20LXaEOoSVZiMkyeMqi8W5UeTLjFB2kg1qtIsjYwHI
         LcEel/B38M7ag==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: Fixes to the interrupt handling
Date:   Fri, 28 Apr 2023 15:53:44 -0400
Message-Id: <20230428195347.3832687-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Fixes in the interrupt handling of the LVTS thermal driver noticed while
testing it on the Spherion Chromebook (mt8192-asurada-spherion) with the
MT8192 support series [1].

These are standalone fixes and don't depend on anything else.

[1] https://lore.kernel.org/all/20230307163413.143334-1-bchihi@baylibre.com/

Thanks,
Nícolas


Nícolas F. R. A. Prado (3):
  thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
  thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate mode
  thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts

 drivers/thermal/mediatek/lvts_thermal.c | 54 +++++++++++++------------
 1 file changed, 28 insertions(+), 26 deletions(-)

-- 
2.40.0

