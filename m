Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C851AE81DF4
	for <linux-pm@archiver.kernel.org>; Fri,  6 Oct 2023 13:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjJFNEr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Oct 2023 09:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjJFNEq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2023 09:04:46 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED51E9;
        Fri,  6 Oct 2023 06:04:43 -0700 (PDT)
Received: from francesco-nb.corp.toradex.com (unknown [201.82.41.210])
        by mail11.truemail.it (Postfix) with ESMTPA id 2530C20B4D;
        Fri,  6 Oct 2023 15:04:37 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] power: reset: gpio-poweroff: use sys-off handler API
Date:   Fri,  6 Oct 2023 10:04:24 -0300
Message-Id: <20231006130428.11259-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Use the new sys-off handler API for gpio-poweroff. This allows us to have more
than one power-off handler and to have a priority for the handler. Also, add a
priority property so we can use gpio-poweroff even when registering another
poweroff handler or using the legacy pm_power_off method.

v1->v2:
 - Add $ref to restart-handler.yaml in gpio-poweroff.yaml

Stefan Eichenberger (4):
  power: reset: gpio-poweroff: use a struct to store the module
    variables
  power: reset: gpio-poweroff: use sys-off handler API
  dt-bindings: power: reset: gpio-poweroff: Add priority property
  power: reset: gpio-poweroff: make sys handler priority configurable

 .../bindings/power/reset/gpio-poweroff.yaml   |  6 ++
 drivers/power/reset/gpio-poweroff.c           | 82 ++++++++++---------
 2 files changed, 50 insertions(+), 38 deletions(-)

-- 
2.25.1

