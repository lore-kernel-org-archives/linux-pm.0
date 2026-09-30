Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A83F8EA2;
	Wed, 30 Sep 2026 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768763; cv=none; b=NuLO4Jh5vLz6YYphFBYmIaz8BvDxfGo8Xd0k+4ox27E25IpkJH9NBSuwPoe2dCIyWcpjTh2roNGMKwzJ0HIGX0Wy6F72Bwb2bw+YBTFsNBnWBE9KQa539JTa/gLFk6tLByT1QWFawCJP6Gvge9MQDzH8o38TtXDr6EzLfLRYPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768763; c=relaxed/simple;
	bh=q0PmE3BXYzKC2hiPyozOAxkIyMNjdMyqzWqE7mAsj2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwK6Cb54YSnU2KBco6yhpT1OV7MOsWx07h9jQVx2EFLk0kilh54jThcMUqV0bSPsWjWGKoEB5BuTRCz20ucbIv1ysX/sUOJDxpQWo2DeDvmNNHquVwozDSVseaDitjpBTzRSWV01vLDs2OouagPHyBigH7uhlavgw+gF6oX8tGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3Vsz0H8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3Vsz0H8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4341F000FF;
	Wed, 30 Sep 2026 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790768760;
	bh=aV5u5aRXaQQEnAiaHkz7ZngY6X+rGsMshxH6ocvG3KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g3Vsz0H8mwII3DRDHpY3v0HtfF6aMnGdMINM26M0BU7TgEV1lyjKWmRQWG3q5qkXz
	 PwENhNkTSrkE5XAwQKm23HXc1ed+Uu3M9wZNMqDD2jlmrrh7P/L96oMZ3eC3tDldSF
	 EmusUQ8391HZqv/diQPsZJcomagC3BvIMEpg7l4ni6atPdBaR2QPKlExBeLurjlAcU
	 y1Ro+RxRYDPbFYNic/Xf6JCd2kHbGmPHcu380Zg+EW+4mroUAz+yilMw11UosS0NYU
	 2JAAznQYDBsH8tzmqNqWQNNfog20B52ElmqGcugTSBpN67hjGiAy5n5wUV5kAwbyGz
	 dZE2e1aF6c+xg==
Date: Wed, 30 Sep 2026 13:45:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: soc: rockchip: add boot ROM download
 boot mode
Message-ID: <20260930-hulking-swan-of-enterprise-94e2ae@quoll>
References: <20260929-b4-rk3576-reboot-mode-v2-0-5a34ca72065a@flipper.net>
 <20260929-b4-rk3576-reboot-mode-v2-1-5a34ca72065a@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929-b4-rk3576-reboot-mode-v2-1-5a34ca72065a@flipper.net>

On Tue, Sep 29, 2026 at 02:28:18PM +0400, Alexey Charkov wrote:
> Rockchip boot ROMs enter USB download mode, commonly known as maskrom,
> when they find 0xef08a53c in the register they take the boot mode from.
> Add the magic under the name U-Boot already uses for it, so that boards
> able to request it can do so symbolically.
> 
> Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

Drop, you cannot test it.

What is the point of such blanket tags which are not even applicable to
50% of patches here?

Best regards,
Krzysztof

