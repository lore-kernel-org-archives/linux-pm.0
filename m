From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Query] CPUFreq: Why do we need policy->user_policy?
Date: Tue, 27 Aug 2013 23:20:32 +0200
Message-ID: <1734682.b8u1f0b3XY@vostro.rjw.lan>
References: <CAKohponkO6oZrvrsUGVK0uUbAM5wse7eHd7udtWkab7y2aatGA@mail.gmail.com> <CAKohpo=ZKA6ieg9BrVRCRL+_7uiPfb2tWMO0_VOYx0m=Sv4+xQ@mail.gmail.com> <CAOLK0pztfCd9ov297t0CW0C5S2iOSb9FJFHq9ycqwYGRiyifmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOLK0pztfCd9ov297t0CW0C5S2iOSb9FJFHq9ycqwYGRiyifmA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 27, 2013 10:04:52 PM Lan Tianyu wrote:
> 2013/8/27 Viresh Kumar <viresh.kumar@linaro.org>:
> > On 26 August 2013 20:53, Lan Tianyu <lantianyu1986@gmail.com> wrote=
:
> >> So far as I know, it stores some user's config and cpufreq_update_=
policy()
> >> bases on the data in the struct to start a new policy. Cpu thermal=
 driver
> >> =EF=BC=88/driver/thermal/cpu_cooling.c=EF=BC=89also will its value=
 to update freq policy
> >> when receive a cpufreq policy adjust notification.
> >
> > Yeah, but how are these different from policy->min/max/policy/gover=
nor?
> > Why do we need to replicate this information?
>=20
> From my understanding.policy->min/max may be modified by some drivers
> but the user_policy only store user space config and should not be ch=
anged
> by other reason.  :)

Yes, that was the original idea IIRC, so separate user settings from st=
uff that
may be changed internally by the kernel.

Thanks,
Rafael

