From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Resend][PATCH] cpufreq: conservative: Decrease frequency faster
 when the timer deferred
Date: Tue, 8 Nov 2016 14:02:29 +0530
Message-ID: <CAKohpo=kbyXvjOYFdOyu6d6x1TP45UWT0kB9eAk3XUXTG5iUpQ@mail.gmail.com>
References: <076fb177-9cb3-4534-aadb-ebc2190d0751@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <076fb177-9cb3-4534-aadb-ebc2190d0751@email.android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 8 November 2016 at 12:49, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> I think we shouldn't. That's why the patch first decreases the frequency
> by n freq steps (where n the number of deferred periods).
> Then the normal processing takes place.

The problem that I see is that the new algorithm will reduce the
frequency even if we are
on a ramp up phase.

For example consider this case:

- We have a special load running, that runs in bursts. i.e. runs for
some time, lets the CPU idle
then and then again runs.

- To run the load properly, we need to ramp up the frequency

- But the new algorithm can make the frequency stagnant in this case.
i.e. because of the idle
period you may want to decrease the frequency by delta A and then the
regular algorithm may
want to increase it by same delta A.

That's why I was asking to adopt this only in the ramp down path.

--
viresh
