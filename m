Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF33303A04;
	Thu, 11 Jun 2026 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157094; cv=none; b=qGceQjDmvzq2FV/KcoTVOKpWJA7Pi+YnguvcZTzPn9gPB/+1OEUCkS76w1OP8oOXPlNbjEvw9isnOVkHUp1TVOdDrdGHoW7usM0l/peFLNpuRT8YZvdRoMeqQ28bzbfBKUMPgZZtyxgveWtwwZx85g5D0vshveyx9Fns/MDBTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157094; c=relaxed/simple;
	bh=BbzaiPfNSKeB/pFF7jjE+dqxsgeGOXI96TJl3aCeNZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LdMcdYM6NXfIDijvvx8Cz5qG9POzZxaebkOoQk8wOpqUO4yDPoFptYYHSF+7Wv/QYV3hO869Kexgw68D8oYOcPaWCF94D1fJ5J24SQviIfpiO1U1wa0M1NFlURevSpkcsBylc1e8MZUJgZRZL2vZzGF9DBWHFZUQXwK/73XI7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rn2lmac3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rn2lmac3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22FB1F00893;
	Thu, 11 Jun 2026 05:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781157093;
	bh=Ybypv8jY2JlamzMUpYTkKUAdHbHVgJc3GEzJSVi7uRI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Rn2lmac3Ntga93Vpxzm5OXWKKDp7lb5vKlvNe6GEdjCaAJppcBb2izK1coVC5neFz
	 ZqiiSG+auzTXz4zvnHp9i7PPF9G5P3Na8zeY+52zB+5MyXo/+Bmx2kSdGAmcSPJ1eA
	 SaYEG4M+yjLhQW2cE9wrnvGge4TZgm08v2NbsDFoZEuby//hWtIYE63tDO9lvK4blb
	 jJoOlNb9WtJfPN2T+NuFbL0ppjMor4drFBpmOnrFN8HaMxOyhzEAk8z4lEWbXA2EMs
	 kBjQprb/3Te8Xka26TNVEy0x1hBgLYTe+6UkHxgU5lVC5WQPMOq1QezGTZ2uDsHmyp
	 5cDlzcgReLqIA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xueyao An <xueyao.an@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>, 
 Imran Shaik <imran.shaik@oss.qualcomm.com>, 
 Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>, 
 Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>, 
 Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>, 
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, 
 Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>, 
 Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 00/10] arm64: dts: qcom: Extend Shikra
 device tree with peripheral and subsystem support
Message-Id: <178115708647.468137.15343207918116447303.b4-ty@kernel.org>
Date: Thu, 11 Jun 2026 11:21:26 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 08 Jun 2026 18:40:20 +0530, Komal Bajaj wrote:
> Extend Shikra DT with peripheral and subsystem support across all SoM
> variants (CQ2390M, CQ2390S, IQ2390S) and their EVK boards.
> 
> The series adds:
> 
> - QUPv3 serial engine configuration
> - cpufreq-hw node for hardware-assisted CPU frequency scaling
> - DDR bandwidth monitor (BWMONv5) nodes with OPP tables for dynamic
>   DDR frequency scaling
> - EPSS L3 interconnect provider node for L3 cache frequency scaling
> - CPU OPP tables to drive DDR and L3 scaling per frequency domain
> - SMP2P nodes for CDSP, modem and LMCU inter-processor signalling
> - Remoteproc PAS nodes for CDSP, LPAICP and MPSS subsystems
> - TSENS instance with 14 thermal sensors and thermal zone definitions
> - Bluetooth (WCN3988) node with board-specific regulator supplies on
>   all three EVK variants
> - WiFi node in the SoC DTSI with board-specific power supply and
>   calibration variant selection on all three EVK variants
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: dma: qcom,gpi: Document GPI DMA engine for Shikra SoC
        commit: 0fbf772fabe93b52f1ecd9ea193dbc90a6042c4d

Best regards,
-- 
~Vinod


