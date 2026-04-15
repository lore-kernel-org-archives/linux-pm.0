Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A913A3808;
	Wed, 15 Apr 2026 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237563; cv=none; b=rLGiSnzeSzxEw/G1i8wtyqloL2U3O3Q15ZSYt1MlmbviuXg/VmZ7Cgb52DSkIwRMTN41FUa6h136gKU0IQot/QyoZo+G5SBNQKmo2chBkwcZ6Ilf7sgrobbReL4K+iVAGqoqKAW2POuxyAMbo3p0eAozJHGruUUcjas8HX6GnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237563; c=relaxed/simple;
	bh=cqeH4VnU9rttfdqTTL3eEQCaEIxdRadBfzQXr8ODzcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnypRiOW7YxX/11Ks3WMj3qNz6pRjWMUabiAWbyDZbERCoQk58RZflFflGrB3oyOgHNvFCyT7Bas9sukoB0XM4YVz7BQSOP9XPy6Jb6mi3R7wHdUIfuQegWZbMMwJRqi1AWzPfxTezbwQMPZ3WGOcJTwFWUDGGE8mZ+DildTeK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTnwxubQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTnwxubQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC4FC19424;
	Wed, 15 Apr 2026 07:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776237562;
	bh=cqeH4VnU9rttfdqTTL3eEQCaEIxdRadBfzQXr8ODzcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mTnwxubQs1lPZ2/AnA5HhUIOM/Bmi3By19r1rz3P8hPNFpyNx9mCRkdN0RySraUCI
	 Dn8XyCsiFC2H4gqVHccAlZTIeIy8fVul2sp8RmgpBQ3bgX0Hx+oCg5DxDmLRhCffO1
	 Nxnne2mPihd2fO52eh0MkkE7DPCi84PpRdTElltV9DpHB0Jkap5T7vabaB8uBd25o5
	 Jy5mg0jQcDB4UfNT+oGD0YSYqNIkuNr6vlMiS8re2KmDW5VZJV/FaCBaTQAi86wh+X
	 nkue6kRbl2lhx9cg6qS+WRrd79jrE3tqz9fdiwETWQsUG7GXgERcClAV7J5k7IVJn2
	 3YVmMqAjvzITw==
Date: Wed, 15 Apr 2026 09:19:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Nam Tran <trannamatk@gmail.com>, =?utf-8?B?xYF1a2FzeiBMZWJpZWR6acWEc2tp?= <kernel@lvkasz.us>, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 07/13] mfd: sec: set DMA coherent mask
Message-ID: <20260415-petite-tireless-binturong-341ea3@quoll>
References: <20260414-s2mu005-pmic-v4-0-7fe7480577e6@disroot.org>
 <20260414-s2mu005-pmic-v4-7-7fe7480577e6@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414-s2mu005-pmic-v4-7-7fe7480577e6@disroot.org>

On Tue, Apr 14, 2026 at 12:02:59PM +0530, Kaustabh Chakraborty wrote:
> Kernel logs are filled with "DMA mask not set" messages for every
> sub-device. The device does not use DMA for communication, so these
> messages are useless. Disable the coherent DMA mask for the PMIC device,
> which is also propagated to sub-devices.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml | 3 +++
>  drivers/mfd/sec-common.c                                   | 3 +++
>  2 files changed, 6 insertions(+)
>

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

