Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B664C4320A
	for <linux-pm@archiver.kernel.org>; Sun,  1 Aug 2021 15:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7B4610A8
	for <linux-pm@archiver.kernel.org>; Sun,  1 Aug 2021 15:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhHAPZc (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 1 Aug 2021 11:25:32 -0400
Received: from mail-40140.protonmail.ch ([185.70.40.140]:39705 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhHAPZb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Aug 2021 11:25:31 -0400
Date:   Sun, 01 Aug 2021 15:25:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1627831521;
        bh=DlAaKUEEimKTCv4vo156aUl4/sao6sK0Mzn0cpFq5m8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=AICgycMXlI24QoAEnnmoL7+UPW79qEbXp81Ml6Wopr9oTwhYdaWkeFh8aVqzm0qyk
         mIQvHI6MTzO84PbOcyMAdN741TwbeyexK9HF+1W408V0IAoVn1qLJ1ZDU8+Ba3Iafp
         gl0YeRgFpf3pZDz2DMqPP5gtrQEgdlwpdILOjIcI=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH v2 3/6] dt-bindings: interconnect: Move SDM660 to a new RPM-QoS file
Message-ID: <20210801152427.475547-4-y.oudjana@protonmail.com>
In-Reply-To: <20210801152427.475547-1-y.oudjana@protonmail.com>
References: <20210801152427.475547-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Move SDM660 to a new shared file to allow for adding other similar SoCs.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 .../interconnect/{qcom,sdm660.yaml =3D> qcom,rpm-qos.yaml} | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/interconnect/{qcom,sdm660.yaml =
=3D> qcom,rpm-qos.yaml} (91%)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yam=
l b/Documentation/devicetree/bindings/interconnect/qcom,rpm-qos.yaml
similarity index 91%
rename from Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
rename to Documentation/devicetree/bindings/interconnect/qcom,rpm-qos.yaml
index 29de7807df54..ea80bd50fd50 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm-qos.yaml
@@ -1,17 +1,18 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/interconnect/qcom,sdm660.yaml#
+$id: http://devicetree.org/schemas/interconnect/qcom,rpm-qos.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
=20
-title: Qualcomm SDM660 Network-On-Chip interconnect
+title: Qualcomm RPM-QoS Network-On-Chip Interconnect
=20
 maintainers:
   - AngeloGioacchino Del Regno <kholk11@gmail.com>
=20
 description: |
-  The Qualcomm SDM660 interconnect providers support adjusting the
-  bandwidth requirements between the various NoC fabrics.
+  RPM-QoS interconnect providers support system bandwidth requirements thr=
ough
+  both the RPM processor and direct AP control. The provider is able to
+  communicate with the RPM through the RPM shared memory device.
=20
 properties:
   reg:
--=20
2.32.0


