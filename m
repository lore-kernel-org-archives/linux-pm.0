Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433A3B636C;
	Mon, 20 Jul 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784531176; cv=none; b=DzU0DIgaSQj3D9txtprmXNUnktXPQELyB+EOrOFLWePykts2VPMF5e057r52GZIJ0tqQMmQH4wfbQRF5XoVvaRJJ7cIEKGl80nERJjjjEyDYP4JOUjrQrReOJFbX9ZCH1Q7pgH6OGERiOTAffbMJKwm/0ob1For4JLV/LUT0eZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784531176; c=relaxed/simple;
	bh=Mo5iW0ecp5dDtDsHCPdHbqYD0jDODScvF1yMPhYFuwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBfI4038yWEgNpj3qAeLEryBhJc4x2AZrQTlvjsDt4E7Eg7iZcmMQ+jdQi0GBQJ+9bZllkr6vSdI7qtE+i0i7HTWp0Y6dG/ZkK9wnpQ1xvlLjucDR18Xiu+8tOQ5MMi0pEIKepMZ9ekcKArEc79P0OH09RbtsE1E3+hj/Ry/Dv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYnVqfs2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYnVqfs2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E7A1F000E9;
	Mon, 20 Jul 2026 07:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784531174;
	bh=VzOto6V24zCwZjm5rqJ05WkrIRAlb4Vob9mKqX7ilFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UYnVqfs2F35rcEctNNcOwtP/OIZUIff3dx+bOhjscnl16W6NU/BUZP9jdru4P4hbb
	 t5rxHyoHqCs5K4UsvWlSpYul6BG4nqbcZiHWJN47dD+w3I30cgGgM4kmKMv/Vgo9ky
	 JVpAC+WHd4IqChLc4r7qf1JJJBeL7lEvDiAK2Ny3vBY5S/hWEPHnlwT5+9XuRwk3Zl
	 22yqIiVsv5rxAimwRh+t5nCqqxYdZyOJMeryfjzHgb+hbLpVJIL+X+oBjKUVIXTK8W
	 SCu0W8ECciLy8S6YQSSA0BuOQR/8hyPhxT4YvHXR6ng2YoUeOWyopNZj2VZVlrfRf3
	 4dZjTQxfz7Qvw==
Date: Mon, 20 Jul 2026 09:06:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Cloutier <vincent@cloutier.co>
Subject: Re: [PATCH v2 4/4] dt-bindings: power: supply: max17042: Allow
 monitored-battery
Message-ID: <20260720-fresh-vehement-toucan-07c895@quoll>
References: <20260720011144.1280219-1-vincent.cloutier@icloud.com>
 <20260720011144.1280219-5-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260720011144.1280219-5-vincent.cloutier@icloud.com>

On Sun, Jul 19, 2026 at 09:11:40PM -0400, Vincent Cloutier wrote:
> From: Vincent Cloutier <vincent@cloutier.co>
> 
> The MAX17042 family binding references the generic power-supply schema,
> but its additionalProperties restriction means generic properties must
> also be admitted explicitly.

With the same explanation, just change additionalProps into
unevaluatedProperties.

Best regards,
Krzysztof

