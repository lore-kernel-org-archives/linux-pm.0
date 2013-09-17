From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Tue, 17 Sep 2013 17:19:19 +0530
Message-ID: <523841BF.3070806@linux.vnet.ibm.com>
References: <085013f4e584e3fef97187bcb349c3fa76942e19.1378012620.git.viresh.kumar@linaro.org> <80c4bd8c577e5da0aa63342671773be5cdc26a9a.1378012620.git.viresh.kumar@linaro.org> <5225E205.7080008@linux.vnet.ibm.com>	<5197493.kSPF7VUWqc@vostro.rjw.lan> <CAKohpom8d89OtJOs-_eCu+RiVA+B0bt7rtgNcJn=D=y95+jdQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpom8d89OtJOs-_eCu+RiVA+B0bt7rtgNcJn=D=y95+jdQg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/13/2013 05:14 PM, Viresh Kumar wrote:
> On 4 September 2013 01:10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> On Tuesday, September 03, 2013 06:50:05 PM Srivatsa S. Bhat wrote:
> 
>>> This doesn't solve the problem completely: it prevents the store_*() task
>>> from continuing *only* when it concurrently executes the __cpufreq_governor()
>>> function along with the CPU offline task. But if the two calls don't overlap,
>>> we will still have the possibility where the store_*() task tries to acquire
>>> the timer mutex after the CPU offline task has just finished destroying it.
>>
>> Yeah, I overlooked that.
> 
> As a background, I had a IRC chat with Srivatsa on this mail.. (I have marked
> this unread as there were other important topics to close)..
> 
> And he had some other code in mind and these synchronization problems
> aren't there with my patch at all (as per him too)..
> 
> Rafael, probably both me and Srivatsa are missing something that you
> understood, can you please share what problem you see here with my patch?
> 
> And yes, even with Srivatsa's patchset I found a problem:
> Two threads, one changing governor from ondemand->conservative and other
> one changing min/max freq..
> 
> First one will try to STOP governor and other one will try to change
> limits of gov.
> Suppose 2nd one gets to ->governor() and after this first one stops
> the governor.
> Now the first one tries to access lock and crashes..
> 
> On IRC, Srivatsa agreed about the problem..
> 

Actually, we had another round of discussions and decided that there is no
problem here. The reason is, the top-level store() routine takes the rwsem of
that policy for write; so only one store() can go at a time. So the race between
changing the governor and changing the min/max freq won't happen because only
one of them can execute at a given time. In fact, by extension, *any* two store()s
in cpufreq shouldn't race with one another.

So the conclusion is that the mainline code is fine in this aspect. Nothing
needs to be reverted.

That said, there are still certain low-priority/less-visible synchronization
issues to be fixed in cpufreq, and we'll take them up later, once the dust is
settled.

Regards,
Srivatsa S. Bhat

