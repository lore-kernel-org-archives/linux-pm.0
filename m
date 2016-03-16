From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Do not schedule policy update work in cpufreq_resume()
Date: Wed, 16 Mar 2016 01:51:18 +0100
Message-ID: <CAJZ5v0j3T37SooAmm+3qRb53HXXXomFz-h+BN0pG0zfpENk_cA@mail.gmail.com>
References: <5379622.iJjZa2C2Nq@vostro.rjw.lan>
	<20160315061059.GB13831@vireshk-mac-ubuntu>
	<CAJZ5v0iW7mkKTdgLm953nPAWVu4Cbx_P-E9bDg9WXwQtjDwb5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35557 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbcCPAvU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 20:51:20 -0400
In-Reply-To: <CAJZ5v0iW7mkKTdgLm953nPAWVu4Cbx_P-E9bDg9WXwQtjDwb5A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Tue, Mar 15, 2016 at 1:11 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Mar 15, 2016 at 7:10 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 12-03-16, 03:05, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> cpufreq_resume() attempts to resync the current frequency with
>>> policy->cur for the first online CPU, but first it does that after
>>> restarting governors for all active policies (which means that this
>>> is racy with respect to whatever the governors do) and second it
>>
>> Why? Its doing the update withing policy->rwsem ..
>
> Which doesn't matter.
>
> dbs_work_handler() doesn't acquire policy->rwsem and may be executed
> in parallel with this, for example.
>
>>> already is too late for that when cpufreq_resume() is called (that
>>> happens after invoking ->resume callbacks for all devices in the
>>> system).
>>>
>>> Also it doesn't make sense to do that for one CPU only in any case,
>>> because the other CPUs in the system need not share the policy with
>>> it and their policy->cur may be out of sync as well in principle.
>>
>> Its done just for the boot CPU, because that's the only CPU that goes to
>> suspend. All other CPUs are disabled/enabled and so the policies are
>> reinitialized for policy->cur as well.
>>
>> I think, its still important to get things in sync, as some bootloader may
>> change the frequency to something else during resume.
>>
>> And our code may not be safe for the case, the current frequency of the CPU
>> isn't part of the freq-table of the policy.
>
> Since we're already started the governor at this point (or called the
> driver's ->resume), so the CPU is (or shortly will be) running at a
> frequency that makes sense at this point.
>
> It might be running at a wrong one before, but not when this code is executed.
>
> I kind of understand the motivation for this code, but it's too late
> to fix up the frequency of the boot CPU at this point.  If you are
> really worried about it, the time to do that is in syscore ops.

OK, so the problem with doing that in syscore ops is that the I2C bus
needed for it may not be available at that point, which is fair
enough.

Still, though, the way it is done now is really awful and has to go.

I guess something along the lines of cpufreq_update_policy() might be
done in cpufreq_resume() before governors are started, but it might
even be better to set policy->cur from scratch when starting the
governors.  Just do driver->get() and set policy->cur to what that
returns (or just use the average of min and max if ->get is not
available).  And that unconditionally, regardless of the reason why
the governors are started.

Thanks,
Rafael
