Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CD3EB0F2;
	Fri, 11 Sep 2026 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093560; cv=none; b=W/5H0rX157/gyK2OgZONhGEGU6ETfjss+00k9ziEN6PBVrfP0ARz/7uNE87DahuljFoQ2EeHSxLclNgKdW8hb8KrG7FSTgcT65iT/MPLl5Mva5BeX1wwX/430P65MwdqeHdtlSikgVVw67sxcVATJ/LDELMiVEIyTikD0bKfIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093560; c=relaxed/simple;
	bh=+jp7NHtmx0KJMezZ8r8FNBTPRApkS/l6I9nsDcLuzwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWXJE/G1cKZbHwQ0/fZufChMmcn9j2r2VQpz9vOwJ/pQRjlOOjPsVoxOV9B/se3Da7nEsYSY5yRURYmlgB2BgNU1jVoDzfRJ917DFv0BGfk4SiEeUGbPe2RZFgtGbROU1tH47obut360WPoEVWRzva/p6+z5GHArmBkDpGhOpkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXmcJWPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXmcJWPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FA11F0089D;
	Fri, 11 Sep 2026 02:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093559;
	bh=V6gJ2io6CHbZV+in01bmVOivcND1h8Ntdr8b0UjzLrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PXmcJWPuqB09dI5WFH4TqhhcYaqNIF8hYst4Gnfo7DpAKjfSkchoYKUQdrvpzVWVR
	 HdD+qlQzeP3xyBw136cuPKmObfMEvtlEkh1uL1X9XJ5UApKS+IKymnsresD9zrugNN
	 WZDvaRv1Ghwq8ILWkREcibno363/XhJmLTdSbForq1X90SkmWig6fBRSFlR8qIdEER
	 8kMLjRirPoVtKpuIn0d46jNSvINm1DNfKHzHqqkM5LSWqHkiYnKVQ/lDi9hPs02nzo
	 RdbPUzZTXK3fIxVWQZqrXSwNl/CYxQ1sk+94Egw4zFvqoLdSM3/2jqfc3mHO/P2Sxo
	 XUUlJf4kJGkVA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Robert Marko <robimarko@gmail.com>,
	Guru Das Srinagesh <linux@gurudas.dev>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 00/15] Add initial support for Qualcomm Kuno SoC
Date: Thu, 10 Sep 2026 21:25:35 -0500
Message-ID: <178909353843.920241.15734171629938035637.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 27 Aug 2026 23:21:03 +0530, Hardeep Sharma wrote:
> This series adds initial support for the Qualcomm Kuno SoC and the Kuno
> IDP reference board.
> 
> Kuno is a 32-bit ARM (Cortex-A7) Qualcomm platform. This series brings up
> the essential SoC infrastructure required to boot to a serial console:
> 
>   - Global Clock Controller (GCC) and RPMh clock controller
>   - RPMh power domains
>   - Interconnect (NoC) provider
>   - TLMM pin controller
>   - PDC interrupt controller and SCM firmware interface
>   - Devicetree for the SoC and the Kuno IDP board
> 
> [...]

Applied, thanks!

[14/15] dt-bindings: arm: qcom: Document Kuno IDP board
        commit: e3fa925ca180aea34852e282211fea12501cb6c3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
