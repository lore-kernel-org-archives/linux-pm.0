Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31FFC6FA8F
	for <linux-pm@archiver.kernel.org>; Thu, 24 Aug 2023 12:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbjHXMQa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 24 Aug 2023 08:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbjHXMQI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2023 08:16:08 -0400
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5E210EF;
        Thu, 24 Aug 2023 05:16:02 -0700 (PDT)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 7B4818CC506; Thu, 24 Aug 2023 13:27:53 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        azkali <a.ffcc7@gmail.com>, CTCaer <ctcaer@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add charger support for the Nintendo Switch
Date:   Thu, 24 Aug 2023 13:27:33 +0200
Message-ID: <20230824112741.201353-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These aren’t my patches, but are required in order to charge this
console.  I have tested them on a downstream 6.0 kernel[0] and they seem
to work properly.

This is the first part of a bunch of upstreaming I’m going to do for the
various drivers required to support this console in mainline.

[0] https://gitlab.azka.li/l4t-community/kernel/mainline/linux/-/commits/icosa-v6.0

Alexandre Courbot (2):
  power: supply: bq24190: Support bq24193
  power: supply: bq24190_charger: Export current regulator

 .../bindings/power/supply/bq24190.yaml        |  1 +
 drivers/power/supply/bq24190_charger.c        | 86 +++++++++++++++++++
 2 files changed, 87 insertions(+)

-- 
2.42.0

