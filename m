Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6E2F8E8E;
	Fri,  8 May 2026 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778203939; cv=none; b=nGQzRd8ZVCUgo/omeZC6XPHoPtpxLwqXF10IzDQso4Pz0nR3qXKIUc7O541K8lChFYJUVDAaHLndQUNN+8RZf6zh0v7oZFYCeeRRJhqbUehxyn1ps5D0oNdx+N7KVZWO9g50dnRoG0ct9IoS4bigx47ZcYbHec7rU9+ERfCRbiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778203939; c=relaxed/simple;
	bh=QP0xG48S9tXmtCpI+YjP2zIBDW86qbdVELRqOAKilqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajnXr/LbM7ff/1Db2zfyhJYypwSz2bldbPmzLsrFARqoKR0woraX5D5WJMJ/20yuT1c1f6oZOyrB6HQSax5FsgxyUQrvQELD1frIfrQbe4lZQrcX4af1F5WBAQ0Wz9jl9BHttVoX/NtfR2XCvTheT8HCNniEm2VPT4OemM8AEAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPtgybFn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPtgybFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE15C2BCB2;
	Fri,  8 May 2026 01:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778203938;
	bh=QP0xG48S9tXmtCpI+YjP2zIBDW86qbdVELRqOAKilqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPtgybFnxiU/9wqeAjmLiX5jcpkh22KSrUmRWWc0ifwYDfYI5gyFBGwRIM2DZWZ5R
	 shY1ZvtBAJTVNZs+G9H1+Jixrqyazmct2tfnZNPizRWaTh117NaqjFwo3rzZzFYAo2
	 g0LzwlQDrL6HZ/LO5JD8KtZvLsuJmjZyl09ax92f6tEKDhuBtfotn2m390TJLJwF1y
	 EJmhCPrNZaJSdSxyyEMA6T7JrmeM88MgwutZgQHhF2qF2dCfvMnf58uLHCj/yBiT18
	 mftY56a1uPxo47dT3bpTwaKyvCPEyLqvN6s41QIPpaM72gFxzgTbUkup1Q+0eeKaLc
	 ykXfd87BDzYTw==
Date: Thu, 7 May 2026 20:32:13 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Georgi Djakov <djakov@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Mike Tipton <mike.tipton@oss.qualcomm.com>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/5] interconnect: Add devm_of_icc_get_by_index() as
 exported API for users
Message-ID: <af08-zMGzSSsw_NR@baldur>
References: <20260501-milos-camcc-icc-v2-0-bb83c1256cc3@fairphone.com>
 <20260501-milos-camcc-icc-v2-1-bb83c1256cc3@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-milos-camcc-icc-v2-1-bb83c1256cc3@fairphone.com>

On Fri, May 01, 2026 at 11:18:29AM +0200, Luca Weiss wrote:
> Users can use devm version of of_icc_get_by_index() to benefit from
> automatic resource release.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Georgi, can I have an ack on this, or an immutable branch and a ping
once it's available?

Thanks,
Bjorn

> ---
>  drivers/interconnect/core.c  | 20 ++++++++++++++++++++
>  include/linux/interconnect.h |  6 ++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 8569b78a1851..bc2e416dbcb2 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -443,6 +443,26 @@ struct icc_path *devm_of_icc_get(struct device *dev, const char *name)
>  }
>  EXPORT_SYMBOL_GPL(devm_of_icc_get);
>  
> +struct icc_path *devm_of_icc_get_by_index(struct device *dev, int idx)
> +{
> +	struct icc_path **ptr, *path;
> +
> +	ptr = devres_alloc(devm_icc_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	path = of_icc_get_by_index(dev, idx);
> +	if (!IS_ERR(path)) {
> +		*ptr = path;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> +
> +	return path;
> +}
> +EXPORT_SYMBOL_GPL(devm_of_icc_get_by_index);
> +
>  /**
>   * of_icc_get_by_index() - get a path handle from a DT node based on index
>   * @dev: device pointer for the consumer device
> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
> index 4b12821528a6..75a32ad0482e 100644
> --- a/include/linux/interconnect.h
> +++ b/include/linux/interconnect.h
> @@ -47,6 +47,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name);
>  struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
>  int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths);
>  struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
> +struct icc_path *devm_of_icc_get_by_index(struct device *dev, int idx);
>  void icc_put(struct icc_path *path);
>  int icc_enable(struct icc_path *path);
>  int icc_disable(struct icc_path *path);
> @@ -79,6 +80,11 @@ static inline struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
>  	return NULL;
>  }
>  
> +static inline struct icc_path *devm_of_icc_get_by_index(struct device *dev, int idx)
> +{
> +	return NULL;
> +}
> +
>  static inline void icc_put(struct icc_path *path)
>  {
>  }
> 
> -- 
> 2.54.0
> 
