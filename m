From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update][PATCH] cpufreq: Do not hold driver module references for
 additional policy CPUs
Date: Fri, 2 Aug 2013 15:06:41 +0530
Message-ID: <CAKohpomGi0FzL-3FwsP=zzmbNMNUc6CN0S9Lyba+vx8m7MS4uQ@mail.gmail.com>
References: <2362640.pUofnXyzOi@vostro.rjw.lan>
	<51FAC46D.1000703@linux.vnet.ibm.com>
	<1757496.qSuJuAun9Z@vostro.rjw.lan>
	<2298639.F0Qv2QqRnZ@vostro.rjw.lan>
	<CAKohponru8Z1fod43dVtAODmYuMTGX70+73b8wk4wuGN=Vuh-w@mail.gmail.com>
	<51FB568B.1040902@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51FB568B.1040902@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, cpufreq@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 2 August 2013 12:19, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> On 08/02/2013 10:07 AM, Viresh Kumar wrote:
>> So, we can't rmmod the module as soon as it is inserted and so the
>> problem stays as is. :(
>>
>
> No, we get one step closer to the solution, since we fix the inconsistency
> between refcounts. Next step would be to get rid of refcounts and use
> locking like you suggested. Then we can rmmod it easily. I'm assuming
> Rafael has the same plan.

Not really. We are putting the reference at the end of add_dev() and
so refcount would be zero when we aren't running any critical sections.
And so, we can rmmod the module now and that problem is gone.

@Rafael: I will try to do generic cleanups in cpufreq in coming time
and will take care to remove .owner field completely in that. Until that
point your patches look fine:

For both of your patches:
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
