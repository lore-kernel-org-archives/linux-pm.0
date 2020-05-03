Return-Path: <SRS0=xEwV=6R=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17869C4725B
	for <linux-pm@archiver.kernel.org>; Sun,  3 May 2020 15:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2292071C
	for <linux-pm@archiver.kernel.org>; Sun,  3 May 2020 15:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="bRJdo6Ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgECPVT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 3 May 2020 11:21:19 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:43470 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbgECPVR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 May 2020 11:21:17 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49FV7b2wbnzJf;
        Sun,  3 May 2020 17:21:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588519275; bh=rwQPTtI5SrLLx7al4xEZLcCbcFpzh7q3OF29uJmCBXM=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=bRJdo6Ib3Hpm9fjQMuEmZBteOxSzjW+AlVOeHGGqX6CVdZpmsmCuU7qCPHRL6DR3b
         0+Gyn4nFKdeCgoQtJDkdMblMKEBbkuu6gf1zOyBXgY5JAQ9xl6WLvlD//EUcK0ML+5
         nrTTvhF7+mGvqxrrVIUISc+3kw6tk8wtueygHYAI/bu600tk34wazgrkXeUX8+YyHW
         QpUH7gqmUypvdIw/fIvEYTpiY1sz9BbyIV2DYnxyzKK6HfU7XtC4AF/o0eKaruVR69
         CMHfd04taneRHIaVRiZyCsroIBSp1EjGTeuVxFUC1eD/3Yrm1hIlS16TwTxlLqJxc9
         LYh9XDLwds9vA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sun, 03 May 2020 17:21:14 +0200
Message-Id: <2ec86a0c610f9d75e47ebd8a356be1b35d6ba910.1588517058.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588517058.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 11/11] power: bq25890: document IBAT compensation DT
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Document newly introduced IBAT compensation settings.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v2: initial version
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 Documentation/devicetree/bindings/power/supply/bq25890.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b/Documentation/devicetree/bindings/power/supply/bq25890.txt
index dc9c8f76e06c..bd214945d9dc 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
@@ -32,6 +32,10 @@ Optional properties:
 - ti,thermal-regulation-threshold: integer, temperature above which the charge
     current is lowered, to avoid overheating (in degrees Celsius). If omitted,
     the default setting will be used (120 degrees);
+- ti,ibatcomp-resistance: integer, value of a resistor in series with
+    the battery (in uOhm);
+- ti,ibatcomp-clamp-voltage: integer, maximum charging voltage adjustment due
+    to expected voltage drop on in-series resistor (in uV);
 
 Example:
 
-- 
2.20.1

