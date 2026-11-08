Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169366;
	b=ee3+M5WxkWNGd68gMjGSRYgmKlP6VEcm1zPaMIm9G0MsE+qRZEid66Lnzt+K8bYe6Lfs
	 nhEdRpzYeagkelFyMAjcSFiNP+0U7mTkCDBybGBVM1EtFuA99sxhmklW/qPhvIlW1Ewym
	 1Jg49kEvCzy0JMV8URUgEKbFC+fxGTHvh+2CT4VbQR0Z4tQBRW9co2jPm2hqo20UAzrl8
	 jv61H0Wnc+8HdaFvmQvLSjVfCofZX0k2V/Fs1JsSVH7T4Y7crw3nFv5k/hnzBXngsNOZI
	 A9zDjSISYsrlOTc5mtGy/KX23J2tq3imAeQSu2I8d/hr6bMRftOBpYAVW0YGu9WGpNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169366;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YpvmXan4lbBMaRPxIka8UXE77WvsxJ91tdRQfWX0O/k=;
	b=N3Od7d9v420V5Y3d+ysE3NP6Sn/YVSRbtI1wsYpUr5i9iUtIWlR0NjCPIgRV3i6yGvE3
	 ItP0wjdeLNV0TYZgCErgvGMq7lR5tAIoMueSywMMzQO+kLYnlEJoNYaeAbqiqQ5yCFT4y
	 RHdgRBHVYquwcbIn6dGEtLkKorGQR792Ot+xEKJJplC0GfPHvtmVYMlcRNSaTlHiG45Pq
	 w+hbU75pIN34+G+8htKjKPH1IosLaFLmWPaW0t9MqxDkFi6F2UtrLWQg3Cxa5cTObbtdS
	 a9YPfLYJFKRhA7l1SH3LsakgaL1gYPDje90WE6z8nILclU7XfJEjv+ILpRn7RFeSkPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PerGWQ6c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A955606B121;
	Sun,  8 Nov 2026 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PerGWQ6c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E021F008A3;
	Sun,  8 Nov 2026 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169366;
	bh=YpvmXan4lbBMaRPxIka8UXE77WvsxJ91tdRQfWX0O/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PerGWQ6cfPhU4g26hwZ/wCmdAxN4fYQu7aYlQSSylD1DhcxBB4tOhLOdblHXR7/v8
	 2a2xRsrTpLigpJ7aboomYvObTDCFXmhFS0Q1BolkHfoCJKxii2wm6H9pBBk9eZAlj1
	 bYtxrPorCA01PGrqEql52GChNY8B7WW7D0rg/Ex/WBhBBttbsFJdLbnhegS1fdfyZ7
	 ZBmq1/8Nek8stD9VdSvbDA3bboyO7/R5THnorDEpk2MfyE3hciCV79n0AfJzbcJede
	 5sncrHyTTJRyq+fhdAtM/le4wnEhH5x2mvKL2gpOr6Fd7wNOSuDBz/j7vUuTNHAzga
	 atJLuCs38rnKg==
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
Date: Sun,  8 Nov 2026 14:19:46 -0600
Message-ID: <179416929226.628393.17390672415084673437.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
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

[5/9] arm64: dts: qcom: kodiak: Enable CDSP & Modem cooling
      commit: aaef1df06a7b65778498801995997c42b7b33ee9
[6/9] arm64: dts: qcom: lemans: Enable CDSP cooling
      commit: 49b2314dc280fbb4b316676d83a0f03ea44b954e
[7/9] arm64: dts: qcom: talos: Enable CDSP cooling
      commit: 0ae7c4dd65f2b7fdab267eb021daec5fcde8cf34
[8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
      commit: 59e3a973584a8ff3d8867f352df092c796d3ee7c
[9/9] arm64: dts: qcom: hamoa: Enable CDSP cooling
      commit: 682fc950ce3daf460164be075e445e6ea66b40c9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
