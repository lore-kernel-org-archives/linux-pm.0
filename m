From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH] smp: make wake up idle cpus more generic
Date: Thu, 31 Mar 2016 22:40:13 -0700
Message-ID: <CAJFUiJgyM0Y0R51OTharWWZyjsOMO6o_+c7WL=kW1L5aQCoUcA@mail.gmail.com>
References: <1459410795-5693-1-git-send-email-lianwei.wang@gmail.com> <201603311622.dg3lPX4F%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32918 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbcDAFke (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 01:40:34 -0400
In-Reply-To: <201603311622.dg3lPX4F%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, mingo@kernel.org, rjw@rjwysocki.net, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Sorry, my fault. I made a typo mistake when sending the patch. I will
fix it and resend the patch.

On Thu, Mar 31, 2016 at 1:24 AM, kbuild test robot <lkp@intel.com> wrote:
> Hi Lianwei,
>
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.6-rc1 next-20160331]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Lianwei-Wang/smp-make-wake-up-idle-cpus-more-generic/20160331-155548
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: i386-randconfig-n0-201613 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All error/warnings (new ones prefixed by >>):
>
>    drivers/cpuidle/cpuidle.c: In function 'cpuidle_latency_notify':
>>> drivers/cpuidle/cpuidle.c:623:37: error: expected ')' before ';' token
>      wake_up_idle_cpus((cpu_online_mask);
>                                         ^
>>> drivers/cpuidle/cpuidle.c:625:1: error: expected ';' before '}' token
>     }
>     ^
>>> drivers/cpuidle/cpuidle.c:625:1: warning: no return statement in function returning non-void [-Wreturn-type]
>
> vim +623 drivers/cpuidle/cpuidle.c
>
>    617   * and then recalculate a new suitable C-state. Just do a cross-cpu IPI; that
>    618   * wakes them all right up.
>    619   */
>    620  static int cpuidle_latency_notify(struct notifier_block *b,
>    621                  unsigned long l, void *v)
>    622  {
>  > 623          wake_up_idle_cpus((cpu_online_mask);
>    624          return NOTIFY_OK;
>  > 625  }
>    626
>    627  static struct notifier_block cpuidle_latency_notifier = {
>    628          .notifier_call = cpuidle_latency_notify,
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
