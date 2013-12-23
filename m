From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH Resend] cpufreq: remove sysfs files for CPU which failed to come back after resume
Date: Mon, 23 Dec 2013 11:57:12 +0100
Message-ID: <87txdzx2bb.fsf@nemi.mork.no>
References: <610b63b7594e5cd364c498f60e69b9e174db9257.1387554926.git.viresh.kumar@linaro.org>
	<1651441.C2UQleWVoy@vostro.rjw.lan> <871u14i00j.fsf@nemi.mork.no>
	<CAKohpok1dGMPSAehwsVeiyHzxaHupenA4sP5cxCrjVYQMyrVWA@mail.gmail.com>
	<87d2kokqdl.fsf@nemi.mork.no> <52B7EC81.6060202@linaro.org>
	<877gavgbuv.fsf@nemi.mork.no>
	<CAKohpo=0HRihdTiQLk+mKiarUdXOPO3n7GCJ9CUoi=4xJ_AYcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=0HRihdTiQLk+mKiarUdXOPO3n7GCJ9CUoi=4xJ_AYcg@mail.gmail.com>
	(Viresh Kumar's message of "Mon, 23 Dec 2013 16:15:06 +0530")
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:
> On 23 December 2013 14:53, Bj=C3=B8rn Mork <bjorn@mork.no> wrote:
>
>> But if you really want to implement suspend/resume, then you
>> do need to keep the whole device and not just the sysfs files. Keepi=
ng
>> the attribute files allow you to save and restore changed permission=
s,
>> but it doesn't save any user modified settings.
>
> Which settings are you talking about? I thought we are preserving all
> files..

I could be missing something, but I haven't noticed any attempt to
preserve anything except the sysfs files.

I tried modifying the max frequency, using

 echo 800000 >/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
 echo 800000 >/sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq

After supend + resume the boot CPU still had the modifed maximum, while
the non-boot core was reset to the default value.  I changed the gid of
both files too, verifying that they were saved and restored as expected=
=2E
But the value will change to default.

IMHO it would still be a lot better if this was handled as a true
hotplug event, allowing userspace to reset values/modes/owners on
resume. Hiding the hotplug event and saving part of the userspace
controlled environment is worse than not doing anything at all.


Bj=C3=B8rn
