Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188111;
	b=FAkjt7oLJY9wJH+Qoe3AQVqmMgMwrRXN/PLYGb6q2PDHxjD86VHC5OweIQ+fh72TeOM3
	 oGN0d1Qrmt/KLlEzNfUj9HjzHOEkIOJBFPXVMysmGjFIWSw3lI2mqzHtgSx3Mg5n6swGA
	 NAodqzvnQtUiGr04rrEzH6RXW5I7fbpwQfJ7s/aS+SRzPQXH9my8luFrkQ5z89jzc9FL8
	 f3Z8Rt1zldcu2welyGpsA+oCUqrBRZqCmwmHcJglwZBgjp+an/Oy5Zfd+mp+znSijDLJF
	 3oDR7i0HLiz7NKHRNO2wnxbg0jJa9MYtxZSCzZgDp1YzUSvNUk7siCJ/6VwwNghMFuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188111;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=zUA7wsdwkDcXAmf5trYXKJIaPx0Jsdm4yykZkgY8SWs=;
	b=vTj2p57z1BXyBcwL09gUJakRmWQDfwMS/5Bd+FcZe+21jeQGGGWcbWcFsWas6QMWM9u6
	 hgC2bFXCLhBULPLC1Tpf4IvEUQS1YxpQiGxd5QpYZRThryc2rwqK6OeZY+RwnbVefQmMb
	 NcC0ejUoifzru6pEPXoJTsTSs4ym4p8vHZ/uH3rAkgI7yYGtL6b/WPohUDVQLNzoI7mWT
	 pMq7ci84gbZdyS6EQNp8+MjAjVDz04ExZtxuAI/UpFEdAFQ7Y8ei3AwaZ752KSzjok0eA
	 Na49O214cpLZw4zLgwwmk/XPAMhamzvAQr+9yCIajpUpF1wDPpj0sLHFxj4XcFyxpFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQwwUKwt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12EF606A325;
	Wed, 28 Oct 2026 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQwwUKwt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E411F01825;
	Wed, 28 Oct 2026 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793188110;
	bh=zUA7wsdwkDcXAmf5trYXKJIaPx0Jsdm4yykZkgY8SWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UQwwUKwtNDl0F0ynm4pREwo76+FnDiRNAtZIUrH/qRV/yf5r83ielPCY5XlGZC8f6
	 o3sYmWHTou7jHUObwehWBNQAEvo4QVA8Mj92AVnKWLtY2QGpWwjogCdSl3576LjKVX
	 hxbMct6TL4Hyq6QhX6Y3ILaAJIAUBz0VD2eNA8HzYZ9mTMVcGY13uONovW4yN6Kx4X
	 c5cnXiNS63MU2RrWA4mH3IjwHIZEHk87PbrJYEPpLrngn+v1/Py3XGlO3bcVicCDh1
	 kzI7MiA25w158CL3UBUamf4nGDSRYPm8+7PEQLu9zyqmwrp3fnlfcnb4s1HJCJmlSl
	 h3qKP7qbF1V2Q==
Date: Wed, 28 Oct 2026 11:48:25 +0000
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
Message-ID: <20261028-imported-pistachio-unicorn-2ecfec@sudeepholla>
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
 <20261005-s2idle_state-v1-2-3c402c66f388@oss.qualcomm.com>
 <20261006-romantic-stalwart-seriema-90e71d@sudeepholla>
 <CAPx+jO-T_0KT3GytYu8w6QvrhXFQNZQzR496RL=McU6rnMtnPA@mail.gmail.com>
 <20261009-frisky-rottweiler-from-avalon-6c409e@sudeepholla>
 <CAPx+jO-_aY5pMnWyy1hAs1WRmfW33vc317jdtBsEXYBoHsPfxA@mail.gmail.com>
 <20261009-skilled-mature-bittern-2206fc@sudeepholla>
 <CAPx+jO87gkTumF=Tg=UPWpJO6O-CRF4njT2KxQ3f=4nF5m7GiQ@mail.gmail.com>
 <20261014-prudent-mini-duck-377cb6@sudeepholla>
 <CAPx+jO_BOwbKeRytBezm+piLhb8Z5N2eQO=LRwBQoSZ3kXOpwQ@mail.gmail.com>
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
In-Reply-To: <CAPx+jO_BOwbKeRytBezm+piLhb8Z5N2eQO=LRwBQoSZ3kXOpwQ@mail.gmail.com>

