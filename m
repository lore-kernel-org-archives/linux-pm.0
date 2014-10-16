From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 0/5] Simplify hotplug/suspend handling
Date: Thu, 16 Oct 2014 14:23:06 +0530
Message-ID: <CAKohpokebj4jkyYipVKUF24Xu4KiVCX2n2D+yj29qxBdzJ-Jdw@mail.gmail.com>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org>
	<1406250448-470-1-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1406250448-470-1-git-send-email-skannan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "Srivatsa S . Bhat" <srivatsa@mit.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 25 July 2014 06:37, Saravana Kannan <skannan@codeaurora.org> wrote:
> Series of patchs to simplify policy/sysfs/kobj/locking handling across
> suspend/resume
>
> The following have been tested so far on a 2x2 cluster environment:
> - Boot with 2 cpus and no cpufreq driver.
> - mod probe driver and see cpufreq sysfs files show up only for the 1st cluster.
> - Online the rest of the 2 CPUs and have files show up correctly.
> - rmmod the driver and see the files go away.
> - modprobe again (or back and forth multiples times) and see it work.
> - suspend/resume works as expected.
> - When a cluster is offline, all read/writes to its sysfs files return an error
>
> v4
> - Split it up into smaller patches
> - Will handle physical CPU removal correctly
> - Fixed earlier mistake of deleting code under !recover_policy
> - Dropped some code refactor that reuses a lot of code between add/remove
> - Dropped fix for exiting hotplug race with cpufreq driver probe/rmmod
> - Dropped changes will come later once this series is acked.

Hi Saravana,

Any  updates on this? We might need some of this soon or should somebody
else start working on this ?
