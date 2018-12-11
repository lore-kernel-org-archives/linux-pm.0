From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
Date: Mon, 10 Dec 2018 23:28:07 -0800
Message-ID: <003401d49123$13627710$3a276530$@net>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan> <20181210122104.GL5289@hirez.programming.kicks-ass.net> <CAJZ5v0j-a6cHayRtcsUPbUTBT0iBSUvmcUy6pfSSvUVcTMBxbw@mail.gmail.com> WUOsgxly2wifMWUOxgv0We
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: WUOsgxly2wifMWUOxgv0We
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Peter Zijlstra' <peterz@infradead.org>, "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, "'open list:DOCUMENTATION'" <linux-doc@vger.kernel.org>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Giovanni Gherdovich' <ggherdovich@suse.cz>, 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.12.10 02:52 Peter Zijlstra wrote:
>On Mon, Dec 10, 2018 at 10:36:40PM +0100, Rafael J. Wysocki wrote:
>> On Mon, Dec 10, 2018 at 1:21 PM Peter Zijlstra <peterz@infradead.org> wrote:

>>> Would not a tracepoint be better?; then there is no overhead in the
>>> normal case where nobody gives a crap about these here numbers.
>> 
>> There is an existing tracepoint that in principle could be used to
>> produce this information, but it is such a major PITA in practice that
>> nobody does that.  Guess why. :-)
>
> Sounds like you need to ship a convenient script or something :-)

For the histogram plots of idle durations that I sometimes provide, trace
is used. It is more work to do it the trace way. Very often, when the rate
of idle state entries/ exits is high, turning on trace influences the system
under test significantly. Also, even if I allocate the majority of my memory
to the trace buffer (i.e. 15 of my 16 gigabytes), I can only acquire a few 
minutes of trace data before filling the buffer.

Some of my tests run for hours, and these new counters provide a way to acquire
potentially useful (I don't have enough experience with them yet to know how useful)
information, while having no influence on the system under test because
I only take samples once per minute, or sometimes 4 times per minute.

>> Also, the "usage" and "time" counters are there in sysfs, so why not these two?

I agree, how are these two counters any different?

In about a week or so, I'll have some test data comparing 4.20-rc5 with teov6
teov7 along with the idle data (graphs) that I usually provide and also these
new counters.

... Doug
