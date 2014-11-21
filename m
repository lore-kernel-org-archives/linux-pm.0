From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: How many frequencies would cpufreq optimally like to manage?
Date: Fri, 21 Nov 2014 09:06:53 +0530
Message-ID: <CAKohpomzxnCy7X+cPsVdDvi0cMRMp2Am1O-S5BeQtTr1CqBhEw@mail.gmail.com>
References: <546D26AE.50601@free.fr>
	<CAOh2x==KZzq1wbQxGwsJjZW+=fBJDzcnmRoaZMh0UYH-=yBJ=g@mail.gmail.com>
	<546DF891.2050401@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <546DF891.2050401@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 20 November 2014 19:50, Mason <mpeg.blue@free.fr> wrote:
> On 20/11/2014 10:13, Viresh Kumar wrote:
> Suppose I expose 100 frequencies. Aside from wasting memory, isn't
> there also a risk that cpufreq will take time, ramping up/down
> through similar frequencies? (Or does it just say "jump to THAT
> frequency" skipping useless intermediate frequencies?)

Some time might be wasted for similar frequencies, moreover for every
change we have to traverse 100 frequencies to see which one fits best.

> There is a trade-off, tough.
>
> My concern is this: suppose the CPU cores are set to e.g. 54 MHz.
> Suddenly, the driver for an important subsystem needs to speak with
> the corresponding device, with hard deadlines in the comms protocol.
> Will the CPU ramp up fast enough (assuming ondemand governor).

All current governors depend on background timers for their functionality.
These timers run at some sampling rate (in ms) and that time we change
CPU's frequency depending on existing load on system.. So, that might
not be fast enough.

> And the end of this message is as good a place as any to thank you
> for having answered my many questions.

Your welcome :)
