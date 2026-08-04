Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36D3F9F47;
	Tue,  4 Aug 2026 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882683; cv=none; b=vF3e6Z+QcOI5knh29CEU1EBHmvD6SxI9d2e2tFJ6d5DF9UuD+uXWMuYi1JnSBBr2dLfZ5EasbYhBkxvHXnt64Cby0PLi8sebVQiozVhBHu526h5g7Lj2d4q+ZNnMzC/SPF3fFMuc8hY5UpE7twvcTa+kUsavboOp73TX8ZgN5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882683; c=relaxed/simple;
	bh=YClK8w2ddOCRhbRTKpgdcjmlzfdwqAVCTh1EnsuSpKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxZ7YBhW01YvlkB+t9Q5Opv5+StLwvl1Qts5LkAx14iqrh8iO7oteTZ53ARczJ01+xGb4rijUKXe/14kjaHcFluhUFUqNaahfc89jPpIQm3i/h1qHHdSZ4b3+9+TN/MXNtBdtrfCDwxFD+Xt7tW6M5pESTLxLlppBW16MXGPBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMKgdHuz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMKgdHuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF1D1F00A3E;
	Tue,  4 Aug 2026 22:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785882682;
	bh=dm+GDMzy5rC5/4YaHPACBKvLe2xFBsn5xErC1xUtibw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iMKgdHuzOYsXDmNSog44DF3Up4tjVkQlAE5rkCW8fPveXM6adsSbNDawF5OftcpqS
	 7aJ8DHS8wNseMsZLTE+CVwYOUfuDWvtxK0w/v3rmnVeSRMkoY/j94ORHDbDzW1cLzt
	 y3McXvS/2PMWi6oZ5eTilQFPhpczy7D5VRcWqHj5ebdW4GYpGaf0B6MXe+lLUSqY+f
	 MpiwoDM+SHeu6glCiMXt5nm/9EAV64wD4ufj2UPIQZgWlltnAgOj6sxqqH/XKf37S3
	 tdSnYSDtwpK+V8xotfP+eT5PrvGY1/tLNAIEZumFtQnOrAgNMatolVwGTKnmzVQlA2
	 svYOjI4dDgkrA==
From: Bjorn Andersson <andersson@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Xueyao An <xueyao.an@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Aastha Pandey <aastha.pandey@oss.qualcomm.com>,
	Imran Shaik <imran.shaik@oss.qualcomm.com>,
	Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
	Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
	Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
	Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
	Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
	Anurag Pateriya <apateriy@qti.qualcomm.com>
Subject: Re: [PATCH RESEND v7 00/10] arm64: dts: qcom: Extend Shikra device tree with peripheral and subsystem support
Date: Tue,  4 Aug 2026 17:31:14 -0500
Message-ID: <178588267255.451855.5021676183503443360.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
References: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 03 Aug 2026 16:56:29 +0530, Komal Bajaj wrote:
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
> - Gpio-reserved-ranges to tlmm to mark GPIOs used by the SoC
>   internally and not available for general use
> 
> [...]

Applied, thanks!

[01/10] arm64: dts: qcom: Add QUPv3 configuration for Shikra
        commit: 3e6a70436d363dec92b3e6c089ab3d2d5f11d8b9
[02/10] arm64: dts: qcom: shikra: Add DDR BWMON support
        commit: 9e5bbfecb523aef0d01241b13d705ca8a48d7d7d
[03/10] arm64: dts: qcom: shikra: Add cpufreq-hw, EPSS L3 interconnect and OPP tables
        commit: aadafe002c9836da43a890f3bcba0a7ab8a69a1e
[04/10] arm64: dts: qcom: shikra: Add SMP2P nodes
        commit: 4a0123734f43acef97cf4e7e05ec33f530e2dbe5
[05/10] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS remoteproc PAS nodes
        commit: 8b6f81f7801a44c0ad141c3bda5537daa5611993
[06/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP and MPSS on EVK boards
        commit: 1db66deb4af8c4121172dfd13aff4cabfacf4534
[07/10] arm64: dts: qcom: shikra: Enable TSENS and thermal zones
        commit: adf87a37cfc9bbdcac4951bdccfb258a1a44ac0f
[08/10] arm64: dts: qcom: shikra: add WiFi node support
        commit: a04957d5ef041059d26fabe8d1a754e6c408fe2a
[09/10] arm64: dts: qcom: shikra: Enable WiFi/BT on SoMs
        commit: 320670a802179ac0851f010f78053da0731c6da8
[10/10] arm64: dts: qcom: shikra: Add gpio-reserved-ranges to tlmm
        commit: 779aead2dace11c7a514c0b94f87c0f2dcf59ca3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
