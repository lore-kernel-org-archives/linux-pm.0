From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] kernel/SRCU: provide a static initializer
Date: Tue, 29 May 2018 19:14:49 +0200
Message-ID: <CAJZ5v0j_O=nL6Eym5GqGGDC8LPB5vu-YAp9DFfZSJsHd-TMEmg@mail.gmail.com>
References: <20180525101958.13277-1-bigeasy@linutronix.de> <20180525101958.13277-2-bigeasy@linutronix.de>
 <CAJZ5v0jEUR7YxzujvZn8WVK+dMxmOxoHNiLKcmgCq9awHR=vYg@mail.gmail.com> <20180529120443.GE3803@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529120443.GE3803@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Tue, May 29, 2018 at 2:04 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Tue, May 29, 2018 at 10:09:51AM +0200, Rafael J. Wysocki wrote:
>> On Fri, May 25, 2018 at 12:19 PM, Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de> wrote:
>> > There are macros for static initializer for the three out of four
>> > possible notifier types, that are:
>> >         ATOMIC_NOTIFIER_HEAD()
>> >         BLOCKING_NOTIFIER_HEAD()
>> >         RAW_NOTIFIER_HEAD()
>> >
>> > This patch provides a static initilizer for the forth type to make it
>> > complete.
>> >
>> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
>> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>
>> I cannot apply this without an ACK from Paul.
>
> I have both queued, but if you would prefer to take them, then for the
> SRCU piece:
>
> Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Thanks!

I'll route them along with the other cpufreq material then.

Cheers,
Rafael
