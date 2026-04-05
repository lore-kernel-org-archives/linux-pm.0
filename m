Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1E35AC2F;
	Sun,  5 Apr 2026 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775418044; cv=none; b=Gf+pwuoFZDywZQsZWWA14UxhkQmS07uJLZ9U5AWrQaktFilIbeggxZR7PQjTfy8WC9LmQN2o80a6BHzyEbprPH6a8tPQCTACSgUC8BH5Qzte4G0yhvCDbdcQmSarX3ml1NUz4S218/8+HDP57pbf1OiEMwIW7KUSrY7ZnImagFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775418044; c=relaxed/simple;
	bh=s14akoiYE6AItWVTCLfNsOj1qvKu5inJeD00kzVA/Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZzk+4cjRQKGoajQ43A/08ClchYaJEyiugqiftjH53Urnf2D7hj5WRLksLCBGtYCkIbFrv1XWC0dSd9XV4weYq0S1p7LCLxgU+5+WiuPvv/0Brzm+jmPhhN+IZMYK7jGTWcm5/DC9Wrzs8QD9KbWMsq4qPpKJF44eFoFuFbY/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAiorilD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAiorilD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD56C116C6;
	Sun,  5 Apr 2026 19:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775418042;
	bh=s14akoiYE6AItWVTCLfNsOj1qvKu5inJeD00kzVA/Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SAiorilDO4IghE7Dz7APuREAw7VjTnqXpg7RBgxuUgIpTfRstB+5hG5yHtiE3/apR
	 +Z8krvSJfwOg+l5FxEF8eq29S6nKkpBEWdh8Q/j1hE/L891UFjGKsgzyQzjmygyi7v
	 7sw9THHB4j3K3OQMZgoJPd3DftJoE/vBhIJ8ZFBOfYCMLz5DEk7shFaFSpQTrtBbhU
	 pixvOadIVp4zQ/qVF0Daj4/eSD/vYKDHAOwyey7uaJYBPVNqfSLw2q6WO2GA1kDQKv
	 f1mletfaTSzYTAcFCQER95syyiUvFPD0XiR4nemkV0I0LgwEXQBsNp42LBLqXWeikN
	 MaXN8UUaBslJw==
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
	Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v3 0/3] Enable QoS configuration on QCS615
Date: Sun,  5 Apr 2026 14:40:22 -0500
Message-ID: <177541802152.2061229.9414750574233334991.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311103548.1823044-1-odelu.kukatla@oss.qualcomm.com>
References: <20260311103548.1823044-1-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 11 Mar 2026 16:05:45 +0530, Odelu Kukatla wrote:
> This series enables QoS configuration for QNOC type device which
> can be found on QCS615 platform. It enables QoS configuration
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

[3/3] arm64: dts: qcom: talos: Add clocks for QoS configuration
      commit: 9b7d6b6c5cef6c578e976a1a605985c255779327

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
