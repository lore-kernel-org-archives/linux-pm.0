Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD24052AC;
	Mon, 31 Aug 2026 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218798; cv=none; b=dJZd5FABf2fFlkKK9YL7Cs8fpsyT5qiuw3c9r+6NF1PsyT9FUsEW+oflDm6iF6PPTKojht1n2CLqEyQaZ42+Zt74XGABhiJp0dl09Z9ncj4UI89ljkVSEh4nnlwbqq/2Hp7wgVgSc3FDUlw0lAoE5/RlisnsKDOKaBRbvKZYYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218798; c=relaxed/simple;
	bh=HazZv9uRXn2zDEZ/VNQ6mnD7ecREtVQ840yGapev2aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9cbg4NQhP18NMiIV3sR/ZTUqRICDE2J3E6k63YeH9tJ44SIHEzMSqhcbBMe//xtpj8abzo+CEfaDBDhoggwHEuiDtpi1rLPFYQA1uffa6y9YXfLXkp8yYcU0AAA3KjjQyis7ld727OgkEMqDDgzESmxJqOr9zFvRfQJQd9w9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+lkcle7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+lkcle7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAF41F00A3D;
	Mon, 31 Aug 2026 23:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788218796;
	bh=jiqRW3Eq9poPOC9pat4jZSNSoS4ay2TFyWKMbTiZyfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f+lkcle7OS+KSeoRbbaxsYBWlKYTPYjUt4szEC4U9bRIBAtw9aQb3sVZ/J6klKPPf
	 eAR5cTjRhQTN8PgH/zaT8rTUGTONvA2suOx7022JtkwCISFFm/1rMlahD6+DwTF9jI
	 zMjpyWRzCSQ44AgLTpJ+lOquh7vrea21d1rEks9CBkQjU9MFJAUDFW244BlEqDNFdL
	 6vwCK8pUTcXyko/SdhgLhGiLrYu3rwAGnFoQu/Mm+ogqnK+CN7KXF6YFn9W1TBLA0x
	 CBRk+niaaZTuOAD/i/vwCC480PzecIrBdix54hNFbE6PUvNyRCPGcEGJ5Jsfs862tM
	 z1hTOt/ysK9Fw==
Date: Mon, 31 Aug 2026 18:26:32 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org, bmasney@redhat.com, 
	radu@rendec.net, abel.vesa@oss.qualcomm.com, lpieralisi@kernel.org, 
	taniya.das@oss.qualcomm.com, danila@mainlining.org, davidwronek@gmail.com, mani@kernel.org, 
	robimarko@gmail.com, linux@gurudas.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 04/13] clk: qcom: Add Global Clock Controller (GCC)
 driver for SM7250
Message-ID: <apYNXZ9TJEC6rVVf@baldur>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
 <20260824150156.1310-5-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824150156.1310-5-sreeshankar0910@gmail.com>

On Mon, Aug 24, 2026 at 03:01:47PM +0000, Sreeshankar K wrote:
> Add support for the global clock controller found on SM7250
> based devices. This should allow most non-multimedia device
> drivers to probe and control their clocks.

"This should"?

> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
[..]
> diff --git a/drivers/clk/qcom/gcc-sm7250.c b/drivers/clk/qcom/gcc-sm7250.c
[..]
> +	.clk_regs_configure = gcc_sm7250_clk_regs_configure,

/home/bjorn/sandbox/kernel/workspace/drivers/clk/qcom/gcc-sm7250.c:2228:24: error: incompatible function pointer types initializing 'void (*)(struct device *, struct regmap *)' with an expression of type 'void (struct regmap *)' [-Wincompatible-function-pointer-types]
 2228 |         .clk_regs_configure = gcc_sm7250_clk_regs_configure,
      |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Thank you,
Bjorn

> +};
