From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Do not modify MSR_IA32_ENERGY_PERF_BIAS in kernel
Date: Tue, 08 Mar 2016 13:14:16 +0100
Message-ID: <1500934.JjcSpplzao@skinner>
References: <4687430.mfM0GbdeDL@skinner> <CAJZ5v0ie-itnxERzA3nhd0VnQUo07MsoyS3+WL+3sm5V+sMTJg@mail.gmail.com> <CAJvTdKnJSqCxVhriMUJfeRL=ogpG2GYgSJ5anvbjrbm_rNyKcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34577 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932068AbcCHMOY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Mar 2016 07:14:24 -0500
In-Reply-To: <CAJvTdKnJSqCxVhriMUJfeRL=ogpG2GYgSJ5anvbjrbm_rNyKcQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Monday, March 07, 2016 07:50:57 PM Len Brown wrote:
> > But with Broadwell-EP processor (E5-2687W v4) the CPU will not enter turbo
> > modes if this value is not set to performance
> 
> BDX-EP supports HWP.
> Are these failing machines running in HWP mode?
> 
> (On BDX-EP, and only on BDX-EP, EPB acts to set the BIAS for HWP,
>  because that processor doesn't yet have EPP.)

I am not sure whether I can publish platform info. I asked for and added you
to CC of the private bug a while ago.

This kernel is run: SLES12 SP1, 3.12.49-4-default
I grepped the whole supportconfig for -i hwp and couldn't find anything, so I 
very much expect this machine is/was not run in HWP mode, right?

I still question the usefulness of the "initialize perf bias to normal" hack.
For our distro I am pretty sure, we do not want to have this one and
we prefer the CPU or BIOS initialized value, even (or especially) if it is
set to performance.

Are there any known platforms where this would really be an issue
and how sever would it be?

I already removed the "set perf bias to normal" years ago for SLE11 without
getting any regression or negative reports.

Now finding the workaround on the hack to run a suspend hook to
adjust perf bias value on each suspend cycle... This is going into
a wrong direction.

I agree that if this needs resetting after each suspend cycle, userspace 
should not need to care about it. I could imagine a sysfs variable here:
/sys/devices/system/cpu/intel_pstate/perf_bias

but the static setting from 0 to 6 in the x86 core code and
the suspend callback should get reverted, right?

    Thomas
