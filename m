From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 1/2] cpufreq: split the cpufreq_driver_lock and use the rcu
Date: Tue, 2 Apr 2013 21:22:15 +0530
Message-ID: <CAKohpo=6xeESG2DqET4WQFciHN6sX5Z7Jz9JbE6RC00BsV3bdA@mail.gmail.com>
References: <5159C147.70800@sgi.com>
	<1364847069-2887-1-git-send-email-nzimmer@sgi.com>
	<1364847069-2887-2-git-send-email-nzimmer@sgi.com>
	<CAKohpok7MR28trAddHRi5Lcg0bGBHBnOfJO=yu7SQqGnV5ZCRg@mail.gmail.com>
	<20130402145536.GA31757@gulag1.americas.sgi.com>
	<CAKohpokXbeRp-pHaJRAOjnF+R+wy8R9We67Yr2C2nyoVXyJd6w@mail.gmail.com>
	<20130402154021.GA521@gulag1.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130402154021.GA521@gulag1.americas.sgi.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nathan Zimmer <nzimmer@sgi.com>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2 April 2013 21:10, Nathan Zimmer <nzimmer@sgi.com> wrote:
> My concern is in the cpufreq_register_driver.  Since we are only to set the
> pointer when it is null we have have to hold the lock over both operations.
>
> int cpufreq_register_driver(struct cpufreq_driver *driver_data)
> {
> ...
>         spin_lock_irqsave(&cpufreq_driver_lock, flags);
>         if (rcu_access_pointer(cpufreq_driver)) {
>                 spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
>                 return -EBUSY;
>         }
>         rcu_assign_pointer(cpufreq_driver, driver_data);
>         spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
>         synchronize_rcu();
> ...
> }

How will the lock help you here?? Lock is useful only when somebody
else who want to access it is waiting on the lock and we are updating
the pointer.

Because all other accesses to cpufreq_driver don't have any lock, this
lock is just a waste of time.
