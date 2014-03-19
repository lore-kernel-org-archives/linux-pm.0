From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC V2] cpufreq: make sure frequency transitions are serialized
Date: Wed, 19 Mar 2014 15:20:17 +0530
Message-ID: <53296859.20801@linux.vnet.ibm.com>
References: <2efc621827cbd96a05a3d34075154974b4816ecd.1394782795.git.viresh.kumar@linaro.org> <532840FD.308@linux.vnet.ibm.com> <CAKohpomhTJa06a1LSi9tK1+=6Y2MyidJSbYWuffAsU5KxVf7zw@mail.gmail.com> <5329609B.8050200@linux.vnet.ibm.com> <CAKohpomrn25hBg5o1h8WWMM+d8o2OJJUmGEmXGvVk3BqP90HJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomrn25hBg5o1h8WWMM+d8o2OJJUmGEmXGvVk3BqP90HJQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Amit Daniel <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 03/19/2014 02:50 PM, Viresh Kumar wrote:
> On 19 March 2014 14:47, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> Wait, I think I remember. The problem was about dealing with drivers that
>> do asynchronous notification (those that have the ASYNC_NOTIFICATION flag
>> set). In particular, exynos-5440 driver sends out the POSTCHANGE notification
>> from a workqueue worker, much later than sending the PRECHANGE notification.
>>
>> From what I saw, this is how the exynos-5440 driver works:
>>
>> 1. ->target() is invoked, and the driver writes to a register and returns
>>    to its caller.
>>
>> 2. An interrupt occurs that indicates that the frequency was changed.
>>
>> 3. The interrupt handler kicks off a worker thread which then sends out
>>    the POSTCHANGE notification.
> 
> Correct!!
> 
>> So the important question here is, how does the exynos-5440 driver
>> protect itself from say 2 ->target() calls which occur in close sequence
>> (before allowing the entire chain for the first call to complete)?
>>
>> As far as I can see there is no such synchronization in the driver at
>> the moment. Adding Amit to CC for his comments.
> 
> Yes, and that's what my patch is trying to fix. Where is the confusion?

Sorry, for a moment I got confused and thought that your patch addresses
the race conditions present in normal drivers alone, and not ASYNC_NOTIFICATION
drivers. But now I understand that your patch intends to fix both the
problems at once. I'll share my thoughts about the design in a separate
reply.
 
Regards,
Srivatsa S. Bhat

