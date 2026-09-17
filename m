Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E023EDE76;
	Thu, 17 Sep 2026 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633123; cv=none; b=bWKyd2XqGue1Frk5nxHAzMYgZVMkIqlrWHDFfs9XKE5MeV44AYFj7LHURb9FOVD8XYe4vwCKVfN8JINSymMX2sk926gSogp5lL8K6RqQFwVJD/9+iXCG0mO7qk6jcSXY296Cx40++u7IkB7ic+huKcAcunhOwnj0VBU+oJigkX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633123; c=relaxed/simple;
	bh=SvOAAvEqQrXLsQwlnPnQWnbNbrravmSOiEtsZTzR2W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3LkpT7uJcqzsqNanxRYhcIlXlD3I5HPrNkHm4Y/tpaxf4iXlptBohCJbbXd6dU2ZONPauAwiIpCJ/cmXdmdDm3ps4WaIzJYflBMFnvb2SPeqzFViqCiI9K818EEH8YKZjy0eORq/J0pHg0QGbTts0P8WvLfvCX+P01OT2suAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZzb+MUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZzb+MUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C567B1F000FF;
	Thu, 17 Sep 2026 08:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789633121;
	bh=SvOAAvEqQrXLsQwlnPnQWnbNbrravmSOiEtsZTzR2W0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FZzb+MUvs6DCrqSinxiRcAYbsiqLJmbaQGqvWAaPxdsyKGJrCYTqyOls4HSAXgZdW
	 CQn7MYibOWxHyT1JtOiT/aPpYQJbdKx7v2p/y29eC+07Puc2JDxM9BMzCPQotOKKDh
	 NYHNfeoo7GN9L82+janmD/eln+b1xqpG4GXAovuzpjME8VQFyWiwo4joFP5AsdVXs9
	 PhpOT2C960tkSIrhDIdOhhFWjEoC98CtLR4Szior/6FJ/gtAcbVyF56DNjICHKpgsE
	 JSLAUxzVg8Gp3IxgGO0xFz75JwXLTcawr5rjgZY7SuNk/gruMnK5Dour9h9SHNuRul
	 MBuF/um2AyKrw==
Date: Thu, 17 Sep 2026 10:18:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 08/20] dt-bindings: cache: l2c2x0: Document power
 domain
Message-ID: <20260917-sexy-jasmine-roadrunner-c31d90@quoll>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-8-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-8-9d0c17e1f816@kernel.org>

On Mon, Sep 14, 2026 at 01:54:36PM +0200, Linus Walleij wrote:
> Describe the optional power domain for cache controllers.

It is already described.

Best regards,
Krzysztof

