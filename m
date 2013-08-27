From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] CPUFreq: Why do we need policy->user_policy?
Date: Tue, 27 Aug 2013 16:29:52 +0530
Message-ID: <CAKohpo=ZKA6ieg9BrVRCRL+_7uiPfb2tWMO0_VOYx0m=Sv4+xQ@mail.gmail.com>
References: <CAKohponkO6oZrvrsUGVK0uUbAM5wse7eHd7udtWkab7y2aatGA@mail.gmail.com>
	<20581731.mdSQ720dHi@vostro.rjw.lan>
	<CAOLK0pzg5VwDBLbUFU8J8wujxUazPgFC-+C4+Z6AMLYv7KcOtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOLK0pzg5VwDBLbUFU8J8wujxUazPgFC-+C4+Z6AMLYv7KcOtw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 26 August 2013 20:53, Lan Tianyu <lantianyu1986@gmail.com> wrote:
> So far as I know, it stores some user's config and cpufreq_update_pol=
icy()
> bases on the data in the struct to start a new policy. Cpu thermal dr=
iver
> =EF=BC=88/driver/thermal/cpu_cooling.c=EF=BC=89also will its value to=
 update freq policy
> when receive a cpufreq policy adjust notification.

Yeah, but how are these different from policy->min/max/policy/governor?
Why do we need to replicate this information?
