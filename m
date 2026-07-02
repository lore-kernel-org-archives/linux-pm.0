Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA33D891C;
	Thu,  2 Jul 2026 23:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783035665; cv=none; b=WXdDFI2z2nwRhZEVXbemjIRVgejRS6Qo7zFiPpTxQNe9CFnjlp9AY5psc+Jo9WCfhYrIrOD/F+OBW0xEoDTu0cHKDsHHGMQ+Nle85nx0xD+xsyU79V8uvg794P8a3W1MF9XXJjPuh9JrMAO22qhQZtmoKcry0mBJsb0vuXF8lMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783035665; c=relaxed/simple;
	bh=8v4h1oySH2NlfgpyXoZBYa2xYhPftXP46g2H4yRh6iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZLNG+cCjQbct5k6LhH+i9BG1UQs9E4TRVxSei0ceEI9bmgNXWmm96jbAfJhwce96/D/lazDIVlO2EGWpiDfrIK9oiBF5ofnK8kzyDI0mn8sVwVm6dNCFV8mv99Lw6AGMuLPtbZ3XjVYAjyRtUpQeurYIeekAb1zLqctmXf6Jb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbkFDYIi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbkFDYIi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36171F00A3F;
	Thu,  2 Jul 2026 23:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783035664;
	bh=tx50Jo+oypciw9AZuwdBGLDGaNgIJ1uib/avA6kEPzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BbkFDYIibW4grYuW8449YHsbED+pfXLzOmbNjuyRAHRFfD9z+VQfMJumsw5xqLOEb
	 CITA91CPx6gOvtfI3Cv/50W4XdjnywvQXDIjR1kMLLf7AxTdwyAvVRJOiz9NQQsnu1
	 F4vnIUZXI/N30ef2oF8dBTQObVil7HcAtkrmYyxLb9odzr1p06Dbphf5BhdYwdlTKf
	 ThPyxaUhEADUHnuU/glKMy9wnSFARfgqlYGIK5hTES75p4dH87O8ed/KOIUWiZ3mOv
	 z4WW48pY4TNruwyqIUQZIX6qBY7JLAY8MBjxlaOfubSHwFG/4v1hzv0WhM12QN6rNy
	 FKk3gjQpZ/RjA==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Mike Tipton <mike.tipton@oss.qualcomm.com>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/5] Support enabling interconnect path for GDSC for fixing Milos camcc
Date: Thu,  2 Jul 2026 18:40:38 -0500
Message-ID: <178303563646.359079.12260993925943817423.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501-milos-camcc-icc-v2-0-bb83c1256cc3@fairphone.com>
References: <20260501-milos-camcc-icc-v2-0-bb83c1256cc3@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 01 May 2026 11:18:28 +0200, Luca Weiss wrote:
> Some power domains like CAMSS_TOP_GDSC requires the enablement of the
> multimedia NoC on newer SoCs like Milos.
> 
> Add support for getting an interconnect path as specified in the SoC
> clock driver, and enabling/disabling that interconnect path when the
> GDSC is being enabled/disabled.
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: qcom: milos: Add interconnects to camcc
      commit: 9d6a63012fcc3ff9152d802aeaea7d3a5a839e02

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
