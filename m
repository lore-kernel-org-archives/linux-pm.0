Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F7389DF3;
	Tue, 31 Mar 2026 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991069; cv=none; b=acdcd60Pil8X4ni2N+1MGn524ff+H7tnZ7DFbdxTyhKgWg1jg8LUmOkXYMY9vwmtgTmaRGsRNhFFbG7LF/M/X08cGJN7RdU5v9dyECkr9C/0BN/kfIP5GN9MJigLTZfUBItlXukO4v5xCKex0DPmeidUtOPfDsxTlAsOeWK3Sy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991069; c=relaxed/simple;
	bh=1AEdyvN2AGz9AWYdQGp5GG/ojE6U2E0V2GcjcPqLc/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqWDHcxmYBUATxJ5J3OwHaaYOmkRC/HX6wd5nLvJOEicbTZK7t4ZlwvNqyqGwX44CgwKT9AsxVZFpCMdUvQR+ZXwMhtqFqXpnqP/rgUZEihLpyCSANB6jfgq6ZJxUSdiXWl9sNuIHT9cebsacBJ+gxM73nWaKbPMBZ1NMLlKGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6NCaLa8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6NCaLa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB6FC19423;
	Tue, 31 Mar 2026 21:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774991069;
	bh=1AEdyvN2AGz9AWYdQGp5GG/ojE6U2E0V2GcjcPqLc/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6NCaLa8/eE0url9u9kVtAdj9KlYPNrl+HdngAVYmK2mLg6rIfmET1RpQPXHQa9TG
	 AMGtlMPJYuHvPNxy+5792LS9i0+ezQjAe5Bni68U3tY+AbedNkrO7M536P/ZRYSUVM
	 lLbvVYJBkvOkS/rGalEVekxro72h77ulm2zh+zGqO7x5kOcOeUlk60xfl+KtcLSdKK
	 rvJwUcC4OY+Qh6DiAz6dNVzjb9vyierp+ER5vHDffdEHcfeSinKVjNBH4a1bL94ByA
	 0RA2aDtW2BJqRgBuf4XU+JhEwtX7s+wARA062gmVwbgop5YvaXodxY2u9CUIRLH7Rw
	 vteMjp6XuLkyg==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Brian Masney <masneyb@onstation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brian Masney <bmasney@redhat.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/9] interconnect: qcom: let MSM8974 interconnect work again
Date: Tue, 31 Mar 2026 16:04:23 -0500
Message-ID: <177499105236.956796.3988363846970257522.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
References: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 24 Mar 2026 02:10:36 +0200, Dmitry Baryshkov wrote:
> Commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out interconnect bus
> clocks") moved control over several RPM resources from the clk-smd-rpm
> driver to the icc-rpm.c interconnect helpers. Most of the platforms were
> fixed before that commit or shortly after. However the MSM8974 was left
> as a foster child in broken state. Fix the loose ends and reenable
> interconnects on that platform.
> 
> [...]

Applied, thanks!

[9/9] ARM: dts: qcom: msm8974: Drop RPM bus clocks
      commit: 6453ad0865b68ab0de5873c1a8bb4addbbde5c19

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
