From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend] cpufreq: remove sysfs files for CPU which failed
 to come back after resume
Date: Mon, 23 Dec 2013 11:32:28 +0530
Message-ID: <CAKohpok1dGMPSAehwsVeiyHzxaHupenA4sP5cxCrjVYQMyrVWA@mail.gmail.com>
References: <610b63b7594e5cd364c498f60e69b9e174db9257.1387554926.git.viresh.kumar@linaro.org>
	<1651441.C2UQleWVoy@vostro.rjw.lan>
	<871u14i00j.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <871u14i00j.fsf@nemi.mork.no>
Sender: cpufreq-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 23 December 2013 11:25, Bj=F8rn Mork <bjorn@mork.no> wrote:
> I can confirm that it fixes the major regression.  With this branch, =
the
> cpufreq directory is completely removed after a cancelled userspace
> hibernate (with the acpi-cpufreq problem causing failure).  So it is
> possible to restore cpufreq by manually offlining and onlining non-bo=
ot
> cores.  No more leftover sysfs attributes.

Thanks for giving it a try once again :)

> But there is still a minor regression compared to the old (v3.11)
> behaviour: Previously the cpufreq functionality would be automaticall=
y
> restored by any completed hibernate or suspend cycle, since it would
> effectively do the CPU offline/online. This automatix fixup won't hap=
pen
> with the current pm-cpufreq branch.

I didn't understood it completely, sorry :)

As far as I can see from 3.11 code we simply used to fail with any fail=
ure
resulting with a call to ->init() or some other call..

And so cpufreq wouldn't have added any directories at all in that case.
And so I think we still required an offline/online sequence to guarante=
e
things..
