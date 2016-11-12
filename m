From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: schedutil: move slow path from workqueue to
 SCHED_FIFO task
Date: Sat, 12 Nov 2016 10:54:37 +0530
Message-ID: <CAKohpo=fxFhnfbHhUVtRAGU18COFM967dYo3AOUYZcytezYKuQ@mail.gmail.com>
References: <cover.1478858983.git.viresh.kumar@linaro.org> <85bf45982709e06f7f42e1b8f8315945e9d9b6d0.1478858983.git.viresh.kumar@linaro.org>
 <CAJZ5v0jODn1gJtTtpTigA=7QwK04wzdFopr-R6GeoSchqgpgiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jODn1gJtTtpTigA=7QwK04wzdFopr-R6GeoSchqgpgiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>, Steve Muckle <smuckle.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 12 November 2016 at 03:46, Rafael J. Wysocki <rafael@kernel.org> wrote:

>> +static void sugov_work(struct kthread_work *work)
>>  {
>> -       struct sugov_policy *sg_policy = container_of(work, struct sugov_policy, work);
>> +       struct sugov_policy *sg_policy =
>> +               container_of(work, struct sugov_policy, work);
>
> Why this change?

Mistake ..

>>  static struct sugov_policy *sugov_policy_alloc(struct cpufreq_policy *policy)
>>  {
>>         struct sugov_policy *sg_policy;
>> +       struct task_struct *thread;
>> +       struct sched_param param = { .sched_priority = 50 };
>
> I'd define a symbol for the 50.  It's just one extra line of code ...

Sure.

As I asked in the cover letter, will you be fine if I send the same patch
for ondemand/conservative governors ?
