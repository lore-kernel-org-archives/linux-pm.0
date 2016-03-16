From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Do not schedule policy update work in cpufreq_resume()
Date: Wed, 16 Mar 2016 14:12:39 +0100
Message-ID: <CAJZ5v0gdnaw_BwW6ugT102YA+-Pb8O578Anf1b2vetEXsvCgzw@mail.gmail.com>
References: <5379622.iJjZa2C2Nq@vostro.rjw.lan>
	<20160315061059.GB13831@vireshk-mac-ubuntu>
	<CAJZ5v0iW7mkKTdgLm953nPAWVu4Cbx_P-E9bDg9WXwQtjDwb5A@mail.gmail.com>
	<20160316044757.GB16250@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:32891 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965945AbcCPNMm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 09:12:42 -0400
In-Reply-To: <20160316044757.GB16250@vireshk-mac-ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Wed, Mar 16, 2016 at 5:47 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 15-03-16, 13:11, Rafael J. Wysocki wrote:
>> On Tue, Mar 15, 2016 at 7:10 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 12-03-16, 03:05, Rafael J. Wysocki wrote:
>> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >>
>> >> cpufreq_resume() attempts to resync the current frequency with
>> >> policy->cur for the first online CPU, but first it does that after
>> >> restarting governors for all active policies (which means that this
>> >> is racy with respect to whatever the governors do) and second it
>> >
>> > Why? Its doing the update withing policy->rwsem ..
>>
>> Which doesn't matter.
>>
>> dbs_work_handler() doesn't acquire policy->rwsem and may be executed
>> in parallel with this, for example.
>
> Right, so we need to fixup something here.
>
>> >> already is too late for that when cpufreq_resume() is called (that
>> >> happens after invoking ->resume callbacks for all devices in the
>> >> system).
>> >>
>> >> Also it doesn't make sense to do that for one CPU only in any case,
>> >> because the other CPUs in the system need not share the policy with
>> >> it and their policy->cur may be out of sync as well in principle.
>> >
>> > Its done just for the boot CPU, because that's the only CPU that goes to
>> > suspend. All other CPUs are disabled/enabled and so the policies are
>> > reinitialized for policy->cur as well.
>> >
>> > I think, its still important to get things in sync, as some bootloader may
>> > change the frequency to something else during resume.
>> >
>> > And our code may not be safe for the case, the current frequency of the CPU
>> > isn't part of the freq-table of the policy.
>>
>> Since we're already started the governor at this point (or called the
>> driver's ->resume), so the CPU is (or shortly will be) running at a
>> frequency that makes sense at this point.
>>
>> It might be running at a wrong one before, but not when this code is executed.
>
> Not necessarily.
>
> Consider Performance governor for example. Lets say policy->max is 1 GHz, so
> before suspend policy->cur will be 1 GHz. We suspended and resumed, and the
> bootloader changed the frequency to 500 MHz (but policy->cur remains the same at
> 1 GHz). Even after calling START for the governor, it will continue to run at
> 500 MHz.

No, it won't.  This might be applicable to other governors, but not to
"performance" (look at what it does on _START instead of just
guessing).

> So, your patch break things for sure.

I'm not actually sure it breaks anything.

Theoretically, it may, but practically?  Is there any system out there
where it makes any difference?
