Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC78D4848A6;
	Thu,  8 Oct 2026 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451003; cv=none; b=bylIY9gzqNtNlaSUQEfOr4SYWfJoLrRv1D8QO00jx6Q6ITxkrp3eZGuOor8UwT1X2nWLkGuMfSZZGZjpi3YiL7PHYYLKtzkxeAJ2aYpx3r5us06AdzlKSKVcri9elRGlCnJV6ORtX6xLo7cE9PaPjSV7bzNxMAH2/xPDkE1ACxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451003; c=relaxed/simple;
	bh=mL/mSPHbMI5qH4gMqEcJWv7ADQEceCa0r9sLvc2xvZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=morgTnsGVMmUL8K6xtxAYz/6FHYArRJrl0ApDUFXJDx54Vg8H7JBpVMzo2mnech2VohnSOMZvMRrqcgIkvG0cZgCQIBfWFdrFBFVo4xzo6R3Z61KCooAIj0JxvdMHBAbGJUX/RUJcNuC/k4pf39f8/QAamfEefc8jkUTkzVOJ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF/tUzXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF/tUzXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6721F000FF;
	Thu,  8 Oct 2026 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791450994;
	bh=94iaDYP74RW2YcEfiGwnFjDvT7zwpu+xasEC5nsyMFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dF/tUzXN91ob7lVTRO5bMkO6UCiPYJRBIJJGfha6B1T8hdKiOcP7HNj0uf3cjC2v5
	 JunAsFXxI03bjqjjkLGZhnAuOzZVxrMKpBirktyuahF6i4qO2yC3O4m+Yvy1CsUg19
	 MAub8VSjffhnrNar06AAPCQgx5xKGJ3lVPdSDCjxasrKn3WJ0+ml0kZ8c6tqICfS2I
	 J0kMmhgFl7/hTZDJAvOnS1n7fk4ghwkRlFTb8T7GDh60ExUYyKgylDmsGamzsw0A95
	 KMFcO/9QyX3Er5l7KsUFpgLwC+3oevKOKEHfeBkJRklqW49KXILdE7zmAilHi7Idts
	 jZrw2soh86Q5A==
Date: Thu, 8 Oct 2026 10:16:29 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
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
Message-ID: <20261008-sexy-kingfisher-of-relaxation-fdbd6a@sudeepholla>
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-2-3c402c66f388@oss.qualcomm.com>
 <20261006-romantic-stalwart-seriema-90e71d@sudeepholla>
 <d0e24121-49f2-4002-ad4f-bf96f6fc0861@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0e24121-49f2-4002-ad4f-bf96f6fc0861@packett.cool>

On Wed, Oct 07, 2026 at 03:55:22PM -0300, Val Packett wrote:
> 
> On 10/6/26 6:15 AM, Sudeep Holla wrote:
> > On Mon, Oct 05, 2026 at 08:59:43PM +0530, Maulik Shah wrote:
> > > Some domain idle states require system-wide coordination and should not be
> > > selected during regular CPU idle. However those states remain valid for
> > > system-wide suspend like s2idle.
> > > 
> > > Add a per-state system_state boolean and populate it from the system-state
> > > property. Make the genpd governor skip these states during CPU idle. Leave
> > > the system wide suspend path unchanged so s2idle can select them.
> > Instead of this I am thinking if we can QoS cpu latency setting and block
> > system level states normally. Since s2idle is user driven, it should be
> > controllable via user-space and we don't have to define bindings again
> > if systems that use platform-coordinated needs this too. They may not
> > use domain-idle-states.
> 
> Messing with latency sounds like a hack. It seems like some system-level
> states are just explicitly provided for runtime idle while others are only
> intended for system suspend. That intention should be captured/documented by
> the device tree explicitly as well.
> 
> I don't have access to HW docs but according to someone who did some digging
> on Windows, it seems to be this way, e.g. on Hamoa Windows enters system SS1
> / "LPI" (0x02000154) at runtime all the time, but reserves system SS3 /
> "DRIPS" (0x0200c354) for system suspend:
> 
> "A Windows WPR trace (Kernel-Processor-Power |PlatformIdleVeto|) showed that
> Windows never enters DRIPS while the screen is on. The PEP vetoes it
> (reasons 4/5/8) and only allows platform.SS1. DRIPS is used only in Modern
> Standby."
> 

I wonder how it is done in ACPI then as no changes were introduced for this
in _LPI tables. More reasons not to add any info to H/W table unless I am
missing something and _LPI was indeed updated or modified.

-- 
Regards,
Sudeep
