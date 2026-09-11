Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003904483A4;
	Fri, 11 Sep 2026 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114824; cv=none; b=YGKjcbhtRbC1bbjcnRC3QodC6D3GzYFO08FL/n1n9rXe3QId4ymbELRZJesJeLh3hoP+ePX+N2NPuSI7cMPZQF+tLe9xy+SO0omRxq5sf7bUZWgBDpUjIOVf2zxeJNOOkTp/NXQ8UG/db0NqLxOVKwlgzHrSdgNBHr+RZ78o9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114824; c=relaxed/simple;
	bh=xmsQyJ/QklFMTqaX5qmXI4VOHeLjqJ36W3Dh/16BKPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI46GAM/FMY5nx3lskgq+GMmjToSslSuDvs0csXE/T9JfT1zlmvUa9E+d/djZwOrwUp1MZbfBdVbW8cGbornJYR3TQSODw/3ubZyNVByiJATLFvwH7DNl133UPABMjNZNfa7m8elhtEmVjZ6W7Dw/5EY0MYAWcBma5ET0omHDp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFUPkdFJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFUPkdFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD771F000FF;
	Fri, 11 Sep 2026 08:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789114822;
	bh=xmsQyJ/QklFMTqaX5qmXI4VOHeLjqJ36W3Dh/16BKPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iFUPkdFJg/kJo4PbYBkxsNHPyJ/jgMXHKBA1cwNryslLxCbgJ2XyInxn51UMAS2+y
	 bA/YS2m2yhHmadVzVLe95NrPl78O2dGR/Pp5gfHTTP0g+8EkWdfEudNuQjxhyD4rfO
	 FQuLZmV/BEounRG6HWcDIcI/t82FyqQVXegQUl1NL66aOJqs8B4oFXr/a9nr+C580u
	 6pR49nEMfcvZqyKAjB/8sEm8QY9sCHZQE1c9vQpKt/uvVgwwkkMGpnvDF1ALSAoP1h
	 r7rI4adpF6j9a0zvTc0ERhRcD3ZabXCGNgmYP4UuAc7FK0xwiMBzVT5QbNRK848zBF
	 mKtX4JRMM8uTQ==
Date: Fri, 11 Sep 2026 10:20:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	David Heidelberg <david@ixit.cz>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, "Andrew F . Davis" <afd@ti.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: power: supply: bq27xxx: add generic
 compatible
Message-ID: <20260911-rare-honored-spoonbill-132c0f@quoll>
References: <20260829205258.26955-1-rinat.muhamedgaliev@gmail.com>
 <20260909234744.1177153-1-rinat.muhamedgaliev@gmail.com>
 <20260909234744.1177153-2-rinat.muhamedgaliev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909234744.1177153-2-rinat.muhamedgaliev@gmail.com>

On Thu, Sep 10, 2026 at 02:47:42AM +0300, Rinat Muhamedgaliev wrote:
> Add a generic compatible for I2C fuel gauges whose device type is
> determined at probe time.

Generic compatibles are not allowed. Existing ones should be used.

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

Best regards,
Krzysztof

