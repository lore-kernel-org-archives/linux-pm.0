Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400AB3D16F8
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440255; cv=none; b=szm4Zj/l6PY39sCAf+nkR92HKPEo1SF60/EBAavWVqc21JBZqGdViehC5hjscSNi1YU/j+Q+ybpyCCd7PC59tFjTb70L+g6VS0fC+h0ugKwOlZakcUiJJLIRwIyT0p+wM5Do+uiAkndBqnija6qac+Pd2VEcf8hojPzK5XPOYkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440255; c=relaxed/simple;
	bh=5SYUb3BbQ7TBlOXQSr0mq1lzSbFyyEnEuic7IaJqgVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAQJoZVM9dlCdKV9ZMm6D+yZT1kUI8xpCAnIJPQFFT8dpe4BzZoJ6fL2+iUdAm73YdspXZ/3GeZ4L078Zsy6pMjAyQzi1y68EQ5EixXA1SZiNhlIADtbdaqF1pG3ReXxRuzdtWBobs6pufO7xQvUhgThL4GrXMzo8d8lx2v5UF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wdhcdea8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdhcdea8"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35b905e9dc0so1396608a91.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774440253; x=1775045053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iiuMY7qjsJ2FyszxcbRHj2zaPzXNgme/X+VTGrgnsxs=;
        b=Wdhcdea8qyOPbMaROSRK5xhNrAcNaY1afcf83u+QZ2gjQ5FxGjH6pZxipuFougqQOT
         DZTAw0D55veCtEgtQxsbeD4lcyojTnCFPg+7m3OnWIHOQI8pD1fxp9egQC36r8FFpOf2
         ej29wtj5EAg/wcMDIjlqZcbmKOuzIu0YO1JBxJvPoeJOwXGK1QzTDqNUeKcg8ohzcg7f
         mvGne8rESiGyks5//d8SFw/Gn5DYbcvWnNkaeNsuwYnY2jxk/I+hPWPrvZNzLEF5dcRd
         FtoMSR71A5gv3684TfToBPJYD0PeVByToYLVqhsAw+WhgPrhCN7Xs4pu/pp+h1/iy0M6
         VOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774440253; x=1775045053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiuMY7qjsJ2FyszxcbRHj2zaPzXNgme/X+VTGrgnsxs=;
        b=BVj2x5N4VyPmJU+fx+vy277Nwk7E2hE/s5bDCv/jN+x8GgH76neHrkm+lE7+tu5o43
         e0TgEOTBxf0QDgZHCbcpoUDXUmFAh9LZE7fCtAC/fm5hdAfWN1TTC2y314qP5koU8+l1
         w3bOB9eakSlYt1kU8JMxalmpj2E3B7/V8e+AvtB4ToVO1vyXYds1XmQrid/bovdczoMT
         uOwJTCPzhMRmsRNtMtN8BVs1C7mxDymBfob1yCZBTv5OEXQBAWXIPLKx1M3umJHZB/kZ
         a3CLwEIUh0Yy5QQh75Gh4pAyMlzZiFcBkoUYmOrB19o62RPdLmKvFwOCSfyDsxvHpLeL
         oqsA==
X-Forwarded-Encrypted: i=1; AJvYcCUQGkdwhBlZDYWFTkS6nuKXljtpoJez5CEfmk9URfGq1goqj+wetPLZdEQrENUsyj2dIhXm82FEzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKslvAhSVEPZFK+naQbS+IJ1bzCRY1gletOVfwXwWBp69GtFAC
	2ZXPTgUIDtmZ0zkJBkmCFKC68iO96vqbZVHgfLfiPgPKw8yyXxs+p15f
