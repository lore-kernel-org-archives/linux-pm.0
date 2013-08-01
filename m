From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC][PATCH] cpufreq: Do not hold driver module references for
 additional policy CPUs
Date: Thu, 1 Aug 2013 22:54:08 +0530
Message-ID: <CAKohpokdZ=JE8riYxJd+abfaDo6RfqnOjNpbFkb+ph_E-O6L_A@mail.gmail.com>
References: <2362640.pUofnXyzOi@vostro.rjw.lan>
	<51FA1818.2050203@linux.vnet.ibm.com>
	<CAKohponkEWs2r5ibR8RTAN6D2LfNfDB7bvy1nqdTN4C3jQHdJA@mail.gmail.com>
	<51FA7DCB.5090201@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51FA7DCB.5090201@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 1 August 2013 20:54, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Well, I now agree that we don't have to keep the module refcount
> non-zero as long as CPUs are being managed (that was just my
> misunderstanding, sorry for the noise). However, I think the _get()
> and _put() used in the existing code is for synchronization: that
> is, to avoid races between trying to unload the cpufreq driver
> module and running a hotplug notifier (and calling the driver module's
> ->init() or ->exit() function).
>
> With that being the case, I think we can retain the module refcounts
> and use them only for synchronization. And naturally the refcount
> should drop to zero after the critical section; no point keeping
> it incremented until the CPU is taken offline.
>
> Or, am I confused again?

No, you aren't.

But, for synchronization we need some blocking stuff, so that when
user tries to rmmod the module, it should wait until other critical
sections are over and then unload the module. But here, we are
simply returning from rmmod, saying that we are busy :)

So, for that kind of synchronization we better use locks available
inside cpufreq core of if required another variable which can be
used for refcount. But now this.
