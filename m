Return-Path: <SRS0=Pe0A=DD=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513B6C47425
	for <linux-pm@archiver.kernel.org>; Sat, 26 Sep 2020 19:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CEFE235F8
	for <linux-pm@archiver.kernel.org>; Sat, 26 Sep 2020 19:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="VR3M8UdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgIZTPV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 26 Sep 2020 15:15:21 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:51312 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbgIZTPU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 26 Sep 2020 15:15:20 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BzJC210pSz18;
        Sat, 26 Sep 2020 21:05:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1601147134; bh=i6GErGfH+UT41Llr031HN9MqOM80pBRiCXb/wqO7iKQ=;
        h=Date:From:Subject:To:Cc:From;
        b=VR3M8UdVC8FaxGAgq6IGf3dm6ilJIQwnWMSnpKo9en2np1zKJm654igWbl2Y/bYHX
         QmBTH8H3feCEGAtG+H+z3HILrqeSfO1UgS7ya915CpoK8iri5YiMXYv+O4JaP2M5sa
         jKKlsRehr1jxOOFz6/53Yy7OP1Mcte9m3yamq6rLPjRtPSW1ptbjkXeiQ8qENYbmlj
         7RYVlf9VzVgvkXR0k4W4XMXGHDn82BtRBN1+DCiAdTiZ3zEQi1dlXfYt5o2uZ9EGuO
         5E7gH4uqwc/04X3cehjnt4knoL6qMaVEZQWcN5z3vcH42nifgsClGI1iX/dgmJOqNK
         iGZinkS/lKFbw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 26 Sep 2020 21:05:31 +0200
Message-Id: <cover.1601146802.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 0/2] power: bq25890: IBAT compensation support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Angus Ainslie <angus@akkea.ca>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These two patches add support for IBAT compensation feature of bq2589x
chargers.

---
v4 fixed property names for the features and dropped other applied or rejected
   patches

Michał Mirosław (2):
  power: bq25890: document IBAT compensation DT properties
  power: bq25890: support IBAT compensation

 .../devicetree/bindings/power/supply/bq25890.txt  |  4 ++++
 drivers/power/supply/bq25890_charger.c            | 15 +++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.20.1

