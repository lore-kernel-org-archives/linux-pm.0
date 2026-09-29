Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FB42586F;
	Tue, 29 Sep 2026 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651768; cv=none; b=l2MYzmj9k+nvIhrnbfoHQs/FLqeNujHIEVBxh+mhGcXF0o4cAYF4HpCUP0OLYMXeFeeSOfMyOFq+JYD1ugVxiyxCBa7AwBVWbwkM8dsoIZFJvY+zwoLc6KlMDmhSrtE0Tu+WlLDkuzF3qdZoiKqtIuEaNiCHmNwhBEDoi20U3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651768; c=relaxed/simple;
	bh=oBgbWYgC+ZBrzhObpkva32WpKuS+aOXGzbQIzF9hqDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q40QCUJHUY29E57LOtPx8BcZVMRmwrjJjbc/9LcPrXgv3WL6SnF8CqxNgWAZQXDvJjWdZYjRRX5n4WkTrLmcKcMAR5vCuh6poW2aSIf5wAIb+xMiCTNHyIybVhLgR78H14e7cMWCVxhIj3IkU7xdWkNKhK4BLFJCkv7ohj4s248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLMiskN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLMiskN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C18B1F00893;
	Tue, 29 Sep 2026 03:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790651757;
	bh=hiGyuLuD6AP0jRy/rb60HA1xE5OCWcCwSzuvDIKtN+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MLMiskN5g/jvHVk8MTXA2yjPMOz5retjmKaqAPfT4AG+NtOLcTMKMo4MoIWRTXqDy
	 wgX6ZxGRPh+jSyj5kf+3hGWEgzGgT0XU8Y+j/NPOnzWo+DzUZMRxkn+VIx9gX4ty/m
	 ZceiNOanCZ16JAVpLjQSrOSOeLg42itt3Ovq8XU0ekmqkt8JxVWVYuC8i2vibJNkDL
	 Xixmyn9KQBqDOeWJmmckWN1gYC3+kEWjrlcIQIYFy3REpha2xUDuNdzYGb/oYEXiua
	 zCZCiZhabyoea/j/QIEI8yMNUaxSwpgwVPQPHK95wdAJyy2kY770Lf2IyUN8qfT0J9
	 ocrdqss+MJLUg==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/3] Enable icc-clk support for Qualcomm IPQ9650
Date: Mon, 28 Sep 2026 22:14:52 -0500
Message-ID: <179065171040.2673486.723562378764431827.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-ipq9650_icc-v2-0-55b8efbd62c6@oss.qualcomm.com>
References: <20260811-ipq9650_icc-v2-0-55b8efbd62c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 11 Aug 2026 21:23:07 +0530, Kathiravan Thirumoorthy wrote:
> On Qualcomm IPQ9650 platform the interconnect busses don't have separate
> RPM / RPMh controls. Instead they require direct votes through the GCC.
> To unify hardware descriptions (and software interfaces) between this
> platform and other Qualcomm platforms, make GCC export corresponding NoC
> clocks as interconnects.
> 
> Add the necessary bindings and the drivers changes for the same.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: ipq9650: add interconnect-cells to GCC node
      commit: 5187d5790a7945362ca8133b937c0af8b770542e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
