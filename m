Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796304;
	b=EbUjy0MicpocPaQFeuUzSUrZmixmQMjvXqTFH5NpxFyVvGZjkx+e3UX15MJDK9h89v10
	 6Y1potV1gBAegNaXWKMmkvAho1UlaoPwn4vpc07gf3F9YUkXqxjjk4G0GgrIlbOzxdgb+
	 1HkyGFyFNhbJRMdZB3MtmvTZbu3BHE+DvTx5Ayg1pDS9Gcv39U7XEi8P3fGBljiO2v6qh
	 sCd381rK6zLQS34PqkRnojaYdkKnl9tf5vIc5bhcXh+LwBLd6erQz6gjmew4Xc1pjJoSA
	 zs+QjOzL/teJpAcztba5kUjR4xx3PI/O3p/eZRLMB+WEFWjB5crWVJTRfsvsoUsXV5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796304;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bcwZ+BIYS1fsQmOTmnctKIFVuU2lYAEyD4sfxCNPlOc=;
	b=rxwM3kNE2pqW6NLV46hWI7w03DIzM/2uiWIex7OugOpu0YeULEvT1keKHQfTtuMHZlED
	 cKueXxeH1/NIG7mx9pPWuE612N29FkNPbH76vpP1jwpfTRbEIf0BAQbPA88oLQivdTBeY
	 vtfw7YScG4VYu7Ab51dilqibIxIzfXMW+3LPiOHsVwlUMZa85z/TrfKPreGROHOdwOLTW
	 mLP+1RCZ9m8Y8pt7TBuPpTkigYYAU2UfGTUO4cJzVs/6Y8WJnB135yTmXCx+61Nf9ydyJ
	 BMlgdz6qrB9BjwAfbDL1aUV4bd0WGjSRh5GMJMJmqn1Z93p3swTJveg/81YkslszNYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIIim+qm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79534606A330;
	Wed,  4 Nov 2026 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIIim+qm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598B81F0093A;
	Wed,  4 Nov 2026 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796304;
	bh=bcwZ+BIYS1fsQmOTmnctKIFVuU2lYAEyD4sfxCNPlOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DIIim+qm76m0x9L1ZNhKMdCT1vWZTspXPk51CEw+nAMPr1rvH5wHjtG4dD8nOWREO
	 aFTPn+yk45VSNsUIoGoSCfFGMPSOxBrTLW/c0BiWbfYsea26DN5KWgX/XIHg4dKMpI
	 UdRph5o4raxC79x4v2v7VWs7nzbQBA3dix0avbtXdFwC+x9mx1fQJtuc4giF0Rx8K2
	 o0aPK74Ll7Qp4YxhuDM57OyycPIb6UACEvuma5MxcYvg9NG00wSXQvOgOA8Sv6H0RN
	 HfmqswWqwQGXBZGUbNCqNjhU6tcXLOuuTFp8rgOtUovDANAPz7Kcc3WpLkHdd0rTdB
	 aFB3+hx3R0fmA==
Date: Wed, 4 Nov 2026 13:44:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/6] dt-bindings: thermal: qcom-tsens: document
 qcm6490 tsens
Message-ID: <20261104-gleaming-polar-panda-77c21f@quoll>
References: <20261031-thermal_bin-v2-0-d76fd073ae98@oss.qualcomm.com>
 <20261031-thermal_bin-v2-3-d76fd073ae98@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261031-thermal_bin-v2-3-d76fd073ae98@oss.qualcomm.com>

On Sat, Oct 31, 2026 at 06:52:49PM +0530, Gaurav Kohli wrote:
> From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> 
> QCM6490 uses a tsens-v2 IP block and supports hardware-binned critical
> trip points. Add its compatible to the tsens-v2 enum.
> 
> SoCs that support hardware-bin critical trips read their manufacturing
> bin from qfprom fuse cells rather than the usual calibration cells: a
> single "i-temp" bit on hamoa/purwa-class parts, and a "jtag-id"/
> "feat-id" pair on sc7280/qcm6490. Extend nvmem-cell-names with two
> oneOf branches so these fuse-cell names validate.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

