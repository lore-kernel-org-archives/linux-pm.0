Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30213812FE;
	Tue,  8 Sep 2026 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896280; cv=none; b=Ymk4GvWpspdDvSEN6jQb10VVmxu5AAiwRjEda5aeXKcGEX//Sset70s1+3MfsSgIojZ0LrBSQFWZfOmtD+UIicc3WBiEJfJAB0blx5NAxgITK1V4XVxQAOkl+/bcBvPREMtdg8KwRyEhw3pTIY3BAbwAK1EQICjBo0ZgaNY2Ksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896280; c=relaxed/simple;
	bh=2qk0fy8BaA5H2eULjkDkeUiAjpBmUTLpUODBkGZ+mHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA4oLx0HWBuecTMZ/i9PQf+mAVkcLaDdMSk0eMzjjxW6NDXzmGPZxmy/MMQVN+/ytJmjk70v5deFBqCpN2MqqQAruVBYq0FlKPGey1yxATr0aqI3x0dNKHicuGSuMRTD5oavAiGab9Y6w33XTHo2Ced77h+fP38O6oXQHW8/iVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxLO7Ylh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxLO7Ylh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEFD1F00A3F;
	Tue,  8 Sep 2026 19:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788896278;
	bh=dqsuwEOibNCoxL+MY+KJcXPDxVwv27f/BtLbRZm4oLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LxLO7YlhfkJ6kIOGDGZ5nSoikZlhH+iKssK96nrIO7LPlq5q0K2Xj6+A/pa9/a+RX
	 MwPsws+1FTtge8362AgmAZRufc0hEQRFbUOUzwWcXHmJoIGnTqVfoWQPyV0JRvyvOs
	 VmHenITvMjztqR/lCdFgSN/laLJDqebEOreLQId8H6kDq8mW2kpJlDTe+W6KqaHwWZ
	 p+rR+msrIozKsAIdEu/QhUHnJKjr+snX2BjbUYougfQxRLPy6wTgLdGNR0Kn7VbpER
	 Up1n5Q6hbMAqpZj1QlHWmyJkUyZ97Ej44ohBwdTHv5XiCehhhnrnKV33ex8bzFWzEm
	 ddml7G1VkX4Cg==
Date: Tue, 8 Sep 2026 20:37:52 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
	Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH RFC 01/10] firmware: arm_scmi: Add SCMI QCOM Generic
 Extension Protocol documentation
Message-ID: <20260908-optimal-alpaca-of-justice-f55bba@sudeepholla>
References: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
 <20260724-rfc_v8_scmi_memlat-v1-1-cb732bcff1f4@oss.qualcomm.com>
 <20260724-crouching-starfish-of-apotheosis-d1cdf8@sudeepholla>
 <f39b2be0-b6d6-43a6-a412-44ff433c51f6@oss.qualcomm.com>
 <20260813-remarkable-handsome-heron-e99e78@sudeepholla>
 <fb0ad185-8989-48a9-86b4-9c765788febf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb0ad185-8989-48a9-86b4-9c765788febf@oss.qualcomm.com>

On Thu, Aug 20, 2026 at 01:26:57AM +0530, Sibi Sankar wrote:
> 
> On 8/13/2026 12:48 PM, Sudeep Holla wrote:

[...]

> > The current rationale isn't entirely clear to me. Windows historically favors
> > ACPI over native SCMI, meaning that supporting a proprietary vendor protocol
> > would require non-native workarounds potentially hidden within interfaces like
> > PEP. I am skeptical of this architectural direction. Since Android leverages
> 
> In an ideal world maybe but transition for all SoC capabilities to ACPI is
> rarely that smooth and they do use the PEP interface.
> 

Well I agree, then we shouldn't be bringing up the topic of OS agnostic
firmware as that is not a reality on the platforms we are talking about
then ?

> > the Linux kernel and already manages this through vendor modules, maintaining
> > those as modules seems like the optimal path until we agree on the interface
> > that can be merged.
> > 
> > Given that this patch series has been under discussion for nearly two years,
> > please provide a summary of the feedback that has already been incorporated
> > to address these concerns just for sake of argument and in your defence.
> > 
> > To clarify, the vendor protocol space is strictly intended for
> > platform-specific functionalities that cannot be standardized; it should not
> > be used to bypass standardization for convenience. It appears no evaluation
> > was done to determine if or why the standard performance protocol was
> > insufficient. Had that assessment occurred, I would expect the proposed
> > interface to align much more closely with the standard definitions as I
> > previously mentioned.
> 
> The design might seem contrived at the moment but it was still largely
> shaped by the SCMI specification. There is a literally a 6-7 year window between
> SCMI landing in mainline and the first mention of the vendor protocol identifiers
> being re-useable between SoC vendors [1]. This largely shaped how Qualcomm

[1] shows the date as 2024, so 6-7 years is bit of exaggeration IMO.

> used vendor protocol. The first instance of vendor protocol was a straight
> forward vendor protcol implementing just MEMLAT [2] but the sudden rise in
> the number of protocol eating up vendor protocol space made them club
> together the class of devfreq algorithms into a singular generic extension
> protocol.
>

I fully understand that this interface is already deployed in firmware and
that changing that firmware ABI may no longer be practical. However, I
think we need to separate two things: supporting an existing firmware ABI
and accepting that ABI as the abstraction exposed through the upstream SCMI
framework.

