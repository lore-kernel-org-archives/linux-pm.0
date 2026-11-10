Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285307;
	b=onVdWma9JN3OEKCVNXqezvTIeeE7WLQ/TP5NLq6mLLeMQfHHPOYRkYgkLk2/QZbs9Me8
	 3mkazsRW/dpkTnF9DGGf3It/ZvTNuYe71cDrh7ZlJRk+0ujtLg+b850kYwAP5SPZdZz7p
	 dTKmKP8AeXnSWLOa5ePHtEoEPKXm3H8YBzVdFg2YV8ts9Ie+EYpwCSrTL90L+eH9WLcH8
	 i7WI2dXgr8jb2jfUFcA5AUv1/zdUMmkcEO7FQEYjSxdaGcH2gX8DkqWs+bGWgJbLeHmuW
	 867GYwOz0TTG9a0DP/2ZeKq10WLcwXx1/cpH/P7fiKl6VNAJLrrtNR8j+I3IntFtsBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285307;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=YmXnhCl7jkWETCG6T7FluA02RpGlT/C0gV4+SRkfm0o=;
	b=sNwFkjkpKg5mztg7Ue1O0f+PPqn38HEWN2VrITr0i8WYZXYScRKeRrIP9SbOKH9dBAON
	 gZZ5uDAky+0PHo2faYs5Kfm34tVfD6CzGQPDCINisFv4DWqZOcWNDjT6PX3f13jQ1S+8Z
	 aQQ9S4/LcTCLtoQxSOPvjKCx3hjJU5ERL+P0raUkJJ6RprAxgKMwZf6+5iM1B9T27iMJG
	 7mxmm/V3LAneHwchtS2pzkt8gOCopjacSv2WDjAqzoN6VVN++D/Kb1fARfkkchII0foIG
	 DVEpJfoxO/nQgfT41sC4wW5iJ7zdPBZX7PrgEP+tY4h+8PU7ikUYDlxYc/10c0e8QOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jikP2adD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADAB606A894;
	Tue, 10 Nov 2026 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jikP2adD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F020B1F0089F;
	Tue, 10 Nov 2026 04:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285307;
	bh=YmXnhCl7jkWETCG6T7FluA02RpGlT/C0gV4+SRkfm0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jikP2adD7HbW2GV6kD4CEvx9Q69n1RvqldIJ852UWcV08SzXaNFObGi5QATb1xxQn
	 BV7Q9TF4g7FH79+jcRT7Y807C5d9+ijfEln6H/IYzDBa9G2DfjFBTX1OE53eyWot01
	 ykRHaRKrDCmsnUx/eJ3kjFO8VmSjLVljPoxRVWseFBQ6Q0jHjxJmG1RzRrjgJv1gqU
	 dFoNLsRz4o6QGShAQlsG9uSQtj9F17dTpw4z+fLesFna1Qb2WyFdN9uPWygBvvCFfH
	 zjQJM4ZC6ASJ2KallT0tI+b+dXR4u35YVxTohqTf58i9+vuVFInZdV1ywTMW4xfJGF
	 k9pw9NzUJ1XyA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add few more SOC IDs for IPQ5210 family
Date: Mon,  9 Nov 2026 22:34:47 -0600
Message-ID: <179428529357.1061455.7098131094603582662.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922-ipq52xx_new_ids-v2-0-4b1a0f3d04b2@oss.qualcomm.com>
References: <20260922-ipq52xx_new_ids-v2-0-4b1a0f3d04b2@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 22 Sep 2026 10:03:13 +0530, Kathiravan Thirumoorthy wrote:
> QCF3211 and IPQ5211 are new SoCs based on the IPQ5210 family. Add
> their SoC IDs and update the corresponding CPUFreq driver support
> accordingly.
> 
> Viresh, since patch 3/3 depends on the first two patches, could you
> please provide your Ack for patch 3/3 so that Bjorn can pick up the
> entire series through the QCOM tree?
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: arm: qcom,ids: add few more SOC IDs for IPQ5210 family
      commit: 9b00a224f0defb1982d2569ecfafbd347d800b34
[2/3] soc: qcom: socinfo: add few more SOC IDs for IPQ5210 family
      commit: e19fbf2955d7f6e3be91090dea6beb77907b5262
[3/3] cpufreq: qcom-nvmem: add support for QCF3211 & IPQ5211
      commit: 011c427b6d209eaa944ac758a0924fc768244228

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
