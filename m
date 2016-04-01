From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Fri, 1 Apr 2016 02:08:31 +0200
Message-ID: <CAJZ5v0gf_ychFverA8NgcMSsE2rrzvGAMsfTfTUEfhukXWa8JA@mail.gmail.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	<8393335.Q1cjiaGecN@vostro.rjw.lan>
	<CADDKRnBE==ea7YvXH+YL_m1v8E1zNHsZnXJgc58OQ=vrcs+cKQ@mail.gmail.com>
	<2727017.UmaUvtBLeX@vostro.rjw.lan>
	<CADDKRnAYPXip0EG0Y7ADuyt9L=FL-Nd1giHBVvPexs4kGkRj4g@mail.gmail.com>
	<1459446905.4569.76.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35915 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757459AbcDAAId convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 20:08:33 -0400
In-Reply-To: <1459446905.4569.76.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

On Thu, Mar 31, 2016 at 7:55 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Thu, 2016-03-31 at 19:27 +0200, J=C3=B6rg Otte wrote:
>> 2016-03-31 17:43 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> > On Thursday, March 31, 2016 05:25:18 PM J=C3=B6rg Otte wrote:
>> > > 2016-03-31 13:42 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>=
:
>> > > > On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wrote:
>> > > >

[cut]

>>
>> OK, patch is applied.
>> After some configurations and compilations I'm there.
>> Under pstate_sample I see:
>> enable  filter  format  id  trigger
>>
>> what to do now ? (never did tracing before)'
>
> # cd /sys/kernel/debug/tracing/
> # echo 1 > events/power/pstate_sample/enable
> # echo 1 > events/power/cpu_frequency/enable
> # cat trace
> Send us the trace file.

Here's what I do, for completeness:

# echo 0 > /sys/kernel/debug/tracing/tracing_on
# echo global > /sys/kernel/debug/tracing/trace_clock
# echo nop > /sys/kernel/debug/tracing/current_tracer
# echo 1000 > /sys/kernel/debug/tracing/buffer_size_kb
# echo 1 > /sys/kernel/debug/tracing/events/power/pstate_sample/enable
# echo "" > /sys/kernel/debug/tracing/trace
# echo 1 > /sys/kernel/debug/tracing/tracing_on

Then, (after a while) make a copy of the trace file.
