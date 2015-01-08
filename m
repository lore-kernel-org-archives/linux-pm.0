From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] drivers: cpuidle: don't initialize big.LITTLE driver if MCPM is unavailable
Date: Thu, 08 Jan 2015 12:27:36 -0800
Message-ID: <7hh9w1vwzr.fsf@deeprootsystems.com>
References: <1420698544-10277-1-git-send-email-sudeep.holla@arm.com>
	<54AE459B.8010703@linaro.org> <54AE4ADF.3030307@arm.com>
	<54AE55CE.6040201@linaro.org> <54AE5C8F.9080600@arm.com>
	<54AE65EC.3050808@linaro.org> <20150108122958.GB32308@red-moon>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:48404 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbbAHU1k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jan 2015 15:27:40 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so13815055pad.9
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2015 12:27:39 -0800 (PST)
In-Reply-To: <20150108122958.GB32308@red-moon> (Lorenzo Pieralisi's message of
	"Thu, 8 Jan 2015 12:29:58 +0000")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <kevin.hilman@linaro.org>, "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On Thu, Jan 08, 2015 at 11:11:40AM +0000, Daniel Lezcano wrote:
>
> [...]
>
>> >> IMO, it would be better to be more strict with the mcpm
>> >> initialization and not let the system boot if something is wrong with
>> >> it which I believe is coming from the firmware and let the user to
>> >> figure out what is really happening by letting him to disable mcpm in
>> >> the kernel configuration (which in turn will disable cpuidle).
>> >
>> > Again I fully agree, but in this case I manually switched to legacy boot
>> > mode on TC2 and used same kernel with MCPM config enabled. Do you mean
>> > to say we should not support that even when developer understand the
>> > consequence of that ?
>> 
>> Well, I see there are the exynos5410/5420/5422. For the 5422 on 
>> chromebook2 MCPM works well, IIUC. But for the 5422 on odroid-xu3, MCPM 
>> does not work, hence cpuidle neither because of the firmware.
>> 
>> Silently disabling cpuidle because mcpm did not initialize will hide the 
>> issue.
>
> No. MCPM *will* initialize, Sudeep's patch does not silently disable
> CPUidle.
> To put it differently MCPM will initialize if CCI is in the DT and it
> is "available", so unless defined differently in the dts mcpm will be
> available and CPUidle will be initialized (and break if there is an issue
> with the platform FW/HW).
>
> I agree the mechanism to define if MCPM is available can be improved
> but that's what it is at the moment.
>
> The problem here is to boot a platform with different boot methods
> and still have a single kernel image.
>
>> I understand your point about switching to legacy without recompiling 
>> the kernel.
>> 
>> I suggest we add a big fat WARN_ON when the mcpm initialization fails 
>> with your patch.
>
> I think there are multiple facets we are tackling at once here and they
> should not be mixed.
>
> 1) We left static idle states there to cope with legacy DTBs that were
>    published before we introduced idle states bindings. If we want to
>    boot eg vexpress in legacy mode but single kernel image with MCPM on,
>    we could remove the idle states in DT and the problem would be
>    solved; we can't do that since we were forced to leave the static
>    idle tables. Overall I think this is not the way to fix the issue.
> 2) The idle driver should be initialized if there is an idle state entry
>    method, which in this case is MCPM. If I boot vexpress with MCPM
>    enabled but legacy boot method (ie spin table) with a single kernel image
>    I do not want to warn if the idle states entry method (MCPM) can't be
>    initialized (and I do not want to get a warning if the idle driver is
>    triggering a mcpm_cpu_suspend), so Sudeep's patch is valid and I am
>    against adding a:
>
>    if (WARN_ON(!mcpm_is_available())
>
> 3) Sudeep's patch is not hiding anything. If CCI is in DT, CCI is
>    probed so mcpm_is_available() == true. If the firmware is borked
>    the idle states will be entered and we will notice there is something
>    wrong
>
> So overall I think Sudeep's patch is sound. I also think we should
> improve the way we detect if MCPM is available, and again, I think the
> CPU operations on arm64 are a good example that we can and we should
> replicate.

This patch disables CPUidle all together, but shouldn't it just disable
the states that rely on MCPM?  IOW, C1 should still work just fine since
it doesn't use MCPM, right?  So, rather than fail the init, it should
just drop any MCPM states (e.g. set ->state_count = 1)

Kevin



