Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794238128;
	b=oKYu73/PbfwlnvkMu4k2kyFpaYwuHYklp9fyMoaCXkk5NEUo/xDnScejR56u9M5/tcva
	 9AifvoLyzT3wNrKsKy0AjX7Cgm8UQbj+5OIw7rtOxVUuwnx3LTY0H0V64H1MbdEuf1a8/
	 +yJhidp2AkoQ7/VHQl8V5cuIWv+5qbcU/V4ixfAPCHlzXwDEW3LvOqxn9Jf9kVxo0r2SA
	 giiKCgrQp1e0Rouh5QcoSW/lGRryWTWob0yZY9ShE05rpn337UgNJMNNdZxKo9ZCCDFex
	 gaGSB9N8YwSbh+gQF6b+GLGXcV45sxigQSvDDSRGkRAFQTBaFdhM6NmpXgoUwH4eQBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238128;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=mCRGrIzDRdJ3fj5LcFpJR8WKCIeELn3A3rZQ9kvKhd0=;
	b=EnkfCT3u6r5FJ+uWddEsKcloVHUl1Y2M4HZPpzPCqSHKXoNEn9DrCpeV1Cidzx9PQY/O
	 sL8gKws1bVHt+uAkx0rskItxsbt9eNIajlK0K+arTuMTkOplKGcRBwGb6prPC3DmjZ0Za
	 rk6JtNRPZz4ysgfifk3r0HTkyanZmqEVaO5frTEMxobJFvHTSLNfvooUL6928ln75mRBs
	 WTNLkQz31APRafZlw1u7u3HdB5uGobez22bqdvicGiDLmkzB1sckVNv+4XcEkYrcDmPOI
	 TT4hy/dcCDY9p3g/WoQ7FVFSGzGfKwCWBQnJc53Bw+jR08AlVCDK+qwwYdZX28tYlXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mt+BvO99;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A9606A321;
	Mon,  9 Nov 2026 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mt+BvO99
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412481F0089F;
	Mon,  9 Nov 2026 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794238127;
	bh=mCRGrIzDRdJ3fj5LcFpJR8WKCIeELn3A3rZQ9kvKhd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mt+BvO99SAb4PB7qhXL0QzsqKiFAgnV29mtcED/SiQZtMrENK8xK+1dS8lTaZvifa
	 o4UOQ+ZgJw9dpcRbDjABLR0oiNJ4wz/Q3n0r16ne0irTox6ilYYFZ257xe5/tqFdht
	 u4mmr/NkRvEDymrd8c0F1y/EtoMatF5tNhvKkwGhZdCK/5UmesFdUX5D46e8f9oxJs
	 3np7sBELOph7fdAwU43PDmuKJWjzf7kU0qxnclfBUAmXLVP0MLuFLTL2kNQXxbtZX8
	 CCCEbL+9kgtzYVpKUL/99P0VF1p2dN6oxSA5uICLriH/+W9GaDxH3eqv40hqdFtmc6
	 Jv4dnSTzbsFtQ==
Date: Mon, 9 Nov 2026 15:28:43 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] pmdomain: Add support for system-suspend-only states
Message-ID: <20261109-swinging-inventive-wrasse-e82ec8@sudeepholla>
References: <20261006-romantic-stalwart-seriema-90e71d@sudeepholla>
 <CAPx+jO-T_0KT3GytYu8w6QvrhXFQNZQzR496RL=McU6rnMtnPA@mail.gmail.com>
 <20261009-frisky-rottweiler-from-avalon-6c409e@sudeepholla>
 <CAPx+jO-_aY5pMnWyy1hAs1WRmfW33vc317jdtBsEXYBoHsPfxA@mail.gmail.com>
 <20261009-skilled-mature-bittern-2206fc@sudeepholla>
 <CAPx+jO87gkTumF=Tg=UPWpJO6O-CRF4njT2KxQ3f=4nF5m7GiQ@mail.gmail.com>
 <20261014-prudent-mini-duck-377cb6@sudeepholla>
 <CAPx+jO_BOwbKeRytBezm+piLhb8Z5N2eQO=LRwBQoSZ3kXOpwQ@mail.gmail.com>
 <20261028-imported-pistachio-unicorn-2ecfec@sudeepholla>
 <CAPx+jO-0Vmah=2mewp-kspV7Nqr+Ay_nnO9fTFB_TMbOoHJp5Q@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO-0Vmah=2mewp-kspV7Nqr+Ay_nnO9fTFB_TMbOoHJp5Q@mail.gmail.com>

On Mon, Nov 09, 2026 at 04:05:56PM +0100, Ulf Hansson wrote:
> On Wed, Oct 28, 2026 at 12:48 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> >

[...]

> > Now I understood the requirement much better. The core issue with OSI is
> > that it fails unless the platform downgrades special system states to
> > non-system states during routine CPUIdle paths.
> >
> > This leaves us with two directions for OSI:
> > 1. Firmware Resolution: Handle state transitions entirely in firmware.
> > 2. OS Intervention: Enforce the handling via the OS.
> >
> > Though I personally prefer (1), I don't have strong arguments against (2)
> > now that you made me understand the requirement. Sorry for taking time,
> > but mentally I was assuming (1) even for OSI until your above response.
> >
> > Since PC mode relies on the firmware to manage these states natively, this
> > binding isn't required for it. Therefore, Could we restrict this specific
> > binding exclusively to OSI implementations ?
> 
> I guess we could, but that seems rather messy. According to earlier
> discussions, if I recall correctly, we deliberately avoided OSI
> specific DT bindings/properties, since support for OSI mode should be
> detected through the FW.
>

Fair enough, we should at the least warn if used on the systems in
PC CPU suspend mode.

> Also note that the domain-idle-state DT bindings
> (Documentation/devicetree/bindings/power/domain-idle-state.yaml) are
> generic and used by RISC-V SBI as well.
> 

Agreed.

-- 
Regards,
Sudeep
