From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Do not modify MSR_IA32_ENERGY_PERF_BIAS in kernel
Date: Tue, 8 Mar 2016 16:07:43 -0500
Message-ID: <CAJvTdKnO9DLVSwJMYq+zEvYyP5RgiqudCg+0W9cNeb9ZAWZYng@mail.gmail.com>
References: <4687430.mfM0GbdeDL@skinner>
	<CAJZ5v0ie-itnxERzA3nhd0VnQUo07MsoyS3+WL+3sm5V+sMTJg@mail.gmail.com>
	<CAJvTdKnJSqCxVhriMUJfeRL=ogpG2GYgSJ5anvbjrbm_rNyKcQ@mail.gmail.com>
	<1500934.JjcSpplzao@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35818 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcCHVHp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 16:07:45 -0500
In-Reply-To: <1500934.JjcSpplzao@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Mar 8, 2016 at 7:14 AM, Thomas Renninger <trenn@suse.de> wrote:
> On Monday, March 07, 2016 07:50:57 PM Len Brown wrote:
>> > But with Broadwell-EP processor (E5-2687W v4) the CPU will not enter turbo
>> > modes if this value is not set to performance
>>
>> BDX-EP supports HWP.
>> Are these failing machines running in HWP mode?
>>
>> (On BDX-EP, and only on BDX-EP, EPB acts to set the BIAS for HWP,
>>  because that processor doesn't yet have EPP.)
>
> I am not sure whether I can publish platform info. I asked for and added you
> to CC of the private bug a while ago.
>
> This kernel is run: SLES12 SP1, 3.12.49-4-default
> I grepped the whole supportconfig for -i hwp and couldn't find anything, so I
> very much expect this machine is/was not run in HWP mode, right?

/proc/cpuinfo will have a bunch of hwp stuff if CPUID is advertising
the feature.

The BIOS could put it in HWP mode by default,
or the intel_pstate driver could enable HWP.

If intel_pstate did that, it would print it in dmesg.

pr_info("intel_pstate: HWP enabled\n");

> I still question the usefulness of the "initialize perf bias to normal" hack.
> For our distro I am pretty sure, we do not want to have this one and
> we prefer the CPU or BIOS initialized value, even (or especially) if it is
> set to performance.
>
> Are there any known platforms where this would really be an issue
> and how sever would it be?
>
> I already removed the "set perf bias to normal" years ago for SLE11 without
> getting any regression or negative reports.
>
> Now finding the workaround on the hack to run a suspend hook to
> adjust perf bias value on each suspend cycle... This is going into
> a wrong direction.
>
> I agree that if this needs resetting after each suspend cycle, userspace
> should not need to care about it. I could imagine a sysfs variable here:
> /sys/devices/system/cpu/intel_pstate/perf_bias

As EPB it is unrelated to intel_pstate, this would be a bad place to
put such state.

> but the static setting from 0 to 6 in the x86 core code and
> the suspend callback should get reverted, right?

The kernel is supplying a reasonable default.
It is up to the operating system to apply -- from user space --
a value that is consistent with the performance profile
for how the machine is being used.

I proposed doing such policy in the kernel a number of years ago,
and a number of non-kernel people insisted strenuously that the
kernel should not know or care, and that user-space should manage this.
Perhaps we need to examine how well abdicating responsibility
to the upper OS has been going...

I'm not going to tell you that you can't make policy choices in distro-specific
kernel patches.  Maybe it is difficult for some distros to modify user-space.
But I am not going to recommend such changes go in the upstream kernel,
since it would impact other users.

thanks,
Len Brown, Intel Open Source Technology Center
