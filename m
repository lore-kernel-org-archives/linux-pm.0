Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B046DFF3;
	Mon, 17 Aug 2026 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786991425; cv=none; b=V2dJR03Y/1R4yqb1Q1q5AiSQJ0YpP2vvFbsaI6mazeVvmAq4TnSBDhqTIEXCptlIsqyojb5IjBu2kiH2QU7K1fNr9lDlVRj5DCyjcuvguB+91sC1i12Gvuzflvew+lu0jgeDwb4RSmfpIRCNdhADqSv6nYlmAb/ZS7v568MHK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786991425; c=relaxed/simple;
	bh=NilObdHYEVgJ8SGvNk1Sj2GRgOyjUIKfhuB1JExerxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS/Q+ifKuGulGqaJlA4VbHXJRqxa93vFRhDYYewV7oMeTq6/0DyQp8TXv7ygQZYf8mqZM6fzfEzOwBLrm9cZKrGZ1Me8WwdV7pnoqurJIy0ZJ5eI2mAe6j84cnR7/aogHtE3YgcuzotpnvXHRi6EIpkGoGLQ51/6w3oBHC4NWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uli4xpFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uli4xpFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628431F000E9;
	Mon, 17 Aug 2026 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786991424;
	bh=pWicw3wdyX2Cf/d1fATA10bx2J8IVOMaFPlUNYeHVQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uli4xpFxmyrHSMu6NIWChiMnMG4R+IERaI7UQ5vUao/T9tZ3Ns+glcKpEynzgx9zH
	 FbyqwkDzxvvVA0tTcdTZ/1zA4zAUsAVgHLcGO2UfkDBr1vC21OeVyEbk53FgIy8WuE
	 aFMnmz9uSzdbfnPDGbDzjdbpUT8ZZGtOInFKZoLGpJMXK8EsAlLA8GPsctYJjO30fz
	 VIZJWyo95ha+CjMwudMaa6Qtl04cNEtlN5QNzfFfsPQFcRfMgOqnOkGWKP1nN64Jib
	 7kQ1+q1QZ8LNJ5Y1b/ugIRtYw5CDi7beUMkBMTjCALcbhMq1xvHA9ghp9AeV0FWmO1
	 lhqH6ZrA/gEhQ==
Date: Mon, 17 Aug 2026 13:30:22 -0500
From: Rob Herring <robh@kernel.org>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: devfreq: samsung,exynos-ppmu: Use standard
 regex syntax
Message-ID: <20260817183022.GA1718712-robh@kernel.org>
References: <20260813174037.2263884-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813174037.2263884-1-robh@kernel.org>

On Thu, Aug 13, 2026 at 12:39:58PM -0500, Rob Herring (Arm) wrote:
> The "{,N}" regex syntax is non-standard, but happens to be supported by
> python re module. It is equivalent to "{0,N}" which is more commonly
> supported. This fixes using a rust implementation of the DT schema
> tools.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob
