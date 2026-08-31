Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9D39B97E;
	Mon, 31 Aug 2026 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207710; cv=none; b=XbT4Uh65rNB6pS9hY/OjRq0yF0vb6ZBXVzC/B51WPUOgI2wM3hhhUQZenIwK2fNDg9BFjaSmmAr9GQz0+CVPjYG5fQKBx6FDrZiX4SyFni1rZ2ECep/XGrmlTP59G/N8pGARHibEkU8FrGKLhBaW8kpyOoPUAi13gjNCqpMSjl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207710; c=relaxed/simple;
	bh=rBKN4xNKl5z4v2F5jkPqwi3k9vybSuEaX6jrtvcNaNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cc6GGbn1XYsBovB4DtUj6OAHYt6rR3i+HJQjOsFYcsSwnesm3Qj9PP8c0JVWW4HJHKXhluFsoyAKxMLnWjQjmN5Gti1CspGbRdjCzaSynI8WLxaO6dWGwlIYNu9FyCy+x2zkVl3K96VZj4X04aHeADvXhHm2j83clSecZU+0+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCbQVlLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCbQVlLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615F71F00ACF;
	Mon, 31 Aug 2026 20:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207708;
	bh=jTAi/teimPay8QjfRekwuFZzF4R/WNh1bkQ0x6pY5C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZCbQVlLrwY69HQuWKgjzntg9le/m8XY0UfLagDQJfuG27WMnLdDWdNN23blv5hYcq
	 VGr6SLQzFwBg0mfjAkoHteaT2Cx7nxtBOAX/BUl8VY1b/aCTWV30VuXsYoa9A2kEaB
	 6e+hGQAjcQqlIDQ/ZyzjNRhgX6LGkp82TBdkUrebGeAj0+AIjdpgMoJ6rwum04+BrV
	 hGKshIVl0IuqnjK/vrcjFdEs2pv6EHHOZmr+m4liiPUG1PduTkCVeBbzFtL6N7Pp5u
	 7ftVB/0tgcDTUP3BI9402F1nxCUVfnrIaVgdy34lNOzucWVbRvw/8SounitWv2mKhd
	 AckF1XboebUxw==
From: Bjorn Andersson <andersson@kernel.org>
To: Georgi Djakov <djakov@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 0/3] Enable QoS configuration on X1E80100
Date: Mon, 31 Aug 2026 15:21:24 -0500
Message-ID: <178820768630.1699313.2273741570972288112.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527-x1e80100_qos-v2-0-305c6539e6d2@oss.qualcomm.com>
References: <20260527-x1e80100_qos-v2-0-305c6539e6d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 27 May 2026 05:37:08 +0000, Raviteja Laggyshetty wrote:
> This series enables QoS configuration for QNOC type device which
> can be found on X1E80100 platform. It enables QoS configuration
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

[3/3] arm64: dts: qcom: x1e80100: Add clocks for QoS configuration
      commit: f49d819c89876f882a9f1b9ac6ae020fd7e92152

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
