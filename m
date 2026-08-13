Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00493002B9;
	Thu, 13 Aug 2026 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610061; cv=none; b=jRuDob8zVThhdjZQmIHb3LUhDIJStuoHDphFN8JbrY178+kOZaIOA+hW/voCfQk+PWOUH6CUsBUwv7UZQk3ws9EY3NpDrBcYgQDuv4cP16SpdzB4XRk9ytPC2sjdsosL8sN77hvaI1SxO5LVSFjG7vtR5ap8l8MMjONMErYubSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610061; c=relaxed/simple;
	bh=T5OE6vfLFkwTA7UckY8AakFKzL2IpkBCaEQOENVAl1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ3IUKKEIcvDDYHIvMa2HuYT5KEJG5KJUGPHNuAKYdkR4aQ0Hjn6tdIcSFOi4+dGb6W+eid027mqbV925nOY4vIbmkJsYHl8fe/SGihSDmq5dVeGWt8Mug1i1oNLOGdQuvauG2g5I/yiT1dx+GkcbRPJP8jgxainXLXP5mFFf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/6seGxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/6seGxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F0B1F00A3D;
	Thu, 13 Aug 2026 08:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786610060;
	bh=WpZmjViDNj9nPaLPOPz80qmgBiPaTATNXRxIiuNLGPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l/6seGxqYKQq+Tq19hbgN6CZEv31KMnguf9IiS1xtIFwLl5YKjP7K1gQtpVZDA/Xc
	 ZVP3AgkvfNR2z6bcXXf0z8fyvcMfFOf3c0QEDXeQ0XTOgK6VrZZxztw/ZHZxKVkvbP
	 YVKvbkyGznmuoWMLr6WGSy0gcM4T2hMZbURDQW0dG/pITzWEMXlIeJikzl8GT0Qace
	 dTGdCxr7xxAv7ncOfenDSB3BVwOquVDYIXmbDZb9SFdYxNSNxD5S5V0yJt3Mpz4/G7
	 kt/G4slgftrgO73nkweSgd7/zDI5rmhDGgL9xYGGquorTpWJpcgGABxtQ+DAL8sRz+
	 N50kXkFG6ghEg==
Date: Thu, 13 Aug 2026 10:34:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: Add Qualcomm IPQ9650
 support
Message-ID: <20260813-flashy-topaz-antelope-dc9706@quoll>
References: <20260811-ipq9650_icc-v2-0-55b8efbd62c6@oss.qualcomm.com>
 <20260811-ipq9650_icc-v2-1-55b8efbd62c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260811-ipq9650_icc-v2-1-55b8efbd62c6@oss.qualcomm.com>

On Tue, Aug 11, 2026 at 09:23:08PM +0530, Kathiravan Thirumoorthy wrote:
> On Qualcomm IPQ9650 platform the interconnect busses don't have separate
> RPM / RPMh controls. Instead they require direct votes through the GCC.
> To unify hardware descriptions (and software interfaces) between this
> platform and other Qualcomm platforms, make GCC export corresponding NoC
> clocks as interconnects. Add IDs for these Network-on-Chip interfaces.
> The GCC schema already defines #interconnect-cells since it was added in
> the commit f92b778251ad ("dt-bindings: clock: add Qualcomm IPQ9650
> GCC").
> 
> Acked-by: Georgi Djakov <djakov@kernel.org>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  include/dt-bindings/interconnect/qcom,ipq9650.h | 28 +++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

