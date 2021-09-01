Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415D9C4320E
	for <linux-pm@archiver.kernel.org>; Wed,  1 Sep 2021 12:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BDE261056
	for <linux-pm@archiver.kernel.org>; Wed,  1 Sep 2021 12:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243982AbhIAMRA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:17:00 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:40001 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243981AbhIAMQ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 08:16:59 -0400
Date:   Wed, 01 Sep 2021 12:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630498559;
        bh=dRoyhfnVNodGny7+/CMR/XiTx1YCPaGARCjlTzQC/j8=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=WME4xoblxy100bfiC2U/LACbKCBORGhywNVRpzNtxkE0Fka5dh1r8DTsfE2AiWCzM
         jm5vA+1gubWfgYMzlx+YoJuKibC7nzTgbu1itjKpbzRlycOftZ4TzxTlVlZcQcrTvX
         FXQHF+BKiop43v+qm1QIDrHtPc66cNyqeJyEX2Tc=
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
Subject: [PATCH v4 0/5] interconnect: qcom: Add MSM8996 interconnect driver
Message-ID: <20210901121518.152481-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds a driver for interconnects on MSM8996. This fixes some rar=
e display underflows
and provides a slight heat reduction.

The driver currently supports all NoCs on MSM8996 except a0noc, due to some=
 issues with writing
to its registers.

Changes since v3:
 - Expand DEFINE_QNODE macros in msm8996.c.
 - Commonize probe function.
 - Don't rename qcom_icc_set in icc-rpmh since it's no longer needed.
 - Code style fixes.
Changes since v2:
 - Dual-license qcom,msm8996.h and move it to the dt bindings patch
 - Remove interconnect paths from CPUs since cpufreq driver doesn't support=
 icc scaling yet.
Changes since v1:
 - Split first patch into 2 patches, one for renaming qcom_icc_set in icc-r=
pmh, and another
   one for the actual commonization.
 - Revert unnecessary move of include line in sdm660.c=20

Yassine Oudjana (5):
  interconnect: qcom: sdm660: Commonize RPM-QoS
  dt-bindings: interconnect: Move SDM660 to a new RPM-QoS file
  dt-bindings: interconnect: Add Qualcomm MSM8996 DT bindings
  interconnect: qcom: Add MSM8996 interconnect provider driver
  arm64: dts: qcom: msm8996: Add interconnect support

 .../{qcom,sdm660.yaml =3D> qcom,rpm-qos.yaml}   |   23 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   80 +
 drivers/interconnect/qcom/Kconfig             |   14 +-
 drivers/interconnect/qcom/Makefile            |    4 +
 drivers/interconnect/qcom/icc-rpm-qos.c       |  358 +++
 drivers/interconnect/qcom/icc-rpm-qos.h       |  135 +
 drivers/interconnect/qcom/msm8996.c           | 2781 +++++++++++++++++
 drivers/interconnect/qcom/msm8996.h           |  149 +
 drivers/interconnect/qcom/sdm660.c            |  487 +--
 .../dt-bindings/interconnect/qcom,msm8996.h   |  163 +
 10 files changed, 3725 insertions(+), 469 deletions(-)
 rename Documentation/devicetree/bindings/interconnect/{qcom,sdm660.yaml =
=3D> qcom,rpm-qos.yaml} (82%)
 create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.c
 create mode 100644 drivers/interconnect/qcom/icc-rpm-qos.h
 create mode 100644 drivers/interconnect/qcom/msm8996.c
 create mode 100644 drivers/interconnect/qcom/msm8996.h
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996.h

--=20
2.33.0


