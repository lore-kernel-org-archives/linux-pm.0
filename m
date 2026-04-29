Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801A3F54C4;
	Wed, 29 Apr 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463905; cv=none; b=pUyQ0cDUzbFV5e3sOLvF6VuhBCpBuFBjBO74QwZv/n2QdxiQBiamTwjkASdKd5QWY0J7wQ4UEBdOx/YMAfRYe1LBxzSuiJS+8d6xHx1F/p7F6g1yO3l3cIpny+9eFAx7mWKAZA7swnife6+D1T6SgTvcf6jm0rHvFIvxr5SP84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463905; c=relaxed/simple;
	bh=tc1x2jFTiS6LhuWXCPLieRSj6Q/gppWfSAnb8qnejuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDNxvFkn/YKIpSdSPtxpFh9i5/QqpUVNSHc8yo8oy+a/nMz5UcNhx2K5oYtMF1YAXVfH+vPJrVJavI5JLT12JbWGRy/zyeTKw6lhOGFWWOIc5TWBZ7kByHr4kdJFyI5KFUb+horHx7mOfEexArIiiiHGoU8rXTRdxzQb5yuVb+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQC0WLW4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQC0WLW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EB8C19425;
	Wed, 29 Apr 2026 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777463904;
	bh=tc1x2jFTiS6LhuWXCPLieRSj6Q/gppWfSAnb8qnejuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQC0WLW4S7uH5MRDcyQoXC+Q5Yk9pkq0jUEVDOB41gvOk4I+/t3GCO8tM7RLlMP4U
	 eZSNx7aYxglGV7RjSQleKBtaQ81faWIlY975sQntD+D9oJxqRJDalQTHFk5RCZK2v8
	 P29HH0IhBCqmf0rEEkeIP9BGiRPCtKd5hhZik/26VjglbsTPGuO/EYqoNu4iTmpWEj
	 zeRnCRNxdf3aIfydquon806G/im0+rwiTIQMJUPtj+5mQYJA2j8lCdyULBWQlSgzdI
	 opEYVKiELwOlx9/VjoAfynGSocsN9rUTLJt6lE/3Vn4A/QeidMPTgFur81eudNp7Gf
	 033itvB5gus8Q==
Date: Wed, 29 Apr 2026 13:58:22 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, 
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, xsf@rock-chips.com, sre@kernel.org, simona@ffwll.ch, 
	airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org, 
	maarten.lankhorst@linux.intel.com, jesszhan0024@gmail.com, neil.armstrong@linaro.org, 
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: power: supply: sgm41542: document
 sgm41542
Message-ID: <20260429-boisterous-cyber-hyena-ce870a@quoll>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-2-macroalpha82@gmail.com>
 <20260428-bulky-nebulous-reindeer-ed45ed@quoll>
 <PH0PR19MB997338F0B06B7B99AA0ED3C6C4A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
 <534f0795-0002-4c04-a83c-fa1b3ce68216@kernel.org>
 <PH0PR19MB99733813E0295B511539050BA9A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH0PR19MB99733813E0295B511539050BA9A5372@PH0PR19MB997338.namprd19.prod.outlook.com>

On Tue, Apr 28, 2026 at 02:54:53PM -0500, Chris Morgan wrote:
> On Tue, Apr 28, 2026 at 05:09:49PM +0200, Krzysztof Kozlowski wrote:
> > On 28/04/2026 16:09, Chris Morgan wrote:
> > > On Tue, Apr 28, 2026 at 09:47:00AM +0200, Krzysztof Kozlowski wrote:
> > >> On Mon, Apr 27, 2026 at 12:09:09PM -0500, Chris Morgan wrote:
> > >>> From: Chris Morgan <macromorgan@hotmail.com>
> > >>>
> > >>> Document the SG Micro sgm41542 battery charger/boost converter.
> > >>>
> > >>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > >>> ---
> > >>>  .../supply/sgmicro,sgm41542-charger.yaml      | 99 +++++++++++++++++++
> > >>>  1 file changed, 99 insertions(+)
> > >>>  create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> > >>> new file mode 100644
> > >>> index 000000000000..3e5041e5b551
> > >>> --- /dev/null
> > >>> +++ b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> > >>
> > >> Filename must match compatible.
> > > 
> > > Acknowledged.
> > > 
> > >>
> > >>> @@ -0,0 +1,99 @@
> > >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > >>> +%YAML 1.2
> > >>> +---
> > >>> +$id: http://devicetree.org/schemas/power/supply/sgmicro,sgm41542-charger.yaml#
> > >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>> +
> > >>> +title: SGM41542 Battery Charger
> > >>> +
> > >>> +description: |
> > >>
> > >> Do not need '|' unless you need to preserve formatting.
> > >>
> > > 
> > > Will fix.
> > > 
> > >>> +  The SGMicro SGM41542 is a single cell battery charger/boost controller.
> > >>> +
> > >>> +maintainers:
> > >>> +  - Chris Morgan <macromorgan@hotmail.com>
> > >>> +  - Xu Shengfei <xsf@rock-chips.com>
> > >>> +
> > >>> +properties:
> > >>> +  compatible:
> > >>> +    const: sgmicro,sgm41542
> > >>> +
> > >>> +  input-current-limit-microamp:
> > >>
> > >> Missing vendor prefix.
> > >>
> > > 
> > > This *appears* to be a standard value (perhaps not formally, but in use by
> > > enough devices to suggest a defacto standard), which is why I did not use
> > > the vendor prefix here. Do I need to add that for this one?
> > 
> > I know, I found these other properties but I think they were just coming
> > from old schema.
> > 
> > If it is really a common property, then should be defined in a common
> > schema and this did not happen.
> 
> Would now be a good time to add it to the power-supply.yaml document?
> It looks like this value is used by about 10 other devices.

I have mixed feelings. Adding it there would mean that all schemas using
unevaluatedProperties will get that property. That suggests they have
such limiting ability in hardware or this ABI is implemented in some
generic part of the kernel.

None of these are true, I think.

Maybe we need some documented guidance on usage of common schemas.

Best regards,
Krzysztof

