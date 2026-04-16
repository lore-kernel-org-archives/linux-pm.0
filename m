Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1328CF4A;
	Thu, 16 Apr 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341006; cv=none; b=HbwVT1FUbMxMqPpDuqPKXnjTEZAfEqGOEzFnewLsaMfYjjSTQME+kb7Grv70BASDJKaczadJua9GscV3isQMEwTL+EVs1ZQhTAUVtvrruuRlHjLz9+s3B+CHr9SYZp9VaSslg1rXXGzJ5SO+KvL0rlTaYKNRGHI8oGgVVSfF9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341006; c=relaxed/simple;
	bh=jI4kFil06zWjf1iB2JpyDVHEeoSXvfIVgPeUzpVg22s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSdjB9109hlSx3v9cCuJMvwJFmA8vSEbSHHvKNbwsqM/R5Gv2hUPKpa9Cnjy3qOnS1zFHj2DaUK6ZS3C4dznlktMdYvsOYzEuQXfAYOY7Kh1fnIcej8MivtiQqXlEbYHS/kcGd8p/3X7sIKS5LA3uZ2gBVq0oq5/e/I9ZqbIPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srxwgCje; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srxwgCje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE4CC2BCB3;
	Thu, 16 Apr 2026 12:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776341006;
	bh=jI4kFil06zWjf1iB2JpyDVHEeoSXvfIVgPeUzpVg22s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srxwgCjexUJhI7u7BtSixy04nCyM5H4FWBThlGn5OIFN1p1hZEKdRgZz2YYKuh42/
	 P6EgtT/Px8T2Ot2J/wCOJ0x8buWQwV/Y8+TOlZp2VXTDbqPPbnemwXTu2ivnpUNxD4
	 mR2em/yma14CQQhACTkdKStw9lP0oGOSo/3gyOG+3LtRanEQyxQN+qbKmNDEKrzhAK
	 zU8WgwckvbrLdBr50uq0wsziVD/OEXx5dvpNi07VAsTttwmpr6IZWWq6jLFwk3DjSg
	 iFgB0ehXLDHi2yNFdpbCv6TIzvhINofmfeyu16gIDsPHXiFFfMlwYXtGlR13+zkhiS
	 i7r2qUNNdtN6Q==
Date: Thu, 16 Apr 2026 07:03:22 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: Fix false warning with 'phandle'
 in trips nodes
Message-ID: <177634099816.2735884.15576512683464919146.robh@kernel.org>
References: <20260410223601.1487473-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410223601.1487473-2-robh@kernel.org>


On Fri, 10 Apr 2026 17:36:00 -0500, Rob Herring (Arm) wrote:
> A pattern property matching essentially anything doesn't work if there
> are implicit properties such as 'phandle' which can occur on any node.
> One such example popped up recently:
> 
> arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: thermal-zones: gpuss0-thermal:trips:phandle: 531 is not of type 'object'
>         from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml
> 
> Instead of a pattern property, use an "additionalProperties" schema
> instead which is the fallback in case of no matching property.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Daniel, Please pick this up for v7.1 as the above warning is in next. Or
> if you prefer, I can take it.
> 
>  .../bindings/thermal/thermal-zones.yaml       | 111 +++++++++---------
>  1 file changed, 54 insertions(+), 57 deletions(-)
> 

Applied, thanks!

