Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03CE58039A;
	Wed,  9 Sep 2026 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972123; cv=none; b=k9iIHcjkGHgSaAmzeX1q8QpAi4au01yunSq1J8hT53X6emK/kR06LTR26wyL5u7ZC5B6oyCOlVcPqndWdFBYEtlCooNbljAQvlVawB6CL9/kJxXslkZObz++Rxm9tAOiNYS/avnXTLTZDZPZVPap/JeflodLqgkWrcMNfP08DRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972123; c=relaxed/simple;
	bh=0KAFwP86LDVP5V9i9f8PlRhPdxwzISLUhwmjDGp6FKc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IqIMWAzjnK5HgiOqWn1y8DPmwxIfmUDkV+X3iLl8w1GXLD6fRBv8uUcLKO2563tl/Ifdys5sIqz6GY5LVr+X2x8cbWVn/yvpt0yXGjjqxf9Nvkz+mg0vBr+HaoAOcr28lHNFGq3fUttrLpAo8Zq+PUMvTcpTSxplgT8E9TTbF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvcTeGD1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvcTeGD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583141F000FF;
	Wed,  9 Sep 2026 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972121;
	bh=M1rKFcyb9VfWX6SJACZgh6ZxTcdbP2Yiddg3LyXcEgc=;
	h=From:Subject:Date:To:Cc;
	b=cvcTeGD1ZeP5HjiewLzapp8E+2rDDn1Z5O3ghNf6bp8izqHlYiPOkPpIExCIXR9YS
	 lqMTpz+iPLUlqFTVVlGjUKaEFdUIlBbke0yfeHVGz/TF3LfyYoW1KeT5NRBDq0qOeW
	 MZeUAO6dNyB3YpNlT1xDiEG+dI6GIErMXpsvQvIFjvy4+zaE4taJFEcqSxA1IKuM9k
	 o2npAYeevs6G5SxT/FAKKxZB5G9bcTGtICe7i4V3fz5yypoFvjsEPggkswBpJGuUyh
	 RKpLB64gfsdLy0CSHC6GEMQS/B8oaUf+n7ruKOCtNA6Z9cjxIeB1fylhBO76xNJyeT
	 eNGqCXZ7rtgSg==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/6] Assorted fixes for icc-rpm
Date: Wed, 09 Sep 2026 18:41:53 +0200
Message-Id: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrBuIodrqVUoJOpm2U9TEjIog3
 t3YLt/i/w2EIpNAnW0QaWFhPyTklwzw0wxvUuySwWhT6kpXavKBUTGijaG30js7+k5dC+OQ7jd
 ssYDUhkgvXn/fx/Nvmdsv4XTOYN8Pk1+iUnkAAAA=
X-Change-ID: 20260909-topic-icc_rpm_smd_qol-452dce87cbc5
To: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Adam Skladowski <a39.skl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788972117; l=1196;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=0KAFwP86LDVP5V9i9f8PlRhPdxwzISLUhwmjDGp6FKc=;
 b=pkv13Itd8MQMQ3456kwB3xndeuEVniwtn+NnBr6foC4i8chMbm8y1lhDDigmo/P34FyJ9ojyC
 /gjuIpiM0OlBKEnZsVxmeYaQKZhjdlF5xNV195GgIrn4/pU2JaNggZV
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

This series brings multi-port QoS programming and squashes some
minor existing issues. No dependencies.

Compile-tested only.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (6):
      interconnect: qcom: Move bcm_div() to common code
      interconnect: qcom: icc-rpm: Don't skip small votes
      interconnect: qcom: icc-rpm: Handle icc_link_create() failures
      interconnect: qcom: icc-rpm: Program SMD RPM auxiliary QoS ports
      interconnect: qcom: msm8996: Configure auxiliary Venus QoS port
      interconnect: qcom: msm8976: Configure auxiliary GPU QoS port

 drivers/interconnect/qcom/bcm-voter.c  |  21 ++-----
 drivers/interconnect/qcom/icc-common.h |   9 +++
 drivers/interconnect/qcom/icc-rpm.c    | 101 +++++++++++++++++++++++++++------
 drivers/interconnect/qcom/icc-rpm.h    |   2 +
 drivers/interconnect/qcom/msm8976.c    |   3 +-
 drivers/interconnect/qcom/msm8996.c    |   1 +
 6 files changed, 103 insertions(+), 34 deletions(-)
---
base-commit: 9d80aa4617b32f5054c5aa471d06b66704854935
change-id: 20260909-topic-icc_rpm_smd_qol-452dce87cbc5

Best regards,
--  
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

