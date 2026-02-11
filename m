Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CBE1CF7D5;
	Wed, 11 Feb 2026 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770843540; cv=none; b=omyHrTkZeVYfXsZiVG2akhCxD35zcTtWTPaFttTSEIaAvQSik6bZNY/TFnTMo7HzoFkMR+uVSK1Legxdrox7T+YHr3udY9pWoULWjyfUg0IkswBYF/FOwHCYNWHBfARqvbiflXX+8fmzZp4uTfnKQxxifGa15Fnu4IFYUZoKw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770843540; c=relaxed/simple;
	bh=qdCaHBM1vsBZYUsiwQrhAgP75Pv4fk+r6MNmnFrGo58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkO9BN6kMpgld/cyayeaGNoZjVsevBW+kxSugwAS89x61MZhuk8a6nwehCef8LBEauCy7ZkLXUyS3jhJtMROxGNMR/PxaVZYAGV4Nckz4UPw+UtvRjzzuOeW3F/VNBJrvda9pZfLdxp9QcOG4jW9pldXBZjkKP3FxFjIG282C4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYLfzg7j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYLfzg7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15EBC4CEF7;
	Wed, 11 Feb 2026 20:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770843539;
	bh=qdCaHBM1vsBZYUsiwQrhAgP75Pv4fk+r6MNmnFrGo58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYLfzg7jzD96tci/rXKGqs/81bavX1iBCE8FR3GapJZKETE91rDNxGzZAkP1gcQAy
	 KRP4yVtBb+MKhsg8yZrKYgtRqqLlJk024qEdA+TRD8fYD4IlboKPho+v70yGX8WO1W
	 48zKlPnlele6pP6oFcsDSYSvQ3xPPgIF4VrNGg0+k/mu7ILJqHSecm+shFQ/Hhnb2l
	 6Ojgtfjm6fRd54LLgcafgpDOrI1bnOQfF2gYAi0yacGPJEWrs6F5HsTViJvgJRZ5SR
	 okQvEx1A7b6ESa+RWBMSDTjUQ9XwJ0fXuz1CPHqfZ+rn5UCTzQZaB6w8yTWhX1FBZO
	 Hy6kBhDpCCejA==
Date: Wed, 11 Feb 2026 14:58:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, kernel-team@android.com,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Will McVicker <willmcvicker@google.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Juan Yescas <jyescas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH v5 01/10] dt-bindings: soc: google: add google,gs101-dtzpc
Message-ID: <177084353310.3872540.16740879904970139914.robh@kernel.org>
References: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
 <20260205-gs101-pd-v5-1-ede49cdb57a6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205-gs101-pd-v5-1-ede49cdb57a6@linaro.org>


On Thu, 05 Feb 2026 21:42:29 +0000, André Draszik wrote:
> The Exynos Distributed TruztZone Protection Control (D_TZPC) provides
> an interface to the protection bits that are included in the TrustZone
> design in a secure system. It configures each area of the memory as
> secure or non-secure.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  .../bindings/soc/google/google,gs101-dtzpc.yaml    | 42 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 43 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

