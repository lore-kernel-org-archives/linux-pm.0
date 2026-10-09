Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92E345EB4;
	Fri,  9 Oct 2026 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548482; cv=none; b=EvSNmAqlgf6SLpKOu7Us8kHuGDjIyRvH7R3b56vYk5er3NMkSBbNy1Pl4yk4KJRQfPMgqlccpV8IaOp3Qel1S7JJNC8C9W4CyGMSuRatyf+xXvvpdILRHcD5yc1rbZoU6Fcuwq1WVrIubLf4F8zsVLt+jF64gdYvwueK6tniDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548482; c=relaxed/simple;
	bh=jgUGRmavRJiBga18v80G2L3GuQK59+VccAUFdDkAHdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1/FpQmBMJXUyz5h/IclUNnxetuHqNth/awhr1KfYCJIbXlY8Ctg9gRq16xvKXb6tuuB/P6pq7F2Th/mbYJm5m/tFlWrYkPOmkM4l23Vuu77fG/yOryjfTYTvjFsfHtWxlWKLi/MJC7iU/dpREqr3XwtrHRix+UpLwq6WEqjjTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuBG6a+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuBG6a+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF82D1F000FF;
	Fri,  9 Oct 2026 12:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548477;
	bh=lOy+6gR5U+XJ/7xxW+LbuJHEriEsitu66YSZlMA/tPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KuBG6a+J6QA3F43i4pmhUSJ85lGk7COEODYHCb3wLty/Wy5OuQBfcLqwMGMtoXoQR
	 17G/pitraoRzw89C+CMNtSLXcdHE7+SnhOh1thuIswxWTfzFvan3kRGgB7rrkijnAl
	 0+yDOyMuw1yeAADKRpuAhX16lTo/kcSgFvocDF81lNqdrHspWSDFhlAHr6f/jFHefB
	 kND+dALy9E2MPRcM4HSkjYe47Cq0/UxFtJCZeFv+1lESBF4tFriISSsLv+JFR1hyIU
	 sUlOpbkexeFvzHU2ajlSBgXkaU1MOz07eznurZzz7DXhriqoqMWgHHtbz3Gm1zy5B5
	 ncr0rfQ0HAOkw==
Date: Fri, 9 Oct 2026 13:21:12 +0100
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
Message-ID: <20261009-frisky-rottweiler-from-avalon-6c409e@sudeepholla>
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-2-3c402c66f388@oss.qualcomm.com>
 <20261006-romantic-stalwart-seriema-90e71d@sudeepholla>
 <CAPx+jO-T_0KT3GytYu8w6QvrhXFQNZQzR496RL=McU6rnMtnPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO-T_0KT3GytYu8w6QvrhXFQNZQzR496RL=McU6rnMtnPA@mail.gmail.com>

On Thu, Oct 08, 2026 at 02:21:49PM +0200, Ulf Hansson wrote:
> On Tue, Oct 6, 2026 at 11:15 AM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> >
> > On Mon, Oct 05, 2026 at 08:59:43PM +0530, Maulik Shah wrote:
> > > Some domain idle states require system-wide coordination and should not be
> > > selected during regular CPU idle. However those states remain valid for
> > > system-wide suspend like s2idle.
> > >
> > > Add a per-state system_state boolean and populate it from the system-state
> > > property. Make the genpd governor skip these states during CPU idle. Leave
> > > the system wide suspend path unchanged so s2idle can select them.
> > >
> >
> > Instead of this I am thinking if we can QoS cpu latency setting and block
> > system level states normally. Since s2idle is user driven, it should be
> > controllable via user-space and we don't have to define bindings again
> > if systems that use platform-coordinated needs this too. They may not
> > use domain-idle-states.
> 
> Even if we likely could make that work, it's seems not correct to rely
> on userspace to make the kernel to pick the correct idle state, while
> the decision should be based on the characteristics of the HW.
> 
> In regards to PSCI PC mode, I believe we should consider adding the
> similar DT property for the arm,idle-state binding and make a
> corresponding change for the regular CPUIdle path/governors. Although,
> it doesn't necessarily need to be part of the $subject series. I would
>  be fine if that is handled later on too.
> 

While I agree with this line of argument, I am bit worried that there is
more deviation from ACPI _LPI binding(equivalent to these in DT). If other
OS has manged to run the same firmware without adding such information
to the firmware(ACPI in this case), why do we need that in DT. Is that
information encoded elsewhere in a different form in ACPI and is this the
right place(the idle state binding for DT) is what I am trying to understand
here.

Also taking the example of screen on, won't that be prevented as the
system domain is shared by the system level idle-states we are talking
and the screen/display device. So it never votes to power down that
and the PSCI OSI domain idle driver must not be able to choose the system
level state.

In general, there is some device that doesn't vote to power down the domain
and hence we can't enter the state. So my question is, will there be some
device that doesn't explicitly register vote and hence we need an alternate
mechanism like the one proposed in this set ? If so, what are those and
how does that work in system suspend states.

Or am I missing something more fundamental the makes all the above argument
void.

-- 
Regards,
Sudeep
