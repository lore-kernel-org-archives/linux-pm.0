From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection framework
Date: Mon, 25 Jun 2018 10:34:48 +0200
Message-ID: <CAJZ5v0gPmMbpFMTQ8mdhxKC86QsUaVQEzBxWyN9MdiTdR1QgWw@mail.gmail.com>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

[cut]

> +/**
> + * idle_injection_wakeup - Wake up all idle injection threads
> + * @ii_dev: the idle injection device
> + *
> + * Every idle injection task belonging to the idle injection device
> + * and running on an online CPU will be wake up by this call.
> + */
> +static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
> +{
> +       struct idle_injection_thread *iit;
> +       unsigned int cpu;
> +
> +       for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
> +               iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +               iit->should_run = 1;
> +               wake_up_process(iit->tsk);
> +       }
> +}
> +
> +/**
> + * idle_injection_wakeup_fn - idle injection timer callback
> + * @timer: a hrtimer structure
> + *
> + * This function is called when the idle injection timer expires which
> + * will wake up the idle injection tasks and these ones, in turn, play
> + * idle a specified amount of time.
> + *
> + * Return: HRTIMER_RESTART.
> + */
> +static enum hrtimer_restart idle_injection_wakeup_fn(struct hrtimer *timer)
> +{
> +       unsigned int duration_ms;
> +       struct idle_injection_device *ii_dev =
> +               container_of(timer, struct idle_injection_device, timer);
> +
> +       duration_ms = READ_ONCE(ii_dev->run_duration_ms);
> +       duration_ms += READ_ONCE(ii_dev->idle_duration_ms);
> +
> +       idle_injection_wakeup(ii_dev);
> +
> +       hrtimer_forward_now(timer, ms_to_ktime(duration_ms));
> +
> +       return HRTIMER_RESTART;
> +}

Also, I'd rename the above to idle_inject_timer_fn() for clarity.
_wakeup_fn() is kind of too similar to _wakeup() IMO and a bit
confusing.
