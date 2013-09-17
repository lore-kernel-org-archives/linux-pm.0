From: karthik vm <meetvm@gmail.com>
Subject: Re: Few clarifications on DVFS
Date: Mon, 16 Sep 2013 22:13:11 -0400
Message-ID: <CAOuKo4kZNv70OyEt6tRynfFmRex8DW+nJCg2pZGPoydnHn+LaA@mail.gmail.com>
References: <CAOuKo4nZ5Yij3cnM=PuMR3awJ2QAbY4O+-mKi110xfc66xyWUg@mail.gmail.com>
 <CAOh2x=n3PVMJhbrJE33Qe73=6ZUhh8yR1rs+ziWTD5tFNjW6RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOh2x=n3PVMJhbrJE33Qe73=6ZUhh8yR1rs+ziWTD5tFNjW6RA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Thanks for immediate response Viresh.

On Mon, Sep 16, 2013 at 1:46 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> What's the problem you see in OS doing that? Its not about the guarantee
> that OS can change freq in that time, but is more about hardware... And
> so it doesn't matter who changes it..

Yeah actually that is what my concern is. It seems that for changing
the frequency we need to acquire a lock (in cpufreq_driver_target()).
Hence even though the hardware is capable of ns level DVFS, OS
overhead may be large enough to take advantage of it. Can we measure
this overhead?

> Ya, the API is open to be called from anywhere you want... but then its
> your hardware and you must know what you are doing :)

Great to know. Thanks!!
