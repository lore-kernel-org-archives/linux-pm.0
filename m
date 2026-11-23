Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436512;
	b=X02saJno2uDvOq+gMzZuhPa9kmP9uULIoL6OTImooR8mDj+Wk4gkk/nycm0rViqwGa9c
	 4BbjDFEjlwWDRD67EBvUMMfG5ekYXyyW4Kt8Y9BgaLsdsuF8iVEuQFdTJGQSk2LcpUnWT
	 Z6qjddjziqWWuCKfdCknHHSxLYAc/Q0tk+TNGDunBTCV6sA9gjDZj+g3+TUZm9RNXf4fe
	 kIukjbjg2UhtH5sHri2iYnTzkdcYqYIpfk/pealFjjMkqQmNLaZyX/vcommpgJLcMS/OI
	 WZrgVT57MyvL715aW6T2PZ8xFhfUrR+ZAAMEElOmdRun3akxXAaTp9SOZklYYoKw4qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436512;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H19bC14P+Fq0u7h+LnbIUXQzZu545dObmgwVSvQDwYk=;
	b=hdxACd68htFEHX47veVGUT9Q6HQvvJD6xK0yrws7aJsnxP+CxLbcdb/k/7p2AI1Zfzue
	 JLFtyZPhQn5C1iVT6OCj6wF5hCCMFzxvVan3unVuDX/RA0WyT6jpxqmfUzCGHZErnRvpP
	 xzGTZQwQHMD3vyVg8CInZ9Tj9FDw9Br3cchtYUKegorBVh30sKE3Ewsv0K6ogmrJrXTGE
	 qsItUIUNiMYS8eBV6xV0KonOiq6/k55+ht7TcvGOv2I16GXvNh1KqbOw+L1Eei/t5AuG3
	 P8N4uZYvTEhKYj5ak5ooRgg/SnglIbwm4Spg8WHKEKx8L0JPWLY4SpYU58aA/njcwSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4kQvRYX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242B606A31A;
	Mon, 23 Nov 2026 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J4kQvRYX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E231A1F000CA;
	Mon, 23 Nov 2026 12:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436511;
	bh=H19bC14P+Fq0u7h+LnbIUXQzZu545dObmgwVSvQDwYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J4kQvRYX4cRJlYBYPvV8UCcRw4CY4NWRq6I8ePpPztgvlHI9Iu7p7qJZrv/My7+n4
	 L91EOq0AWHZd+NLIJyF5x6QeNvdznETlVLTwYvb9h/b5A41kfXiyc6f7ol/mImR7Mv
	 P6xjZbOpB2ZmUcIPMY79LBfhZ1QPh5mPEyMh6tDtvAsuzeZ/CXZ8NjXr4yKnqJIXPP
	 HP6Yw+3mDXfqAA3YsGtyFtAT19VOvwLj377rbOtFZoFVMRxoCMaobc2VUAegG7lQ0u
	 uZuXg/w4vhuJv1JWvWGvTsGz2tA5+DMnBo+wlr0WUo7dar2o8gu7FarrILTSdWFokM
	 ks1zSI+1ncErg==
Date: Mon, 23 Nov 2026 13:21:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, ychuang3@nuvoton.com, 
	schung@nuvoton.com, p.zabel@pengutronix.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: nuvoton,ma35d1-reset: Add
 #thermal-sensor-cells
Message-ID: <20261123-clever-ingenious-saluki-5ea443@quoll>
References: <20261117060501.2611071-1-zychennvt@gmail.com>
 <20261117060501.2611071-2-zychennvt@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261117060501.2611071-2-zychennvt@gmail.com>

On Tue, Nov 17, 2026 at 02:04:58PM +0800, Zi-Yu Chen wrote:
> The system management (SYS) block of the MA35D1 SoC also hosts the
> on-chip temperature sensor. The sensor is controlled through a single
> SYS register and has no resources of its own.
> 
> Allow the SYS node to act as a thermal sensor provider instead of
> adding a child node that would only exist to instantiate a driver.
> 
> Reference the common thermal-sensor schema and update the title to
> reflect that the node describes the whole SYS block. This makes
> #thermal-sensor-cells a required property, which is fine as the sensor
> is always present in the SoC and no driver depends on the property.
> 
> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
> ---
>  .../bindings/reset/nuvoton,ma35d1-reset.yaml        | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

