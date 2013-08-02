From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: BUG_ON(irqs_disabled()) in cpufreq.c
Date: Fri, 2 Aug 2013 12:12:53 +0530
Message-ID: <CAKohpok4y3jyZqddQDJu5kwRxZyV7QMRUXFQ-C66Xe90soCKhw@mail.gmail.com>
References: <CAEL66Hib_KJ3=5Hi-=OAye=2pbQz_0-PcC6CicjP9n2Ng2KG9g@mail.gmail.com>
	<CAOh2x=nfzMEgbetmaUhjKx2FfCvxPjOxk6A_XC-Q9h0+HOEnGQ@mail.gmail.com>
	<20130802063854.6450.70950@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130802063854.6450.70950@quantum>
Sender: cpufreq-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Michael Giardino <giardino@ece.gatech.edu>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2 August 2013 12:08, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Viresh Kumar (2013-08-01 22:02:37)
>> More lists cc'd
>>
>> On Thu, Aug 1, 2013 at 6:08 PM, Michael Giardino
>> <giardino@ece.gatech.edu> wrote:
>> > Hi,
>> >
>> > I hope this is the right spot to ask this.
>> >
>> > Is there any way to change the cpu frequency using the cpufreq driver
>> > from within an hrtimer callback function? I encounter a kernel panic
>> > at cpufreq.c line 255 (260 in 3.9.5)
>
> It is not just about the notifiers.
>
> Performing a clock rate change and voltage regulator transition (DVFS)
> is not a short operation on many ARM platforms. Relocking a PLL and
> waiting for a regulator to step and stabilize can take well over 100
> milliseconds and some of those functions might sleep.

BTW, The routine in question doesn't change frequency by itself. But the
caller of this routine will change clk just after/before calling this routine.

I don't really know why this code was initially written there, but I don't think
we should add such a BUG() or WARN() to satisfy performance of a
system.

They should be used only when it is not possible to execute the notifier
when interrupts are disabled.

You have any clue why this code was placed here?
