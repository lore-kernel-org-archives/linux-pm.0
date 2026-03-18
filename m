Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABB23DFC9C;
	Wed, 18 Mar 2026 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841860; cv=none; b=FR1wfPoK/3/Kf/yDAaVC7vbrdzBAl+Npak1OlUPuQlpgFYDTMjYpYQOnq/kHKFmavndsbSxJlCK+nBm8ctFKc+EKJqGRo5P8WZYas6+Qnkv4nNxVNKpH4NVNGpMpT50KywnV0yWQmPC38zXE6fPYV66AcIMwciU6dqrWg1wSPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841860; c=relaxed/simple;
	bh=nSFbTXyuvi0Bv8BkfD89DSmALFjiDT/NVuQuejbNGSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arO0wF4zrnqlgOzv8MPiyzwcD3OvOsILZk8flXkh8zkPfLiHIM8dkaCHffqQ6a+Y84E38/3NxMul5dXF8eMjz+Eg4c8DXJQN+lbRD/gm94U5RD1z6fhybOl0gLja9VPYcgGOAcMLeUiFpkoKbdIxSridHo95enEFTbKWWDUS4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGz5m1ok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGz5m1ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04B5C19424;
	Wed, 18 Mar 2026 13:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773841860;
	bh=nSFbTXyuvi0Bv8BkfD89DSmALFjiDT/NVuQuejbNGSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGz5m1ok3unViL9JmCyrdRFNzz0xHPIg34H8UrHHNidBLCppZe4oH6MJixiqQshzA
	 G1B9aqEtHEHMgejCZEpbQ5v8DrRbQA7SwWOpt3U+sRuMJf2Khqyel/x3swYA9onOIA
	 kTsHP9rIMU9qyI6eh2Z6vxLxmtmx8q47AkUzV3hfHLrutuftnEx8TjRp427ckwO4fQ
	 looeQb29xbxFKQ3N2VYXbnvkdnNgMY1eB8SWcoyHgQu3nZR8m4enBHNQc8sD+5ggai
	 +GkKmSx43ch5mcqrahYK7EmBTkDmwBmwUX3VSrIy+ZMj0VjvSaIQNF/mZDlMYHfoLE
	 XqNHmgknpNvHA==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Tipton <mike.tipton@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: Re: (subset) [PATCH v2 0/3] Enable QoS configuration on QCS8300
Date: Wed, 18 Mar 2026 08:50:17 -0500
Message-ID: <177384182884.14526.11418013318188575523.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
References: <20260127090116.1438780-1-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 27 Jan 2026 14:31:13 +0530, Odelu Kukatla wrote:
> This series enables QoS configuration for QNOC type device which
> can be found on QCS8300 platform. It enables QoS configuration
> for master ports with predefined priority and urgency forwarding.
> This helps in prioritizing the traffic originating from different
> interconnect masters at NOC (Network On Chip).
> The system may function normally without this feature. However,
> enabling QoS helps optimize latency and bandwidth across subsystems
> like CPU, GPU, and multimedia engines, which becomes important in
> high-throughput scenarios. This is a feature aimed at performance
> enhancement to improve system performance under concurrent workloads.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: qcom: qcs8300: Add clocks for QoS configuration
      commit: 7aec47be7c2bbed4823325e888df3e91dde33253

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
