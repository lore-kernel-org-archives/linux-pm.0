Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA0426ED33;
	Mon, 31 Aug 2026 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160851; cv=none; b=MrXEbsPCt6HH1+40snE+8HDdki7UYnryflmMybOpG+AnyqcRnGnQELpp40as/651fyqQ5DfhIapE4LfUScYoiQdW8Oclp5AQ4PqZIloaosvGpPCuOksGwEeqWjm/yTSZcV2iVLZzt4SHnaGlRGFPoEwLDHLk007DSpQEHCGRJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160851; c=relaxed/simple;
	bh=OjIH3a2OWYV3xp3PjnuCBHDQdYodCUe5WGLMr8RvKRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5xQ6+AY+CMRKOoLWmQXPjZX4aOiPQkg4lFTiiev1EMSaUMp3Lh0lVNjEnlgdCj8SlWVDM1qC3tmseFM1EzeC7RBsUpz/LA8D0gurZa64T6YnVSZaasj7uEl0pK8vdFdM3yACFo7CY9r/BTkix+sAgk4XbhT/YAyfnF7yBBbNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Evwalu5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Evwalu5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF121F000E9;
	Mon, 31 Aug 2026 07:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788160850;
	bh=OsDsXUk/nDP5qhJBBwkmhIbA361/d82hYpBUhJ/4iyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Evwalu5vNSHZXGZm1ZyPrVFPYrvh2+XwtNHZmEtSOKu1LTWG1C1KhTf6mmSl1aXnR
	 8928JrMLwrh1g6qw4Mp7lPtE82VDyjTxp7pzD060cahA3QpJyf5GXDAK2WzvgK3zxg
	 gwbF4hJLEhKoKVaubsuDXxagKJfc6u3SXhMk1K9aNmK2S3zFVMZ2YUnT6LE1R7enG3
	 oX7MALyfCXwm1c1fXxf9zxfptobJjJ5SKRgD3tX3bBT1SO/mauUAsdWXts5JEGAnZ6
	 565FzyOBSqIFhWK9KYRxQSc8mWq/nAKCUtFXUeDloaKXDTBwBIJ9t2wfrC09Htop53
	 s95OUacl9zbEg==
Date: Mon, 31 Aug 2026 09:20:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v5 10/15] dt-bindings: clock: qcom: Add Kuno Global Clock
 Controller
Message-ID: <20260831-clever-koala-of-typhoon-d3fae3@quoll>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
 <20260827-kuno-soc-support-v5-10-6d47636a8f09@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260827-kuno-soc-support-v5-10-6d47636a8f09@oss.qualcomm.com>

On Thu, Aug 27, 2026 at 11:21:13PM +0530, Hardeep Sharma wrote:
> Document the Global Clock Controller (GCC) binding and associated
> clock/reset IDs for the Qualcomm Kuno SoC.
> 
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/clock/qcom,kuno-gcc.yaml   |  52 +++++++++++
>  include/dt-bindings/clock/qcom,kuno-gcc.h          | 100 +++++++++++++++++++++
>  2 files changed, 152 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

