From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/14] cpufreq: create & use cpufreq_generic_init() routine
Date: Thu, 22 Aug 2013 10:17:07 +0530
Message-ID: <CAKohponcPiN9br+K76ky1ROtKM0TS-WFNkL2FtAQTf-yaq8jJg@mail.gmail.com>
References: <cover.1377093938.git.viresh.kumar@linaro.org>
	<1493410.kWm56FEZ0a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493410.kWm56FEZ0a@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 22 August 2013 04:50, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> OK, so the plan for merging this will be that we'll put 1 into linux-next
> and add 2 to it after a few days etc. to give people a chance to test one
> set of changes before going to the next one.
>
>> 1: cpufreq: Introduce cpufreq_table_validate_and_show()
>> https://lkml.org/lkml/2013/8/8/263
>
> So perhaps we can *try* to push the above for 3.12 if it doesn't breaks
> stuff left and right.
>
> Can you please resend it with all of the ACKs collected so far?

Sure..

But I believe we can reduce our work to some extent.. Probably instead
of sending all again separately, we can bind them together logically..

So, I would like to divide these six patchsets into two and we can get the
first one in 3.12 now..

This is how I would bind them:

Set I: CPUFreq: Introduce helper functions to remove code redundancy
<132 Patches>

1: cpufreq: Introduce cpufreq_table_validate_and_show()
https://lkml.org/lkml/2013/8/8/263

2: cpufreq: define generic routines for cpufreq drivers
https://lkml.org/lkml/2013/8/10/48

4. CPUFreq: set policy->cur in cpufreq core instead of drivers
https://lkml.org/lkml/2013/8/14/288

6. cpufreq: create & use cpufreq_generic_init() routine
<This series>

Set II: CPUFreq: Make ->target lightweight()
<70 Patches>

3. CPUFreq: Implement light weight ->target(): for 3.13
https://lkml.org/lkml/2013/8/13/349

5. CPUFreq: Move freq change notifications out of drivers
https://lkml.org/lkml/2013/8/15/506


What do you say? I will wait for your reply before actually spamming
LKML with so many patches :)

I have updated commits with all the Acks and pushed them to my
for-v3.13 branch..

--
viresh
