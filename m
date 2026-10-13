Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60F37A851;
	Tue, 13 Oct 2026 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876223; cv=none; b=ma0Tp3Z2jS8bJZK9tRuj+Hp17mc6A2MX9i4I8BkMWyfJFUCntW1cP4AbTcbHvC7w+s/uTn08Db3UgDjQg4QCiy862v51i8qJ3E9ToABU1/kXs176R2fHReIGSs7HKn9ckZzKWtmU7yF2x2JP2UrkFJ+TUS4ZN+DzXkBhuG2kNnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876223; c=relaxed/simple;
	bh=19ToMy2ByqL69aqVkZrVqejSIl4lAIMOCpq9cnNgjlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tN4pxB4uLUpz0Blbdd86zgxSRNgFFJ0J4FxZrU6SrWQWl/B7ekIYShIHpLXyN9KYSIWcINfA0Jw5FJPmIe1YgRpROOmsM9o3MFQl/t0Qu5ddqeO0kQbBONLyxKQURm09s+bUCgWdQwjqPQqmUSdQ3bSqs08w1VLX7f10E7LA1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDBhvRQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDBhvRQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242641F000FF;
	Tue, 13 Oct 2026 07:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791876222;
	bh=9E7huG+IX3VUsBj8kOL6lXqalD+ceLUjMJv5mqB6cAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oDBhvRQ1S511T8QPmZtRW5Ap5VVwJkWVDqP7llNwPtlcttsU0Ipbs5WcKLTXmcXEE
	 KMzShSDQGz6jDwXEwqInr77zyhSgzOnblV+ZEC2Nh+I1zuARYuwat9mTLEL3LYkkDj
	 ucoT7cPJHcZNlfr5ldebEX3gNXuDslVOR7meS7VtzORkO6cn6BSqEOWTryszlfJb3q
	 +0tsWhG50iEUBOyKqfm66cEaKEdrFoyaHLbcw7NcVSI9to5jbTQOvVmrObK9yixgXd
	 xx4vhFLdlFHi0/w32F+rOjkWtt0k92Ofxyqid14qBaXHqTLTKbSrgUPUtuy5G9o00P
	 fkadIUI5ZUkhg==
Date: Tue, 13 Oct 2026 09:23:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adrian Nguyen <thenguyen1024@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: power: supply: Add Qualcomm SMB1351
 charger
Message-ID: <20261013-big-honeybee-from-jupiter-4cac08@quoll>
References: <20261011072135.12757-1-thenguyen1024@gmail.com>
 <20261011072135.12757-2-thenguyen1024@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261011072135.12757-2-thenguyen1024@gmail.com>

On Sun, Oct 11, 2026 at 02:21:34PM +0700, Adrian Nguyen wrote:
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: qcom,smb1351
> +      - items:
> +          - const: qcom,smb1350
> +          - const: qcom,smb1351
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      The STAT output, which the chip can drive as an interrupt line.
> +    maxItems: 1
> +
> +  monitored-battery: true

Drop, power-supply.yaml brings it.

With this fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

