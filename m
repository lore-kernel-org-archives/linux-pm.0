From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 0/2] Skylake PSys support
Date: Wed, 20 Apr 2016 22:21:14 +0200
Message-ID: <CAJZ5v0gtJxLxJpmBqT-ymFV-VtimG1R5ngaiO=+iPnA=7Xhkuw@mail.gmail.com>
References: <1460930581-29748-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<20160420135945.GY3448@twins.programming.kicks-ass.net>
	<1461176931.8946.150.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:35750 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbcDTUVR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 16:21:17 -0400
In-Reply-To: <1461176931.8946.150.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, the arch/x86 maintainers <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Apr 20, 2016 at 8:28 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Wed, 2016-04-20 at 15:59 +0200, Peter Zijlstra wrote:
>> On Sun, Apr 17, 2016 at 03:02:59PM -0700, Srinivas Pandruvada wrote:
>> >
>> > Skylake processor supports a new set of RAPL registers for
>> > controlling
>> > entire SoC instead of just CPU package called PSys. This change
>> > adds
>> > support in two sub systems:
>> >
>> > x86/perf: Adds basic support for Skylake RAPL and PSys support
>> >
>> > powercap/rapl: A new platform domain to the current power capping
>> > Intel
>> > RAPL driver.
>> >
>> > Srinivas Pandruvada (2):
>> >   perf/x86/intel/rapl: support Skylake RAPL domains
>> >   powercap: intel_rapl: PSys support
>> >
>> >  arch/x86/events/intel/rapl.c     | 51 +++++++++++++++++++++++++++-
>> > -
>> >  arch/x86/include/asm/msr-index.h |  2 ++
>> >  drivers/powercap/intel_rapl.c    | 69
>> > ++++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 120 insertions(+), 2 deletions(-)
>> These two patches depend on one another, right?
> Yes.
>> Because the first patch
>> adds the MSR the second patch uses?
>>
>> How should we go about merging this? The perf-rapl stuff normally
>> goes
>> through tip while the powercap stuff goes through Rafael's tree.
> Do you want me to only send PERF patch and wait for this to be merged
> before sending powercap?

You can send both and they both can go in via tip as far as I'm concerned.
