From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4] intel_pstate: Use avg_pstate instead of current_pstate
Date: Fri, 22 Apr 2016 03:01:13 +0200
Message-ID: <CAJZ5v0hMTanSQQ9VX2YbTgRvtUkkTDJAJSYcHGxAdtm=xEHE6g@mail.gmail.com>
References: <1459754617-8872-1-git-send-email-philippe.longepe@linux.intel.com>
	<1662176.YWLDtbbot1@vostro.rjw.lan>
	<1461286745.8946.203.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34352 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbcDVBBP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 21:01:15 -0400
Received: by mail-lb0-f195.google.com with SMTP id w1so3886901lbl.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2016 18:01:14 -0700 (PDT)
In-Reply-To: <1461286745.8946.203.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Philippe Longepe <philippe.longepe@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>

On Fri, Apr 22, 2016 at 2:59 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Fri, 2016-04-22 at 02:48 +0200, Rafael J. Wysocki wrote:
>> On Monday, April 04, 2016 09:23:36 AM Philippe Longepe wrote:
>> >
>> > The result returned by pid_calc() is subtracted from current_pstat=
e
>> > (which is the pstate requested during the last period) in order to
>> > obtain the target pstate for the current iteration.
>> > However, current_pstate may not reflect the real current P-state o=
f
>> > the CPU.  In particular, that P-state may be higher because of the
>> > frequency sharing per module.
>> >
>> > The theory is:
>> >
>> > - The load is the percentage of time spent in C0 and is related to
>> > the average frequency during the same period (We'll not have the
>> > same load at 1GHz or at 2GHz for the same task running).
>> >
>> > - The current frequency can be completely different than the
>> > average frequency (because of frequency sharing or throttling).
>> >
>> > =3D> The frequency shift computed by the pid_calc is based on the
>> > load, so it must be applied to the frequency with which the load
>> > was measured.
>> >
>> > Using the average pstate instead of current pstate solve some
>> > migration issues (e.g when a task migrates from one core to anothe=
r
>> > in the same package/module and all of the cores in there except fo=
r
>> > that particular one are basically idle).
>> >
>> > Performance and power comparison with this patch on Android:
>> >
>> > IPLoad+Avg-Pstate vs IP Load:
>> >
>> > Benchmark               =E2=88=86Perf    =E2=88=86Power
>> > FishTank                10.45%    3.1%
>> > SmartBench-Gaming       -0.1%   -10.4%
>> > SmartBench-Productivity -0.8%   -10.4%
>> > CandyCrush                n/a   -17.4%
>> > AngryBirds                n/a    -5.9%
>> > videoPlayback             n/a   -13.9%
>> > audioPlayback             n/a    -4.9%
>> > IcyRocks-20-50           0.0%   -38.4%
>> > iozone RR               -0.16%  -1.3%
>> > iozone RW                0.74%  -1.3%
>> >
>> > Comparison with the perf algorithm:
>> > (this patch in cpu_load vs Core algorithm)
>> >
>> > Benchmark               =E2=88=86Perf    =E2=88=86Power
>> > SmartBench-Gaming       -0.58%   -22.8%
>> > SmartBench-Productivity  0.82%
>> > CandyCrush                n/a    -20.8%
>> > AngryBirds                n/a    -37.0%
>> > videoPlayback             n/a    -53.4%
>> > audioPlayback             n/a     -2.1%
>> > iozone RR               -0.55%   -13.29%
>> > iozone RW                2.22%
>> >
>> > =3D> No regression > 1% observed and a huge power improvement!
>> >
>> > Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
>
>
>> Srinivas, what about this one?  Yes?  No?  Maybe?
>>
> I am fine with this change.
> I would like to edit the commit and remove the bottom table compare
> with core and statement with exclamation as this not relevant here fo=
r
> the affected platforms.
>
> Do you want me to send update?

Yes, please.
