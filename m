Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D352F26E;
	Fri, 18 Sep 2026 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789768482; cv=none; b=U3aFhlOjpTeWtpCYWqHElhyOucEkmJCh+Wh9cKKGl/TRwH2G5ZZ37Nsz4qh4gsFyI3bHe1ThUspuM7ly2MFbSfb8AZuirCrGKr5u1uqLMb+C9hDjmSKmzBOwwjIQUUsQ4b1vvwLEKt9HEwKYf83xbeywawJ0AdCys2ZQxHxAOFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789768482; c=relaxed/simple;
	bh=APjgCQLgB2nhExtRuNmfVurF4rZ8NdJLg3PZMxluxNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUqvZl4k9W7FlB2SANe2d03dj6LlThMyQtK3XQoTi2q1dtZILtbGNIvFD7nyTs+17FD+xC6zjY1mg9MHVTzwwfX6I4mwWNlKH9RCEy8rVBntWNAzw1clIWE8HN/JkMIdKzTuawhOwj854X3Sblt9JmLbzWIp92d8q9mjuFkHdAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoYhzv4M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoYhzv4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95E41F000FF;
	Fri, 18 Sep 2026 21:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789768481;
	bh=/IGcE4Un2wpGwr+Z93YjNPv1ak5DqpFH5SF0r5Kz4u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SoYhzv4MR+LTYbfzms3XsI8GodI9iCPYHDPP3hYul5Vik7dq0ofmBKiKefD4dwCUj
	 x/OXVoDxa7t8NFm7rv4RX1Ukw71y2ADjm6eNDmiI3vjC7twgMQF1B7nWGbXYJFW8wt
	 GKIHYZRHTAb992YnyiDqYmzBI3+n/z6f6yULrAbPa1Ek4Otc0MbxL9cDJsF0/1OV29
	 gCjU5VL0nBHG7I3IDxn82PvzPqnolCnL94ZB9pbHcadrd9ViqRlWW/Kcdvez7BJlrs
	 5DT5FSyNsrCBWnig4Wu87TtH8uv1wfJkSu1qvVpicxu2gRJCPwK5gkV5KYqJD1zvMM
	 t4em0p4kCubgQ==
Date: Fri, 18 Sep 2026 16:54:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, linux-pm@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	linux-arm-kernel@lists.infradead.org,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 12/20] dt-bindings: watchdog: arm,twd-wdt: Allow power
 domains
Message-ID: <178976847923.2411948.11909002578336297742.robh@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-12-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-12-9d0c17e1f816@kernel.org>


On Mon, 14 Sep 2026 13:54:40 +0200, Linus Walleij wrote:
> Allow TWD watchdog nodes to reference their power domain.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

