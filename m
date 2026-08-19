Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE08448D05;
	Wed, 19 Aug 2026 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133184; cv=none; b=r4izB7F57C4B8EToGv2GwMC//aeaSElYothkJ3nROhukQPowZOSldnq0RQpY4rvSUMUPWCW6rvc96rx9mx6ZhEQFUkmCUY9MlIsIW44d6R8l86J2R69ijDd04LC8UVYW/ZobxlvSScCyGCaP3+Y/byAjlPlJPQB0Zhbd+Q/O/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133184; c=relaxed/simple;
	bh=y3QwPQKoyacYdfx+yFRTRRsHiOAJDm4MlXs9xs0Bc4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms6dO01IOboHhuUWIh7FCBw8KwtcAQyzsGwUTxBMCNj3kFpVDb5l6BdBx9Fw/CCtcn5QPJGrmr4P/BUFklbaOvLSmCkKVBClkr7BtgFbAlxpQdY12bjIDIrAsLgbg6BAnO4mF3SGRe0pjhl8D4a7fvkGaxCMmTE652IL5XFhYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOHTrXaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOHTrXaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC92B1F000E9;
	Wed, 19 Aug 2026 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787133177;
	bh=NYRoBK8EbGRRmGCMJEI3e7DjEmkit0ExY6GnKbvmDck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LOHTrXaUkr12UCZtKv6s4wUUdz6KmaoKLeF5dtHsGQTOXRNkvOylhVjWuD9nZcWeO
	 RPZGC2QK35WCD+4GeYSUMeKE0p9DsDPq9mEmuwI3UBTfqocW0+4xFxqyXdjRDuk43e
	 Y00/f6T6IZNJsdMUmCipIbvc6Se76rW9vdnckAX5uS5JHP/Bh2r179Om0OjloVsArZ
	 9/6kxErl+SKOURLiRaDJS9cx0UEeDVL0V+ChJnwufTA7uH+aq1rfYb2tZCHO2qja1w
	 1ALuBRRoYVEXuwzggwY7zFjgyPA+QaIzxpu+5quiRXM1643WN5Uf0cOFzXZ+ujOlh8
	 j5AgGckBUP0iQ==
Date: Wed, 19 Aug 2026 11:52:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Henrik Grimler <henrik.grimler@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, "Andrew F. Davis" <afd@ti.com>, Chris Lapa <chris@lapa.com.au>, 
	Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	kernel@axis.com
Subject: Re: [PATCH v2 1/3] dt-bindings: power: bq27xxx: bq27z561: allow
 interrupts property
Message-ID: <20260819-unstoppable-okapi-of-energy-dcfe19@quoll>
References: <20260818-bq27z746-v2-0-0371e206665f@axis.com>
 <20260818-bq27z746-v2-1-0371e206665f@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818-bq27z746-v2-1-0371e206665f@axis.com>

On Tue, Aug 18, 2026 at 11:48:20AM +0200, Henrik Grimler wrote:
> According to the technical reference manual for bq27z561 it has
> support for an interrupt on an INT pin. Remove it from the list of
> devices without interrupt support to better describe the hardware.
> 
> Fixes: b4f7a727c29c ("dt-bindings: power: supply: bq27xxx: document optional interrupt")
> Signed-off-by: Henrik Grimler <henrik.grimler@axis.com>
> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

