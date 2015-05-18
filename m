From: Ruchi Kandoi <kandoiruchi@google.com>
Subject: Re: [PATCH 2/2] sched: cpufreq: Adds a field cpu_power in the task_struct
Date: Mon, 18 May 2015 14:18:49 -0700
Message-ID: <CAL8qYTMr=MNETA_TUQt9wWsnYc+ZbUD0Suy=b9x14Bid9gZr4w@mail.gmail.com>
References: <1431647748-13221-1-git-send-email-kandoiruchi@google.com>
	<1431647748-13221-3-git-send-email-kandoiruchi@google.com>
	<20150515160716.GY21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36475 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbbERVSu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 17:18:50 -0400
Received: by obbkp3 with SMTP id kp3so141622389obb.3
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2015 14:18:49 -0700 (PDT)
In-Reply-To: <20150515160716.GY21418@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 15, 2015 at 9:07 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 14, 2015 at 04:55:48PM -0700, Ruchi Kandoi wrote:
> > cpu_power has been added to keep track of amount of power each task is
> > consuming. cpu_power is updated whenever stime and utime are updated for
> > a task. power is computed by taking into account the frequency at which
> > the current core was running and the current for cpu actively
> > running at hat frequency.
> >
>
> Both you patches completely lack any reason for me to even start
> considering this.
>
> _WHY_ and _what_ are you doing?

We need a mechanism in which we can get information about how much cpu
power each of the process(which is then aggregated fro each
uid/application) is consuming. In the current architecture, it is
based on the amount of the time the process ran. This brings in
inaccuracy because running x seconds at low frequency will have
different power consumption as compared to running at the higher
frequency. With these changes we have the information about the power
which is not only dependent on the time it was running but also takes
into account the frequency it was running at as well as the CPU # it
was running at. Because the cost of running at different CPUs at the
same frequency is different. This gives a better overview of the
current power state of the system wrt cpu power. Please let me know if
more information is required for the same.

Thanks,
Ruchi Kandoi
