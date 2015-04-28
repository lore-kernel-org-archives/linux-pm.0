From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v19 0/3] ARM: qcom: cpuidle support for 8064, 8074, 8084
Date: Tue, 28 Apr 2015 14:32:32 -0500
Message-ID: <D3466AA5-C5E9-4A5E-9EA7-CDD3938A2CCA@codeaurora.org>
References: <1428607243-7723-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38139 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030588AbbD1Tch convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Apr 2015 15:32:37 -0400
In-Reply-To: <1428607243-7723-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: olof@lixom.net, arnd@arndb.de, daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org


> On Apr 9, 2015, at 2:20 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>=20
> Hi,
>=20
> This patchset adds acks and reviewed-by tags to the SPM driver and up=
dates the
> defconfig files to enable cpuidle support on the v18 rev of the patch=
set [1].
>=20
> The dependencies for these changes are
> - SCM and device tree changes for QCOM SoCs [2], [4].
> - cpuidle framework changes [3]
>=20
> Changes since v18:
> + Add commit tags to SPM driver
> + Update qcom_defconfig to enable cpuidle support
> + Update multi_v7_defconfig to enable cpuidle support
>=20
> Thanks,
> Lina
>=20
> [1]. http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March=
/333521.html
> [2]. https://lkml.org/lkml/2015/3/27/599
> [3]. https://lkml.org/lkml/2015/3/25/117
> [4]. https://lkml.org/lkml/2015/1/19/483
>=20
> Lina Iyer (3):
>  ARM: qcom: Add Subsystem Power Manager (SPM) driver
>  ARM: config: Update qcom_defconfig to enable cpuidle
>  ARM: config: multi_v7: Update to enable cpuidle for QCOM SoCs
>=20
> arch/arm/configs/multi_v7_defconfig |   2 +
> arch/arm/configs/qcom_defconfig     |   2 +
> drivers/soc/qcom/Kconfig            |   7 +
> drivers/soc/qcom/Makefile           |   1 +
> drivers/soc/qcom/spm.c              | 385 +++++++++++++++++++++++++++=
+++++++++
> 5 files changed, 397 insertions(+)
> create mode 100644 drivers/soc/qcom/spm.c

Applied.

I=E2=80=99ve updated the Kconfig to only be built on ARM32 for now.

- k

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project

