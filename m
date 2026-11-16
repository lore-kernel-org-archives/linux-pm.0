Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827027;
	b=3CKHBtHHbH/8ChMyAH4TfqqljU06yOQbPfY+IwuEgO24ZEtaAYAmI7+h0v195KxybdA7
	 81A5VoCjIgZVyEJ0d7CSiG6/m9jIj9MHVSb+7OinUzvNZ7H9nqltp3H50Z3eWeQYECoZX
	 E1sc787abRUY6ZVl55u6uwf21OLDHVlHnvUWTe+FT9rd2x9Cjl1e48KgurX8mAT0KSxoe
	 H66u+sQy7/b1a91M69Yf/hy191A6Y9qPSDNNZwuWlA63+OjSb3pw8ewm63XFWA6WLr6Qm
	 t08aPxyHRucMDaRWT7cfz34K7S3+on4Os/nEqVuUCo7nWOzcfbNlpsnjSagwR+VANBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827027;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9UJIHPk6jaJwoBMcauinS+HC1sRarknDd42jwj+8xR8=;
	b=NaJrUJPTNW/9c4zBPx5fkxczC+PrCgogyTArLR9sJliXiSlQP6aRnLM+Jbn7FKWftHN2
	 yaCwfjPw63M7fVXOL7gMkPurAQEQnd/ND5+Z/v70myW2RBQPtQ5fwLaUXDmg8YD8DYqxw
	 1RPr/WkM+b7FIeCbKUK2Zj/S7oR0sbQ6ffbuNvsU6w/ioV6iYrTaI7DWXNLD9qEBbPPzy
	 4tytyIiMyhmsxjfVLjoR+C5fROkz5NMKep4q0hCGbsS4uXGohG0I28jzREHC+ZCoJ4Onl
	 XvTG1FlJnP1W3pAiFKrA8gXM6YJmDYro4sSKDU7XVSpyql1DRSDsF/zljOO6GXY4fZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QUNBOH/C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F621606A32F;
	Mon, 16 Nov 2026 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUNBOH/C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D37C1F000C4;
	Mon, 16 Nov 2026 11:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827026;
	bh=9UJIHPk6jaJwoBMcauinS+HC1sRarknDd42jwj+8xR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QUNBOH/CzNodAAUKKXa3XaNurUbqWB6pJO1R8ByE1IBPZ5EDxb3r1AGAfPvOw/stb
	 /imjuS1VtqPQRodaND4VaQ1Jgd9k3UYeMVI4oLXbvIYYmLoqb8OWuRNqIDWz4ASa1r
	 pTwJocCN3VcHZuVCAeev/437XMGbEmbeSH6ZPkA4S2PqM5figClI67l1Td6uHoiWPC
	 8cjPAL6NB9C1/tyeSGOpR5z84vck2wSmqZjdH8eEfW0ZIOXkTGEiRWKRJOzj95JJTi
	 7NMaRTqJOjCkgKc15xCKyf83lD85TnmiMoWSOhrKKIqpipe2Tb2jQPHNVV2tGkuoCb
	 sbJ2WFIzT9GGg==
Date: Mon, 16 Nov 2026 12:03:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ishu Brar <patches@brar.si>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: interconnect: qcom: Add SM7250 RPMh
 NoC
Message-ID: <20261116-furious-powerful-nightingale-8adcad@quoll>
References: <20261116-icc-sm7250-v5-0-506be082a3c5@brar.si>
 <20261116-icc-sm7250-v5-1-506be082a3c5@brar.si>
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
In-Reply-To: <20261116-icc-sm7250-v5-1-506be082a3c5@brar.si>

On Mon, Nov 16, 2026 at 11:58:00AM +0530, Ishu Brar wrote:
 +
> +  clocks:
> +    items:
> +      - description: aggre UFS PHY AXI clock
> +      - description: aggre USB3 PRIM AXI clock
> +
> +  interconnect:
> +    type: object
> +    description:
> +      The interconnect providers do not have a separate QoS register space,
> +      but share parent's space.

Sashiko claims these do not share address space.


Best regards,
Krzysztof

