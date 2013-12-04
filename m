From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Wed, 04 Dec 2013 16:41:45 +0100
Message-ID: <87li00y66e.fsf@nemi.mork.no>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no>
	<529F04B2.7050303@linaro.org> <87fvq8lsxt.fsf@nemi.mork.no>
	<CAKohpomBeJSMc3=BSPbo97nkGbc5MRRvTtJn1z062FN01B51Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomBeJSMc3=BSPbo97nkGbc5MRRvTtJn1z062FN01B51Qw@mail.gmail.com>
	(Viresh Kumar's message of "Wed, 4 Dec 2013 20:11:01 +0530")
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:
> On 4 December 2013 17:38, Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>> Yes, that patch looks like it fix the problem, and I cannot spot any
>> obvious missing cleanups.
>
> Great!!
>
>> But I must say that the whole kobj + free thing makes me feel a bit
>> uneasy.  I assume there are good reasons why "cpufreq" isn't just a
>> device with a release method?
>
> I didn't get it completely.. How exactly you wanted it to be..

Like a normal "struct device".  All that manual fiddling with sysfs
files and kobj removal etc looks so complicated and error prone to me.
But this is likely because I don't understand the code at all.

Take my comments for what they are worth.  I'm not claiming any
understanding at all here....

>> And I do hope there is something gained by the special suspend handl=
ing,
>> because keeping this partial device looks really messy. If it's all =
just
>> for some file permissions, then there must be better ways?
>
> We didn't found many and so Srivatsa went with this way.. If you have=
 a
> better way then we are all for it :)
>
>> Isn't consistent file permissions on device creation really a usersp=
ace issue?
>
> Yes, normally it is.. But suspend/resume or hibernation isn't a users=
pace
> problem at all.

It is a userspace problem for other devices which are unplugged and
plugged on suspend/resume. CPUs are obviously exceptional for some
reason. This is what I don't understand.  I assume the file permissions
are set up by userspace when the device is first created? Why doesn't
the same apply to device creation after a resume hotplug?

You have made the very wise decision to handle suspend/resume of non
boot CPUs as hotplugging events.  But then you totally destroy this nic=
e
and simple model by adding lots of code implementing some very device
specific suspend/resume handling.  That confuses me.  And it's not like
you save anything valuable over the suspend/resume.  You want to save
file permissions of sysfs attributes? Who cares?  They should be set by
udev rules anyway.

> We had a discussion earlier on it and realized that kernel
> is screwing it up and so it should get it back. Userspace doesn't hav=
e to
> know how cpufreq removed these directories/files and added them back
> on resume.

Userspace should see this as CPUs going away and then being added back,
right? If userspace set the file permissions the first time the CPU was
added, why can't it do so the next time as well?

This wouldn't have been such a big deal if the workaorund was a simple
line or two.  But it is not.



Bj=C3=B8rn
