From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC/PATCH v2 3/5] devicetree: bindings: Add new cpuidle enable
 method for Renesas R-car SoCs
Date: Tue, 21 Apr 2015 11:55:39 +0100
Message-ID: <20150421105539.GA26706@red-moon>
References: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
 <1429180540-5692-4-git-send-email-keita.kobayashi.ym@renesas.com>
 <20150417124624.GD21904@leverpostej>
 <CANqRtoTaGc7QCJAVj8Jhpo5HgbwyfiRQZz5j0zBkE1cBkDZAzQ@mail.gmail.com>
 <20150417143723.GC2347@red-moon>
 <5534AD37.20705@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46362 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbbDUKzo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Apr 2015 06:55:44 -0400
Content-Disposition: inline
In-Reply-To: <5534AD37.20705@renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: keita kobayashi <keita.kobayashi.ym@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Mark Rutland <Mark.Rutland@arm.com>, "horms@verge.net.au" <horms@verge.net.au>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Apr 20, 2015 at 08:39:35AM +0100, keita kobayashi wrote:

[...]

> > It is related, but Mark's remark is correct. We have to keep in mind
> > that an enable-method defines how a CPU is powered {up/down} and
> > also suspended (quiesced through idle).
> > 
> > It has to be defined through proper bindings and related code, adding a
> > random compatible string for the sake of matching does not cut it,
> > that is not acceptable and I stated it from the beginning.
> > 
> > So, to make it clear, an enable-method defines CPU operations as a
> > whole, cpu init, power{up/down} and suspend.
> > 
> > It must be documented with proper bindings that defines compatible string and
> > related properties.
> > 
> > The sooner we incorporate the CPUidle ops into SMP ops the better to
> > prevent this abuse from happening, an enable-method encompasses SMP
> > ops and CPUidle ops, actually they must be merged because they represent
> > the enable-method implementation as a whole.
> > 
> > I hope this helps.
> > 
> > Lorenzo
> 
> 
> I will rename "renesas,rcar-idle" in the next patch.

It is not just about renaming a compatible string, it is about defining
a DT binding and related enable-method as a whole.

Thanks,
Lorenzo