The former is a compatibility constraint for Qualcomm platforms. The latter
is an upstream interface and maintainability decision, and the existence of
deployed firmware cannot by itself determine that decision.

> "deliberated attempt to circumvent the standard SCMI protocol template"

This was specifically targeted for having performance related tunables
outside of PERF protocol. If that is not possible, then I take back that
statement.

> "expectation of immediate acceptance without modification"
> 
> I gather that ^^ are the major objections to the current series landing but
> sadly none of these were raised during this 2 year period and this protocol
> even had a "Reviewed-by" from the only other reviewer listed [3]. We
> promised to fix all the concerns raised [4] in the next major/minor version upgrade
> [5].

It is common for intermediate versions to receive Reviewed-by tags, but those
do not necessarily imply final acceptance of the entire series. If there is an
instance where I provided a Reviewed-by and later withdrew it without
providing a technical justification, please point it out.

Also, with code alone, please do not expect me to review these series
effectively. It took more than a year and half for the documentation to reach
a state where the design and implementation could be reasonably understood.
Now that we have sufficient improved documentation and a clearer understanding
of the approach, a proper and detailed review has just begun.

Therefore, I do not think it is fair to claim that these issues should have
been identified during reviews over the past two years. The lack of clear and
adequate documentation made meaningful review difficult, and I have repeatedly
requested improvements to the documentation for precisely this reason.

> The current version works as is on Hamoa/Purwa/Glymur/Mahua/Kaanapali
> maintaining the same ABI (that should count for something) and it would only
> need a major/minor version update when a new algorithm string gets added
> or a new param-ids gets added. Both of these are yet to happen.
> 

My concern with the generic extension protocol remains the multiplexing
model. SCMI protocol IDs are themselves the mechanism by which
independently defined functionality is identified, discovered and
versioned. Introducing another namespace underneath a single vendor
protocol, where an algorithm string selects effectively independent
interfaces with their own sets of param_ids, duplicates that mechanism and
makes protocol 0x80 a container for potentially unrelated functionality.

> Given that we put out the pseudo code of what the MEMLAT algorithm does
> and spent the past several revisions trying to explain why generic perf nor
> mpam would work for us we keep getting hit with the blanket "It appears
> no evaluation was done to determine if or why the standard performance
> protocol was insufficient". The only recommendation I see from your side
> is move MEMLAT to it's own protocol. With the documentation/code
> available to you can please let us know how current perf protocol or MPAM
> can be used as a standin replacement?
> 

This is also why I suggested treating MEMLAT as a distinct vendor protocol.
I am not suggesting that MEMLAT can necessarily be replaced by the standard
Performance protocol or MPAM. Those are separate questions. If MEMLAT
semantics do not map to either of those, then that is a perfectly valid
reason for having a vendor protocol. But "this functionality requires a
vendor protocol" does not imply that the generic SET/GET/START/STOP
multiplexing protocol is the right upstream representation of it. I am
completely against such generalisation which will end up being ambiguous
sooner or later.

> [1] - https://lore.kernel.org/lkml/Zag5L9j8-oCebKFm@pluto/
> [2] - https://lore.kernel.org/lkml/1667451512-9655-1-git-send-email-quic_sibis@quicinc.com/#t
> [3] - https://lore.kernel.org/lkml/Zo14-rQ1Jaxh5Idi@pluto/
> [4] - https://lore.kernel.org/lkml/Z1GfGk0yQAVQKEVL@pluto/
> [5] - https://lore.kernel.org/lkml/55fd0c34-c52c-95c5-5cd0-16fd66a4baa2@quicinc.com/
> 
> > 
> > The core issue here is that the proposed vendor protocol interface has been
> > presented as a finished product without open discussion or a willingness to
> > iterate based on upstream feedback. This approach bypasses standard
> > development processes.
> 
> It would be way easier for us to re-design this but it would mean that we
> are abandoning the current users stuck with this firmware version and that's the
> only reason for trying to land this in a form that is maintainable. Either
> way  please do take the call to decisively NAK the series (even if it's coming 9
> revisions late and at the cost of 2 years). That way we can give up on this
> and go about upstreaming using the standard development process.
>

I also don't think the fact that this has gone through several revisions
means that architectural concerns can no longer be raised. I appreciate the
amount of work that has gone into the series and the changes made in
response to previous reviews, but neither elapsed time nor deployed
non-standard vendor firmware can make an upstream interface immutable
before it is merged. This series is not even properly versioned, carries
RFC still without version if it is no the first RFC. Anyways, there are
series that go through 15-20 versions before it get merged. See SCMI
telemetry itself at v11 already. So, I don't understand your complaint and
all I can say is welcome to the kernel development process if its still a
for you.

So I don't see this as a choice between accepting the current generic
protocol or abandoning users of existing firmware. Sorry!

If it is easier as you mentioned, yes please re-design MEMLAT and any other
algorithm as a separate vendor protocol. If it helps take this as NACK for
the current interface. Hopefully this helps you in making proper progress
on upstreaming using the standard development process.

This is not the only or first firmware ABI Qualcomm has failed to upstream
because it was all baked and couldn't be changed. So nothing new/surprise
at that end.

> That said please do consider expanding your reviewer/maintainer count
> in a way that gives you the capability to review series from all SoC
> vendors.
> 

I don't quite understand this. Please elaborate.

-- 
Regards,
Sudeep
