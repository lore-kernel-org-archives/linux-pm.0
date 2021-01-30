Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DBBC433DB
	for <linux-pm@archiver.kernel.org>; Sat, 30 Jan 2021 17:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3211164E09
	for <linux-pm@archiver.kernel.org>; Sat, 30 Jan 2021 17:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhA3R3j (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 30 Jan 2021 12:29:39 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:63779 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhA3R3j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Jan 2021 12:29:39 -0500
Date:   Sat, 30 Jan 2021 17:28:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1612027736;
        bh=6t41VqcyyZdCArTnBHxNv9rzmYfvAGRD55C9dQ+BKlw=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=JTjL5lKfGS5aBa3kvmy/TMq35P5jrzx+dAPapVglOwVByt+L2RtTdRV4hjenQ6F+8
         R2HtFKy2EWIkKdAzvrgWkkx4dnBHrIzjFSeBA8TM40DpqWu8C9GgsIp4xoyV1uipn4
         /XedgSD5qbPtTIt5+pqnbsFhJSuFLZp8Y0a55m5o=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH 0/3] charger-supply for max8997_charger
Message-ID: <20210130172747.2022977-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Based on the discussion from [0] add an optional DT property to retrieve
the regulator used for charging control in the max8997_charger driver.

[0] https://lore.kernel.org/lkml/20210118124505.GG4455@sirena.org.uk/


Timon Baetz (3):
  regulator: dt-bindings: Document charger-supply for max8997
  ARM: dts: exynos: Add charger supply for I9100
  power: supply: max8997_charger: Switch to new binding

 .../bindings/regulator/max8997-regulator.txt         |  1 +
 arch/arm/boot/dts/exynos4210-i9100.dts               |  2 ++
 drivers/power/supply/max8997_charger.c               | 12 ++++++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

--=20
2.25.1


