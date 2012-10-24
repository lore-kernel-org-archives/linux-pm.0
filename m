From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] cpufreq: governors: remove redundant code
Date: Wed, 24 Oct 2012 21:43:46 +0200
Message-ID: <1597360.JT7plJlUsZ@vostro.rjw.lan>
References: <32e5bed743cc6cc4e614291a7080299f5f0d0933.1350677395.git.viresh.kumar@linaro.org> <CAKohpo=Jsy9az4PgJ-mkq_U49EOpHGES+-DaROanCOTn-L2s3Q@mail.gmail.com> <CAKohpomUD-JQbkyEom+_BaRqJSvw8P_hBUsrjTU3vH6bM1+scQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomUD-JQbkyEom+_BaRqJSvw8P_hBUsrjTU3vH6bM1+scQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdsw-power-team@arm.com, arvind.chauhan@arm.com
List-Id: linux-pm@vger.kernel.org

On Wednesday 24 of October 2012 11:37:13 Viresh Kumar wrote:
> On 22 October 2012 14:16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 20 October 2012 01:42, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> Initially ondemand governor was written and then using its code conservative
> >> governor is written. It used a lot of code from ondemand governor, but copy of
> >> code was created instead of using the same routines from both governors. Which
> >> increased code redundancy, which is difficult to manage.
> >>
> >> This patch is an attempt to move common part of both the governors to
> >> cpufreq_governor.c file to come over above mentioned issues.
> >>
> >> This shouldn't change anything from functionality point of view.
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> For everybody else, this patch is already pushed by Rafael in his linux-next
> branch.

Well, not yet, although I'm going to do that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
