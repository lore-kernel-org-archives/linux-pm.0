From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC v3] cpufreq: Make sure frequency transitions are serialized
Date: Wed, 19 Mar 2014 20:18:54 +0530
Message-ID: <5329AE56.8080204@linux.vnet.ibm.com>
References: <2efc621827cbd96a05a3d34075154974b4816ecd.1394782795.git.viresh.kumar@linaro.org> <532840FD.308@linux.vnet.ibm.com> <CAKohpomhTJa06a1LSi9tK1+=6Y2MyidJSbYWuffAsU5KxVf7zw@mail.gmail.com> <53296870.5010505@linux.vnet.ibm.com> <CAKohpomr1s3SLs-K8+-BKguX4PyfHvSjyzd5PFjM4mJeyTj3-A@mail.gmail.com> <53298A7D.3080400@linux.vnet.ibm.com> <CAKohpomQjvkAaty-nBSb=Qyxvk0RhvkwNXC9194gmYr6Vpw5WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomQjvkAaty-nBSb=Qyxvk0RhvkwNXC9194gmYr6Vpw5WA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Amit Daniel <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 03/19/2014 07:05 PM, Viresh Kumar wrote:
> On 19 March 2014 17:45, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> +       bool                    transition_ongoing; /* Tracks transition status */
>> +       struct mutex            transition_lock;
>> +       wait_queue_head_t       transition_wait;
> 
> Similar to what I have done in my last version, why do you need
> transition_ongoing and transition_wait? Simply work with
> transition_lock? i.e. Acquire it for the complete transition sequence.
> 

We *can't* acquire it for the complete transition sequence
in case of drivers that do asynchronous notification, because
PRECHANGE is done in one thread and POSTCHANGE is done in a
totally different thread! You can't acquire a lock in one
task and release it in a different task. That would be a
fundamental violation of locking.

That's why I introduced the wait queue to help us create
a "flow" which encompasses 2 different, but co-ordinating
tasks. You simply can't do that elegantly by using plain
locks alone.

Regards,
Srivatsa S. Bhat

