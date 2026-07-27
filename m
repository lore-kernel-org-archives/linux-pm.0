Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E43026F2B9;
	Mon, 27 Jul 2026 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134204; cv=none; b=PK1/i0HBM/uciIGIJE7TsNTteSFjR1IHyxmpOK4VDWo/8rD82v675cgNtfGe7l2DJa8krsbliQAILhgeUgdjGsscSd2KA5hM7Y1/Tz8YQW1eUil3WjnedIQwYtOaEgLNgA3hOd6P3/P9IuFDGmi2KxRlJi/NTcksJYlwED1FIV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134204; c=relaxed/simple;
	bh=Mc7KAaFe42ZU3bmIFRdMHy/D6HhIaveLu8S420YaaW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxBb7f2dKiCpQ9TJV2mwsgMPZU9B9IbVZX/IXaohDcxw7gLWqSkzvdfYQk5A2x5yIHxdzCNQqW8gVI+uXaVHpU6R8CzCzvf5w1Fzju9YYPCQhzWO3cPTbGErt9lu+DMi3ZlI9BzG4JvkkMFxA36bn6saQgJEJlcZqx/sTMm7wQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmERUw8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmERUw8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA621F000E9;
	Mon, 27 Jul 2026 06:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785134202;
	bh=GO4HzC8njbJrOnpeY46ZFFHbHffdr55Xh8QeEptCtsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lmERUw8bCAAlCyZvsEa5FL4GTtQzqBn7H5yMugbhXn0kggWPkhxjSbg08Nk9NvYrp
	 uSG229BQpnKhU1jtiRNLUb9r4krD28P23aqvi0AV9PP/G5bQVKFTsflKXaXY13WhJT
	 N53q6gvQpNXCA2JGRWFBTTW0EDbQ+n3dnwVu2k7isoZQCV9RagWzyYAjyWY6D8Kide
	 kX2dYsrOoE8lVHKY4c2r8xFq5QuZVG+xmyu5l2014VDejWIJzTJtLZTCSilXrZIhhC
	 An0ar7tMxlBargi04dylIPS1hVoJRQhEFOiqCBFKvoFoXcbusp+NjenWtLWy5SlnjD
	 ln3T3u4yLGqsQ==
Date: Mon, 27 Jul 2026 08:36:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: power: reset: fix minimum reg count
 for pmk8350-pon
Message-ID: <20260727-weightless-fierce-tiger-a9c6ed@quoll>
References: <20260724-b4-add_pwrkey_and_resin-v6-0-41acc214d93a@oss.qualcomm.com>
 <20260724-b4-add_pwrkey_and_resin-v6-2-41acc214d93a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724-b4-add_pwrkey_and_resin-v6-2-41acc214d93a@oss.qualcomm.com>

On Fri, Jul 24, 2026 at 03:44:12PM +0530, Rakesh Kota wrote:
> The GEN3 PON peripheral requires two register address spaces: "hlos"
> for the primary PON block and "pbs" for the address needs to be
> specified to facilitate software debouncing. Set minItems: 2 for reg

That's ABI break and I do not underestand if this was broken before or
not. Driver ignores the PBS, so everything was working fine, no? Then
why PBS is required now? Is it actually working or not?

> in the qcom,pmk8350-pon if/then constraint to enforce that both
> address spaces are always present.
> 
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Best regards,
Krzysztof

