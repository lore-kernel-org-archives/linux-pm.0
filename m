From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 1/2] cpufreq: split the cpufreq_driver_lock and use the rcu
Date: Wed, 3 Apr 2013 10:55:54 +0530
Message-ID: <CAKohpo=Um9LGhGtMB0z9C2jxmS3oHwV7i_Gmsq5rR80ZcGYyLw@mail.gmail.com>
References: <5159C147.70800@sgi.com>
	<20130402145536.GA31757@gulag1.americas.sgi.com>
	<CAKohpokXbeRp-pHaJRAOjnF+R+wy8R9We67Yr2C2nyoVXyJd6w@mail.gmail.com>
	<8456428.Vj8uefv4LI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <8456428.Vj8uefv4LI@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nathan Zimmer <nzimmer@sgi.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 3 April 2013 04:27, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, April 02, 2013 08:29:12 PM Viresh Kumar wrote:
>> On 2 April 2013 20:25, Nathan Zimmer <nzimmer@sgi.com> wrote:
>> > The lock is unneeded if we expect register and unregister driver to not be
>> > called from muliple threads at once.  I didn't make that assumption.
>>
>> Hmm.. But doesn't rcu part take care of that too?? Two writers
>> updating stuff simultaneously?
>
> RCU doesn't cover that in general.  Additional locking is needed to provide
> synchronization between writers.

Hmm.. I read the same from rcu documentation now...

Nathan, What about using a single spinlock (instead of two) that will take care
of all locking requirements of cpufreq.c ... i.e. both cpufreq_cpu_data and
cpufreq_driver_{register|unregister}... We don't need two locks actually.
