From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3] PM / OPP: Don't remove the first cpu in the mask
 before removing others
Date: Tue, 29 Nov 2016 13:49:56 +0100
Message-ID: <CAJZ5v0jRooZSJP1wRHD7NN2rkEpsJ-tkk5Z7_Xw1xcQaiUQwpw@mail.gmail.com>
References: <29c512d06de99663c3c8acc2e04a898831879a6c.1480398079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:32863 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754693AbcK2Mt6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2016 07:49:58 -0500
In-Reply-To: <29c512d06de99663c3c8acc2e04a898831879a6c.1480398079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, jy0922.shim@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "# v4 . 4+" <stable@vger.kernel.org>

On Tue, Nov 29, 2016 at 6:42 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Joonyoung Shim reported an interesting problem on his ARM octa-core
> Odoroid-XU3 platform. During system suspend, dev_pm_opp_put_regulator()
> was failing for a struct device for which dev_pm_opp_set_regulator() is
> called earlier.
>
> This happened because an earlier call to
> dev_pm_opp_of_cpumask_remove_table() function (from cpufreq-dt.c file)
> removed all the entries from opp_table->dev_list apart from the last CPU
> device in the cpumask of CPUs sharing the OPP.
>
> But both dev_pm_opp_set_regulator() and dev_pm_opp_put_regulator()
> routines get CPU device for the first CPU in the cpumask. And so the OPP
> core failed to find the OPP table for the struct device.
>
> In order to fix that up properly, we need to revisit APIs like
> dev_pm_opp_set_regulator() and make them talk in terms of cookies
> provided by the OPP core. But such a solution will be hard to backport
> to stable kernels.
>
> This patch attempts to fix this problem (in a Hacky way) by specially
> handling the first cpu in the mask. A FIXME is also added to make sure
> that this Hack doesn't get unnoticed later on.
>
> Cc:  # v4.4+ <stable@vger.kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2->V3:
> - Fix $Subject, which carried text from V1.
>
> V1->V2:
> - A completely different approach, more of hack so that backport to
>   stable kernels can be done easily.
> - A more comprehensive solution is required to fix the design flaws.

I'll wait for a response from Stephen this time.

Thanks,
Rafael
