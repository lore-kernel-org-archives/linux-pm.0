From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection framework
Date: Mon, 25 Jun 2018 23:55:16 +0200
Message-ID: <CAJZ5v0gv_y9DfEsqq_46D5hi3SA+UYy7cUoaCwb3_+HtRadDOg@mail.gmail.com>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iyS7wUx5sYnyhZxhRD7EMEWyKzcpBu7vXUGxuwM4+prw@mail.gmail.com> <98f43bb6-9ab5-2f79-05f2-be68a0f7f88e@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <98f43bb6-9ab5-2f79-05f2-be68a0f7f88e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 25, 2018 at 1:52 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 25/06/2018 10:23, Rafael J. Wysocki wrote:
>
> [ ... ]
>
>>> + * It is up to the user of this framework to provide a lock at an
>>> + * upper level to prevent stupid things to happen, like starting while
>>> + * we are unregistering.
>>> + */
>>
>> The English above and elsewhere needs some polishing IMO, but I can
>> take care of that. :-)
>
> I can give a try and if you are still unhappy, you change them in a
> better way.

Well, I could tell you what I would write, but then it'll take less
time and effort if I just write it myself. :-)

> [ ... ]
>
>>> +static void idle_injection_setup(unsigned int cpu)
>>> +{
>>> +       struct sched_param param = { .sched_priority = MAX_USER_RT_PRIO / 2 };
>>> +
>>> +       set_freezable();
>>
>> Why do you need set_freezable() here?
>
> We don't want to continue injecting idle cycles when the system is
> suspended.

And where's the corresponding try_to_freeze() called?
