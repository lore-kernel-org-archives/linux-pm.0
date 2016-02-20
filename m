From: Arto Jantunen <viiru@iki.fi>
Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Sat, 20 Feb 2016 19:10:53 +0200
Message-ID: <87a8mv9ujm.fsf@iki.fi>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from viiru.iki.fi ([185.19.28.114]:39342 "EHLO viiru.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757858AbcBTRK5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 20 Feb 2016 12:10:57 -0500
In-Reply-To: <000401d16bfc$21338450$639a8cf0$@net> (Doug Smythies's message of
	"Sat, 20 Feb 2016 08:31:18 -0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

"Doug Smythies" <dsmythies@telus.net> writes:

> On 2106.02.20 00:50 Arto Jantunen wrote:
>> The machine is using the intel_pstate driver, I don't know if it's
>> possible to choose to use the acpi driver instead (without recompiling
>> the kernel so that intel_pstate is not supported).
>
> Here is an example, with the intel_pstate directive by itself:
>
> GRUB_CMDLINE_LINUX_DEFAULT="intel_pstate=disable"
>
> If the intel_pstate driver is disabled, then the acpi-cpufreq CPU
> frequency scaling driver will be used. 
> Remember to update grub after the above edit.
>
> If you do not use grub, then I don't know.
>
> Please, and as a test, also try this and report back:
>
> GRUB_CMDLINE_LINUX_DEFAULT="intel_pstate=no_hwp"

Thanks, I'll test this.

>> I can force the frequency down manually with cpufreq-set, so the problem
>> doesn't seem to be with the actual frequency changing.
>
>> Cpuinfo (taken from 4.4 which doesn't have the problem):
>
> Is kernel 4.5-rc4 the first one you have tried in the 4.5 series?
> What I am asking is if you know if the issue was introduced between
> kernels 4.4 and 4.5-rc1 (most likely) or between 4.5-rc3 and 4.5-rc4 or?

4.5-rc4 is the first one I have tested, I assume that the problem has
been introduced between 4.4 and 4.5-rc1.

> What distribution, if any, of Linux do you use?

The system is running Debian Unstable, but the kernel is built from
upstream git (no Debian patches).

-- 
Arto Jantunen
