Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B16B415B74;
	Fri,  9 Oct 2026 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551945; cv=none; b=EHIxk9OUjAXP2OPg8bo/yVBniSLFTMdIeIdlMmm9BZ99C0zFJ8+WIL8xvCZ1D/ZKZeBtgj4YsmwKbfIidMvwJWaX6FRSk1ZhV/pchS8g/DasNWC7zt4ViHgqcyrdHtfFRBpAABowbxjXTBL1zxpxXhmhCRbC3jA5LhQQJ20Dzj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551945; c=relaxed/simple;
	bh=swFdVr1GBByCIob+w+yLjGMyV17EFa45b0c4FnVIqns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rITfckyCM7Bg7wdMbwLF1Z+29HQlM0Oz90acZikL2VSGIFlpTi2g9u4AfZsAK5WR5ryXgYrZfVXkISWoIRzzj7ySVrlmm0VwdQmNVNnaO1VSBOsiKwiohAB3k5mIU/yquhiWyWpXJQxdpQSs5PeTxKwXPeUOa6cVGw5rgrk3yKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG+fv9sO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG+fv9sO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5371F000FF;
	Fri,  9 Oct 2026 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791551943;
	bh=MeTS903UniSorg3O8uRqhtVLu+zdRHCgvqD8Aqg8dOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KG+fv9sO2cWKt4tryxYl9sx9h2ufhePBXN76r4zzjyrBgFguj7pOE04vRVGxCyv3v
	 JQ1KqKdSFTGzboGMuYlxUQv6VlXRe85zzx8xT1/rUlDLjDWMbkgXMKVA2or7ZhmdmM
	 X14KqQGpWaQYMngsSJr3moRRB+VeF+GU1Y8imhiRq95bKVHnqq7WIv9yQDeOk9IftP
	 kGfvxewAtGzUleRXZHE/nVc8Gd9N5rCPcL38QFTjeH7q8biFEAbk3EbjfWOpZZ9DZm
	 QpaS8zmz7zl6VuAJGNqjMHhNZgEd0LWeDSOcMg2gIV8C3BtYDy7nzJyGogT3dsOsEV
	 6mw4GowjjDgFg==
Date: Fri, 9 Oct 2026 08:19:02 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 05/18] dt-bindings: display: ste,mcde: Allow power
 domains
Message-ID: <20261009131902.GA1195061-robh@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org>
 <CAL_Jsq+1O+os8=YGUoKg6zCm-r0gQ35baKX=z65uTQNB0i=RVQ@mail.gmail.com>
 <CAD++jLm+yRo9e1UDhnaYrdPq28mdyYKQZ6tdKuUa3UG85imkNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLm+yRo9e1UDhnaYrdPq28mdyYKQZ6tdKuUa3UG85imkNA@mail.gmail.com>

On Fri, Oct 09, 2026 at 07:05:46AM +0200, Linus Walleij wrote:
> On Thu, Oct 8, 2026 at 7:41 PM Rob Herring <robh@kernel.org> wrote:
> 
> > > +      power-domains = <&pm_domains DOMAIN_B2R2_MCDE>;
> >
> > This patch is in next, but the define is not breaking dt_binding_check.
> 
> I screwed up, I forgot the dependency on the new define :(
> 
> I asked Ulf to merge the prerequisite which would resolve it:
> https://lore.kernel.org/linux-pm/CAD++jL=gFt9kKZH9T-m8B_pbwRvzc35tTrMn5V238d3528DpUg@mail.gmail.com/
> 
> Is it very urgent so I should just revert it? I could also just merge
> the single patch adding the defines into the drm-misc tree if
> Ulf is OK with that.

'make dt_binding_check' errors out. That kills my bot for anything based 
on next which is most patches.

You could also just remove the define from the example.

(Note that drm folks require a revert be posted and acked or they will 
revert your revert. I learned the hard way.)

Rob
