Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4696ACA5A;
	Wed, 11 Feb 2026 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770843818; cv=none; b=uiBhvMsG74s8kXUmcV/W3OrvGcLECS/FOOf820lQbgKyfK1Kg9SGMwCAKG0ABq4MYOZvalGeWRt0d/FvJRqJdiAx5s+LMfBC53mXLypp07N05qui5GaK6dLZCKxuRDV2Gh26dcIzmwDDywi1RiGyYk+aNxJXfkwfi5WFVVXimCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770843818; c=relaxed/simple;
	bh=yKZgXX+CsYRZzhuWXY3GAbVJ6v2rTJISb4JSw/063sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udTfdUj/crwHcFD7/VYqFAnwTcyAqOkiCZySFCJPoi41IyvdqVwsm5I595feT5q2eDe9PKlPeoLhejF9OO53d8D/pjGjS87bGbvBITczbrdrdZ+bS0/ydXUNnP3eL61/PHCbaMj8TpZF0dXjUUnWfyO+YyMLRaFxAr02kU6dums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJzwUTrR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJzwUTrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B690EC4CEF7;
	Wed, 11 Feb 2026 21:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770843817;
	bh=yKZgXX+CsYRZzhuWXY3GAbVJ6v2rTJISb4JSw/063sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJzwUTrROdDwAU473dmNRp1Kjga6TjSB46dDrsHdY86NUWg9BfPd7zfMrNzzhmnXp
	 vRZi15J+OWDJL+yDmxgfVjK/8UUeiy9vStjc4DDH5DindDJLYRMwSmLBsSG2NUW2t+
	 oVHFAhY3MjyJ92+xqwPTtpx9Lz0i+E44M5nuNReLPspX6jkxI2HoYAlaBJhMvDB0q9
	 h4DidSQ+PB0sHGHk3tBXTP19p4HMxsnVjDkDjWQ3QskhYLEOM+5eJFU9j6CTzrGztX
	 Q4idPT4ST2EA3LwsEZ7ShYBdBMYs4GVsBkyY/r1/rHJQIqUI3p4ERBbZF5RIFQIWT7
	 K+bJ5lku9A2+Q==
Date: Wed, 11 Feb 2026 15:03:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: kernel-team@android.com, linux-pm@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, Juan Yescas <jyescas@google.com>,
	Will McVicker <willmcvicker@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] dt-bindings: soc: samsung: exynos-pmu: move
 gs101-pmu into separate binding
Message-ID: <177084381638.3881673.13620235276834374128.robh@kernel.org>
References: <20260205-gs101-pd-v5-0-ede49cdb57a6@linaro.org>
 <20260205-gs101-pd-v5-3-ede49cdb57a6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205-gs101-pd-v5-3-ede49cdb57a6@linaro.org>


On Thu, 05 Feb 2026 21:42:31 +0000, André Draszik wrote:
> The gs101-pmu binding is going to acquire various additional (pattern)
> properties that don't apply to other PMUs supported by this binding.
> 
> To enable this, move google,gs101-pmu into a separate binding.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
> v4:
> - update since 'syscon' was removed from gs101-pmu compatibles
> - update since 'select:' was removed from google,gs101-pmu.yaml
> 
> v3:
> - use additionalProperties, not unevaluatedProperties
> - fix path in $id (Rob)
> - drop comment around 'select' (Rob)
> ---
>  .../bindings/soc/google/google,gs101-pmu.yaml      | 56 ++++++++++++++++++++++
>  .../bindings/soc/samsung/exynos-pmu.yaml           | 20 --------
>  MAINTAINERS                                        |  1 +
>  3 files changed, 57 insertions(+), 20 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

