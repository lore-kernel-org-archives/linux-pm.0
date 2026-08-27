Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82E415F1F;
	Thu, 27 Aug 2026 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833221; cv=none; b=eudjKsyTXkZriyLMjdcNWRU7cO23GkhAOK+vF+9/f6Tv00yKcX2Q4GI4Cy+LtZ8rUBN1KBbTeRLam1YfzbZS723vHP0CJXiUKxCygVWvR/q1jEK7Kga7dzxUijzz1079AbsupfucuVV0obv/597Zxn/MXAEcgJPba8IN4ltnILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833221; c=relaxed/simple;
	bh=VHraeBIZleTsAxdBtv6ZKxlOuK71+qD7wSnonQkE2g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rN3kOVqgc6OcCif+CWyKk4lRikcc6IC3+Icne7A1mbNIMlu8lwshrBYRwYqjMND/IZ0Bz9j7TAmBDyClyEDpWQKIdg+7gOv7j35ggWsBVm7U4loUnHFJfVYMK3Yzjwk0lDGtQ6qt6eIrKv7ioswgQSHO7UrgU6Trtu3bgRjRhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ns3c1dbg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ns3c1dbg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6301F000E9;
	Thu, 27 Aug 2026 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787833220;
	bh=JC8KEH2A5MaBWTLPjH1KEcQphE7kFFAbdhvua3h0dxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ns3c1dbgik71leiI5OFOgqECUIefVwx/zRnd6jyWTbatex/odpR1+VaXlszUnQ2Gz
	 +Oc1OMOAS+mMgDM+HVN8N8q4Rq858mfCFiFs/XTZfwlnx+uuYcYMBkEr7t+vHGr7i/
	 3bIp+aBVOQtpxadtjMEoJR0aoh5pTydMhZlUhEZW+4X9jmK+oP9iATtr77WsZX+I+l
	 tD6rg9A4+diFFnctSArK3/GBlDNIe6DrQwBbHc5ckdLqaugZefKMG2koXa/vgeNH1B
	 1rY1hp2+4lYToz7u5eOIBhnGonlqlBUvZ8a1d8tBLc+CtmH4LdAsz7kMLaH2cvjHKT
	 ThEaoKXn0Y3vQ==
Date: Thu, 27 Aug 2026 14:20:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 06/15] dt-bindings: interconnect: Add Qualcomm Kuno NoC
Message-ID: <20260827-predictable-mauve-catfish-3d5ad0@quoll>
References: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
 <20260821-kuno-soc-support-v3-6-196e2b306368@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821-kuno-soc-support-v3-6-196e2b306368@oss.qualcomm.com>

On Fri, Aug 21, 2026 at 09:38:59PM +0530, Hardeep Sharma wrote:
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,kuno-aggre-noc
> +      - qcom,kuno-clk-virt
> +      - qcom,kuno-cnoc-main
> +      - qcom,kuno-dc-noc
> +      - qcom,kuno-mc-virt
> +      - qcom,kuno-mem-noc
> +      - qcom,kuno-pcie-anoc
> +      - qcom,kuno-system-noc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:

Missing minItems. I asked to open other bindings to see how this is
done. So for example you took qcom,maili-rpmh.yaml. What do you see
there but you do not see here?

Best regards,
Krzysztof

