Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424A31E840;
	Sat, 21 Mar 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098994; cv=none; b=hSF8F6Lr8zebuwkAqDFJG6zBLNbfP5X/9jlOuyWDHSsAXGFqwde/BvPdHtW/FECWLGuSSfAK8JnLnz0FSWtHQbjnLEvI2Fg1nOC9t6NixI79G1pmBc5y3/GYbptEUl2BDY/GEiMfiOKdMcfi7nCWdrxOVvKTBhf0ICUjvBro7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098994; c=relaxed/simple;
	bh=CLnvewI/UfShz9G/65NIDvFFZFc0qemSPFVOjcA29Ac=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=iKV2KgHkYaQG8IcjthfsDCO7QqSkZeHYQCJJ9rVxdSLpKw85Bw17eWL3TaqjQMVngFxE7ugE+X/u/gRqcASiYNpolXtETPl7P5bOxOM9982wletPsqL32pu5+ZEj+GXqYGDWhNEUIbJ4D9Cdqu1lQZJug+TdjeUFPG5xbOPU4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iunsJL60; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iunsJL60"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BB2C2BCAF;
	Sat, 21 Mar 2026 13:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774098993;
	bh=CLnvewI/UfShz9G/65NIDvFFZFc0qemSPFVOjcA29Ac=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=iunsJL60pOXWPS1F7Z9YnJog5xQgRuR36yPleSJPbtaXbe5nFXlDEf8pYvvtApQJR
	 dZVbxGl6ZuElLd4BEXp+ZZVpFvLnXRP4p08p3knIMGA7c7dlu/r8/+ovgHsLny1qNl
	 BZtMxw3xqekFL4Cqx1s+BOSFmHqNTuAWEPB2xAtoNav6t3uFMMRstXCWoHbuj7xkra
	 fpDP21zXVqQWWCHNjUNiNZNWvQUTkEN4I/ZcfeShgTqIg73dTpZWl2o3nDjS2qPLD7
	 drDuHadaYp/r6m8x91+U28S6mQbOCugrv2iG3MRf7bfqzK9jBuA+3PAlM5GNggbdcx
	 /oEVNsXu2O/Cw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 07/10] pmdomain: samsung: add support for
 google,gs101-pd
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260318-gs101-pd-v8-7-241523460b10@linaro.org>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
 <20260318-gs101-pd-v8-7-241523460b10@linaro.org>
Date: Sat, 21 Mar 2026 14:16:13 +0100
Message-Id: <177409897341.266364.10743294916208405425.b4-review@b4>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=827; i=krzk@kernel.org;
 h=from:subject:message-id; bh=CLnvewI/UfShz9G/65NIDvFFZFc0qemSPFVOjcA29Ac=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpvpokvp7iuzqKQjPC3U8ReUlnCbYDhIr2Pci2e
 dH3QvGRe8SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCab6aJAAKCRDBN2bmhouD
 12LSD/0erKmpqy6MvhFhp80A6FNcSTw6aDLtQmKbwjznfNdh3RPxFBquhBPIX9pGRqNznNTOXLE
 TpQnZzjVeTO/rK20UQTjbw0DDwsyY+vfbaG0Yj3OVqt82cX8RxvEg/EiOrUXHtWfFpi/1E7czaV
 qpT7rtdsGCPIjv7QEarORGBW2pwTJQb/IaR+20TqdR1OE4oVd0jp3QKd2Wnvv1ifEN+WWcFWvvI
 Fffy1Sh1nvAQKBCKghf0n0XCmhRjFdRYSPP5AgobHOcfY7oWKa5NVY0eJ9ywoACA4k/WLcl+X8n
 AZjYGU2xS9Vx6DWq7GGh7JDbo+Mz3UdpJdVqFBx6nb9D2CPcX4AIvxX2UFqUEE6dtwZ9h+qSU72
 Z56e8CEKK9E1RvjGyZx8DjgNMITGEPGMvKbddoee9YfOL00IbbdhXTC7PGHS7FagBpWQejZ6OWH
 09c0SyFq43mojYVGVdr7/MiYcqeOZnbU8/NDCsvt+mG0vwMYEFCAzdMKTVnfBBy583KaLBYM1Dt
 zIbxH6s3VCssht/hUDtx4AIvaj+FWz962wV4V7OYMqDDN54o+SQap6UVqX9VFrIwkR34fbNBl50
 QSf+eN4lJ3SqlTbq+YYtcHvNSO+vaKa+R3B7TkId1moMKxL07ckwxOEWseH5V4Fl3CyAnRqes9H
 zzgSj/O8HuzIrgQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

On Wed, 18 Mar 2026 15:27:52 +0000, André Draszik <andre.draszik@linaro.org> wrote:
> On Google gs101, direct mmio register access to the PMU registers
> doesn't work and access must happen via a regmap created by the PMU
> driver instead.
> 
> Add a flag to the device match data to denote this case, and obtain
> the regmap using the parent node in DT if true, while keeping to use
> the traditional direct mmio regmap otherwise.
> 
> Additionally, the status is just one bit on gs101.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

There are few reviews from Sashiko which seem legitimate. Please check
them. If they are false positives, just reply that you carefully went
through them.

-- 
Krzysztof Kozlowski <krzk@kernel.org>
