Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B838B7CD;
	Sun,  4 Oct 2026 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791101216; cv=none; b=UfbIn6YxPrM2MeMqct8/x6vl6n0dFAknvH1mkSHvGyf0z+OOsi/+5gsjnEdVl100gJtcxU2PbcTDtCmQyzpctr7xahl1tDwOzlFMV/3YExzFFYy2OSDknVOsIITeOk8imX551R2Bfyer5GlyD3NFSxhfuD92sVqu2/9NHVRMxLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791101216; c=relaxed/simple;
	bh=PKBu3xV6QKKtSKiJ8rb7HAO8rvGoi/hUCba+uwbNUZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=deeZVvoKLZhyWRrS+hV9X27jvqYITwPmHsLitkJlABTXNWx6hWWAcFEjZfFGnLiNNXoMtq5JIpjQEZa/fCDFuedZs3cmPryFO6WQqlks3PlHg0vNTv7XMxwsG8+dIG1K/XN4wyz4qG8fsuhcc+SIHE1MDbTvca/0fV03N5EZ23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifwK0MoN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifwK0MoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA01F000FF;
	Sun,  4 Oct 2026 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791101214;
	bh=PKBu3xV6QKKtSKiJ8rb7HAO8rvGoi/hUCba+uwbNUZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ifwK0MoNXhDqr8XzV+Egqfubi7nJV5sPXUlZKIb86RBBwc6NnHrP1/CENgKSVSSOd
	 tAKWfqBc6ZQV9N7pVbKt3yE/DrkVqjA5cIFYTgevwe8+ZGOg08+MKLrNiCq40xqjmh
	 oaJWNrju/HJSHKqb+oJQ1B4UnhPcHJBMw8cUKq63fAZkKu7kFB6uc22Zb2kPpDXoSn
	 sUCYRTHaRKvFK5J/qdL8/RsEimJZ2PvV7NxwK4INnnXbcAhtSpLtn7vnG6qa9jTteJ
	 hz1mCVUbKpnfO1qP0fTVIH3U7C0eUPSvIc3Du2Uc/OIjaG5O42619xHtEYh7F+zYgC
	 ZgEs6/QIpezlw==
Date: Sun, 4 Oct 2026 10:06:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabricio Akio <fabricioakio@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Robin Snyders <robin@snyders.xyz>, 
	David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
	Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/4] dt-bindings: power: supply: qcom,pmi8998-charger:
 add chg-state-change
Message-ID: <20261004-jovial-fancy-ammonite-f9fd1d@quoll>
References: <20261003-qcom-smbx-chg-state-change-v1-0-fffaef446932@gmail.com>
 <20261003-qcom-smbx-chg-state-change-v1-1-fffaef446932@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261003-qcom-smbx-chg-state-change-v1-1-fffaef446932@gmail.com>

On Sat, Oct 03, 2026 at 04:45:21PM -0300, Fabricio Akio wrote:
> The charger raises an interrupt when its charging state changes. Allow

Each of the ones mentioned in the binding?

> it as an optional fifth interrupt.

Best regards,
Krzysztof

