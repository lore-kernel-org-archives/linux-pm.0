Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999728;
	b=aO1EKfKsNEwLPh/4CCu3q2jCXlgHg5Veb4FoNL055m8BeXQiYvLmCNgd6S0S8Ez5gwU7
	 /R6jCWewXb1iLnAZa1VEQWOxtbzDYtTGFIz4OqV0SCQGJJXAQJjRUKbX3A2ubBv1Nk342
	 TZ9MrwcgzhD9aj5NstLfwW+50btZcpL/kYLuLFzD6WRnStUGw+blU7ar90Dyw6itMrCZZ
	 1nTXj4NkgjYOW9QttepsbLx1LViNGKKgkyUSar34+WbM8aexzpmHptNf1RlvEZzxNr6qd
	 33rmfCxdxh3cxCUZsaOxPRdB4emxrIEwlrdrA0sryvB9OKpyYSNkSvErkFR8/pfZ5Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999728;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lGevc54PDN7MmVEAeNdpITEvNybLOdJmT7pRAvwG7X8=;
	b=ZpJ7Btw+9MuONPgxECiTI8WGCg870Cl0AULQwvA8kxJoHNXu/+OFiAfbI6oDOgKPBdWZ
	 DKSiUNOW9o6yRYATQdhLUk7on+YOKTkPgSIkO8QYfyz54UI0Sm90F2xbat+lOHyjEoD3v
	 BgAyyOUSNQrRwAfWdjjz+X5Qh17eaPGGA/+C4Q9+x1mtVCOmewADkBMWUlYiidM4Bduas
	 sd3rQfxFY8ycfLJac/rjfb3iBPZ9l16h+9y3PyzgcjSnyr7btCrEKPDKQeO/Qqir8sjjI
	 vJ17uBWovVDMnuLgX+fbUvM1a6jsAR24YAokz/mWDY7AaZvlkCPOqB9nG3yF+pKk2dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYXvVgzP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B957606A326;
	Fri,  6 Nov 2026 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYXvVgzP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49CF1F0089F;
	Fri,  6 Nov 2026 21:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999728;
	bh=lGevc54PDN7MmVEAeNdpITEvNybLOdJmT7pRAvwG7X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JYXvVgzPJqpkfuhSWYPSEhIAcWilXosveDN3IT4UdY3cf5vwaYMxXvCWBoPT2Wf9C
	 xhixXjodw37nbMmiq9aeu13POo8CRgpjRTP06+Bp5J7YJ5/SW7lEknjISBzC8CSwUA
	 booF+VjPcjKi/8fGCM7D7SweiACKVrV07V5gkMEEObAUS5kyf9+UFWlfp/XyDny8tL
	 MlpkqK97IuMhkhJ5fWI6U0Z/lbe66X+Eg6dRtrMcjV4cvWy6T+3hvrD7ZAz2md49cB
	 g2TnQaeslQyL9j8hMUEH8Me1856nqGYl2cruhByCb3GklWdRXu40iZeNG3M/TIQ5ch
	 cBoNOIwgLMS+Q==
Date: Fri, 6 Nov 2026 15:15:24 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Ilia Lin <ilia.lin@kernel.org>,
	devicetree@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-cpufreq-nvmem: Simplify
 bindings
Message-ID: <179399972393.1703387.748498468512223215.robh@kernel.org>
References: <20261105194606.772346-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105194606.772346-2-krzysztof.kozlowski@oss.qualcomm.com>


On Thu, 05 Nov 2026 20:46:07 +0100, Krzysztof Kozlowski wrote:
> This binding selects a few top-level compatible machines, but since
> commit 389de9c5a677 ("dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
> bindings optional") only qcom,qcs404 is present in  "if:then:" clause
> which enforces specific OPP properties.
> 
> For all other machines, this is a no-op, because there is no schema here
> enforcing a specific compatible for OPP nodes or any of OPP table
> properties: one can switch to standard OPP table (operating-points-v2)
> and this binding will not complain.
> 
> OTOH, this binding has complicated "if:then:" blocks so is not easy to
> maintain and causes false positives when regular OPP table is
> encountered in matched machines.
> 
> Drop all machines except QCS404 and move the subschema to top-level.
> 
> Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 78 ++++++-------------
>  1 file changed, 24 insertions(+), 54 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

