Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6FFC43381
	for <linux-pm@archiver.kernel.org>; Tue, 22 Dec 2020 07:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE5523124
	for <linux-pm@archiver.kernel.org>; Tue, 22 Dec 2020 07:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgLVHcH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Dec 2020 02:32:07 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:54436 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgLVHcH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Dec 2020 02:32:07 -0500
Date:   Tue, 22 Dec 2020 07:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608622284;
        bh=zj7BLVma6bwTDbkNV2OP9sFWg/3xvXVUsybje3al6Cg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=r3C02VT9/wOS5O5ImAMG6zrfSVRoM5vFDZBuCezPuMsu6pdjTrzqkn2jDZK+uJHd1
         lZNL6nkOL/VUT00XD60ghn6SL7eXHl2N1RZACf5FTonRmdPBYWF9jQpJXHRmfJ99Yk
         uSDES7TeCE7GFRdoqK8+aMGckY/dVzkAatDTVCVk=
To:     Krzysztof Kozlowski <krzk@kernel.org>
From:   Timon Baetz <timon.baetz@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Timon Baetz <timon.baetz@protonmail.com>
Reply-To: Timon Baetz <timon.baetz@protonmail.com>
Subject: [PATCH v3 2/7] regulator: dt-bindings: Document max8997-pmic nodes
Message-ID: <20201222070520.710096-2-timon.baetz@protonmail.com>
In-Reply-To: <20201222070520.710096-1-timon.baetz@protonmail.com>
References: <20201222070520.710096-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add maxim,max8997-battery and maxim,max8997-muic optional nodes.

Signed-off-by: Timon Baetz <timon.baetz@protonmail.com>
---
 .../bindings/regulator/max8997-regulator.txt          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/max8997-regulator.=
txt b/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
index 6fe825b8ac1b..f969fc09fe29 100644
--- a/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/max8997-regulator.txt
@@ -53,6 +53,17 @@ Additional properties required if either of the optional=
 properties are used:
 - max8997,pmic-buck125-dvs-gpios: GPIO specifiers for three host gpio's us=
ed
   for dvs. The format of the gpio specifier depends in the gpio controller=
.
=20
+Optional nodes:
+- charger: Node for configuring the charger driver.
+  Required properties:
+  - compatible: "maxim,max8997-battery"
+  - extcon: extcon specifier for charging events
+  - charger-supply: regulator node for charging current
+
+- muic: Node used only by extcon consumers.
+  Required properties:
+  - compatible: "maxim,max8997-muic"
+
 Regulators: The regulators of max8997 that have to be instantiated should =
be
 included in a sub-node named 'regulators'. Regulator nodes included in thi=
s
 sub-node should be of the format as listed below.
--=20
2.25.1


