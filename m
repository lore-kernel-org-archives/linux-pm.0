From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v1 4/7] thermal: introduce the Power Allocator governor
Date: Mon, 9 Feb 2015 10:14:23 +0000
Message-ID: <20150209101423.GC6009@e104805>
References: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
 <1422464438-16761-5-git-send-email-javi.merino@arm.com>
 <20150202235120.GC4855@linaro.org>
 <20150203130336.GA2896@e104805>
 <20150203043102.GG17425@developer.hsd1.ca.comcast.net>
 <20150203173211.GD4855@linaro.org>
 <20150203191951.GA3486@developer.amazonguestwifi.org>
 <20150204234716.GC488@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:42723 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbbBIKOd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Feb 2015 05:14:33 -0500
Content-Disposition: inline
In-Reply-To: <20150204234716.GC488@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>

Hi Lina,

On Wed, Feb 04, 2015 at 11:47:16PM +0000, Lina Iyer wrote:
> On Tue, Feb 03 2015 at 12:20 -0700, Eduardo Valentin wrote:
> >On Tue, Feb 03, 2015 at 10:32:11AM -0700, Lina Iyer wrote:
> >
> ><big cut>
> >
> >> >
> >> >Well, I am not convinced drivers really need to be aware of these trip
> >> >types. Which kind of drivers are we talking? Thermal zone drivers?
> >> >cooling device drivers?
> >>
> >> I am sorry, I am missing the point here. The Tz driver is requested to
> >> return the type of an enum and if the enum is not shared, then how is
> >> the driver expected to know what to return.
> >
> >Yeah, however, the only requirement I see for this governor is to have
> >two passive trip points.
> >
> I understand, but the thermal zone may have multiple trip points that
> are passive. How would the thermal zone indentify which trip point is of
> interest to this particular governor.
> 
> From what I see, every governor can define its number/type of trip
> requirements and the TZ can define any number of trip points. I dont see
> how I can write a TZ driver tha would work with a  governor in the
> future that may expect more than 2 passive trip points.
> 
> >> >
> >> >Lina, do you have an existing driver (it can be yet to be posted) that
> >> >would required using these types? To my understanding, these are simply
> >> >for the governor internal control, drivers do not really need to understand
> >> >the difference from one to another.
> >>
> >> I am currently prototyping Javi's patches on QCOM existing solution. So its all WIP.
> >
> >I see.
> >
> >> >
> >> >The purpose of the .bind_to_tz callback is exactly to verify if the
> >> >driver has added the required info into the thermal zone. Including the
> >> >trip setup.
> >>
> >> I may be completely off-base here and my understanding of trips is
> >> questionable. But it seems like even with this callback, the driver
> >> expected to know what the particular governor defines and needs from the
> >> TZ.  The definitions may overlap and may mean different things in
> >> different governros. To me a TZ driver should not care what the
> >> governors are, but define some common parameters that any governor can
> >> work with. Am I making sense here?
> >
> >
> >And that's is what I want to keep across the framework. Thermal zone
> >driver should not really be aware of governor details. Ideally, the
> >driver should provide a thermal zone that can be usable by different
> >governors. That is the ideal setup.
> 
> Right, but if the governors have no common enums, the driver would not know how
> many trip points to implement.

The constraint we currently have in the power allocator governor is
that trip points 0 and 1 must be passive.  Actually, all the governor
needs is two passive trip points, but they don't need to be pinned to
a specific number.  The "switch on" trip point has to be the first
passive trip point, but it need not be trip point 0.  We could relax
this constraint to just make it exactly that: "the first passive trip
point".  As for the control temperature, we could relax the constraint
to make it "the last passive trip point of the thermal zone".  Would
that work for you?

> >If we allow this new governor to have its own trip types, we will be
> >segregating thermal zones. And that should be avoid if possible.
> >
> >
> >>
> >> >
> >> >Besides, the existing exposed trip types are sufficient, given that this
> >> >series is in a working state. Unless we have a valid use case to change
> >> >/ add trip types and expose them to driver, I would prefer to keep this
> >> >simple.
> >> >
> >> >Side note, drivers/thermal/thermal_core.h has symbols that are not
> >> >exported. As drivers can be built as separated modules from thermal
> >> >core, I would not recommend include things in that header. The symbols
> >> >that are EXPORT_SYMBOL'ed are in thermal.h under include directory.
> >> >
> >> >>
> >> >> Cheers,
> >> >> Javi
> >> >>
> >> >> > I dont think anymore, this should be a enum thermal_trip_type, but it has to be
> >> >> > generic across governors.
> >> >> >
> >> >> >
> >> >> > Thanks,
> >> >> > Lina
> >>
> >>
> 
> 
> 
