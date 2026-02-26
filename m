Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0875F421F1B;
	Thu, 26 Feb 2026 15:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118735; cv=none; b=X/yzHAfj6L1j4Tf+zLWZQTl5VXngA1u0Qm7/XO2mU8akosVSN10Kz5Z7l0aVwS3r6Nj7bXP4U/Omvyh8T0I/UCi+zUHMB3abaS6ljqbxtyhjHEYOo8ZgdAfudhjUzYP5T/5NhkBwCM/kCUv6F/4v6JlzlZXisNpUKO0lpLFYLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118735; c=relaxed/simple;
	bh=+zqqV27s6Sh3LoSSYhuGrseLEVImuAYSJmpSc2rq93I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BIe/yPWDymUOMNIfHjdEcfUZNV9gcSZ6XA9ZG7pvsj4yOVpueoQdJDw1VjhUFGpaBRjGwGoiQbHq73obfMCt5YR8DmZK+fo951QpSNNQFgRBX+iDisj+z1mVW/EuEY4o9a+UIBoAf29N+MZM/l4b+9r/lFY4ZnLnIhYOBpNgDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpZd19KP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpZd19KP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D059C19424;
	Thu, 26 Feb 2026 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772118734;
	bh=+zqqV27s6Sh3LoSSYhuGrseLEVImuAYSJmpSc2rq93I=;
	h=From:To:Cc:Subject:Date:From;
	b=JpZd19KPsLgGS/LPs3lsQTmJ/PEz4ePofrR/kgtgyKaULwgzvwJAwo6KtT3qo3CHf
	 ZP4wPD0dS7IripSbl8HrpTFlolMP3jYcIlRDc4flblwR/sU4Sx84d7xCi76/9mJ6sg
	 8jw+A8zbbtv5hqx5GmPSPGXNBcJz9vtiVkV7JaSCcQ6fPagRIPnsOB0pubA0tjTXQe
	 +BuXFyjbydA13dU9Xs2yiQmOtwg+WH6YTl61eQSHbc5I6zNHbdTIN/hjYQkTm95GPg
	 FNluEtFecjDki6vMmY+XlpVLDL4mJjnRHjsMKk+9i+J5prCm7ZywM7qoI6kv7ToMUS
	 8LqkIpV/kr2tQ==
From: Thierry Reding <thierry.reding@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: nvidia: Document the Tegra238 CCPLEX cluster
Date: Thu, 26 Feb 2026 16:12:11 +0100
Message-ID: <20260226151212.4067944-1-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Tegra238 is derived from Tegra234 and uses a similar CCPLEX cluster,
with slight variations but the same programming model. Add a compatible
string to specify this particular implementation.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
index 36dbd0838f2d..fe9c8791f227 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
@@ -24,6 +24,7 @@ properties:
     enum:
       - nvidia,tegra186-ccplex-cluster
       - nvidia,tegra234-ccplex-cluster
+      - nvidia,tegra238-ccplex-cluster
 
   reg:
     maxItems: 1
-- 
2.52.0

