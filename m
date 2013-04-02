From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v6 1/2] cpufreq: split the cpufreq_driver_lock and use the rcu
Date: Wed, 03 Apr 2013 00:57:50 +0200
Message-ID: <8456428.Vj8uefv4LI@vostro.rjw.lan>
References: <5159C147.70800@sgi.com> <20130402145536.GA31757@gulag1.americas.sgi.com> <CAKohpokXbeRp-pHaJRAOjnF+R+wy8R9We67Yr2C2nyoVXyJd6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpokXbeRp-pHaJRAOjnF+R+wy8R9We67Yr2C2nyoVXyJd6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nathan Zimmer <nzimmer@sgi.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 02, 2013 08:29:12 PM Viresh Kumar wrote:
> On 2 April 2013 20:25, Nathan Zimmer <nzimmer@sgi.com> wrote:
> > The lock is unneeded if we expect register and unregister driver to not be
> > called from muliple threads at once.  I didn't make that assumption.
> 
> Hmm.. But doesn't rcu part take care of that too?? Two writers
> updating stuff simultaneously?

RCU doesn't cover that in general.  Additional locking is needed to provide
synchronization between writers.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
