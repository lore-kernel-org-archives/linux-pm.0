From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Wed, 2 Mar 2016 09:26:03 -0600
Message-ID: <CAGo_u6ofNVVDDGm3_M2G3A6hbzf1hQuXqHm8DyyqzTuk5OKsdQ@mail.gmail.com>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
	<2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
	<55F72C97.2030306@kernel.org>
	<CAKohpo=fcab=eisbwMw=wvbmuXVY5iw_CSe3QK1Ax_i-56JAzA@mail.gmail.com>
	<20160302025016.GS18327@sirena.org.uk>
	<20160302102831.GE2891@vireshk-i7>
	<20160302112410.GN18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:34750 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbcCBP0E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 10:26:04 -0500
Received: by mail-ob0-f194.google.com with SMTP id wz1so15104322obc.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 07:26:04 -0800 (PST)
In-Reply-To: <20160302112410.GN18327@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <rob.herring@linaro.org>

On Wed, Mar 2, 2016 at 5:24 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Mar 02, 2016 at 03:58:31PM +0530, Viresh Kumar wrote:
>> On 02-03-16, 11:50, Mark Brown wrote:
>
>> > I'm really not sure what I can say here that I've not already said
>> > repeatedly, what's new here?
>
>> Yeah, you have raised some genuine concerns earlier, like the sequence
>> in which the voltages of multiple supplies should be changed, and if
>> we should rely on some DT sequence for that.
>
>> I started it again, because we have a real case now (not like the
>> virtual case earlier) where a platform has multiple supplies for a
>> device (CPU). I just wanted to hear from all of you on how should we
>> go ahead and solve it.
>
>> TI guys had some crazy ideas, like using OPP-notifiers to update the
>> second regulator, etc and I really hated it :)

Ummm... We prefer not to do this via notifier solution.. yeah doing
that around notifiers is indeed a crazier alternative

>
> My main thought with this stuff is that if it's really complicated to
> write generic code that might be a sign that it's sensible to write a
> custom driver.  We can always writee something later if we figure out
> some general patterns.

We did propose to go via voltage domain[1] to actually do an OPP
transition and provide hooks that can implement required regulator set
for the SoC. After seeing dev_pm_opp_set_rate is available, it does
not make sense to go down the voltagedomain path anymore.

We do have a real need to control multiple regulators around an OPP
change. this logic is valid for more than CPU device -> it is valid
for devices like DSP, GPU etc in the SoC as well across multiple
families in the OMAP generation SoCs. The logic by itself it not too
complicated. a voltage plane for a device has two regulators that need
to be controlled in tandem for a given target frequency. by allowing
dev_pm_opp_set_rate to control "n" regulators it actually does
simplify the problem down for a generic solution -> DVFS for devices
triggered from cpufreq or via devfreq.


[1] http://marc.info/?l=linux-omap&m=139275579731801&w=2


---
Regards,
Nishanth Menon
