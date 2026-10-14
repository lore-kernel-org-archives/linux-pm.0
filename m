Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCE44F563;
	Wed, 14 Oct 2026 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005148; cv=none; b=H46DfHOHvta/pLEs5/M+qbmmzAl8NcwUsLWGXegF1c7m0oDU9/Yhc6IfpQZi7yy4KonCN6wwkvNiiYeJX94ySzd596O2geMReXWGqWSotI5B/DRTpPmLXLgSGTNVTPpXsJ5G2HturtiDzQ/XgUfgcfGgpJG7zwVDC0buq1nWNaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005148; c=relaxed/simple;
	bh=PhrFgxAyb5Wdn5xkWs0bigFi1PPwop1LsrGEQiyc4g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uv3z8QUqwfkzeIm5WEtn5X/rVTN8sLNt9J0Fg8IvmfjYhupyegJaruHO6x6lBiwkpqXBoprOQQMxVKgmqt1RCOyA42XVtvI7Q720Ih5XmhQGP8PSrzhHmjUSFGeVW6dOK+TIg3yXA7zo0KV520Pm7jUHOI+cjTaph+YPXDwf0xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRbzJX9/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRbzJX9/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283221F000C4;
	Wed, 14 Oct 2026 19:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792005146;
	bh=sy51dZnwp63qodB69dzwmoIWn3ZCJ4Oue2+ZkfODJOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WRbzJX9/UI0iMSHjtQ92PNv3XZnhstPDKvD9dPgRFxetsXjqCIDgCIW9QIjncwRN7
	 q8BNbmEaZTLNdPWvMpabTPcOlOEJxzkMSjxWpig3MzLMOURcgq7X9S6/OELHo7Ks6z
	 YmvuI8JwT4ZE7lN90ch7XhvSVq1XH4GYLrNUVDcQIb5ZV4YpbGvY3zf5ylMEL8IwFO
	 SN4i14bsdmTaZy4TyMMCZa2PKtVcve/NuMF1UgcJd3y8dJoLagne706fXx6aIxJsmi
	 VmgNz2qbbeApxkuVLkikck8kM0oZCRLxd9ePdCftSTBzwatTsvbV0r4iQIj0ND6BJ8
	 +1wZNDtBEe8tQ==
Date: Wed, 14 Oct 2026 20:12:20 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
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
Message-ID: <20261014-prudent-mini-duck-377cb6@sudeepholla>
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-2-3c402c66f388@oss.qualcomm.com>
 <20261006-romantic-stalwart-seriema-90e71d@sudeepholla>
 <CAPx+jO-T_0KT3GytYu8w6QvrhXFQNZQzR496RL=McU6rnMtnPA@mail.gmail.com>
 <20261009-frisky-rottweiler-from-avalon-6c409e@sudeepholla>
 <CAPx+jO-_aY5pMnWyy1hAs1WRmfW33vc317jdtBsEXYBoHsPfxA@mail.gmail.com>
 <20261009-skilled-mature-bittern-2206fc@sudeepholla>
 <CAPx+jO87gkTumF=Tg=UPWpJO6O-CRF4njT2KxQ3f=4nF5m7GiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO87gkTumF=Tg=UPWpJO6O-CRF4njT2KxQ3f=4nF5m7GiQ@mail.gmail.com>

On Tue, Oct 13, 2026 at 12:11:36PM +0200, Ulf Hansson wrote:
> On Fri, Oct 9, 2026 at 5:27 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> >
> > On Fri, Oct 09, 2026 at 04:26:38PM +0200, Ulf Hansson wrote:

[...]

> > > If that's the case, besides that the cluster PM domain topology must
> > > be modelled accordingly, the display device should be hooked up to the
> > > cluster PM domain it belongs to.
> > >
> >
> > Ah, I thought that's the way the whole domain-idle was modelled as we
> > started this OSI discussion a decade ago with an example of CPU clusters
> > sharing power domains with some other devices. I am surprised if that is
> > not the case already 🙁.
> 
> It works fine today, I was just trying to explain how it works,
> considering the use case that you brought up.
>

Ah OK, good to hear. For once, it sounded like that's not the case. My bad.

> >
> > > Beyond that, it's the corresponding display driver that becomes
> > > responsible for what should happen during system suspend. If the
> > > screen needs to stay on it may need to call device_set_awake_path()
> > > for the display device - unless it's a decision for user space that
> > > can control the behaviour for the display device via its sysfs node.
> > > If things are managed accordingly, genpd_finish_suspend() may decide
> > > to keep the corresponding PM domain powered on during system suspend.
> > >
> >
> > But the s2idle and s2ram anyways suspends all the devices, so they need
> > to vote in for the power domains to be turned off. If they are supposed
> > to stay on, the system enters the state it can based on the other votes.
> >
> > > The above said, $subject patch doesn't change any of this. It only
> > > allows us to use more states (deeper), which are limited to system
> > > suspend (s2idle).
> > >
> >
> > Still not convinced, if all devices are plugged in to the power domain
> > hierarchy correctly and the domain-idle states represent or carries
> > the entire system power domain topology, we shouldn't need this extra
> > information. Having it make cause issues when it conflicts with the
> > topology information IMO.
> 
> No, it's still not sufficient to model the power domain hierarchy correctly.
> 
> These "system states" are special since they require additional
> coordination in FW/HW, to take into account votes not directly
> controlled by Linux.
> 

But if Linux doesn't control, some other entity would vote and until then
the system shouldn't enter that state. Without knowing that it is system
state, will the kernel be unable to choose that state as it hidden vote
is invisible/not tracked ? I trying to understand why if Linux chooses
that system level state as part of idle loop, the platform can't downgrade
if all the voting requirements are not met. I am struggling with that
and want to make sure we are not working around a broken firmware.

Sorry for being pedantic, but some real example would help to understand
it IMO.

> I realize that the description in patch1 should be extended a bit to
> explain this better. In principle, we can compare this with the PSCI
> SYSTEM_SUSPEND support. The difference would be that PSCI
> SYSTEM_SUSPEND is limited to support only one state, while the
> $subject series would allow us to support multiple.
> 

I understand that part. SYSTEM_SUSPEND is sort of platform co-ordinated
once the requirement for entering is met.

> In regards to ACPI. I think this is as simple as comparing it with the
> list of ACPI S-states.
> 

I need to check if we use ACPI S-states via S2Idle which is the case with
this patch set I assume.

-- 
Regards,
Sudeep
