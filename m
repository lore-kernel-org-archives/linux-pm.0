From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: try to resume policies which failed on last resume
Date: Mon, 6 Jan 2014 11:57:19 +0530
Message-ID: <CAKohpo=3s6=gw8OJTrUdLH8o2ouA=8a8MhrgNRXwHmOf0si5Pw@mail.gmail.com>
References: <f9d7b0d5424e4443597d2ed39bec3fedd2b10d1e.1387848958.git.viresh.kumar@linaro.org>
	<5562479.pVWRuDL0y6@vostro.rjw.lan>
	<87zjne7f75.fsf@nemi.mork.no>
	<2302938.b8tymqrMEz@vostro.rjw.lan>
	<878uuxquxu.fsf@nemi.mork.no>
	<871u0po0gx.fsf@nemi.mork.no>
	<CAKohpo=9p8ArfWyyWkdQm_BWtyWbWe_dsg6VAUP60VUFcAjFSw@mail.gmail.com>
	<87wqihmg9a.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <87wqihmg9a.fsf@nemi.mork.no>
Sender: cpufreq-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 3 January 2014 17:25, Bj=F8rn Mork <bjorn@mork.no> wrote:
> Correct. And users not running a lock debugging kernel will of course
> not even see the warning.

Okay..

>> - It only happens when cpufreq_add_dev() fails during hibernation wh=
ile
>> we enable non-boot CPUs again to save image to disk. So, isn't a pro=
blem
>> for a system which doesn't have any issues with add_dev() failing on
>> hibernation
>
> Wrong.  This was my initial assumption but I later found out that the
> issue is unrelated to hibernation failures.  Sorry about the confusio=
n.

Hmm.. Can we have the latest warning logs you have? Earlier ones were
related to hibernation..

>> - There is a contention of locks in the order they are taken. And th=
e contention
>> looks to be between, hotplug lock taken by cpu_online_cpus() and s_a=
ctive
>> lock for sysfs files. Don't know what's the role of previous write t=
o
>> sysfs files.
>> As that should finish before hibernation starts and so all locks sho=
uld be back
>> in place.
>
> Yes, that seems logical.  But I guess this is where it fails?

It looked like that.. Though your new logs might indicate something els=
e.
