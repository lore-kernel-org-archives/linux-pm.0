From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 0/5] intel_pstate: Use C0 time, calculate target pstate directly
Date: Mon, 13 Apr 2015 14:16:10 -0700
Message-ID: <001a01d0762f$117316c0$34594440$@net>
References: <1428811830-15006-1-git-send-email-dsmythies@telus.net> <20150413093214.63dc6184@kcaccard-desk.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta5.telus.net ([209.171.16.78]:53392 "EHLO cmta5.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020AbbDMVQP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Apr 2015 17:16:15 -0400
In-Reply-To: <20150413093214.63dc6184@kcaccard-desk.amr.corp.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Kristen Carlson Accardi' <kristen@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

Hi Kristen,

Thanks for your quick and positive reply.

On 2015.04.13 09:32 Kristen wrote:
> On Sat, 11 Apr 2015 21:10:25 -0700 Doug Smythies wrote:

> Thanks for your patches, I'll be doing some testing and review and let
> you know how things go.

And from the other thread:

> I'm going to need to do a lot of
> benchmarking on a variety of platforms to make sure we haven't regressed
> anything.

Yes, of course.

I make no claim to have found the best default operating parameters,
IIR gain, c0_floor, c0_ceiling, sample_rate_ms.

I only have a i7-2600K to test with.

Other results:

Phoronix: Kernel compile:
acpi-cpufreq: 122.4 seconds
4.0RC7, unpatched: 121.8 seconds
Patched: 122.4 seconds

Phoronix: Apache:
acpi-cpufreq: 19429
4.0RC7, unpatched: 20089
Patched: 20410

Phoronix: ffmpeg:
acpi-cpufreq: 17.06 seconds and 1444.36 Joules Package Energy.
4.0RC7, unpatched: 17.65 seconds and 1444.36 Joules
Patched: 23.1 seconds and 1302 Joules

Note: Dirk proved that the ffmpeg test does odd switching of CPUs
when they become 50% loaded. With the settings I have used for c0_floor
and c0_ceiling, these results are not a surprise. 
 
2000 Seconds idle (server): 
Unpatched: 7704 Joules
Patched: 7625 Joules.

An i5-4690K running some Ubuntu desktop, but otherwise idle:
Average CPU frequency goes way down and power consumption drops by just over half a watt.

An i7-4790K running xorg and Arch distro, but otherwise idle:
Average CPU frequency drops considerably, and power consumption is about the same.
Note: unpatched CPU frequencies were not as high as previously reported on that bugzilla report.
I do not know why.
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=93521

Still waiting to hear from the other i7-4790K user that had high CPU frequency when idle issues.

There is a bit of evidence that the unpatched reference kernel might do a little
better at holding CPU frequencies lower in the low load 20 Hz work / sleep frequency range.
I'm still looking at that scenario.

There are many graphs at:
Double u double u double u dot smythies dot com /~doug/linux/intel_pstate/build220/index.html

... Doug


