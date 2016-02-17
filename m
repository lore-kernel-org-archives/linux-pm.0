From: Matt Longnecker <mlongnecker@nvidia.com>
Subject: Re: [PATCH V5 07/11] of: Add bindings of hw-trip-points for soctherm
Date: Wed, 17 Feb 2016 12:52:32 -0800
Message-ID: <56C4DD90.3080506@nvidia.com>
References: <1454057260-16412-1-git-send-email-wni@nvidia.com>
 <CAL_JsqKwQOxkWyYPcv6sBe8ELUuPx4N+iUF94J8R63bRxsGK4g@mail.gmail.com>
 <56C17AFD.8050203@nvidia.com> <56C4417D.2030409@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56C4417D.2030409@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Ni <wni@nvidia.com>, Rob Herring <robh@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

(cc +=3D linux-pm)

Rob,

The Linux thermal framework makes a sharp distinction between "thermal=20
zones" and "cooling devices". thermal_zones are aware of temperatures=20
and have trip points. cooling_devices are unaware of temperatures --=20
they just have a state variable. The thermal framework binds thermal=20
zones at particular temperatures to particular cooling devices. It does=
=20
so *in software*

The SOC_THERM IP block doesn't fit neatly in that paradigm. Yes, it=20
provides the ability to read temperatures and raise interrupts at=20
temperatures. However, it also has the ability to take cooling action=20
_in hardware_ at particular temperatures. It can throttle the CPU & GPU=
=20
clock and it can shut down the SOC. Neither of those are graceful=20
actions, but they are valuable in practice.

In previous incarnations of this driver we have implemented an unholy=20
mash-up of a cooling device and a thermal zone for configuring the=20
hardware thermal actions. It was a mess. This patchset from Wei takes a=
=20
simpler approach -- allow the thermal hardware cooling actions to be=20
configured directly via DT. It's simple but it's good enough in=20
practice. I like it.

-Matt

On 02/17/2016 01:46 AM, Wei Ni wrote:
> On 2016=E5=B9=B402=E6=9C=8815=E6=97=A5 15:15, Wei Ni wrote:
>> >Hi, Rob
>> >
>> >On 2016=E5=B9=B402=E6=9C=8812=E6=97=A5 22:42, Rob Herring wrote:
>>> >>On Fri, Jan 29, 2016 at 2:47 AM, Wei Ni<wni@nvidia.com>  wrote:
>>>> >>>Add hw-trips sub-node for soctherm, which is
>>>> >>>used to describe the hardware trip points for
>>>> >>>each soctherm sensors.
>>> >>
>>> >>I still don't understand why you are doing something custom here.
>>> >>What's wrong with what is defined in:
>>> >>
>>> >>Documentation/devicetree/bindings/thermal/thermal.txt
> I think it's better to add a .set_trip_temp for of-thermal's
> thermal_zone_of_device_ops{}, so that we can set trip points on hardw=
are. I'm
> preparing patches, and will send out next version.
> Thanks for your comments.
>
