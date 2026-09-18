Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41EF522F19;
	Fri, 18 Sep 2026 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768471; cv=none; b=IDBqc0r2nlEkCxrSM+BdKm3/20IVyNsZBLkLfmPdPvpo9jzTbvelLR/ar7Sl42HMbS0kESc4fK2DRoTSUhqRpuoGIHrqvr48qxaN4d5Zz+2dWDAi1cwymTYORMdglxjin/WvFFND97wMxL8KqlwuYFR+4X5ztfV3vMgF2sr0T1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768471; c=relaxed/simple;
	bh=qPEVkrG2LZkjdkLwHphSCjRKR2zGvvam+yV+0sG1Pdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEbC4Wpk2ClDB8GPpW3VmuHGgMPPvMxg+roKqPx0VjEbJfDG70Rl8uRo5Jxz0W6agJmKMpA7u8YJYyMEDkkbQS3FuLuKXD1pR0UMFz61KTCuiXiBpZrZh7wB55LigVU5gbUCQyIhLr8KjM8EGRvankKD/NA2WAzKB/bGMveMUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLbvXml5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLbvXml5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9771F000FF;
	Fri, 18 Sep 2026 21:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789768470;
	bh=UN/6arrxng22tJrn7BRCyO+ECsAZSProc9+N1c5mFT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QLbvXml5HHRNDrwkCg+JH2fLuaCctWQ8iqIQd6SJOLgqvoHb2+X8/5bGYMqryclzG
	 uFXYD145O0HyAaSciFIjZylqQC74BunUrPHuE5MDQV4FM08qCaO8OnrwvfiNVEk2IB
	 /knds9ot/tok9odystSPYMruqvTiJlsf0ubXx9VWXezfyWoB8ZhRAknMwPjVQNHkce
	 7WaAuEdUVfzZo5h1fvF2GfOFppsdkYlIEj0kFgNYmgXwqWxkf/qas/WwnzlFvwZJ7F
	 /UH4dUkLO1j9uNMqcKpRWYOPCcF1ldLZZODsjqcKsk3RBZqmEymdYUCWjUXzruBGGi
	 CKXHZ2QpQJMpw==
Date: Fri, 18 Sep 2026 16:54:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Mark Brown <broonie@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 11/20] dt-bindings: timer: arm,twd-timer: Allow power
 domains
Message-ID: <178976846922.2411312.3899064627778136436.robh@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-11-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-11-9d0c17e1f816@kernel.org>


On Mon, 14 Sep 2026 13:54:39 +0200, Linus Walleij wrote:
> Allow TWD timer nodes to reference their power domain.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/timer/arm,twd-timer.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

