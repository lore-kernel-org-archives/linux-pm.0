Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B6EC433C1
	for <linux-pm@archiver.kernel.org>; Mon, 29 Mar 2021 14:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D4661959
	for <linux-pm@archiver.kernel.org>; Mon, 29 Mar 2021 14:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhC2OiF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 29 Mar 2021 10:38:05 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:19753 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhC2Ohx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 10:37:53 -0400
Date:   Mon, 29 Mar 2021 14:37:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1617028671;
        bh=ZhhhXbujQTU3L7Fi2UVY1TCHQor+eNnrE0NgE91kYmo=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=nL0rkbfa+n2tPMLJKYa47Th7agV8NCmksjKHJ+eS+NjIfjO0+25IFXXVoWu/gEUef
         FKPvVg61VlLfmjBvEArGrscTs0t04GTGpLe3bR9dft050IxqipwrMZH5EgqeKXTxKs
         RIdDl67CaM3G2kljpe76bRg84GrTcYF2sJdSML2k=
To:     Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH v2 0/1] charger-supply for max8997_charger
Message-ID: <20210329143715.806981-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Based on the discussion from [0] add an optional DT property to retrieve
the regulator used for charging control in the max8997_charger driver.

[0] https://lore.kernel.org/lkml/20210118124505.GG4455@sirena.org.uk/

Changes in v2:

* drop accepted patches

Timon Baetz (1):
  power: supply: max8997_charger: Switch to new binding

 drivers/power/supply/max8997_charger.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--
2.25.1


