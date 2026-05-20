Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67631D381;
	Wed, 20 May 2026 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260733; cv=none; b=HfQz8HeopbwhBAI3viWk6XLs8Hwec4Zoq5gKFanTIOZWc9hB4DxYvY81kmAqVLYp2SYm4RqJ0WfLSzzIg9yCLhaCplAy4gEQCoKwOGnyr7D7IvH07LujJNXPr9c7/57lg1joLgXtKto3LDPbrx4T5IcLimA4YlXyyFaF1k7/904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260733; c=relaxed/simple;
	bh=jeyaqCM12UaFZUbm801ue7THJrNDtsZvHyqF29DrdmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiSXKpAZfNfmQGXrY55LtmpimcHZeRRld6RS981UIRDlCqN+cWSbPV7Ypg26CDGMnAXk8UgIrwLpkyiMCFF5B6eS8MJGkuD+0lklG9LCbSq5QSIZQhviECSCOYKAtcwbLNgBmif/nZ7y3jm7ksK4x/Q14OUqfjPUbyRGYy/939c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDxsmpiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDxsmpiZ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2C3531F000E9;
	Wed, 20 May 2026 07:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779260732;
	bh=dNxYJzRsqTJiSaP9X3cbcp8HsvdjAZnZvzwhsQ6A73g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZDxsmpiZQWOoN0bs5/c0t7VLjoF166oIR7cTYCve5nWIe1y9s0Vp4ojRAxN08WANx
	 l2bYLQIX/sxJwVgMKeYq5GJpmSCgF18JF/NrGU6kF8sNc5LotCw6pdEbNNnJJAWmKp
	 P/+AUwVf4l6m2v7JcUPVnk6MNmUQbvO2OU/A7wVS7FGvI+ejM8bCMwNNmES8/80MTh
	 XecBz+2nM7zYCm5/iOqUAhSit+9JUC/cMxwKPU0/3WrvIPJApDTRDh+BiYeGYj+FwW
	 ltpDe5hdoQ6+CgMQ+FRELxF7rzSPvczExpJexU4mrOyRCO3zbtnZrtSp5KbgqyfkP/
	 ZhG1QQFno3lOQ==
Date: Wed, 20 May 2026 09:05:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] dt-bindings: arm: airoha: Add the chip-scu node
 for AN7583 SoC
Message-ID: <20260520-bouncy-original-bulldog-5d67ed@quoll>
References: <20260519222433.29684-1-ansuelsmth@gmail.com>
 <20260519222433.29684-5-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519222433.29684-5-ansuelsmth@gmail.com>

On Wed, May 20, 2026 at 12:24:25AM +0200, Christian Marangi wrote:
> Document support for Airoha AN7583 chip-scu node.
> 
> This is similar to Airoha EN7581 with the addition of the presence of
> thermal sensor in addition to controlling HW PIN and other miscellaneous
> pheriperals.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/airoha,en7581-chip-scu.yaml       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
> index 67c449d804c2..0d042fb90a78 100644
> --- a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
> +++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
> @@ -18,16 +18,30 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - airoha,an7583-chip-scu
>            - airoha,en7581-chip-scu

Keep alphabetical order.

Best regards,
Krzysztof

