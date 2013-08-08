From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: RFC: device thermal limits represented in device tree nodes
Date: Thu, 08 Aug 2013 14:45:19 +0100
Message-ID: <1375969519.12043.142.camel@hornet>
References: <51ED40E3.5020703@ti.com> <51EF3186.9060001@wwwdotorg.org>
	 <1374664745.25700.118.camel@hornet> <51EFED19.5090900@ti.com>
	 <1374768928.3213.31.camel@hornet> <51F15E42.1060409@ti.com>
	 <1374773611.3213.44.camel@hornet> <51F2D443.6040909@ti.com>
	 <1375787649.12043.34.camel@hornet> <5202AB95.9020605@ti.com>
	 <20130808085346.GC14648@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:42061 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947Ab3HHNpY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2013 09:45:24 -0400
In-Reply-To: <20130808085346.GC14648@e106331-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Guenter Roeck <linux@roeck-us.net>, Durgadoss R <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Wei Ni <wni@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2013-08-08 at 09:53 +0100, Mark Rutland wrote:
> On Wed, Aug 07, 2013 at 09:18:29PM +0100, Eduardo Valentin wrote:
> > Pawel, all,
> >=20
> > On 06-08-2013 07:14, Pawel Moll wrote:
> > > Apologies about the delay, I was "otherwise engaged" for a week..=
=2E
> > >=20
> >=20
> > I do also excuse for my delay, as I was also "engaged" for a week o=
r so.
> >=20
> > > I hope you haven't lost all motivation to work on this subject, a=
s it's
> > > really worth the while!
> >=20
> > Not really! quite the opposite. Although I was looking at some othe=
r
> > stuff, I got this series also tested on different boards and wrote =
down
> > a couple of improvements I will be working in the coming days. Inde=
ed,
> > it is worth moving forward with this work.
> >=20
> > >=20
> > > On Fri, 2013-07-26 at 20:55 +0100, Eduardo Valentin wrote:
> > >> On 25-07-2013 13:33, Pawel Moll wrote:
> > >>> On Thu, 2013-07-25 at 18:20 +0100, Eduardo Valentin wrote:
> > >>>>>> 	thermal_zone {
> > >>>>>> 		type =3D "CPU";
> > >>>>>
> > >>>>> So what does this exactly mean? What is so special about CPU?=
 What other
> > >>>>> types you've got there? (Am I just lazy not looking at the nu=
merous
> > >>>>> links you provided? ;-)
> > >>>>
> > >>>> Hehehe. OK. Type is supposed to describe what your zone is rep=
resenting.
> > >>>
> > >>> As in "a name"? So, for example "The board", "PSU"? What I mean=
t to ask
> > >>> was: does the string carry any meaning?
> > >=20
> > > You haven't commended on this...
> >=20
> > The string is supposed to carry meaning, yes. Couple of common used=
:
> > CPU, GPU, PCB, LCD
>=20
> I think the point Pawel was getting at is that the string doesn't hav=
e a
> *well-defined* meaning that always allows an OS to figure out the set=
 of
> relevant devices. If we have a thermal zone for "LCD", and have multi=
ple
> LCDs, which LCDs are covered? If we have a "PCB" zone, does this cove=
r all
> the devices attached to the PCB, a subset thereof, or the substrate o=
f
> the PCB itself?

Or: what happens if I type "lcd" instead of "LCD"? Would there be any
decision made based on this string? Or is it just a label to be used
somewhere in debugging messages?

Pawe=C5=82


