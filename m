From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 1/2] time: allow changing the timekeeper clock frequency
Date: Fri, 30 Aug 2013 10:40:49 -0400
Message-ID: <5220AEF1.7080808@tilera.com>
References: <201308081953.r78Jrt0Z029523@farm-0021.internal.tilera.com> <CALAqxLX8zkzofgGSdEVsP4wdnejd25iSFHyhBwp7nRVgEnqNrA@mail.gmail.com> <520BF6EC.8070006@tilera.com> <521F95BB.2060600@tilera.com> <521FA13F.5040204@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <521FA13F.5040204@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 8/29/2013 3:30 PM, John Stultz wrote:
> On 08/29/2013 11:40 AM, Chris Metcalf wrote:
>> Ping!  I have this work queued up to push as part of the linux-tile tree for the
>> merge window.  Is that acceptable to the timekeeping/clocksource folks?
>> Should I hold it back pending further review?  Or does it make sense to
>> push it as-is and think about further improvements, if any, for a later release?
>>
>> https://lkml.org/lkml/2013/8/9/497
>> https://lkml.org/lkml/2013/8/9/499
> Oh right! Sorry for the slow response here! I originally replied while I
> was on vacation and didn't flag the thread to follow up on.
>
> Few comments below.

Thanks for the feedback. It does sound like too much to take on before
the 3.12 merge window opens, so we will plan to look into this as time
permits over the next little while. I've filed a bug internally to
track this for us.

It sounds like the most straightforward thing for us to do may be to adopt
your original approach of making our clocksource driver internally convert
the variable frequency clocksource to a fixed frequency; the overhead
shouldn't be too bad and it seems like it should moot all the other
concerns you raised in your email.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com

