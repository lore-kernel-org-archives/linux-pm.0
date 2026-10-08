Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DDA47045C;
	Thu,  8 Oct 2026 13:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465820; cv=none; b=l+RKmZRZkt7HiSV2zMYUE8RFNjFWrzxiY4NwzX+JGnVSEYbg5Z5AZSEW+WgspVZ6ojt2ygT/BgPcQmrQdsFZXCuPmjuHoXNk108Zvn9Lhkt6CACGdDeR8gxvc6q+QfsItRd63U4zdNyN+nYG3LjeSb3BTiwFUQeJ54oFpbFuvWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465820; c=relaxed/simple;
	bh=byR7KCyQTM9IcR9U+cedENxNH7ox5ybCNEitpZTwmm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDl267J4W1EyZk2aYyeR+q+KZVxFNCh0JCNlGNAaA9kHnqY/Rf/K5g0W7ae8pApcyand+G/P8FuNnRl2nYpBxXE0VVoOIw1/wtXErcg03ZAZ2hfP+n45/jdxTCxfP0u/CafCYdSmjwR27XgXhNqigs5iXm55WQOQqjPOEK3X1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHuYqDuI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHuYqDuI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D4A1F000FF;
	Thu,  8 Oct 2026 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791465819;
	bh=IaKcoXA7uPRlCi3Ecfqo5f4Dhh72RmQqlLLkldNTjso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RHuYqDuIrL8iQD4la9YrcwktXJhQQprAokPtDnmpMPNXPSHY5ca67kKZlHHgGJNmY
	 1LKSOPlvn/6Hat3YzJR7XItq2QBsVqvy/XpQDSu80+/0e+lofThNQA33zlQU7CjAui
	 rLy8HMDwe4VivcAy96svKc6V6OuGl6FQRIXjQdy6YUyFiRsti6srnM64BQrnM1N43w
	 wP0zR33+IDK3szDf93BKvHeOuX0Bj5hKJC3msHbPfrp20v+uxPGMDW0V3z2192zpsA
	 J2YBLba1L6ed+gllwGUCJFI/vaL3NOlJEsBkF6kP5FtCm95yOweNJBbC30xDuE5x+s
	 jPVKHcBdb+6zA==
Date: Thu, 8 Oct 2026 08:23:38 -0500
From: Rob Herring <robh@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sre@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: power: reset: syscon-reboot-mode:
 allow supplies
Message-ID: <20261008132338.GA183998-robh@kernel.org>
References: <20261006-b4-rk3576-reboot-mode-v3-0-6edba064693b@flipper.net>
 <20261006-b4-rk3576-reboot-mode-v3-2-6edba064693b@flipper.net>
 <20261007212432.GA381404-robh@kernel.org>
 <CAKTNdwFo03jFGMeJQpxXp1yOX+cG+6BZOYf1eGGZTdZWAFdz5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKTNdwFo03jFGMeJQpxXp1yOX+cG+6BZOYf1eGGZTdZWAFdz5A@mail.gmail.com>

On Thu, Oct 08, 2026 at 01:58:55AM +0400, Alexey Charkov wrote:
> On Thu, Oct 8, 2026 at 1:24 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Oct 06, 2026 at 08:02:40PM +0400, Alexey Charkov wrote:
> > > Whatever program that acts on a reboot mode runs before a full OS, so it
> > > may lack the capability to enable the regulators it depends on, and a
> > > reset that preserves the mode register generally leaves the regulators as
> > > the previously running system left them.
> > >
> > > Allow a reboot mode node to name such supplies, so that they can be
> > > turned on while the mode is being requested.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > ---
> > >  .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml       | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> > > index 79ffc78b23ea..5ed70c87269e 100644
> > > --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> > > +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.yaml
> > > @@ -36,6 +36,14 @@ patternProperties:
> > >    "^mode-.*$":
> > >      maxItems: 1
> > >
> > > +  "^[a-z0-9]+(-[a-z0-9]+)*-supply$":
> > > +    description:
> > > +      Supply that has to be powered for whatever program acts on the mode.
> > > +      That could be a boot ROM with no access to regulators, and a warm reset
> > > +      leaves them as the previously running system left them and not necessarily
> > > +      what their expected out-of-reboot state is. Any supply described here is
> > > +      enabled when a mode is requested, and stays enabled.
> >
> > Sorry, but no. If we allow this, then what next? clocks? power-domains?
> > GPIO lines? The list is endless. Maybe if a not generic binding is used,
> > but still pretty much pure configuration.
> 
> These are the resources which are required to handle the reboot mode
> request, they are not exactly configuration. There is a limited and
> hardware defined number of IP blocks which need to be powered for the
> reboot mode request to complete successfully. In my case (Rockchip
> RK3576), these are the IPs that need to be made aware of the trained
> DDR memory parameters: if they are unpowered _at warm reboot_ then the
> boot process stalls immediately with an exception (cold reboot is
> handled by the power-on default state of the PMIC).

If you need certain h/w blocks, then you should list them and then you 
can get whatever resources they have. That's assuming we were to go down 
this path, not an endorsement for doing this.

> I see that this may be abused to hack around what should be a
> bootloader's job, so it would be great to find a way to explicitly
> limit the scope of these - though I couldn't think of one yet. Any
> suggestions would be much appreciated.

Maybe the boot phase stuff could work here?

Rob
