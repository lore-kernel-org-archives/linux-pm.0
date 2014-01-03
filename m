From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH 1/2] cpufreq: try to resume policies which failed on last resume
Date: Fri, 03 Jan 2014 12:55:29 +0100
Message-ID: <87wqihmg9a.fsf@nemi.mork.no>
References: <f9d7b0d5424e4443597d2ed39bec3fedd2b10d1e.1387848958.git.viresh.kumar@linaro.org>
	<5562479.pVWRuDL0y6@vostro.rjw.lan> <87zjne7f75.fsf@nemi.mork.no>
	<2302938.b8tymqrMEz@vostro.rjw.lan> <878uuxquxu.fsf@nemi.mork.no>
	<871u0po0gx.fsf@nemi.mork.no>
	<CAKohpo=9p8ArfWyyWkdQm_BWtyWbWe_dsg6VAUP60VUFcAjFSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=9p8ArfWyyWkdQm_BWtyWbWe_dsg6VAUP60VUFcAjFSw@mail.gmail.com>
	(Viresh Kumar's message of "Fri, 3 Jan 2014 16:49:17 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 3 January 2014 15:23, Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>> Note that "ondemand" and "1401000" are the default vaules, so I don'=
t
>> actually change anything here.  The write is causing the problem, no=
t
>> the value.  As expected, I guess.
>>
>> Also note that boot vs non-boot cpu doesn't seem to matter.  Nor doe=
s
>> cancelling the hibernation.  The warning appears on hibernate - not =
on
>> resume.
>
> Hmm... I spent quite some time understanding whats going on and reall=
y
> couldn't get across anything as of now. I haven't tried reproducing i=
t though.
>
> Few things that I can make out of this mail chain so far:
> - Apart from the log, everything is working fine. i.e. system is back=
 in
> working condition.

Correct. And users not running a lock debugging kernel will of course
not even see the warning.

> - It only happens when cpufreq_add_dev() fails during hibernation whi=
le
> we enable non-boot CPUs again to save image to disk. So, isn't a prob=
lem
> for a system which doesn't have any issues with add_dev() failing on
> hibernation

Wrong.  This was my initial assumption but I later found out that the
issue is unrelated to hibernation failures.  Sorry about the confusion.

> - There is a contention of locks in the order they are taken. And the=
 contention
> looks to be between, hotplug lock taken by cpu_online_cpus() and s_ac=
tive
> lock for sysfs files. Don't know what's the role of previous write to
> sysfs files.
> As that should finish before hibernation starts and so all locks shou=
ld be back
> in place.

Yes, that seems logical.  But I guess this is where it fails?



Bj=C3=B8rn
