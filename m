From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Wed, 2 Mar 2016 09:43:10 -0600
Message-ID: <CAGo_u6r=+cEUiRqP5uLEjRM73qQYPC1kt-D=71vnexkL-fhZZA@mail.gmail.com>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
	<2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
	<55F72C97.2030306@kernel.org>
	<CAKohpo=fcab=eisbwMw=wvbmuXVY5iw_CSe3QK1Ax_i-56JAzA@mail.gmail.com>
	<20160302025016.GS18327@sirena.org.uk>
	<20160302102831.GE2891@vireshk-i7>
	<20160302112410.GN18327@sirena.org.uk>
	<CAGo_u6ofNVVDDGm3_M2G3A6hbzf1hQuXqHm8DyyqzTuk5OKsdQ@mail.gmail.com>
	<20160302153021.GR18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f196.google.com ([209.85.214.196]:36319 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbcCBPnL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 10:43:11 -0500
Received: by mail-ob0-f196.google.com with SMTP id u2so15157320obz.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 07:43:11 -0800 (PST)
In-Reply-To: <20160302153021.GR18327@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <rob.herring@linaro.org>

On Wed, Mar 2, 2016 at 9:30 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Mar 02, 2016 at 09:26:03AM -0600, Nishanth Menon wrote:
>
>> We do have a real need to control multiple regulators around an OPP
>> change. this logic is valid for more than CPU device -> it is valid
>> for devices like DSP, GPU etc in the SoC as well across multiple
>> families in the OMAP generation SoCs. The logic by itself it not too
>> complicated. a voltage plane for a device has two regulators that need
>> to be controlled in tandem for a given target frequency. by allowing
>> dev_pm_opp_set_rate to control "n" regulators it actually does
>> simplify the problem down for a generic solution -> DVFS for devices
>> triggered from cpufreq or via devfreq.
>
> That's n regulators that need to be changed in arbitrary orders
> (together with some other number of clocks).

I agree, the "n" regulators that control supplies to a device cannot
obviously be transitioned in random order and ofcourse we want to
describe what supplies are present in the hardware in dts, not how the
supplies need to be transitioned. There will be a sequencing required
based on platfiorm for these n regulators (and or optimization of
voltages) - similar to requirement for voltage Vs frequency scale
needs.

One alternative I can think of is to reintroduce voltage domain driver
back in (we will get rid of the clock notifier tieups etc).. this
voltage domain mechanism will handle all the required sequencing based
on platform and any optimizations or quirks needed, then,
_set_opp_voltage would see if a voltagedomain is present, if yes, it
will invoke that instead of a single regulator. obviously two things
take place with this approach:
a) dev_pm_opp_set_rate still remain the single entry point for all OPP
transition (I think this is a good idea)
b) a level of abstraction introduced by complex drivers via the
voltage domain framework ( the original proposed framework had ability
already to handle 1-n regulators based on platform voltage domain
drivers).

What other alternatives can folks suggest we go towards?

---
Regards,
Nishanth Menon
