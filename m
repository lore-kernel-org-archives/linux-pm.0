Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168037C91E;
	Tue,  7 Jul 2026 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394530; cv=none; b=uOq7tBiPK51Rx68RtnfpqHH71uXquHN2abtTNXh04Fq4z2Hh/MRM91QPME4L3e83wsMC4cRWtkgU6ZOULpmc6mI9DUQ5f7xXrscV5C/q3PVxwI79yTsWb/LiMNsDOIhAGOQb9j89OFIp9N6kw/8VWIi8fB0p85LE1zb1+BzW7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394530; c=relaxed/simple;
	bh=W9p4hNOOLf8mGe1ZtENPDTQeNXj5KWhf4/+5s5yeaXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNHxy0YsDytTadirZTItKtSEdjsqfZoJmZdAn3WtOkj672ml4IZJLO9lyJIRUY2BJqu0105PMLmKNJxPk/O8TyT2Hx3BkuWrEytuihPxUt6aVwfuLMD1E0fei6wBeU8pd/eMM0goGB/hXeL/DLVTLuzoaOuXxEhX5h/oCsaLTvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiBlwugn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiBlwugn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D101F00A3D;
	Tue,  7 Jul 2026 03:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783394522;
	bh=vZwlutgfXIhP3JfSPnEATD6YUC9EW/RGVOREU5dLc/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KiBlwugn/4gIIESSPIpxrxjSbVZxxuF11zmeasYglJh9wLu8tjpOy6l1x4B3VSGG5
	 A3t9YSJnYbsZgcBrqYz7ByJEURPHJY8FZs7/aa+X1IzhQq6gV3AIru8CPGyWw4CZeF
	 eC4P4DQG2E27JLQ0dIekUfEkd4ufdLOaJAZUqM/oDpaDJoq6jcicKgr1Ceh6eektQF
	 YZFyOb5t8iG12zOFCqjZ/vzXmLvxl30b7f6eiWCmCdMPTcg4qJ8LkJ+KToKubZe5qR
	 TM5ljd70ZgEe4nwe11/iupr8wdKagdcJhGipJS/PQ147uUQ+5xQuwLVTtyzPkrFelF
	 iEl3C0ZJ+5sSw==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Xilin Wu <sophon@radxa.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Enable QoS configuration on SC8280XP
Date: Mon,  6 Jul 2026 22:21:36 -0500
Message-ID: <178339449906.1938770.13092252233496253130.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507-sc8280xp-qos-v1-0-15135858cd98@radxa.com>
References: <20260507-sc8280xp-qos-v1-0-15135858cd98@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 07 May 2026 22:25:11 +0800, Xilin Wu wrote:
> This series enables QoS configuration for QNOC type device which
> can be found on SC8280XP platform. It enables QoS configuration
> for master ports with predefined priority and urgency forwarding.
> This helps in prioritizing the traffic originating from different
> interconnect masters at NOC (Network On Chip).
> 
> The system may function normally without this feature. However,
> enabling QoS helps optimize latency and bandwidth across subsystems
> like CPU, GPU, and multimedia engines, which becomes important in
> high-throughput scenarios. This is a feature aimed at performance
> enhancement to improve system performance under concurrent workloads.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: sc8280xp: Add reg and clocks for QoS configuration
      commit: 204242d747e67e7483256fc927d0ab19a63a54d2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
