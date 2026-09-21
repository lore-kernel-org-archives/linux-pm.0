Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A454F4032;
	Mon, 21 Sep 2026 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016077; cv=none; b=UCIlRpGR20XDv5LqyMOlTtoqHevF7TQsQd5Kk3cTdhRZomijtPsf3gERoUpZ3QngFyFP/Criq88Pkdrl13cYogpGY4gW6SDrGZrL/OBvdKj1HwYtPhZshAHkXmHUlGWckmjiLEoAURQTV7EwZPWFVjWBS1HyKHTIx+B7XmwAhIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016077; c=relaxed/simple;
	bh=erDUfccdx9b1ae8tfdpzQo24LmbknARaiyYGluhC+9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4yOEI/THAZ9Ro2MRcgt6/+1Dw2/xHZ9cBMi/eLUo8Lf9HdZjQpHNgeCwtqZ/sXwuBnl+FBDqn99cb3Am2fxMJc4qevlUDwqycnm1OmXIGlyNrI1hp2EEmKSwtw7Ojt9fNmbbJJTql43yfY9AvQBVtXRVxayI8IpHjYcQ6RjCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU+QQFzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU+QQFzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACB31F000FF;
	Mon, 21 Sep 2026 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790016075;
	bh=qcGY65hS+6BY3CDr/NBRDjfgtOdWVX7qh93GVRRkDmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QU+QQFzwL2DzW81MiDQ21qaNETIZnN3LdiRsJ9XVYMQ7ujd4MhD0UDWdWcIIllIp+
	 7J7eoTHRSPfDu5xKz1fo2PeUb+bFLiy5f6THkYrua7NOgEyAmX5icuMeJSpnDq8xrx
	 g2dKUDtLRsLfZ636SdjsD14KqUGI8U94YjrUDnA84LvwyX34YE9rc7wVXlKADGS+U+
	 WP8I2nzLRlBKMPmfC1uBt5A5Y6BOPNK1+jRpoUtOte0hmYLMtPVgUIhyWtlHoqD9wI
	 d2hr+5yIE6JABNsXeD85oNbR7RgK+EO1J8ffhVIgNtm6hIN9CuATryz6k8WZ7v5zsu
	 lRHXe2SRtaaOA==
Date: Mon, 21 Sep 2026 13:41:13 -0500
From: Rob Herring <robh@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Christian Loehle <christian.loehle@arm.com>,
	Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Andre Draszik <andre.draszik@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, mfd@lists.linux.dev,
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v25 05/10] dt-bindings: arm: Document reboot mode magic
Message-ID: <20260921184113.GA1250850-robh@kernel.org>
References: <20260914-arm-psci-system_reset2-vendor-reboots-v25-0-4aaf5c09b5c2@oss.qualcomm.com>
 <20260914-arm-psci-system_reset2-vendor-reboots-v25-5-4aaf5c09b5c2@oss.qualcomm.com>
 <20260918220634.GA2441717-robh@kernel.org>
 <0e6877df-0306-474f-bc25-aa7d3fd2f53c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6877df-0306-474f-bc25-aa7d3fd2f53c@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 03:59:22PM +0530, Shivendra Pratap wrote:
> 
> 
> On 9/19/2026 3:36 AM, Rob Herring wrote:
> > > +            minimum: 0x80000000
> > > +          - description:
> > > +              arg2 (cookie_lo in 2-cell form, cookie_hi in 3-cell form)
> > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > Drop. Types are per property, not per item.
> 
> Ack.
> 
> > > +          - description: arg3 (cookie_lo in 3-cell form)
> > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > Drop.
> 
> something like this?
> 
>   items:
>     - description: arg1 (vendor-specific SYSTEM_RESET2 reset_type)
>       minimum: 0x80000000
>     - description: arg2 (cookie_lo in 2-cell form, cookie_hi in 3-cell form)
>     - description: arg3 (cookie_lo in 3-cell form)

Yes.

Rob
