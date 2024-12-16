Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5FC1B6D1A;
	Mon, 16 Dec 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343485; cv=none; b=kF65zPlazoC6Ua4mcEAJd3VZnWjVR2jWyuJzvON0khttXZKzsNSb5/6UL5i7dR6BuZFBfZ5w+lwe+Jnn4lqaMStZ1eRYh9QGosVPTxd8JMdsTFAo2AvGeFQp9D1RhB3uiqyN+wvpRyT7CUX194+DxsXMWDkBqqVe1X0hREDhV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343485; c=relaxed/simple;
	bh=h3soJ/GHXkglGzwy5t8lMwa1WecVZ+A4tzP9OiFFs0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5rxUDaPZwo2iKmfGNBy95qDnm4z3K6rbrYQDePSjzDgHp5GGCHf0A8ZZRaG2Eza8Lc+bXKzUyPNKPX7BzeeJ0tBa7aX2/weRledjJ/DUvkq8A6SAuEz5Klib3LTRATh+XsmY09RUKadAr+4V8R2OgHBeoSQndtAkOcapPCJUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/nNDfii; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/nNDfii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D81C4CED0;
	Mon, 16 Dec 2024 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734343484;
	bh=h3soJ/GHXkglGzwy5t8lMwa1WecVZ+A4tzP9OiFFs0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/nNDfiiC2ajeCwW6rWTUCQkCQIfOjjUNv2t6PsGHaBBVHmwoXWXV2VWugaPfsmsD
	 xwUXl8twRFFBOSTAjJL8i0DkEgSDvJcZtGE5GZCRXQk5yi12c9w5n6gWZhB00fQDDp
	 3Na9pEYCULKLBs5Iqw58dl/uSvcBXJcXyY65jS/uAvXjoK3jXpQQeSODWnFZ1IHhi8
	 f10ORT3zFI+2TeeG29kl4Heo1DUHZDNN3JvBYHFomchuQF4PwR+f0OlZtumvFdxMMO
	 eD2EIiLVmbxelXmv8mXQhqKHFEYneGeN2RyBvyR+sOwuIh+FuFd336/ayPvL8JhQve
	 SKf8xYxsj5qwA==
Date: Mon, 16 Dec 2024 11:04:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: gpio-charger: add
 support for default charge current limit
Message-ID: <2tk4mnzzhr3se3sts7gyt27izhlsmzajvdgfszubgy74wggeom@kggdt4go667b>
References: <20241213-default-charge-current-limit-v2-0-45886fce905c@liebherr.com>
 <20241213-default-charge-current-limit-v2-1-45886fce905c@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213-default-charge-current-limit-v2-1-45886fce905c@liebherr.com>

On Fri, Dec 13, 2024 at 08:32:33PM +0100, Dimitri Fedrau wrote:
> With DT properties charge-current-limit-gpios and
> charge-current-limit-mapping one can define charge current limits in uA
> using up to 32 GPIOs. Add property charge-current-limit-default-microamp
> which selects a default charge current limit that must be listed in
> charge-current-limit-mapping.

Last time you wrote the point of it is to avoid defaulting to 0 A for
charging, because existing implementation uses smallest possible value.
This is supposed to be here in commit msg.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

