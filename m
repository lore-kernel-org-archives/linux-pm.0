Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679CB37E5F6;
	Thu, 16 Jul 2026 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784238566; cv=none; b=aLeZWPzpwxxL7EnBFiyZTq0nw3PulC6A69XSgnkwXNBGoLy2pkSleLGCBaoNLCBorNNG/bpqdpKOzH2Szrv087GGdj3Fv3jUJj+mhcMO9F8Q5zj1R+xfYMkEofKe6ZCRYL2OiCBvnEwllkxpfejvrcvxpf3G+nRafFWiNps5Tmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784238566; c=relaxed/simple;
	bh=LBMbmOs0P0G7nxvJZmumNqWf0/JfAYN9hCv/hs38PhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPd9CIhOqy9RjJwFNfbGKZD7qLEabAqo5TIVIYu9dhSCdXIc9Dk2bu4vYDHZBlM4aQTkyjVhuJyPqZWgdEZKA5EXR200wmUTkuuga6IPa84HVPzsXK9IDVr0c2UbyslKtIJuyQGCaFZmPVA4hYxnrdSNCNkFR4v91M8AQ96JlDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFA2RyZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFA2RyZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2030C1F000E9;
	Thu, 16 Jul 2026 21:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784238565;
	bh=eOISDNQWs3+70L2z0Z/sRRYhHltwdBHFBDQdmATJlRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nFA2RyZwvaxjwYUaBF3M0hVJbc/cCntzN4Rkn0dY4KzIkKk/dQa7lNM+h1EoeyW+u
	 RpxJkG2WudhcGwtak8jbY2zB1Yyf4lx6fivlQJMKsBuhQifRrEpcIJek174FxExSr9
	 kwbMTf2Nn/PCeS8iEn1tBpdtiUBaKlJwEQ2aISPTZo+VCqkC45i3bpkNLgiHPGnmS8
	 Cr0ZrjOVwzt89sKbPEtCbeYjV8DXKUrzKMvYJAOREsAM8wnLQ7UVX+arefRXySS8ZD
	 powCgSjKH2/ZfbzCxB++g81cDgnGnLxCkFh9fFHXdcPBz3qZPFB2TbWCEWaVXd74V7
	 LiTLGOu3mAZNA==
Date: Thu, 16 Jul 2026 16:49:24 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] dt-bindings: clock: renesas,r8a78000-cpg: Add
 firmware property
Message-ID: <20260716214924.GA1477674-robh@kernel.org>
References: <cover.1783505329.git.geert+renesas@glider.be>
 <49726acff0fee1c3606e83c4f242ef6aad25b4b8.1783505329.git.geert+renesas@glider.be>
 <20260710-adventurous-burgundy-chimera-b2fff9@quoll>
 <CAMuHMdV=ckONBbTYELPJU8YWoNzdu3PJ95VR8cz+f_7dUeiPUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV=ckONBbTYELPJU8YWoNzdu3PJ95VR8cz+f_7dUeiPUw@mail.gmail.com>

On Fri, Jul 10, 2026 at 01:02:39PM +0200, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Fri, 10 Jul 2026 at 12:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Wed, Jul 08, 2026 at 12:16:23PM +0200, Geert Uytterhoeven wrote:
> > > Add a firmware property, for systems where SCMI must be used instead of
> > > direct hardware access.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > v2:
> > >   - Spin off from "dt-bindings: clock: Document Renesas R-Car X5H Clock
> > >     Pulse Generator".
> > > ---
> > >  .../devicetree/bindings/clock/renesas,r8a78000-cpg.yaml    | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > > index 4e23bba334382346..fc499e7cf52e4f0c 100644
> > > --- a/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/renesas,r8a78000-cpg.yaml
> > > @@ -35,6 +35,12 @@ properties:
> > >        <dt-bindings/clock/renesas,r8a78000-cpg.h>.
> > >      const: 1
> > >
> > > +  firmware:
> >
> > RPi is doing similar, but I have doubts. It looks way too close to
> > generic "syscon" which is disallowed.
> >
> > I think this should be vendor+purpose specific, e.g.:
> > "renesas,scmi-transport" or "renesas,scmi-firmware"

If you can tell me the resource that a 'firmware' provider provides then 
it is fine, but you can't.


> The disadvantage of a vendor-specific property is that there are more
> cases to handle for fw_devlink, cfr. "[PATCH v2 02/10] of: property:
> fw_devlink: Add support for firmware"[1].

If vendor specific phandle properties are a problem for fw_devlink, then 
we already have that problem to solve and 1 more doesn't matter.

Rob
