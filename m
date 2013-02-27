From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] workqueue: define mod_scheduled_delayed_work[_on]() helpers
Date: Wed, 27 Feb 2013 17:50:08 +0530
Message-ID: <CAKohpo=s2z=G=YZc7qm+9RAw7iLtODqbH-=PSzg4Wt-HtHoaCw@mail.gmail.com>
References: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, rickard.andersson@stericsson.com, fabio.baltieri@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27 February 2013 16:59, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The only difference between schedule_delayed_work[_on]() and
> queue_delayed_work[_on]() is the workqueue, work is scheduled on. We may need to
> modify the delay for works queued with schedule_delayed_work[_on]() calls and
> thus adding these helpers.
>
> First users of these new helpers is cpufreq governors which need to modify the
> delay for its works.
>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

btw, this patchset is pushed here:

http://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/cpufreq-fix-gov-wakeups
