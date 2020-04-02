Return-Path: <SRS0=3neH=5S=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E08CC43331
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F110520784
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="SG60aV3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbgDBO6c (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:58:32 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:34283 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388781AbgDBO6c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:32 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5d74hQz9j;
        Thu,  2 Apr 2020 16:58:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839510; bh=mhzH+hs9VaIQNtzqoeiD4OEdNou6DjDUexIsXN1p4N4=;
        h=Date:From:Subject:To:Cc:From;
        b=SG60aV3ALJHzHpCditgd8BB4fbR/C5GdN9sfO7m1ovjcE7p7iHHdaem/lx/mfDNki
         oF3ppN6w9U28aCGuYJdLm1GjodP4VCeqdqibIlOx4chQLKW2ivb9Yb0Lo+ThYhEDQ1
         7/TxaEQBtiOqsFuVw7BdSSPeGbDEinRZ8ER5GGHiFZyOKWwNXIxMF6zk0z91ommQ50
         S7zSgl6eqEIXASuiifPXbgpFiAMn/TZdRxz5YWxnOfQG8eyub2odtht6jqOVtrhDAj
         /SZjM7fgtX2KE6VaiCGjon3IjO0YdSo9OF2RmB8i+/4SqbyaoF+SBLXj4Yg4PLrg2C
         0xyHMyTbcjFZg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:29 +0200
Message-Id: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 00/14] power: supply: bq25890: fix and extend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series consists of a set of fixes and enchancements to bq25890
driver. This is tested on a board using bq25896 as battery controller.

Patches 1-6 are fixes and cleanups, patches 7-14 update and extend
property support.

Series depends on core extensions from earlier series [1].

[1] https://lore.kernel.org/linux-pm/cover.1585837575.git.mirq-linux@rere.qmqm.pl/

Michał Mirosław (14):
  power: supply: bq25890: remove redundant I2C bus check
  power: supply: bq25890: simplify chip name property getter
  power: supply: bq25890: make property table const
  power: supply: bq25890: protect view of the chip's state
  power: supply: bq25890: fix ADC mode configuration
  power: supply: bq25890: update state on property read
  power: supply: bq25890: implement CHARGE_TYPE property
  power: supply: bq25890: implement PRECHARGE_CURRENT property
  power: supply: bq25890: implement INPUT_CURRENT_LIMIT property
  power: supply: bq25890: use proper CURRENT_NOW property for I_BAT
  power: supply: bq25890: show measured VBUS
  power: supply: bq25890: show VSYS as output voltage
  power: supply: bq25890: show VBAT as VOLTAGE_NOW
  power: supply: bq25890: support IBAT compensation

 drivers/power/supply/bq25890_charger.c | 261 +++++++++++++++----------
 1 file changed, 154 insertions(+), 107 deletions(-)

-- 
2.20.1

