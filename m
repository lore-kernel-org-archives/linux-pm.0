From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 0/7] sched/cpufreq: Make schedutil energy aware
Date: Mon, 13 May 2019 12:42:26 +0530
Message-ID: <CAOh2x=k23D_FefOnmLjExj1d+UiothgOmyUk=1mqFknpHNwWGg@mail.gmail.com>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190508174301.4828-1-douglas.raillard@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: douglas.raillard@arm.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, quentin.perret@arm.com, patrick.bellasi@arm.com, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 8, 2019 at 11:57 PM <douglas.raillard@arm.com> wrote:
>
> From: Douglas RAILLARD <douglas.raillard@arm.com>
>
> Make schedutil cpufreq governor energy-aware.

Hi Douglas,

I was wondering on why the cpufreq maintainers weren't cc'd for this set and
then I noticed that get_maintainers doesn't report us at all for schedutil :(

I have sent a patch to fix that, but please include us as well in the
future even
if get_maintainers doesn't report us :)

--
viresh
