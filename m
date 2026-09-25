Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089354908A7;
	Fri, 25 Sep 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345923; cv=none; b=eRm939lBRKZtyMED/KXMA7ImN2BnE7VsN1v2WBUHsfWbvqdZgXOQEs+z1MaT/K63kRE5rKyVOR6hj6Z/3FP8iuzk6EgLOFimUQNCQDCNXqoi/gRJCKFBUBugbpUjg5AxO8eprdXKsO+4WqN4zl5Ry9mIICbPRlsWxTscRt52T10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345923; c=relaxed/simple;
	bh=O0UQlcpBePEhCtE60o4RB9ewz0ke7JOvuoOv6HWv36E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqZPTI+zQ8ZUVT/0HPeY+UpJn0dxDmmNJMWWAnIqaKiGXnc40i7tG/7l0KYCj1QZsEXyvgF1mKotlUe4F0mhNgs9PMdtxC/bamWoHFTt0BemE3lhEPkuVz6G5O9RgQaQCPwCish1QgTJSssEc4l5wiV++GwxWAoLC987t2A5C+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eftRXca8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eftRXca8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7642B1F00899;
	Fri, 25 Sep 2026 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790345921;
	bh=lfwbK6aQOk9FHQe0F0mk3C3hQbetkzcccmn4T4ffiAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eftRXca8xtBhE587iml/z29FSktAe7JYuF53Y224sbx+Rt8BUUYPtDLXRpFmCIXDx
	 xiJIjaDaj34GBdm3rQSCSMZFfvZjSsPm9ZQ6efPQHGvQtqnfQfGmfQqvxNdlRC3SAE
	 XDwvEqbCu2+wxv98uliQUd6g49Wqp9vpJ+nsix7Qihek/OZqOAIaZuUkBoRqbguU1q
	 zgJ+0VaIILgnADgAG8rrnhVbtayQG7MbnMknzPHjpMBJ1opbJevYcK8aUDWxFPPD5z
	 XVM6gpIxE84k1AqGu9OGk59r8iy9InuNxC2gHthmlc1JxqKBG6Qawohv8pjDqgkKPx
	 BsF9i4rXq+YOw==
From: Bjorn Andersson <andersson@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	manaf.pallikunhi@oss.qualcomm.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Casey Connolly <casey.connolly@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v8 0/9] Add support for Qualcomm remoteproc subsystem cooling
Date: Fri, 25 Sep 2026 09:18:31 -0500
Message-ID: <179034590772.712210.9030677461364721298.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 09 Aug 2026 17:58:56 +0530, Gaurav Kohli wrote:
> This series introduces Qualcomm Messaging Interface based Thermal
> Mitigation Device (QMI TMD) support to control thermal mitigation
> on remote subsystems such as the Modem and CDSP.
> 
> The QMI TMD is an interface that instructs a remote subsystem to adjust
> the performance level of the devices it manages, reducing power consumption
> in response to critically low battery charge, overcurrent alerts, or
> overheating conditions.
> 
> [...]

Applied, thanks!

[1/9] dt-bindings: remoteproc: qcom,pas: add #cooling-cells property
      commit: 1a61afc42cff8397cbc430666cf4ce9dec72e076
[2/9] soc: qcom: Add QMI TMD support for remote thermal mitigation
      commit: 2ff581c2185c3797fae2725537c7de1da3bc89fd
[3/9] remoteproc: qcom: pas: add support for TMD thermal cooling devices
      commit: 8eef721027127b7bd8ec06246bf1bbd975dc5f64
[4/9] remoteproc: qcom_q6v5_pas: enable QMI TMD cooling support
      commit: 586a2fadadb160295a93e5d5d32db1a2558a4d3f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
