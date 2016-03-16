From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Do not schedule policy update work in cpufreq_resume()
Date: Wed, 16 Mar 2016 13:29:38 +0100
Message-ID: <CAJZ5v0jYdyDaPQ157iP5P3HRoufD=7TbcpBdEvRkFtA87A9y6w@mail.gmail.com>
References: <5379622.iJjZa2C2Nq@vostro.rjw.lan>
	<20160315061059.GB13831@vireshk-mac-ubuntu>
	<CAJZ5v0iW7mkKTdgLm953nPAWVu4Cbx_P-E9bDg9WXwQtjDwb5A@mail.gmail.com>
	<CAJZ5v0j3T37SooAmm+3qRb53HXXXomFz-h+BN0pG0zfpENk_cA@mail.gmail.com>
	<20160316045209.GC16250@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36301 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966175AbcCPM3l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 08:29:41 -0400
In-Reply-To: <20160316045209.GC16250@vireshk-mac-ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Wed, Mar 16, 2016 at 5:52 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 16-03-16, 01:51, Rafael J. Wysocki wrote:
>> OK, so the problem with doing that in syscore ops is that the I2C bus
>> needed for it may not be available at that point, which is fair
>> enough.
>
> Not just that. We wouldn't call syscore-ops for the boot-cpu. It never went
> away.

Yes, we would.

We actually call syscore ops *only* on that CPU.

>> Still, though, the way it is done now is really awful and has to go.
>>
>> I guess something along the lines of cpufreq_update_policy() might be
>> done in cpufreq_resume() before governors are started, but it might
>> even be better to set policy->cur from scratch when starting the
>> governors.  Just do driver->get() and set policy->cur to what that
>> returns (or just use the average of min and max if ->get is not
>> available).  And that unconditionally, regardless of the reason why
>> the governors are started.
>
> I think doing it from a somewhat centric location would make more sense then
> pushing this for the governors.

I'm not talking about doing that in governors, but in
cpufreq_governor() when the event is _START.

> Maybe the beginning of cpufreq_resume() is good enough for that.

Is that really the only case, though?
