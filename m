From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH v3 1/5] Documentation: add DT bindings for ARM SCPI
 sensors
Date: Tue, 15 Sep 2015 17:31:29 +0100
Message-ID: <1442334689.4040.68.camel@linaro.org>
References: <1442235619-4029-1-git-send-email-punit.agrawal@arm.com>
	 <1442235619-4029-2-git-send-email-punit.agrawal@arm.com>
	 <20150914131448.GC7002@leverpostej>
	 <9hhh9mxf7lg.fsf@e105922-lin.cambridge.arm.com>
	 <20150914134949.GE7002@leverpostej>
	 <9hhk2rtdq1f.fsf@e105922-lin.cambridge.arm.com>
	 <1442251092.2850.53.camel@linaro.org>
	 <9hhy4g89g64.fsf@e105922-lin.cambridge.arm.com>
	 <1442313962.2917.25.camel@linaro.org>
	 <9hheghzvfbz.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smarthost01b.mail.zen.net.uk ([212.23.1.3]:45988 "EHLO
	smarthost01b.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751622AbbIOQci (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 12:32:38 -0400
In-Reply-To: <9hheghzvfbz.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux@roeck-us.net" <linux@roeck-us.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 2015-09-15 at 17:04 +0100, Punit Agrawal wrote:
> "Jon Medhurst (Tixy)" <tixy@linaro.org> writes:
> 
> > On Tue, 2015-09-15 at 10:37 +0100, Punit Agrawal wrote:
> >> "Jon Medhurst (Tixy)" <tixy@linaro.org> writes:
> >> 
> >> > On Mon, 2015-09-14 at 15:38 +0100, Punit Agrawal wrote:
> >> >> Mark Rutland <mark.rutland@arm.com> writes:
> >> >> 
> > [...]
> >> >> The way the SCP interface is defined, the sensor identifiers are
> >> >> contiguous,
> >> >
> >> > Is there any documentation other than DUI0922A? [1] From what I can seen
> >> > that just says it's a 16-bit value and doesn't put any particular
> >> > constraints on its value.
> >> 
> >> Although not explicitly stated, if you look at the Get Sensor Capability
> >> [2] and Get Sensor Info [3] commands you can indirectly infer that the
> >> Sensor IDs are contiguous.
> >
> > I personally wouldn't even indirectly infer they are contiguous from
> > what the document says. If I were implementing the firmware I would feel
> > quite in my rights to, for example, use the top 8 bits of the ID for a
> > sensor type and the bottom 8 for an index, if that made dispatching of
> > requests more efficient. Or if some optional hardware was detected as
> > missing, leaving some holes in ID space.
> 
> True. And without a command to convey the list of valid IDs, the
> consumer of the API would have to iterate over the entire 16bit space to
> locate valid IDs.

Or get IDs from device-tree :-) Anyway, I'm not arguing that the IDs
shouldn't be 0..N-1, just that it should explicitly documented in the
SCPI doc, which we're are in agreement on.

-- 
Tixy

