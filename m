Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558883;
	b=KYelIxTJZQmkV5J8gtrvrgqlzB04PXDynRy1a2+XiTPidCJt0iGdsbOWvnp0nMtTLdRz
	 NrYWQBKsvB45asoVllYMixa010UrxIKjq90KTAgQohe6bEFZY4VW3q+9rqUnUh2sc/Rem
	 12lbQAa2QepgH74tew/y3br+3QzJWSAI8qyPxnfkdlBIxDB7D++ACIRg/uV5SlCM/0qqY
	 ohqCvAsD9+awkmPJ4S+iKxTbjeiJctvkAeUvMB0OVe0jGlqwTtCuqaviHxdk0P34vzGvc
	 byCbFBBpDGryQRI5RZ8/Dc92+4qERh2jNQoGS2h/j2ILngTK7tiBM/PRaAuWI+BGYwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558883;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v7TkNmAjWoTE0ChEpTaHQcYbnV/hk1xGuEWLimgYKas=;
	b=mYW+RSUfCbNitcxLWvXcNFfi/Azn3BhSvmAR4IEf1cpqRDVvWfZDNQjDO0JyEdp1FvrX
	 isO7Ozguo0lgoW/udKqi7CNsdtSNPbZq0f46OQvFDqVQCloGOddhPibWVc96fXI8r22qf
	 MsUb90Rca6KImYPLXGyuqONmhrXK/1sRIadosxpqxXMZGycpIgQgw2OzthlJzPq3hJQie
	 93kpEVONYhe+NDay/2Hdo+yN3VNgVUXv9EzOIzwl/UpW8O8mWE7TQYIzyox7YAsa3zji/
	 Pl5H4AoEGiXUIZWIrqIfFfic3T0aKMq9j36QL5jaJ0SVwme6znYvC5ftI/bDgwYar/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgpgC6BC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0436606A33E;
	Fri, 13 Nov 2026 08:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgpgC6BC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3137E1F000C4;
	Fri, 13 Nov 2026 08:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558882;
	bh=v7TkNmAjWoTE0ChEpTaHQcYbnV/hk1xGuEWLimgYKas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dgpgC6BCIyY6r2PPIy7apw5eOig0q3odoYc7hAIx3l+bk4sifsiPyTuN/BeQRCgDZ
	 Bc/YxSoKcLqwcIZZ1eYQNFW3GBDBNYFRRzmB0tcrwY06gZ7AIVWV8IKU5SmsEE+TNx
	 Nghg3TokkTD+ph95MtYO360LlNdL/xjEdGwa5UPejyOsKz8ZxqoiSsKbF68RUUWPZ4
	 7Aes/80oUhrx6MZvHjXzKhnY4bhlWTno1r5CxIRgNUUczE5hPLUe9vtS3MHgEpqmSJ
	 AX1Hx0pFeIElTolSy/X6W1+61J0rtzvEfqMHYDuRi5RLOJ2HHHxbpB7qjwxzOndbO6
	 +82hVegjvQ/ig==
Date: Fri, 13 Nov 2026 09:34:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shaunak Datar <shaunakkdatar@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: thermal: marvell,kirkwood-thermal:
 Convert to DT Schema
Message-ID: <20261113-striped-fascinating-mussel-dbcf6b@quoll>
References: <20261112080532.30774-1-shaunakkdatar@gmail.com>
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
In-Reply-To: <20261112080532.30774-1-shaunakkdatar@gmail.com>

On Thu, Nov 12, 2026 at 01:35:32PM +0530, Shaunak Datar wrote:
> Convert the Kirkwood thermal binding from the legacy text format to YAML
> schema to enable validation with dtbs_check.
> 
> Signed-off-by: Shaunak Datar <shaunakkdatar@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

