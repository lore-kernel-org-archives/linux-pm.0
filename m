From: Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH 0/3] Add support for Tegra Activity Monitor
Date: Tue, 11 Nov 2014 16:32:22 +0900
Message-ID: <5461BB86.509@nvidia.com>
References: <1414594232-15684-1-git-send-email-tomeu.vizoso@collabora.com> <545C8BCC.3090908@nvidia.com> <545CBC87.7050404@collabora.com> <546190BA.7050502@nvidia.com> <5461B35A.3080604@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:19269 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514AbaKKHdD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Nov 2014 02:33:03 -0500
In-Reply-To: <5461B35A.3080604@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?windows-1252?Q?Terje_Bergstr=F6m?= <tbergstrom@nvidia.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Thierry Reding <treding@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 11/11/2014 03:57 PM, Terje Bergstr=F6m wrote:
> On 11.11.2014 06:29, Alexandre Courbot wrote:
>> I think (after a quick look at devfreq's source) that you can avoid
>> polling altogether if you set polling_ms to 0 in your
>> devfreq_dev_profile instance. Then it is up to you to call
>> update_devfreq() from your custom governor whenever it sees fit.
>>
>> ACTMON support seems to overlap between being a governor (which reac=
ts
>> to ACTMON interrupts and calls update_devfreq() when needed) and par=
t of
>> a devfreq_dev_profile (get_dev_status() needs to use the actmon
>> counters). If we keep your current design where the driver simply
>> controls a clock, you could have the ACTMON driver obtain that clock=
,
>> register its governor, create a non-polling devfreq_dev_profile that
>> controls that clock, and just call devfreq_add_device() with both. T=
hen
>> we will have the benefit of being able to use ACTMON as well as the
>> performance and powersave governors on EMC, and switch policies
>> dynamically.
>
> Another way to use it is that governor is just a governor. It takes i=
n
> load values and generates new target frequencies, and doesn't know
> anything about HW.
>
> Device profile is the one that enables threshold interrupts and disab=
les
> polling. Device profile receives the interrupt, retrieves new load
> number from hardware, and calls update_devfreq().
>
> This way we keep all HW specific code in device profile, and there's
> potential to use a generic governor instead of writing your own.

I see several obstacles with this approach:

1) update_devfreq() is a governor private function (defined in=20
drivers/devfreq/governor.h) and it would need to be called from the=20
device profile.

2) devfreq events (start monitoring, stop monitoring, suspend, resume,=20
=2E..) are processed by the governor. So it would still need access to =
the=20
actmon registers to honor these requests.

3) simple monitors like performance and powersave set the frequency (ma=
x=20
or min) once and for all when they are started, and don't need to be=20
called again afterwards. But this is probably what will happen if you=20
let the devfreq_dev_profile handle the ACTMON registers, since it can=20
make no assumption on when the governor expects to be invoked.

It would be good to have the feedback of devfreq's maintainers about=20
this (added them). How could an IP capable of monitoring activity=20
through counters and firing interrupts when these counters reach a=20
certain threshold be integrated nicely into devfreq? The functions seem=
=20
to overlap between the governor (reacting to specific events, in this=20
case ACTMON interrupts) and dev_profile (querying current status throug=
h=20
the counters), and it seems difficult to come with a design where the=20
governor and dev_profile are not tightly intertwined.
