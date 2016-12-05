From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 00/10] PM / OPP: Multiple regulator support
Date: Mon, 5 Dec 2016 19:51:50 +0530
Message-ID: <CAKohpokXXhcrhzqs+iW+1kTYjyF47bHF0TupMxP=4cSqXOThtA@mail.gmail.com>
References: <cover.1480564564.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33193 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbcLEOVw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Dec 2016 09:21:52 -0500
Received: by mail-io0-f177.google.com with SMTP id j65so598002973iof.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Dec 2016 06:21:52 -0800 (PST)
In-Reply-To: <cover.1480564564.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On 1 December 2016 at 16:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi,
>
> Some platforms (like TI) have complex DVFS configuration for CPU
> devices, where multiple regulators are required to be configured to
> change DVFS state of the device. This was explained well by Nishanth
> earlier [1].
>
> One of the major complaints around multiple regulators case was that the
> DT isn't responsible in any way to represent the order in which multiple
> supplies need to be programmed, before or after a frequency change. It
> was considered in this patch and such information is left for the
> platform specific OPP driver now, which can register its own
> opp_set_rate() callback with the OPP core and the OPP core will then
> call it during DVFS.
>
> The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
> and code to pass values for multiple regulators and verified that they
> are all properly read by the kernel (using debugfs interface).
>
> Dave Gerlach has already tested [2] it on the real TI platforms and it
> works well for him.
>
> This is rebased over: linux-next branch in the PM tree.
>
> V6->V7:
> - Added RBY from Stephen for the 8th patch as well.
> - Rebased over pm/bleeding-edge as the dependency patch is already
>   applied there.
> - s/dev_pm_opp_set_regulator()/dev_pm_opp_set_regulators() in a comment.
> - Removed the local 'names' array in cpufreq-dt and used "&name"
>   instead.
> - Only the 6th patch doesn't have a Reviewed-by Tag now..

Hi Rafael,

V6 of this series received some minor comments [1] and I have
resolved them all here. Now that the merge window is so close,
I think we should be merge it now so that it gets a chance to live
in linux-next for few days.

--
viresh

[1] https://marc.info/?l=linux-pm&m=148054543630253&w=2
