Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749504E80C1;
	Fri,  9 Oct 2026 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559643; cv=none; b=IOn+3mYxRdM7pRpEbOSN+L2kELvf7RHZl0Qhto0E6MNkOBAiUJuEEJN7IU///rgCezA/S2Z7R2akAuZYjiyGJD82EF8c9JUy/0p/0bRbGeMuPdqBE4cN30v4jaRnfYSDPq++aCH+gpy8a+ApaLeb7BMuqEzj3uel/OaFrUe1WlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559643; c=relaxed/simple;
	bh=J/r0cmylI3rsbeVOLn/L+u6QaHH8WMrAf4BaJst6G8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFQz6OEMzeY+GGEqP0qEkex4UJFswsrEks825Fc2lq2iZK0Qp4QsvluExLEIfxEDTnYhB8zlDWCVNetYCMSAvaFpL9FsRbUznrBbot+t6VVCu2EfV6TR5r8+agfeUIN1kY+0b1rlaC/4BmpoqvoK/Ew4ATf8x85Hi0/8Jg9oc5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQDiZNDd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQDiZNDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B73C1F000FF;
	Fri,  9 Oct 2026 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791559641;
	bh=rox2fOsL5pgm67p/vQVOSoocQPIT539zTWquqZ/ztnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DQDiZNDdWfHLosGRMhZd1DH/xoyDrwu0+pd8Bjnvz9s9OqGNafiu6Z+BwKOr+s0jv
	 AFZ3McjwsB//8Ge1QIPcuDCULiJvpzzeLCH4ouO00HpjHw1a5QQ+x085eBcVNGWODz
	 Wl9FXuv06U2GAQ1qTvIQYII2Tq8zRSO+Bjuiv0000wqGp+MZbe2weS/bBpkBcKn+1R
	 5Yp7D/PsRAPVnh56CL7wLLw4TYQC36WYSWf6Cs5llpJpirJZA1x18BlAl+mvV5FC2K
	 dV3ti5SkjAE3WG5zAJ+Evd5xV4ILPSB0SxGSvbiejDpdjD6v8PxqGzFsw3I85g+fZe
	 8DIOMU/H68LKw==
Date: Fri, 9 Oct 2026 16:27:16 +0100
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
Message-ID: <20261009-skilled-mature-bittern-2206fc@sudeepholla>
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-2-3c402c66f388@oss.qualcomm.com>
 <20261006-romantic-stalwart-seriema-90e71d@sudeepholla>
 <CAPx+jO-T_0KT3GytYu8w6QvrhXFQNZQzR496RL=McU6rnMtnPA@mail.gmail.com>
 <20261009-frisky-rottweiler-from-avalon-6c409e@sudeepholla>
 <CAPx+jO-_aY5pMnWyy1hAs1WRmfW33vc317jdtBsEXYBoHsPfxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO-_aY5pMnWyy1hAs1WRmfW33vc317jdtBsEXYBoHsPfxA@mail.gmail.com>

On Fri, Oct 09, 2026 at 04:26:38PM +0200, Ulf Hansson wrote:
> On Fri, Oct 9, 2026 at 2:21 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> >
> > On Thu, Oct 08, 2026 at 02:21:49PM +0200, Ulf Hansson wrote:
> > > On Tue, Oct 6, 2026 at 11:15 AM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> > > >
> > > > On Mon, Oct 05, 2026 at 08:59:43PM +0530, Maulik Shah wrote:
> > > > > Some domain idle states require system-wide coordination and should not be
> > > > > selected during regular CPU idle. However those states remain valid for
> > > > > system-wide suspend like s2idle.
> > > > >
> > > > > Add a per-state system_state boolean and populate it from the system-state
> > > > > property. Make the genpd governor skip these states during CPU idle. Leave
> > > > > the system wide suspend path unchanged so s2idle can select them.
> > > > >
> > > >
> > > > Instead of this I am thinking if we can QoS cpu latency setting and block
> > > > system level states normally. Since s2idle is user driven, it should be
> > > > controllable via user-space and we don't have to define bindings again
> > > > if systems that use platform-coordinated needs this too. They may not
> > > > use domain-idle-states.
> > >
> > > Even if we likely could make that work, it's seems not correct to rely
> > > on userspace to make the kernel to pick the correct idle state, while
> > > the decision should be based on the characteristics of the HW.
> > >
> > > In regards to PSCI PC mode, I believe we should consider adding the
> > > similar DT property for the arm,idle-state binding and make a
> > > corresponding change for the regular CPUIdle path/governors. Although,
> > > it doesn't necessarily need to be part of the $subject series. I would
> > >  be fine if that is handled later on too.
> > >
> >
> > While I agree with this line of argument, I am bit worried that there is
> > more deviation from ACPI _LPI binding(equivalent to these in DT). If other
> > OS has manged to run the same firmware without adding such information
> > to the firmware(ACPI in this case), why do we need that in DT. Is that
> > information encoded elsewhere in a different form in ACPI and is this the
> > right place(the idle state binding for DT) is what I am trying to understand
> > here.
> 
> I don't have the information about ACPI at hand, so I will leave that
> to Maulik to be answered. Or perhaps, someone else already has this
> information and can share that with us?
> 
> In any case, I don't see any other reasonable way to describe this in
> DT at this point.
> 

Fair enough, we can consider that once we finalise what we have in this
set is the way to progress(not important until then).

> >
> > Also taking the example of screen on, won't that be prevented as the
> > system domain is shared by the system level idle-states we are talking
> > and the screen/display device. So it never votes to power down that
> > and the PSCI OSI domain idle driver must not be able to choose the system
> > level state.
> >
> > In general, there is some device that doesn't vote to power down the domain
> > and hence we can't enter the state. So my question is, will there be some
> > device that doesn't explicitly register vote and hence we need an alternate
> > mechanism like the one proposed in this set ? If so, what are those and
> > how does that work in system suspend states.
> 
> Assuming I understand the above use case, you are thinking that the
> display device (for example) is a part of a cluster PM domain, right?
> 

Yes, exactly.

> If that's the case, besides that the cluster PM domain topology must
> be modelled accordingly, the display device should be hooked up to the
> cluster PM domain it belongs to.
> 

Ah, I thought that's the way the whole domain-idle was modelled as we
started this OSI discussion a decade ago with an example of CPU clusters
sharing power domains with some other devices. I am surprised if that is
not the case already 🙁.

> Beyond that, it's the corresponding display driver that becomes
> responsible for what should happen during system suspend. If the
> screen needs to stay on it may need to call device_set_awake_path()
> for the display device - unless it's a decision for user space that
> can control the behaviour for the display device via its sysfs node.
> If things are managed accordingly, genpd_finish_suspend() may decide
> to keep the corresponding PM domain powered on during system suspend.
> 

But the s2idle and s2ram anyways suspends all the devices, so they need
to vote in for the power domains to be turned off. If they are supposed
to stay on, the system enters the state it can based on the other votes.

> The above said, $subject patch doesn't change any of this. It only
> allows us to use more states (deeper), which are limited to system
> suspend (s2idle).
> 

Still not convinced, if all devices are plugged in to the power domain
hierarchy correctly and the domain-idle states represent or carries
the entire system power domain topology, we shouldn't need this extra
information. Having it make cause issues when it conflicts with the
topology information IMO.

-- 
Regards,
Sudeep
