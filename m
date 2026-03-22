Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C793164A9;
	Sun, 22 Mar 2026 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774220888; cv=none; b=N2wLNP0HbY79mr2YVnf5yuhO5rm7r2pcKxuPy4KX2mplpa915u+UXRgIqzpSgYyCEAKAjTjCzD5xFaVkgWtzgCVNcXkYzOLMx7/pKPPEo2cLPjCxCyVD8qHHxkr3P24rE+opEr+ENASHTEJPPucVyD0SpIQnaZRhYakuBd5QwqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774220888; c=relaxed/simple;
	bh=cS9fnBLUaiAxDgJ4h9rJnb6mgZnkEly0eecDci0Jflo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcRd/cr19jDDMpQ/02sSN5PdnE49daN8Udc88SHgGW7Vj0Wj0Z/1lPUeig7Djwcs0JLwRlRe7HD7uoGf2yajdYzAIAXVLt+RLYTzxzYhpbLr/DEongvdkIAsCObBxkAPhPgrFvxcGX+VYASamAlGUaIM8qkISwSiwgmKsyInomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1eZG+m4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1eZG+m4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B325C19424;
	Sun, 22 Mar 2026 23:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774220887;
	bh=cS9fnBLUaiAxDgJ4h9rJnb6mgZnkEly0eecDci0Jflo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s1eZG+m44A34AAcPnyJ45jYAnlY5Y02ieiSkTpmTSwFgdnMvBM/lUHVsHL35m8+PX
	 x4OoFyJB26NE2aghErBEbHe1Lj3vIuTl6OqFqkO+7GXEgC6n5QT4xco5B8Vcnk6NmG
	 2j0RU204vWHN+nexvY0H6qy3U6cQjOk1kqdt9ihLPdD0avNQth2JgM0+Y7vF9DxGo5
	 B8biCHalnLNM/3wZnqrmwXlSQ+bpzA2iGZnQG2cWUb9KXOwu62AHkwwrhMSKuebV+i
	 2EnKBT01dsP0aWWJ6ju4oBfqj9Cp6hEsaJ4B/bD0Q9vQTuBU1PV7NCu1WylqdBRsnK
	 MfXBFXqI3cLPQ==
Date: Sun, 22 Mar 2026 18:08:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Mark Brown <broonie@kernel.org>, kernel-team@android.com,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH v8 04/10] dt-bindings: soc: google: gs101-pmu: allow
 power domains as children
Message-ID: <177422088580.68999.2696628451454506531.robh@kernel.org>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
 <20260318-gs101-pd-v8-4-241523460b10@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318-gs101-pd-v8-4-241523460b10@linaro.org>


On Wed, 18 Mar 2026 15:27:49 +0000, André Draszik wrote:
> The power domains are a property of / implemented in the PMU. As such,
> they should be modelled as child nodes of the PMU.
> 
> Note:
> Because the properties added are 'required', this commit breaks DT
> validation of the existing DT for Pixel 6, but a) that's simply because
> the DT is incomplete and b) a DT update will be posted once the binding
> is accepted.
> It is not possible to write the binding such that it supports old
> (incomplete) DTs in addition to the full version, but as per above
> it's not required to keep supporting old DTs.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
> v8:
> - move comment from commit message footer into body (Rob)
> - fix incorrect use of ranges in example (Rob)
> 
> v7:
> - really be consistent with quoting (Krzysztof)
> - drop invalid tested-by tag (Krzysztof)
> 
> v4:
> - consistent quoting using " (Krzysztof)
> - add samsung,dtzpc to example
> ---
>  .../bindings/soc/google/google,gs101-pmu.yaml      | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

