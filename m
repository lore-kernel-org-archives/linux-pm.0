From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4
Date: Sat, 20 Feb 2016 08:31:18 -0800
Message-ID: <000401d16bfc$21338450$639a8cf0$@net>
References: <87egc7ahqn.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta6.telus.net ([209.171.16.79]:50440 "EHLO cmta6.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757548AbcBTQbW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 20 Feb 2016 11:31:22 -0500
In-Reply-To: <87egc7ahqn.fsf@iki.fi>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Arto Jantunen' <viiru@iki.fi>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

On 2106.02.20 00:50 Arto Jantunen wrote:

> When using kernel 4.5-rc4 my Skylake machine runs very warm since all
> cpu cores are always kept at 3.10Ghz (with maximum without turboboost
> being 2.6Ghz), completely regardless of load. Swapping between the
> governors (performance and powersave) doesn't change the result in any
> way, frequency remains at a constant 3.10Ghz.
>
> The machine is using the intel_pstate driver, I don't know if it's
> possible to choose to use the acpi driver instead (without recompiling
> the kernel so that intel_pstate is not supported).

If you use grub then you can disable the intel_pstate driver by modifying
the grub command line. Here is an example, where I have left other stuff
that I use:

GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 intel_pstate=disable net.ifnames=1 biosdevname=0"

Here is an example, with the intel_pstate directive by itself:

GRUB_CMDLINE_LINUX_DEFAULT="intel_pstate=disable"

If the intel_pstate driver is disabled, then the acpi-cpufreq CPU
frequency scaling driver will be used. 
Remember to update grub after the above edit.

If you do not use grub, then I don't know.

Please, and as a test, also try this and report back:

GRUB_CMDLINE_LINUX_DEFAULT="intel_pstate=no_hwp"

> I can force the frequency down manually with cpufreq-set, so the problem
> doesn't seem to be with the actual frequency changing.

> Cpuinfo (taken from 4.4 which doesn't have the problem):

Is kernel 4.5-rc4 the first one you have tried in the 4.5 series?
What I am asking is if you know if the issue was introduced between
kernels 4.4 and 4.5-rc1 (most likely) or between 4.5-rc3 and 4.5-rc4 or?

What distribution, if any, of Linux do you use?

It might make sense to take this off-list and into a bugzilla bug report.

... Doug


