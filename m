From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH Resend] cpufreq: remove sysfs files for CPU which failed to come back after resume
Date: Mon, 23 Dec 2013 10:23:04 +0100
Message-ID: <877gavgbuv.fsf@nemi.mork.no>
References: <610b63b7594e5cd364c498f60e69b9e174db9257.1387554926.git.viresh.kumar@linaro.org>
	<1651441.C2UQleWVoy@vostro.rjw.lan> <871u14i00j.fsf@nemi.mork.no>
	<CAKohpok1dGMPSAehwsVeiyHzxaHupenA4sP5cxCrjVYQMyrVWA@mail.gmail.com>
	<87d2kokqdl.fsf@nemi.mork.no> <52B7EC81.6060202@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <52B7EC81.6060202@linaro.org> (viresh kumar's message of "Mon, 23
	Dec 2013 13:25:45 +0530")
Sender: cpufreq-owner@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

viresh kumar <viresh.kumar@linaro.org> writes:

> On Monday 23 December 2013 12:25 PM, Bj=C3=B8rn Mork wrote:
>> That's correct.  The immediate result of the failure is exactly the
>> same.
>
> Okay..
>
>> The difference is that a subsequent resume would restore the cpufreq
>> device whether it existed or not.  That made a complete suspend/resu=
me
>> fix up any missing cpufreq device, e.g. one that was removed by a
>> previous error.
>
> I see.. Please see if below patch fixes it for you, it should :)

Confirmed.  With that patch on top of the current pm-cpufreq branch all
functionality is restored and there are no regressions AFAICS.

I still don't understand why you want to add this hackish half-assed
suspend implementation, but at least it doesn't seem to break anything
anymore.  But if you really want to implement suspend/resume, then you
do need to keep the whole device and not just the sysfs files. Keeping
the attribute files allow you to save and restore changed permissions,
but it doesn't save any user modified settings. What's the point of
that?  Is the next step yet another hack to save those?  Where does thi=
s
end?

Why not implement proper support for suspending the "cpufreq device",
and *then* enable suspend/resume support?

Well, not my problem...  Just wondering really.


Bj=C3=B8rn
