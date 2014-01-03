From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH 1/2] cpufreq: try to resume policies which failed on last resume
Date: Fri, 03 Jan 2014 10:53:34 +0100
Message-ID: <871u0po0gx.fsf@nemi.mork.no>
References: <f9d7b0d5424e4443597d2ed39bec3fedd2b10d1e.1387848958.git.viresh.kumar@linaro.org>
	<5562479.pVWRuDL0y6@vostro.rjw.lan> <87zjne7f75.fsf@nemi.mork.no>
	<2302938.b8tymqrMEz@vostro.rjw.lan> <878uuxquxu.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <878uuxquxu.fsf@nemi.mork.no> (=?utf-8?Q?=22Bj=C3=B8rn?=
 Mork"'s message of "Fri, 03
	Jan 2014 10:24:45 +0100")
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: cpufreq@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Bj=C3=B8rn Mork <bjorn@mork.no> writes:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
>
>> OK, thanks!  Well, this is somewhat worrisome.
>>
>> Could you also check the linux-pm.git/fixes branch that contains all=
 patches
>> I'm planning to push for 3.13-rc7 shortly?
>
> It's definitely still there.  But I'm less sure about the exact trigg=
er.

I did a couple of more tests after clean reboots, and 100% sure ways to
trigger the circular locking on my laptop are

  echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
  s2disk

or

  echo 1401000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq=20
  s2disk

or

  echo 1401000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq=20
  s2disk


Note that "ondemand" and "1401000" are the default vaules, so I don't
actually change anything here.  The write is causing the problem, not
the value.  As expected, I guess.

Also note that boot vs non-boot cpu doesn't seem to matter.  Nor does
cancelling the hibernation.  The warning appears on hibernate - not on
resume.

Hope this helps.


Bj=C3=B8rn