X-Gm-Gg: ATEYQzz8WE3J8SrVcPyL6TNG238+BheB2qF2D9lfhjeygsmzSAGhGmTF6G3kVO5MFoC
	dbDmmGlmTluLUvBtBEERprYfVD6mMFFktwsFedqtfNCeJCHUhhgHrSKsovhgJE6QBT8O6qCQCB3
	GcDan0fmieG1B+mw11ol1TPhNYd9R//AqfKNijzcqcprL0+awZyax5hJvGRcslIVqkiBJDIK+e4
	nEymzasR1GOfZLT80cXfpZJVZp/hBQ/KdKOTB/AORWXfJx8RkbT49UHVgUbu81zyNvhXF12G/8N
	cGq1ucCT3b4oSsTF8KCT3iJHCwW1BCAMY+vU6HJBr1AfM2HBOxDfi0+zXH9vj/2F7OWBA8MmgCP
	NkrX48lPBLoWL7ZYzYw7eFGa+PiDkLkRcr7TG/BKYTgVrdF1kZHxEstZKOnngoh3i426G//yqaT
	PKz48o0H4OTGl0OUPlwJhR/p8wOOMwafYc25eZAi9uXFWR26EpReRUzKe1+sE=
X-Received: by 2002:a17:90b:2b4f:b0:35b:99f8:966d with SMTP id 98e67ed59e1d1-35c0ddc3f25mr2750442a91.24.1774440253469;
        Wed, 25 Mar 2026 05:04:13 -0700 (PDT)
Received: from localhost ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0ea59e43sm765837a91.11.2026.03.25.05.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:04:12 -0700 (PDT)
Date: Wed, 25 Mar 2026 17:34:07 +0530
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, lee@kernel.org, 
	conor+dt@kernel.org, daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, 
	m-chawdhry@ti.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reset: st: convert to dtschema
Message-ID: <acPMx9NZBehAzkBp@toolbx>
References: <20260324155935.183952-1-krishnagopi487@gmail.com>
 <20260325-speedy-amethyst-beaver-08a3a4@quoll>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-speedy-amethyst-beaver-08a3a4@quoll>

On Wed, Mar 25, 2026 at 12:39:36PM +0100, Krzysztof Kozlowski wrote:

> On Tue, Mar 24, 2026 at 09:29:30PM +0530, Gopi Krishna Menon wrote:
> > Convert the STiH4xx reset controller bindings to DT schema.
> > 
> > Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
> > Suggested-by: Dhruva Gole <d-gole@ti.com>
> 
> Both suggested you to write this patch?
> 
Hi Krzysztof,

Thanks for the review, They helped me to improve the PATCH,

- Dhruva suggested me to change the subject from dt-bindings: power:
  reset: st: convert to dtschema to dt-bindings: reset: st: convert to
  dtschema as that was the general trend followed with similar files.
- Daniel suggested me to use the word 'reset' instead of 'restart' in
  the patch (whereever possible) as that is more accurate here.

That's why I added those Suggested-by tags.

> > Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> > ---
> > Note:
> > * This patch is part of the GSoC2026 application process for device tree bindings conversions
> > * https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> > 
> >  .../power/reset/st,stih407-restart.yaml       | 31 +++++++++++++++++++
> >  .../bindings/power/reset/st-reset.txt         | 11 -------
> >  2 files changed, 31 insertions(+), 11 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/power/reset/st-reset.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml b/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
> > new file mode 100644
> > index 000000000000..d7adbc00f5c3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
> > @@ -0,0 +1,31 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/reset/st,stih407-restart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ST SW reset controller
> > +
> > +maintainers:
> > +  - Lee Jones <lee@kernel.org>
> > +
> > +properties:
> > +  compatible:
> > +    const: st,stih407-restart
> > +
> > +  st,syscfg:
> > +    description: phandle of the syscfg node
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +required:
> > +  - compatible
> > +  - st,syscfg
> > +
> > +unevaluatedProperties: false
> 
> additionalProperties instead
> 
Ok will send a V2 for this.
> 
> Best regards,
> Krzysztof
> 
Thanks,
Gopi Krishna Menon
