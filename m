Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74893630B2;
	Sat, 30 May 2026 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780134912; cv=none; b=WsMf8cRcW+G0B4MRYhQVUWgyOAMiE7ymSfmAkJ/8RotLEULQq8FSEyH1VsNa0Ffdfzvjn5H8PpONy7EVIAMoBa7dJeYEaM0Gy6aLTLZnyxNszMWSg/zqi0l+tcGpU/SnIPXb9fF3tXJj9ZJZcN4feloGwPkkZGn1v5IHTD0/49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780134912; c=relaxed/simple;
	bh=WqfLUJLud8lEZkAjSt4exA+VJyyrcXOf6ZUpZcQMn/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkOt5F8EIJRoliPs2+8cyMsTKhVCu4GEN61uCh16h0wEPW9Fino+TDMrkBtAspghNDo81J8obqYsLAazZrqpbK36NKWHNTaJa1ROBZ1TEMwR/ylethhQOQQ26dwgcT6SN8xU1RFnnaYyrTYcGIsgivRWW6mQ9N7t8pRGxm4VtIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOYwxXcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOYwxXcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E56E1F00893;
	Sat, 30 May 2026 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780134911;
	bh=uyUKkjo6pnNNWYfroj3w1XskPDVhdezyivpcvRA+dmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UOYwxXcZ/OD8LETTFDiraW+3jdP45q6snmWBQ6hAq7kkOf6lYxN1AW+Ergw6ACAQd
	 +gftRAlEjm7QnI993LAMUsqc/t6L4d1kg7Q0/JpYih1hkPdpXt2Y4c8PpPUki1V/rb
	 WM2riGvPopkCLpE/5ffn1+ZnymjDi/Md9j7QayS0uSC2AniE8GxwXQBKRmtJ0UH316
	 nEjnLZOHfO37kuAMuXsRvBFR3BY3rP+cSd36Og32j63vMa7ZFqzrQKEbOr32L7dOsX
	 b8GH3ZNGXswZcIpx6r30+N/O8TDDlGOWkDu/HTx1ePQ6ROrQJbt0IHiSWjezwnsWuk
	 71GAm5HQ7flhw==
Date: Sat, 30 May 2026 11:55:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Abel Vesa <abelvesa@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: qcom,x1e80100-rpmh:
 add clocks property to enable QoS
Message-ID: <20260530-stereotyped-carp-of-fragrance-d410a9@quoll>
References: <20260527-x1e80100_qos-v2-0-305c6539e6d2@oss.qualcomm.com>
 <20260527-x1e80100_qos-v2-1-305c6539e6d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527-x1e80100_qos-v2-1-305c6539e6d2@oss.qualcomm.com>

On Wed, May 27, 2026 at 05:37:09AM +0000, Raviteja Laggyshetty wrote:
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
>  .../bindings/interconnect/qcom,x1e80100-rpmh.yaml  | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