On Wed, Oct 28, 2026 at 11:59:58AM +0100, Ulf Hansson wrote:
> On Wed, Oct 14, 2026 at 9:12 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> >
> > On Tue, Oct 13, 2026 at 12:11:36PM +0200, Ulf Hansson wrote:
> > > On Fri, Oct 9, 2026 at 5:27 PM Sudeep Holla <sudeep.holla@kernel.org> wrote:
> > > >
> > > > On Fri, Oct 09, 2026 at 04:26:38PM +0200, Ulf Hansson wrote:
> >
> > [...]
> >
> > > > > If that's the case, besides that the cluster PM domain topology must
> > > > > be modelled accordingly, the display device should be hooked up to the
> > > > > cluster PM domain it belongs to.
> > > > >
> > > >
> > > > Ah, I thought that's the way the whole domain-idle was modelled as we
> > > > started this OSI discussion a decade ago with an example of CPU clusters
> > > > sharing power domains with some other devices. I am surprised if that is
> > > > not the case already 🙁.
> > >
> > > It works fine today, I was just trying to explain how it works,
> > > considering the use case that you brought up.
> > >
> >
> > Ah OK, good to hear. For once, it sounded like that's not the case. My bad.
> >
> > > >
> > > > > Beyond that, it's the corresponding display driver that becomes
> > > > > responsible for what should happen during system suspend. If the
> > > > > screen needs to stay on it may need to call device_set_awake_path()
> > > > > for the display device - unless it's a decision for user space that
> > > > > can control the behaviour for the display device via its sysfs node.
> > > > > If things are managed accordingly, genpd_finish_suspend() may decide
> > > > > to keep the corresponding PM domain powered on during system suspend.
> > > > >
> > > >
> > > > But the s2idle and s2ram anyways suspends all the devices, so they need
> > > > to vote in for the power domains to be turned off. If they are supposed
> > > > to stay on, the system enters the state it can based on the other votes.
> > > >
> > > > > The above said, $subject patch doesn't change any of this. It only
> > > > > allows us to use more states (deeper), which are limited to system
> > > > > suspend (s2idle).
> > > > >
> > > >
> > > > Still not convinced, if all devices are plugged in to the power domain
> > > > hierarchy correctly and the domain-idle states represent or carries
> > > > the entire system power domain topology, we shouldn't need this extra
> > > > information. Having it make cause issues when it conflicts with the
> > > > topology information IMO.
> > >
> > > No, it's still not sufficient to model the power domain hierarchy correctly.
> > >
> > > These "system states" are special since they require additional
> > > coordination in FW/HW, to take into account votes not directly
> > > controlled by Linux.
> > >
> >
> > But if Linux doesn't control, some other entity would vote and until then
> > the system shouldn't enter that state. Without knowing that it is system
> > state, will the kernel be unable to choose that state as it hidden vote
> > is invisible/not tracked ? I trying to understand why if Linux chooses
> > that system level state as part of idle loop, the platform can't downgrade
> > if all the voting requirements are not met. I am struggling with that
> > and want to make sure we are not working around a broken firmware.
> 
> For OSI, all the FW would be able to do is to return an error. But
> that doesn't prevent Linux from trying the same idle state again and
> again.
> 

Now I understood the requirement much better. The core issue with OSI is
that it fails unless the platform downgrades special system states to
non-system states during routine CPUIdle paths.

This leaves us with two directions for OSI:
1. Firmware Resolution: Handle state transitions entirely in firmware.
2. OS Intervention: Enforce the handling via the OS.

Though I personally prefer (1), I don't have strong arguments against (2)
now that you made me understand the requirement. Sorry for taking time,
but mentally I was assuming (1) even for OSI until your above response.

Since PC mode relies on the firmware to manage these states natively, this
binding isn't required for it. Therefore, Could we restrict this specific
binding exclusively to OSI implementations ?

-- 
Regards,
Sudeep
