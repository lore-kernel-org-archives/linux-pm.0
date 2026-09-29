Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405A427F84;
	Tue, 29 Sep 2026 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651780; cv=none; b=PFkYtVsG6ZAADB1jAoq9/pSQ8y12TycMQmQvkCYzqX85lmVl0A61gnMLHakTXUKI76JeLZYPvOscGKpSBhTJkZyiKUd8GOlzPmvjKAa9FEywCf0Tfl63DySk9dQLE2XX8j5FcVHctyYpXgQ9QGUCstSYMmT5NMIzBs0Z/GVVq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651780; c=relaxed/simple;
	bh=l+N/vDOeKcNCoZOMpLX6skSt6hoikWyX7uLDqIYxIH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzRJudFuOoKO+cjASsXXfKmDUysftBcpap2qVDw7hUVnPR/7jWaC1JtA8JrxSB3vt9fUdI1+TMnNzT8ZkkL+XmqDvcYZpOYC94VtYfEFH6nv/vpIlX28GVX0+mPTA3B8KvmbK/yeIMGd589W8OGH4VYE2inGA/8SjRU4/6UbeUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLFc2JEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLFc2JEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FCA1F008A1;
	Tue, 29 Sep 2026 03:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790651773;
	bh=wb+0ESFR8alxA0WO3G+yUOYEjeoG719jm+oHpFJ5vxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cLFc2JEcxrNgIM/MRN92bWVM15PKbPLYH6NQFx5jCJw9u0aoBmjJHqQPRnFt790fP
	 SguGMeBAgKSXQWdxHBZ3wZKhxpI/nfpsp2EGU0JJMT/H/4dMOoQhH5i8ioDG9dQwyh
	 dZd4W96L/RV1JpPfIa0MJe6/bOSPg2+wwUO/SzNRFTMH9DLx2iIPkAxRJVj7LBEjp4
	 RccolTYoA2WTaDGaWsPaJ31ZnqSWn8E/AexSPuYYe5YPz+HvmumRcUpNOIaNbcjnfJ
	 nl3TQXk1TXMYw9IDttCYqLBWoX3aIHTfLRO4gMAUhE6qx75Tl/4vAXRlfs2cT1Fx8J
	 lxmuNUrrAabjQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Alexander Koskovich <akoskovich@pm.me>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/2] Add Milos CPU OPP table for DDR & L3 bandwidth scaling
Date: Mon, 28 Sep 2026 22:15:06 -0500
Message-ID: <179065170992.2673486.12226626252314405778.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717-milos-cpu-opp-v2-0-428813fafd52@fairphone.com>
References: <20260717-milos-cpu-opp-v2-0-428813fafd52@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 17 Jul 2026 15:33:02 +0200, Luca Weiss wrote:
> Add a node for the OSM L3 on the Milos SoC and define the CPU OPP tables
> to scale DDR & L3 bandwidths when CPU cores change frequency.
> 
> Tested with 7zip benchmark ("7z b") and membw [0] showing very close
> results compared to disabling .sync_state and thus keeping all
> interconnect bandwidths on maximum vote.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: milos: add CPU OPP table with DDR & L3 bandwidths
      commit: 99f8d632f69ce29d5cd1326439f03d5a53373600

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
