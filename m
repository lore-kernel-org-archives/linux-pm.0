Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84D3DEAEA;
	Thu, 23 Apr 2026 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933491; cv=none; b=qJWrjJfRd7f+vWGF1bn2FQ4PNypvilGp5IBk+ZZLw13VePE+NiF95BfGSa+obkCCTDePupoE/sqFf0i3W2xSONt9QIlb4bW522Kdu12FOYMayev+o9cmsHfsFnUZzgaykBj0hG5YhrqNvVyfjVd7FriFlQDoJY/Hn6r2lqpNHy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933491; c=relaxed/simple;
	bh=7TncH7v5oMurcqGtlqVH6Qwxgl3u+rSFozfoTQxHXOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oztaitet7+Ih4C6BJdizs2d0j0nMNJcNNGeW2xVkAUfeL2fGlNqlzlxR8RySHvCEBL6kWOdaf1WYWL/KaZBrd2zp/q/s0oZRIE0mWqXGR1C3r1yN/RU7PrLny1QXDk3uLvIGbB1Aa3k7eFhnq2CDHZgpZYr7rc+EWXBFHiEhAIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfV2Xf6e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfV2Xf6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBADC2BCAF;
	Thu, 23 Apr 2026 08:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776933490;
	bh=7TncH7v5oMurcqGtlqVH6Qwxgl3u+rSFozfoTQxHXOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfV2Xf6ezyVMa/E5Ys5S423AcV776mCHIICo7rdol+0+nLH1piAkMHg0beZJ7wKjv
	 HtltoLvnQoyQe6HZ7h0KuLOjcmwLTfowM2Qr8t5OS36WRqVIHYxJyr9DWVjxM+x15a
	 Fzgyf5d3rsVCiuMjTwEdvCwk8AMloNJQFwkDjRBKLc8drufkL0wDVDBFibxubhtp4n
	 x88X6HF5kh1NvpMZ3DtnwleIERi+3kbBjrB7BNm73B5oWCDh1EP0iOECQP0W+hukEr
	 tqPKHH6KckgcQVNHfyVTjz90LH2pfbDoLYriVJ1AwodscTNiXM3RUS6q9AoCwx/UGe
	 9doAWH4D6VXHA==
Date: Thu, 23 Apr 2026 10:38:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Abel Vesa <abelvesa@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: qcom,x1e80100-rpmh: add
 clocks property to enable QoS
Message-ID: <20260423-thick-beneficial-capuchin-e4aaad@quoll>
References: <20260422-x1e80100_qos-v1-0-bcc2afe4cc78@oss.qualcomm.com>
 <20260422-x1e80100_qos-v1-1-bcc2afe4cc78@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422-x1e80100_qos-v1-1-bcc2afe4cc78@oss.qualcomm.com>

On Wed, Apr 22, 2026 at 02:05:11AM +0000, Raviteja Laggyshetty wrote:
> Some interconnect nodes on X1E80100 have QoS registers located inside
> a block whose interface is clock-gated. For those nodes, driver
> must enable the corresponding clock(s) before accessing the
> registers. Add the 'clocks' property so the driver can obtain
> and enable the required clock(s).
> 
> Only interconnects that have clock-gated QoS register interface
> use this property; it is not applicable to all interconnect nodes.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,x1e80100-rpmh.yaml  | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

